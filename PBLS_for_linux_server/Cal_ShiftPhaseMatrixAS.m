function [H] = Cal_ShiftPhaseMatrixAS(shift_x, shift_y, r_CatEye)
   [~, samplingNum, ~, ~, ~, deltaF] = Para_FFTAlgorithm(r_CatEye);
   M = samplingNum;                                                        %采样点数量 M
   [n1, n2]=meshgrid(linspace(-M/2, M/2-1, M));                            %生成采样点下标
   H=(exp(1i*2*pi*(n1*deltaF*shift_x+n2*deltaF*shift_y))); %公式（9）计算传递函数矩阵
end