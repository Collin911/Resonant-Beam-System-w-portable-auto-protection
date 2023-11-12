function [H] = Cal_LensImpactMatrix(length, lambda, r_CatEye)
   [~, samplingNum, ~, ~, delta, ~] = Para_FFTAlgorithm(r_CatEye);
   k = 2 * pi ./ lambda;                                                   %引入采样点数量、频域采样间隔
   M = samplingNum;                                                        %采样点数量 M
   [n1, n2]=meshgrid(linspace(-M/2, M/2-1, M));                            %生成采样点下标
   H=exp(-1i*k./(2*length)*((n1*delta).^2+(n2*delta).^2));                  %公式（9）计算传递函数矩阵
end