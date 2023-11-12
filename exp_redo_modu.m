clc

close all


V_pbm= [];
S_pbm= [];
itr_pm = [];
ThreshPm = [];
ERm = [];

opd = [];
i = 1;

% ////////// /////// 从此处开始和exp对齐  ////////// /////// 
d = 0.003;
r_aperture = 0.00006;
r_CatEye = 0.00018;
r_aperture = r_CatEye;
f = 0.001;

d = 1.5;
r_aperture = 0.0012;
r_CatEye = 0.0012;
r_aperture = r_CatEye;
f = 0.01;
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


H_fsdf = Cal_FreeSpaceTransferMatrixAS(d+f, lambda, r_CatEye);
H_fsdf2 = Cal_FreeSpaceTransferMatrixAS(d+f, lambda, r_CatEye);

tiltPsi = 0;
if tiltPsi ~= 0
    tiltParam(1) = tiltPsi;
    tiltParam(2) = sampN; 
    tiltParam(3) = deltaF; 
    tiltParam(4) = lambda;
else
    tiltParam = 0;
end

ss = [0:0.01:0.05];
ds = [0.001:0.001:0.005];
ps = [9/180*pi:9/180*pi:0.5*pi];
ds = [0.5:0.05:5];
xAxis = ss;
A_gm = r_aperture ^ 2 * pi;
for shift = ss


    shift2 = -shift;
    H_shiftphase1 = Cal_ShiftPhaseMatrixAS(0, shift, r_CatEye);
    H_shiftphase2 = Cal_ShiftPhaseMatrixAS(0, shift2, r_CatEye);

    Ros = [Ros Ro];
    Rps = [Rps Rp];
    
    
    ro = sqrt(Ro);
    rp = sqrt(Rp);
    opd = (r_CatEye + sqrt(d^2 + shift^2) + 2*f + 2*l) * 2;

% ////////// /////// 从此处结束和exp对齐  ////////// /////// 

    ERm_i = ER(i);
    ThreshPm_i = ThreshP(i);
    ThreshNP_i = ThreshNP(i);
    S_mi = S_pb(i);
    V_mi = V_pb(i);
    modu_len = 0;

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
        [S_mi, finalDistribution, U_eigen, U_pm, itr_times] = Cal_Mode(H_fsdf, H_fsdf2, H_fsl,...
           H_lens,H_lensShift, H_fsf, B_lens, B_aper, B_lensshift, r_CatEye,...
           H_shiftphase1, H_shiftphase2, tiltPsi, ro, rp, opd);
        V_mi = Cal_DiffractionEfficiency(U_eigen, U_pm);    
        ERm_i = Cal_EquivalentReflect_V2_own(opd, lambda, 0, Ro, Rp, V_mi);
        if V_mi < V_mi_old || ERm_i < ERm_i_old
            disp("Modulation fail, back out to unmodulated...")
            V_mi = V_mi_old;
            ERm_i = ERm_i_old;
        end
        ThreshPm_i = Cal_PowerThresh(1, ERm_i, V_mi, 1, 0.99, eta_excit, A_gm,I_s);
    end
    V_pbm = [V_pbm V_mi]
    S_pbm = [S_pbm S_mi]
    itr_pm = [itr_pm itr_times]
    ERm = [ERm ERm_i];
    ThreshPm = [ThreshPm ThreshPm_i]
    i = i + 1
end