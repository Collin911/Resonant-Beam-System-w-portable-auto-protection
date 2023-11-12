clc
clear all
close all

subplot(2,2,1)
title('1')
subplot(2,2,3)
title('3')
V = [];
S = [];
i = 1;
shift = 0;
d = 0.004;
r_aperture = 0.00006;
r_CatEye = 0.00018;
r_aperture = r_CatEye;
shift2 = -shift;
fRR = 3;
f = 0.001;
l = f^2./(2*fRR)+f;
% l = f;
lambda = 1064E-9;

[itr, sampN, windowExpandFactor,...
    windowSize, delta, deltaF] = Para_FFTAlgorithm(r_CatEye);

d = 0.004;
d_half = d + lambda / 2;
d_enti = d + lambda;
H_fsd = Cal_FreeSpaceTransferMatrixAS(d, lambda, r_CatEye);
H_fsd_half = Cal_FreeSpaceTransferMatrixAS(d_half, lambda, r_CatEye);
H_fsd_enti = Cal_FreeSpaceTransferMatrixAS(d_enti, lambda, r_CatEye);
H_fsref = Cal_FreeSpaceTransferMatrixAS(0, lambda, r_CatEye);

B_lens = Cal_BoundaryFunction(r_CatEye, r_CatEye, 0);
B_aper = Cal_BoundaryFunction(r_aperture, r_CatEye, 0);


U_pre = 1;
U_d = Cal_AperturetoLens1(U_pre, H_fsd, B_lens, B_aper, delta);
U_t = Cal_TransTiltPlane(U_pre, H_fsd, B_lens, B_aper, 30/180*pi, sampN, lambda, deltaF); 
figure
subplot(1,2,1);
mesh(abs(U_d));
subplot(1,2,2);
mesh(abs(U_t));

U_half = Cal_AperturetoLens1(U_pre, H_fsd_half, B_lens, B_aper, delta);
U_enti = Cal_AperturetoLens1(U_pre, H_fsd_enti, B_lens, B_aper, delta);
U_ref = Cal_AperturetoLens1(U_pre, H_fsref, B_lens, B_aper, delta);
U_intf_half = U_d + U_half;
U_intf_enti = U_d + U_enti;

k = 2 * pi ./ lambda;
U_Mhalf = U_d .* exp(-j * k * (lambda / 2));
U_Menti = U_d .* exp(-j * k * lambda);
U_modu_half = U_d + U_Mhalf;
U_modu_enti = U_d + U_Menti;


sum(U_d(:))
sum(U_half(:))
sum(U_enti(:))
sum(U_intf_half(:))
sum(U_intf_enti(:))
sum(U_ref(:))


[x,y]=meshgrid(linspace(-2*r_CatEye, 2*r_CatEye, sampN));
figure;
subplot(2,3,1);
mesh(x,y,abs(U_ref));
title('d=0')
subplot(2,3,2);
mesh(x,y,abs(U_intf_half));
title('半波长相加')
subplot(2,3,3);
mesh(x,y,abs(U_intf_enti));
title('全波长相加')
subplot(2,3,4);
mesh(x,y,abs(U_d));
title('d=0.003')
subplot(2,3,5);
mesh(x,y,abs(U_modu_half));
title('调制半波长相加')
subplot(2,3,6);
mesh(x,y,abs(U_modu_enti));
title('调制全波长相加')
colormap hot; 
shading interp;
grid on
box off
drawnow
i = i+1;

% figure(1)
% [x,y]=meshgrid(linspace(-2*r_CatEye, 2*r_CatEye, samplingNum));
% mesh(x,y,finalDistribution);
% colormap hot; 
% shading interp;
% grid on
% box off