function [U] = oneRoundtripWithPB(U_pre, H_fsdf,H_fsdf2, H_fsl, H_lens,H_lensShift,...
    H_fsf, B_lens, B_aper, B_lensshift, delta, H_shiftphase1, H_shiftphase2, tiltParam, ro, rp, PBmodulation_len)
    if(~exist('PBmodulation','var'))
        PBmodulation_len = 0;  % ���δ���ָñ������������и�ֵ
    end
% �Կ���Ϊ��ʼƽ��   
    %mesh(abs(U_pre));
    U = Cal_AperturetoLens2(U_pre, H_fsdf, B_lensshift, B_aper, delta, H_shiftphase1);         %������L2�������
%     mesh(abs(U));
    if tiltParam ~= 0
        psi = tiltParam(1);
        sampN = tiltParam(2); 
        deltaF = tiltParam(3); 
        lambda = tiltParam(4);
        U = Cal_TransTiltPlane(U, B_lens, B_aper, psi, sampN, lambda, deltaF);
    end
    U = Cal_lensImpact(U, H_lensShift, B_lensshift);                                 %L2�������-L2�������
    U = Cal_AperturetoLens1(U, H_fsl, B_lensshift, B_lensshift, delta);              %L2�������-M2
    %U = Cal_FieldNormalization(U);
    %U = rot90(U, 2);
%     mesh(abs(U));
    pU = 0;
    to = sqrt(1-ro^2);
    if ro ~= 1 && rp~= 0
        pU = oneRoundtripPB(U .* to, H_fsdf,H_fsdf2, H_fsl, H_lens,H_lensShift,...
        H_fsf, B_lens, B_aper, B_lensshift, delta, H_shiftphase1, H_shiftphase2, tiltParam); %���㱣����һ������
    end
    [~, ~, ~, ~, ~, ~, lambda] = Para_FFTAlgorithm(0);
    pU = Modulate(pU, lambda, PBmodulation_len);
    U_M2_total = U .* ro + pU .* to .* rp;
    
    U = Cal_AperturetoLens1(U_M2_total, H_fsl, B_lensshift, B_lensshift, delta);              %M2-L2'�������
%     mesh(abs(U));
    U = Cal_lensImpact(U, H_lensShift, B_lensshift);                                 %L2'�������-L2'�������
    U = Cal_AperturetoLens2(U, H_fsdf2, B_aper, B_lensshift, delta, H_shiftphase2);             %L2'�������-����
%     mesh(abs(U));
    
    U = Cal_AperturetoLens1(U, H_fsf, B_lens, B_aper, delta);              %������L1�������
    if tiltParam ~= 0
        U = Cal_TransTiltPlane(U, B_lens, B_aper, -psi, sampN, lambda, deltaF);
    end
%     mesh(abs(U));
    U = Cal_lensImpact(U, H_lens, B_lens);                                 %L1�������-L1�������
    U = Cal_AperturetoLens1(U, H_fsl, B_lens, B_lens, delta);              %L1�������-M1
    %U = rot90(U, 2);
%     mesh(abs(U));
    U = Cal_AperturetoLens1(U, H_fsl, B_lens, B_lens, delta);              %M1-L1'�������
    U = Cal_lensImpact(U, H_lens, B_lens);                                 %L1'�������-L1'�������
    U = Cal_AperturetoLens1(U, H_fsf, B_aper, B_lens, delta);              %L1'�������-����
%     mesh(abs(U));
    
end