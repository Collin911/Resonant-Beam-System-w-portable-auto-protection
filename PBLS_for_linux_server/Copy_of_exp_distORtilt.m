clc
clear all
close all

gpuDevice(1);
V_pb = [];
S_pb = [];
Vp_pb= [];
itr_pb = [];
ThreshP = [];
V_np = [];
S_np = [];
itr_np = [];
ThreshNP = [];
V_pbm= [];
S_pbm= [];
Vp_pm= [];
itr_pm = [];
ThreshPm = [];
ER = [];
ERm = [];

opd = [];
i = 1;

d = 0.003;
r_aperture = 0.00006;
r_CatEye = 0.00018;
r_aperture = r_CatEye;
f = 0.001;

d = 2;
r_aperture = 0.0025;
r_CatEye = 0.0012;
r_aperture = r_CatEye;
f = 0.02;
% l = 0.052;

fRR = 3;

l = f^2./(2*fRR)+f;
eta_excit = 0.72;
I_s = 12600000;

[itr, samplingNum, windowExpandFactor,...
    windowSize, delta, deltaF, lambda] = Para_FFTAlgorithm(r_CatEye);
% H_fsdf = Cal_FreeSpaceTransferMatrixDIShift(d+f, lambda, r_CatEye, 0);
% H_fsdf2 = Cal_FreeSpaceTransferMatrixDIShift(d+f, lambda, r_CatEye, 0);
% H_fsl = Cal_FreeSpaceTransferMatrixDI(l, lambda, r_CatEye);
% H_fsf = Cal_FreeSpaceTransferMatrixDI(f, lambda, r_CatEye);

H_fsl = Cal_FreeSpaceTransferMatrixAS(l, lambda, r_CatEye);
H_fsf = Cal_FreeSpaceTransferMatrixAS(f, lambda, r_CatEye);
H_fsr = Cal_FreeSpaceTransferMatrixAS(2*r_CatEye, lambda, r_CatEye);

H_lens = Cal_LensImpactMatrix(f, lambda, r_CatEye);
H_lensShift = Cal_LensImpactMatrixShift(f, lambda, r_CatEye, 0);
B_lens = Cal_BoundaryFunction(r_CatEye, r_CatEye, 0);
B_aper = Cal_BoundaryFunction(r_aperture, r_CatEye, 0);
B_lensshift = Cal_BoundaryFunction(r_CatEye, r_CatEye, 0);

Ros = [];
Rps = [];
Rp = 1;
Ro = 0.4;

shift = 0;
shift2 = -shift;
H_shiftphase1 = Cal_ShiftPhaseMatrixAS(0, shift, r_CatEye);
H_shiftphase2 = Cal_ShiftPhaseMatrixAS(0, shift2, r_CatEye);




tiltPsi = 0;
if tiltPsi ~= 0
    tiltParam(1) = tiltPsi;
    tiltParam(2) = samplingNum; 
    tiltParam(3) = deltaF; 
    tiltParam(4) = lambda;
else
    tiltParam = 0;
end

ss = -0.2:0.02:0.2;
ds = 0.001:0.001:0.005;
ps = [30]./180.*pi;
ds = 2:lambda/16:2+1.5*lambda;
xAxis = ds;
A_gm = r_aperture ^ 2 * pi;
for d = ds
tic

H_fsdf = Cal_FreeSpaceTransferMatrixAS(d+f, lambda, r_CatEye);
H_fsdf2 = Cal_FreeSpaceTransferMatrixAS(d+f, lambda, r_CatEye);


Ros = [Ros Ro];
Rps = [Rps Rp];


ro = sqrt(Ro);
rp = sqrt(Rp);
opd = (r_CatEye + sqrt(d^2 + shift^2) + 2*f + 2*l) * 2;

[S_i, finalDistribution, U_eigen, U_pb, itr_times, Vp] = Cal_Mode_V2(H_fsdf, H_fsl,...
       H_lens,H_lensShift, H_fsf, B_lens, B_aper, B_lensshift, r_CatEye, H_shiftphase1, ...
       H_shiftphase2, tiltParam, ro, rp, opd);
V_i = Cal_DiffractionEfficiency(U_eigen, U_pb);
Vp_pb = [Vp_pb Vp] %单保护光走一次roundtrip的效率
V_pb = [V_pb V_i]%加保护光的整体系统效率
S_pb = [S_pb S_i]
itr_pb = [itr_pb itr_times]

%mesh(abs(finalDistribution));
ER_i = Cal_EquivalentReflect_V2_own(opd, lambda, 0, Ro, Rp, Vp);
ER = [ER ER_i];
ThreshP_i = Cal_PowerThresh(1, ER_i, V_i, 1, 0.99, eta_excit, A_gm,I_s);
ThreshP = [ThreshP ThreshP_i]


[S_ni, finalDistribution, U_eigen, U_np, itr_times] = Cal_Mode(H_fsdf, H_fsl,...
       H_lens,H_lensShift, H_fsf, B_lens, B_aper, B_lensshift, r_CatEye, H_shiftphase1, H_shiftphase2, tiltParam, 1, 0);
   V_ni = Cal_DiffractionEfficiency(U_eigen, U_np);
