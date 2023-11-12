clc
clear all
close all

gpuDevice(2)
V_pb = [];
S_pb = [];
Vp_pb= [];
itr_pb = [];
ThreshP = [];
Vvec_pb = [];
Pout_pb = [];

V_np = [];
S_np = [];
itr_np = [];
ThreshNP = [];
Vvec_np = [];
Pout_np = [];

V_pbm= [];
S_pbm= [];
Vp_pm= [];
itr_pm = [];
ThreshPm = [];
Vvec_pm = [];
Pout_pm = [];

ER = [];
ERm = [];
ifModu = [];

opd = [];
i = 1;

d = 0.003;
r_aperture = 0.00006;
r_CatEye = 0.00018;
r_aperture = r_CatEye;
f = 0.001;

d = 3; 
r_aperture = 0.0020;
r_CatEye = 0.0025;
%r_aperture = r_CatEye;
f = 0.02;
l = 0.052;

fRR = 3;

l = f^2./(2*fRR)+f;
eta_excit = 0.72;
I_s = 12600000;
Vs = 0.99;

[itr, samplingNum, windowExpandFactor,...
    windowSize, delta, deltaF, lambda] = Para_FFTAlgorithm_V2(r_CatEye, f, 0);
% H_fsdf = Cal_FreeSpaceTransferMatrixDIShift(d+f, lambda, r_CatEye, 0);
% H_fsdf2 = Cal_FreeSpaceTransferMatrixDIShift(d+f, lambda, r_CatEye, 0);
% H_fsl = Cal_FreeSpaceTransferMatrixDI(l, lambda, r_CatEye);
% H_fsf = Cal_FreeSpaceTransferMatrixDI(f, lambda, r_CatEye);

H_fsl = Cal_FreeSpaceTransferMatrixAS(l, lambda, r_CatEye);
H_fsf = Cal_FreeSpaceTransferMatrixAS(f, lambda, r_CatEye);
H_fsr = Cal_FreeSpaceTransferMatrixAS(2*r_CatEye, lambda, r_CatEye);

H_lens = Cal_LensImpactMatrix(f, lambda, r_CatEye);
H_lensShift = Cal_LensImpactMatrixShift(f, lambda, r_CatEye, 0, 0);
B_lens = Cal_BoundaryFunction(r_CatEye, r_CatEye, 0);
B_aper = Cal_BoundaryFunction(r_aperture, r_CatEye, 0);
B_lensShift = Cal_BoundaryFunction(r_CatEye, r_CatEye, 0);

Rp = 0;
Ro = 0.99;
H_fsdf = Cal_FreeSpaceTransferMatrixAS(d+f, lambda, r_CatEye);

tiltPsi = 0;
if tiltPsi ~= 0
    tiltParam(1) = tiltPsi;
    tiltParam(2) = samplingNum; 
    tiltParam(3) = deltaF; 
    tiltParam(4) = lambda;
else
    tiltParam = 0;
end


shift=0;
shift2 = -shift;
windowTimes = floor(abs(shift)/(r_CatEye * 3))+1
shiftWindow = shift / windowTimes;

H_shiftwindow_forward = Cal_ShiftPhaseMatrixAS(0, shiftWindow, r_CatEye);
H_shiftwindow_backward = Cal_ShiftPhaseMatrixAS(0, -shiftWindow, r_CatEye);



ss = [-0.4:0.05:0.4];
as = [15:15:75]./180.*pi;
ss = tan(as) * d;
ds = [0.5:0.1:6];
xAxis = as ./pi .*180;
% xAxis = as;
A_gm = r_aperture ^ 2 * pi;
disp("Ready Prepared, Starting Iteration...")
for d = ds
 



H_fsw = Cal_FreeSpaceTransferMatrixAS(d/windowTimes, lambda, r_CatEye);


ro = sqrt(Ro);
rp = sqrt(Rp);
opd = (r_CatEye + sqrt(d^2 + shift^2) + 2*f + 2*l) * 2;

% Protective beam scenario
[S_i, U_eigen, U_pb, itr_times, Vp, Vvec_pbi] = Cal_Mode_V3_multipleV(H_fsw, windowTimes, H_fsl,...
       H_lens,H_lensShift, H_fsf, B_lens, B_aper, B_lensShift, r_CatEye, H_shiftwindow_forward, ...
       H_shiftwindow_backward, tiltParam, ro, rp, opd);
   V_i = Cal_DiffractionEfficiency(U_eigen, U_pb);
Vp_pb = [Vp_pb Vp]; %单保护光走一次roundtrip的效率
V_pb = [V_pb V_i]%加保护光的整体系统效率
S_pb = [S_pb S_i];
Vvec_pb = [Vvec_pb Vvec_pbi]
itr_pb = [itr_pb itr_times];


ER_i = Cal_EquivalentReflect_V2_own(opd, lambda, 0, Ro, Rp, V_i);
ER = [ER ER_i];
ThreshP_i = Cal_PowerThresh(1, ER_i, V_i, 1, Vs, eta_excit, A_gm,I_s);
ThreshP = [ThreshP ThreshP_i];


