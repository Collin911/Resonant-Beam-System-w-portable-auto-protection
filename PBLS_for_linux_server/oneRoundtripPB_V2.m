function [U] = oneRoundtripPB_V2(U_pre, H_fsdf, H_fsl, H_lens,H_lensShift,...
    H_fsf, B_lens, B_aper, B_lensshift, delta, H_shiftphase1, H_shiftphase2, tiltParam)

    U = Cast_FreeSpace(U_pre, H_fsl, B_lensshift, B_lensshift);              %M2-L2'入射表面

    U = Cast_lensImpact(U, H_lensShift, B_lensshift);
    %%保护光不设接收端回复反射
    U = Cast_FreeSpaceShift(U, H_fsdf, B_aper, B_lensshift, H_shiftphase2);             %L2'出射表面-孔阑
     
    U = Cast_FreeSpace(U, H_fsf, B_lens, B_aper);              %孔阑到L1入射表面
    if tiltParam ~= 0
        psi = tiltParam(1);
        sampN = tiltParam(2); 
        deltaF = tiltParam(3); 
        lambda = tiltParam(4);
        U = Cast_TiltPlane(U, B_lens, B_aper, -psi, sampN, lambda, deltaF);
    end
    U = Cast_lensImpact(U, H_lens, B_lens);                                 %L1入射表面-L1出射表面
    U = Cast_FreeSpace(U, H_fsl, B_lens, B_lens);              %L2出射表面-M2

    U = Cast_FreeSpace(U, H_fsl, B_lens, B_lens);              %M1-L1'入射表面
    U = Cast_lensImpact(U, H_lens, B_lens);                                 %L1'入射表面-L1'出射表面
    U = Cast_FreeSpace(U, H_fsf, B_aper, B_lens);              %L1'出射表面-孔阑

    
    U = Cast_FreeSpaceShift(U, H_fsdf, B_lensshift, B_aper, H_shiftphase1);         %孔阑到L2入射表面
    if tiltParam ~= 0
        U = Cast_TiltPlane(U, B_lens, B_aper, psi, sampN, lambda, deltaF);
    end
    U = Cast_lensImpact(U, H_lensShift, B_lensshift);                                 %L2入射表面-L2出射表面
    U = Cast_FreeSpace(U, H_fsl, B_lensshift, B_lensshift);              %L2出射表面-M2





%     U = Cal_AperturetoLens1(U_pre, H_fsl, B_lensshift, B_lensshift, delta);              %M2-L2'入射表面
% %     mesh(abs(U));
% %     U = Cal_lensImpact(U, H_lensShift, B_lensshift);                                 %L2'入射表面-L2'出射表面
%     U = Cal_AperturetoLens2(U, H_fsdf, B_aper, B_lensshift, delta, H_shiftphase2);             %L2'出射表面-孔阑
% 
% %     mesh(abs(U));
%     
%     U = Cal_AperturetoLens1(U, H_fsf, B_lens, B_aper, delta);              %孔阑到L1入射表面
% %     mesh(abs(U));
%     U = Cal_lensImpact(U, H_lens, B_lens);                                 %L1入射表面-L1出射表面
%     U = Cal_AperturetoLens1(U, H_fsl, B_lens, B_lens, delta);              %L2出射表面-M2
% %     mesh(abs(U));
%     U = Cal_AperturetoLens1(U, H_fsl, B_lens, B_lens, delta);              %M1-L1'入射表面
%     U = Cal_lensImpact(U, H_lens, B_lens);                                 %L1'入射表面-L1'出射表面
%     U = Cal_AperturetoLens1(U, H_fsf, B_aper, B_lens, delta);              %L1'出射表面-孔阑
% %     mesh(abs(U));
%     
%     U = Cal_AperturetoLens2(U, H_fsdf, B_lensshift, B_aper, delta, H_shiftphase1);         %孔阑到L2入射表面
%     U = Cal_lensImpact(U, H_lensShift, B_lensshift);                                 %L2入射表面-L2出射表面
%     U = Cal_AperturetoLens1(U, H_fsl, B_lensshift, B_lensshift, delta);              %L2出射表面-M2
% %     mesh(abs(U));
   
end