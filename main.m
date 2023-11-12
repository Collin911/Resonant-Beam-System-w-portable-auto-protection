clc
clear all
close all
V = [];
S = [];
i = 1;
lambda = 1064E-9;

d = 0.003;
r_aperture = 0.00006;
r_CatEye = 0.00018;
% r_aperture = r_CatEye;

% d = 3;
% r_aperture = 0.003;
% r_CatEye = 0.012;

fRR = 3;
f = 0.001;
l = f^2./(2*fRR)+f;

[itr, samplingNum, windowExpandFactor,...
    windowSize, delta, deltaF] = Para_FFTAlgorithm(r_CatEye);
% H_fsdf = Cal_FreeSpaceTransferMatrixDIShift(d+f, lambda, r_CatEye, 0);
% H_fsdf2 = Cal_FreeSpaceTransferMatrixDIShift(d+f, lambda, r_CatEye, 0);
% H_fsl = Cal_FreeSpaceTransferMatrixDI(l, lambda, r_CatEye);
% H_fsf = Cal_FreeSpaceTransferMatrixDI(f, lambda, r_CatEye);

H_fsdf = Cal_FreeSpaceTransferMatrixAS(d+f, lambda, r_CatEye);
H_fsdf2 = Cal_FreeSpaceTransferMatrixAS(d+f, lambda, r_CatEye);
H_fsl = Cal_FreeSpaceTransferMatrixAS(l, lambda, r_CatEye);
H_fsf = Cal_FreeSpaceTransferMatrixAS(f, lambda, r_CatEye);

H_lens = Cal_LensImpactMatrix(f, lambda, r_CatEye);
H_lensShift = Cal_LensImpactMatrixShift(f, lambda, r_CatEye, 0);
B_lens = Cal_BoundaryFunction(r_CatEye, r_CatEye, 0);
B_aper = Cal_BoundaryFunction(r_aperture, r_CatEye, 0);
B_lensshift = Cal_BoundaryFunction(r_CatEye, r_CatEye, 0);

s = [0 0.0001 0.0002 0 0.0001 0.0002 0 0.0001 0.0002 0 0.0001 0.0002];

for shift = [0 0.0001 0.0002 0 0.0001 0.0002 0 0.0001 0.0002]
    shift2 = -shift;
rp = 1;
ro = 1;
if i > 3
    ro = 0.4;
end
if i > 6 
    rp = 0;
end
H_shiftphase1 = Cal_ShiftPhaseMatrixAS(0, shift, r_CatEye);
H_shiftphase2 = Cal_ShiftPhaseMatrixAS(0, shift2, r_CatEye);

[Si,finalDistribution, V_i] = Cal_DiffractionLoss(H_fsdf, H_fsdf2, H_fsl,...
       H_lens,H_lensShift, H_fsf, B_lens, B_aper, B_lensshift, r_CatEye, H_shiftphase1, H_shiftphase2, ro, rp);
V = [V V_i]
S = [S Si]


[x,y]=meshgrid(linspace(-2*r_CatEye, 2*r_CatEye, samplingNum));
subplot(3,3,i);

mesh(x,y,finalDistribution);
title(['rp=',num2str(rp),' ro=',num2str(ro)])
% colormap hot; 
shading interp;
grid on
box off
drawnow
i = i + 1;
end
% figure(1)
% [x,y]=meshgrid(linspace(-2*r_CatEye, 2*r_CatEye, samplingNum));
% mesh(x,y,finalDistribution);
% colormap hot; 
% shading interp;
% grid on
% box off