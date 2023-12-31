function [S, finalDistribution, U_eigen, U_next, itr_times] = Cal_Mode(H_fsdf, H_fsl, H_lens,H_lensShift,...
    H_fsf, B_lens, B_aper, B_lensshift, r_CatEye, H_shiftphase1, H_shiftphase2, tiltParam, ro, rp, PB_path_len)
   [N_itr, ~, ~, ~, delta,~] = Para_FFTAlgorithm(r_CatEye);                 %引入迭代次数
    if(~exist('PB_path_len','var'))
        PB_path_len = 0;  % 如果未出现该变量，则对其进行赋值
    end   
%    length = 0.004;
%    shift = -0.0001;
%    lambda = 1064E-9;
%    primaryU = InitialTiltWave(length, shift, lambda, r_CatEye);
   
   primaryU = 1;                                                           %初始场分布
   if ro == 1 
   firstU = oneRoundtripDistribution_V2(primaryU, H_fsdf, H_fsl, H_lens,H_lensShift,...
       H_fsf, B_lens, B_aper, B_lensshift, delta, H_shiftphase1, H_shiftphase2, tiltParam);                                     %引入第一次round trip后输出镜上的分布
   else
   firstU = oneRoundtripWithPB_V3_own(primaryU, H_fsdf, H_fsl, H_lens,H_lensShift,...
       H_fsf, B_lens, B_aper, B_lensshift, delta, H_shiftphase1, H_shiftphase2, tiltParam, ro, rp, PB_path_len);                                      %引入第一次round trip后输出镜上的分布   
   end

   firstU = gpuArray(firstU);
   %开始迭代过程
   prevU = firstU;
   prevV = 1;
   itr = 0;
   while 1
       if ro == 1 && rp == 0
           U_eigen = oneRoundtripDistribution_V2(prevU, H_fsdf, H_fsl, H_lens,H_lensShift,...
       H_fsf, B_lens, B_aper, B_lensshift, delta, H_shiftphase1, H_shiftphase2, tiltParam);
       else
            U_eigen = oneRoundtripWithPB_V3_own(prevU, H_fsdf, H_fsl, H_lens,H_lensShift,...
       H_fsf, B_lens, B_aper, B_lensshift, delta, H_shiftphase1, H_shiftphase2, tiltParam, ro, rp, PB_path_len);  %这次像面即下次物面 
       end 
        U = U_eigen;                                                          
        U_abs = abs(U);                                                    %对振幅分布求模 = sqrt(a^2 + b^2)
        U_abs_maxArr = max(U_abs);                                           %幅值的最大值discrete*discrete到1*discrete
        U_abs_maxVal = max(U_abs_maxArr);                                       %幅值的最大值1*discrete到1*1
        m = U_abs./U_abs_maxVal;                                              %归一化后的幅值
        V = Cal_DiffractionEfficiency(prevU, U);        
        if abs(V - prevV) < 0.0001 || itr > N_itr
            break
        end
        U = U./U_abs_maxVal;                                                  %归一化
        prevU = U;
        prevV = V;
%         tempU = U_itr;
        itr = itr + 1;
        if mod(itr, 10) == 0
            if (mod(itr, 50) == 0 && itr > 100) || itr <= 100
                itr
            end
        end
   end
%    U = Cal_AperturetoLens2(s_it, H_fsdf, B_lensshift, B_aper, delta, H_shiftphase1);         %孔阑到L2入射表面
%    U = Cal_lensImpact(U, H_lensShift, B_lensshift);                                           %L2入射表面-L2出射表面
%    U = Cal_AperturetoLens1(U, H_fsl, B_lensshift, B_lensshift, delta);              %L2出射表面-M2
%    finalDistribution =  (abs(U)./(max(max(abs(U))))).^2;                                              %输出幅值

    if ro == 1 
       U_next = oneRoundtripDistribution_V2(U_eigen, H_fsdf, H_fsl, H_lens,H_lensShift,...
    H_fsf, B_lens, B_aper, B_lensshift, delta, H_shiftphase1, H_shiftphase2, tiltParam);
    else
        U_next = oneRoundtripWithPB_V3_own(U_eigen, H_fsdf, H_fsl, H_lens,H_lensShift,...
       H_fsf, B_lens, B_aper, B_lensshift, delta, H_shiftphase1, H_shiftphase2, tiltParam, ro, rp, PB_path_len);  %这次像面即下次物面 
    end 
   finalDistribution =  m.^2;

   temp = (1./exp(1)).*(max(max(m)));
   tempS = sum(sum(m>=temp));
   S = tempS*delta*delta;
   itr_times = itr;
end