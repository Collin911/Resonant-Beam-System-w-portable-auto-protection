function [U] = InitialTiltWave(length, shift, lambda, r_MAX)
   [~, samplingNum, ~, ~, delta, ~] = Para_FFTAlgorithm(r_MAX);
   k = 2 * pi ./ lambda;                                                   %引入采样点数量、频域采样间隔
   M = samplingNum;                                                        %采样点数量 M
   [~, n2]=meshgrid(linspace(-M/2, M/2-1, M));                            %生成采样点下标
   U=exp(-1i*k*(n2*delta)*sin(atan(shift/length))); %公式（9）计算传递函数矩阵
end