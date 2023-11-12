function [U,Vp, Vvector] = oneRoundtripWithPB_V4_multipleV(U_pre, H_fsw, windowTimes, H_fsl, H_lens,H_lensShift,...
    H_fsf, B_lens, B_aper, B_lensshift, delta, H_shiftwindow1, H_shiftwindow2, tiltParam, ro, rp, PB_path_len)
%此函数中采用滑动窗口法进行自由空间传输，请确保H_fsw传输距离为实际距离(d+f)/windowTimes
%H_shiftwindow离轴距离为实际距离shift/windowTimes
    Vvector = [];
    if(~exist('PB_path_len','var'))
        PB_path_len = 0;  % 如果未出现该变量，则对其进行赋值
    end
% 以孔阑为起始平面   
    %mesh(abs(U_pre));
    U = U_pre;
    for i = 1:windowTimes
        U = Cast_FreeSpaceShift(U, H_fsw, 1, B_aper, H_shiftwindow1);         %孔阑到L2焦点
    end
    U = Cast_FreeSpace(U, H_fsf, B_lensshift, B_aper);             %L2焦点到L2入射表面

%     mesh(abs(U));
    if tiltParam ~= 0
        psi = tiltParam(1);
        sampN = tiltParam(2); 
        deltaF = tiltParam(3); 
        lambda = tiltParam(4);
        U = Cast_TiltPlane(U, B_lens, B_aper, psi, sampN, lambda, deltaF);
    end
    U = Cast_lensImpact(U, H_lensShift, B_lensshift);                                 %L2入射表面-L2出射表面
    U = Cast_FreeSpace(U, H_fsl, B_lensshift, B_lensshift);              %L2出射表面-M2
    %U = Cal_FieldNormalization(U);
    %U = rot90(U, 2);
%     mesh(abs(U));
    
    [~, ~, ~, ~, ~, ~, lambda] = Para_FFTAlgorithm(0);
    dPhi = 2 * pi / lambda * PB_path_len;
    
    if ro ~= 1 && rp ~= 0
        Vp = Cal_DiffractionEfficiency(U, oneRoundtripPB_window(U, H_fsw, windowTimes, H_fsl, H_lens,H_lensShift,...
        H_fsf, B_lens, B_aper, B_lensshift, delta, H_shiftwindow1, H_shiftwindow2, tiltParam));
        coeff = (rp * Vp^2 * exp(1i*dPhi)  - ro) / (1 - ro * rp * Vp^2 * exp(1j * dPhi));
        nU = coeff .* U;
    else 
        Vp = 0;
        nU = U;
    end
    %U_M2_total = U .* ro + pU .* to .* rp;
    
    V2 = Cal_DiffractionEfficiency(U_pre, U);
    U_pre = U;

    U = Cast_FreeSpace(nU, H_fsl, B_lensshift, B_lensshift);              %M2-L2'入射表面
%     mesh(abs(U));
    U = Cast_lensImpact(U, H_lensShift, B_lensshift);                                 %L2'入射表面-L2'出射表面
    U = Cast_FreeSpace(U, H_fsf, B_lensshift, B_aper);             %L2出射表面到L2焦点
    for i = 1:windowTimes
        U = Cast_FreeSpaceShift(U, H_fsw, B_lensshift, B_aper, H_shiftwindow2);         %L2焦点到孔阑
    end

    V3 = Cal_DiffractionEfficiency(U_pre, U);
    U_pre = U;
    
%     mesh(abs(U));
    
    U = Cast_FreeSpace(U, H_fsf, B_lens, B_aper);              %孔阑到L1入射表面
    if tiltParam ~= 0
        U = Cast_TiltPlane(U, B_lens, B_aper, -psi, sampN, lambda, deltaF);
    end
%     mesh(abs(U));   
    U = Cast_lensImpact(U, H_lens, B_lens);                                 %L1入射表面-L1出射表面
    U = Cast_FreeSpace(U, H_fsl, B_lens, B_lens);              %L1出射表面-M1

    V4 = Cal_DiffractionEfficiency(U_pre, U);
    U_pre = U;
    %U = rot90(U, 2);
%     mesh(abs(U));
    U = Cast_FreeSpace(U, H_fsl, B_lens, B_lens);              %M1-L1'入射表面
    U = Cast_lensImpact(U, H_lens, B_lens);                                 %L1'入射表面-L1'出射表面
    U = Cast_FreeSpace(U, H_fsf, B_aper, B_lens);              %L1'出射表面-孔阑
    
    V1 = Cal_DiffractionEfficiency(U_pre, U);    
    Vvector = [V1 V2 V3 V4];
%     mesh(abs(U));
    
end