function [H] = Cal_FreeSpaceTransferMatrixAS(length, lambda, r_CatEye)
   [~, samplingNum, ~, ~, ~, deltaF] = Para_FFTAlgorithm(r_CatEye);
   k = 2 * pi ./ lambda;                                                   %引入采样点数量、频域采样间隔
   M = samplingNum;                                                        %采样点数量 M
   [n1, n2]=meshgrid(linspace(-M/2, M/2-1, M));                            %生成采样点下标
   H=exp(1i*k*length*sqrt(1-(lambda*n1*deltaF).^2-(lambda*n2*deltaF).^2)); %公式（9）计算传递函数矩阵
   
   f_limit = 1./(lambda * sqrt((2 * length * deltaF)^2 + 1));
   i = find((n1*deltaF < -f_limit) | (n2*deltaF < -f_limit) | (n1*deltaF > f_limit) | (n2*deltaF > f_limit));
   H(i) = 0;
end