V_np = [V_np V_ni]
S_np = [S_np S_ni]
itr_np = [itr_np itr_times]
ThreshNP_i = Cal_PowerThresh(1, Ro, V_ni, 1, 0.99, eta_excit, A_gm,I_s);
ThreshNP = [ThreshNP ThreshNP_i] 

ERm_i = ER_i;
ThreshPm_i = ThreshP_i;
S_mi = S_i;
V_mi = V_i;
modu_len = 0;
% while (ThreshPm_i > 0.8 * ThreshNP_i) || ERm_i < Ro
%     modu_len = modu_len + 3/4*lambda;
%     [S_mi,finalDistribution, V_mi] = Cal_DiffractionLoss(H_fsdf, H_fsdf2, H_fsl,...
%        H_lens,H_lensShift, H_fsf, B_lens, B_aper, B_lensshift, r_CatEye,...
%        H_shiftphase1, H_shiftphase2, Ro, Rp, modu_len);
%     opd = (r_CatEye + sqrt(d^2 + shift^2)) * 2 + modu_len;
%     ERm_i = Cal_EquivalentReflect(opd, lambda, 0, Ro, Rp, V_mi, 0, 0);
%     ThreshPm_i = Cal_PowerThresh(1, ERm_i, V_mi, 1, 0.99, eta_excit, A_gm,I_s);
%     if modu_len == 3 * lambda
%         break
%     end
% end

try 
    V_mi_last = V_pbm(end); % The first point will throw invalid index exception 'cuz V_pbm==[]
catch 
    V_mi_last = V_mi;
end

if ERm_i < 1.1*Ro || V_mi_last - V_mi > 0.08 || ThreshPm_i > ThreshNP_i
    disp("Perform half wavelength modulation")
    modu_len = 0.5 * lambda;
    opd = opd + modu_len;
    V_mi_old = V_mi;
    ERm_i_old = ERm_i;
    Vp_old = Vp;
    [S_mi, finalDistribution, U_eigen, U_pm, itr_times, Vp] = Cal_Mode_V2(H_fsdf, H_fsl,...
       H_lens,H_lensShift, H_fsf, B_lens, B_aper, B_lensshift, r_CatEye,...
       H_shiftphase1, H_shiftphase2, tiltParam, ro, rp, opd);
    
    V_mi = Cal_DiffractionEfficiency(U_eigen, U_pm);    
    ERm_i = Cal_EquivalentReflect_V2_own(opd, lambda, 0, Ro, Rp, Vp);
    if V_mi < V_mi_old || ERm_i < ERm_i_old
        disp("Modulation fail, back out to unmodulated...")
        Vp = Vp_old;
        V_mi = V_mi_old;
        ERm_i = ERm_i_old;
    end
    ThreshPm_i = Cal_PowerThresh(1, ERm_i, V_mi, 1, 0.99, eta_excit, A_gm,I_s);
end
Vp_pm = [Vp_pm Vp]
V_pbm = [V_pbm V_mi]
S_pbm = [S_pbm S_mi]
itr_pm = [itr_pm itr_times]
ERm = [ERm ERm_i];
ThreshPm = [ThreshPm ThreshPm_i]

% % [x,y]=meshgrid(linspace(-2*r_CatEye, 2*r_CatEye, samplingNum));
% subplot(4,5,i);
% % mesh(x,y,finalDistribution);
% mesh(finalDistribution);
% view(2);
% title(['d=' num2str(d)]);
% 
% % colormap hot; 
% shading interp;
% grid on
% box off
% drawnow
i = i + 1
toc
end
sgtitle('Field Distribution')



figure;
hold on
plot(xAxis, V_pb, 'linewidth', 1.5);
plot(xAxis, V_pbm, 'linewidth', 1.2);
plot(xAxis, V_np, 'linewidth', 1.2);
legend('Transfer Efficiency with PB', 'Transfer Efficiency with mPB', 'Transfer Efficiency without PB');

figure
% ER = Cal_EquivalentReflect(opd, lambda, 0, Ros, Rps, V_pb, 0, 0)
hold on
plot(xAxis, ER, 'linewidth', 1.5)
% ERm = Cal_EquivalentReflect(opd, lambda, 0, Ros, Rps, V_pb, 1, 0.63)
plot(xAxis, ERm, 'linewidth', 1)
plot(xAxis, Ros)
% plot(xAxis, ones(size(xAxis) * 0.63)
hold off
legend('Equivalent Reflectivity','Modulated Reflectivity','Physical Reflectivity')%,'Designated Threshold')

figure;

% T = Cal_PowerThresh(1, ER, V_pb, 1, 0.99, eta_excit, S_pb,12600000);
% Tm = Cal_PowerThresh(1, ERm, V_pb, 1, 0.99, eta_excit, S_pb,12600000);
% To = Cal_PowerThresh(1, Ros, V_np, 1, 0.99, eta_excit, S_np,12600000);
plot(xAxis, ThreshP, 'linewidth', 1.5);
hold on
plot(xAxis, ThreshPm, 'linewidth', 1);
plot(xAxis, ThreshNP, 'linewidth', 1.2);
legend('Power Threshold With PB', 'Power Threshold With MPB','Power Threshold Without PB');

% figure(1),'Modulated Reflectivity'
% [x,y]=meshgrid(linspace(-2*r_CatEye, 2*r_CatEye, samplingNum));
% mesh(x,y,finalDistribution);
% colormap hot; 
% shading interp;
% grid on
% box off