% Naked Resonant beam scenario
[S_ni, U_eigen, U_np, itr_times,~,Vvec_npi] = Cal_Mode_V3_multipleV(H_fsw, windowTimes, H_fsl,...
       H_lens,H_lensShift, H_fsf, B_lens, B_aper, B_lensShift, r_CatEye, H_shiftwindow_forward, H_shiftwindow_backward, tiltParam, 1, 0);
   V_ni = Cal_DiffractionEfficiency(U_eigen, U_np);
V_np = [V_np V_ni]
S_np = [S_np S_ni];
Vvec_np = [Vvec_np Vvec_npi]
itr_np = [itr_np itr_times]
ThreshNP_i = Cal_PowerThresh(1, Ro, V_ni, 1, 0.99, eta_excit, A_gm,I_s);
ThreshNP = [ThreshNP ThreshNP_i];


% Modulation scenario
ERm_i = ER_i;
ThreshPm_i = ThreshP_i;
S_mi = S_i;
V_mi = V_i;
Vvec_pmi = Vvec_pbi;
modu_len = 0;

try 
    V_mi_last = V_pbm(end); % The first point will throw invalid index exception 'cuz V_pbm==[]
catch 
    V_mi_last = V_mi;
end

try
    ERm_last = ERm(end);
catch
    ERm_last = ERm_i;
end

if ERm_i < Ro || V_mi_last - V_mi > 0.1 || ERm_last - ERm_i > 0.2
    disp("Perform half wavelength modulation")
    modu_len = 0.5 * lambda;
    opd = opd + modu_len;
    V_mi_old = V_mi;
    S_mi_old = S_mi;
    Vvec_old = Vvec_pbi;
    ERm_i_old = ERm_i;
    Vp_old = Vp;
    [S_mi, U_eigen, U_pm, itr_times, Vp, Vvec_pmi] = Cal_Mode_V3_multipleV(H_fsw, windowTimes, H_fsl,...
       H_lens,H_lensShift, H_fsf, B_lens, B_aper, B_lensShift, r_CatEye,...
       H_shiftwindow_forward, H_shiftwindow_backward, tiltParam, ro, rp, opd);
    V_mi = Cal_DiffractionEfficiency(U_eigen, U_pm);    
    ERm_i = Cal_EquivalentReflect_V2_own(opd, lambda, 0, Ro, Rp, V_i);
    if V_mi < V_mi_old || ERm_i < ERm_i_old
        disp("Modulation fail, back out to unmodulated...")
        V_mi = V_mi_old;
        S_mi = S_mi_old;
        Vvec_pmi = Vvec_old;
        ERm_i = ERm_i_old;
    end
    ThreshPm_i = Cal_PowerThresh(1, ERm_i, V_mi, 1, 0.99, eta_excit, A_gm,I_s);
end
ifModu = [ifModu ERm_i==ER_i];
Vp_pm = [Vp_pm Vp];
V_pbm = [V_pbm V_mi]
S_pbm = [S_pbm S_mi];
Vvec_pm = [Vvec_pm Vvec_pmi]
itr_pm = [itr_pm itr_times]
ERm = [ERm ERm_i];
ThreshPm = [ThreshPm ThreshPm_i];

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
end

g0l = (eta_excit.*floor(ThreshNP)) ./ (A_gm*I_s);
P_out = Cal_PowerOutput(A_gm, I_s, Vvec_pm, Vs, g0l, ERm);
P_out1 = Cal_PowerOutput(S_pbm, I_s, Vvec_pm, Vs, g0l, ERm);


clear B_aper B_lensShift B_lens Pout_i
clear H_fsdf H_fsr H_shiftwindow_backward H_shiftwindow_forward H_fsf
save ../res/r25_final_tilt_d=3.mat

% figure
% hold on
% plot(xAxis, floor(ThreshNP), 'linewidth', 1.5);
% plot(xAxis, ThreshPm, 'linewidth', 1.5);
% plot(xAxis, ThreshNP, 'linewidth', 1.2);
% plot(xAxis, P_out, 'linewidth', 1.5);
% % plot(xAxis, P_out1, 'linewidth', 1.5);
% legend('Power Input', 'Power Threshold With MPB','Power Threshold Without PB','Power Output');
% box on 
% grid on
% hold off
% 
% figure;
% hold on
% plot(xAxis, V_pb, 'linewidth', 1.5);
% plot(xAxis, V_pbm, 'linewidth', 1.2);
% plot(xAxis, V_np, 'linewidth', 1.2);
% legend('Transfer Efficiency with PB', 'Transfer Efficiency with mPB', 'Transfer Efficiency without PB');
% 
% figure
% hold on
% plot(xAxis, ER, 'linewidth', 1.5)
% plot(xAxis, ERm, 'linewidth', 1)
% plot(xAxis, repelem(Ro, length(ER)))
% hold off
% legend('Equivalent Reflectivity','Modulated Reflectivity','Physical Reflectivity')%,'Designated Threshold')
% 
% figure;
% plot(xAxis, ThreshP, 'linewidth', 1.5);
% hold on
% plot(xAxis, ThreshPm, 'linewidth', 1);
% plot(xAxis, ThreshNP, 'linewidth', 1.2);
% legend('Power Threshold With PB', 'Power Threshold With MPB','Power Threshold Without PB');
% 
