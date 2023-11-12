function [U] = oneRoundtripWithPB_V2_opticPrin(U_pre, H_fsdf,H_fsdf2, H_fsl, H_lens,H_lensShift,...
    H_fsf, B_lens, B_aper, B_lensshift, delta, H_shiftphase1, H_shiftphase2, tiltParam, ro, rp, PB_path_len)
    if(~exist('PB_path_len','var'))
        PB_path_len = 0;  % 如果未出现该变量，则对其进行赋值
    end
% 以孔阑为起始平面   
    %mesh(abs(U_pre));
    U = Cal_AperturetoLens2(U_pre, H_fsdf, B_lensshift, B_aper, delta, H_shiftphase1);         %孔阑到L2入射表面
%     mesh(abs(U));
    if tiltParam ~= 0
        psi = tiltParam(1);
        sampN = tiltParam(2); 
        deltaF = tiltParam(3); 
        lambda = tiltParam(4);
        U = Cal_TransTiltPlane(U, B_lens, B_aper, psi, sampN, lambda, deltaF);
    end
    U = Cal_lensImpact(U, H_lensShift, B_lensshift);                                 %L2入射表面-L2出射表面
    U = Cal_AperturetoLens1(U, H_fsl, B_lensshift, B_lensshift, delta);              %L2出射表面-M2
    %U = Cal_FieldNormalization(U);
    %U = rot90(U, 2);
%     mesh(abs(U));
    
    [~, ~, ~, ~, ~, ~, lambda] = Para_FFTAlgorithm(0);
    opd = 4 * pi / lambda * PB_path_len;
    nU = (1 - exp(1j * opd)) * ro / (1 - ro^2*exp(1j * opd)) .* U;
    %U_M2_total = U .* ro + pU .* to .* rp;
    
    U = Cal_AperturetoLens1(nU, H_fsl, B_lensshift, B_lensshift, delta);              %M2-L2'入射表面
%     mesh(abs(U));
    U = Cal_lensImpact(U, H_lensShift, B_lensshift);                                 %L2'入射表面-L2'出射表面
    U = Cal_AperturetoLens2(U, H_fsdf2, B_aper, B_lensshift, delta, H_shiftphase2);             %L2'出射表面-孔阑
%     mesh(abs(U));
    
    U = Cal_AperturetoLens1(U, H_fsf, B_lens, B_aper, delta);              %孔阑到L1入射表面
    if tiltParam ~= 0
        U = Cal_TransTiltPlane(U, B_lens, B_aper, -psi, sampN, lambda, deltaF);
    end
%     mesh(abs(U));
    U = Cal_lensImpact(U, H_lens, B_lens);                                 %L1入射表面-L1出射表面
    U = Cal_AperturetoLens1(U, H_fsl, B_lens, B_lens, delta);              %L1出射表面-M1
    %U = rot90(U, 2);
%     mesh(abs(U));
    U = Cal_AperturetoLens1(U, H_fsl, B_lens, B_lens, delta);              %M1-L1'入射表面
    U = Cal_lensImpact(U, H_lens, B_lens);                                 %L1'入射表面-L1'出射表面
    U = Cal_AperturetoLens1(U, H_fsf, B_aper, B_lens, delta);              %L1'出射表面-孔阑
%     mesh(abs(U));
    
end