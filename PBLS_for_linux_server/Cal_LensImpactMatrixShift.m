function [H] = Cal_LensImpactMatrixShift(length, lambda, r_CatEye, shift_x, shift_y)
    if(~exist('shift_y','var'))
        shift_y = 0;  % 如果未出现该变量，则对其进行赋值
    end
   [~, samplingNum, ~, ~, delta, ~] = Para_FFTAlgorithm(r_CatEye);
   k = 2 * pi ./ lambda;                                                   %引入采样点数量、频域采样间隔
   M = samplingNum;                                                        %采样点数量 M
   [n1, n2]=meshgrid(linspace(-M/2, M/2-1, M));                            %生成采样点下标
   H=exp(-j*k./(2*length)*((n1*delta+shift_x).^2+(n2*delta+shift_y).^2));                  %公式（9）计算传递函数矩阵
%    H=exp(-j*k*(length-sqrt(length.^2+(n1*delta).^2+(n2*delta+shift).^2)));
end

% function [H] = Cal_LensImpactMatrixOffset(length, lambda, r_CatEye, ofx, ofy)
%    [~, samplingNum, ~, ~, delta, ~] = Para_FFTAlgorithm(r_CatEye);
%    k = 2 * pi ./ lambda;                                                   %引入采样点数量、频域采样间隔
%    M = samplingNum;                                                        %采样点数量 M
%    [n1, n2]=meshgrid(linspace(-M/2, M/2-1, M));                            %生成采样点下标
%    H=exp(-j*k./(2*length)*((n1*delta + ofx / delta).^2+(n2*delta+ofy).^2));                  %公式（9）计算传递函数矩阵
% %    H=exp(-j*k*(length-sqrt(length.^2+(n1*delta).^2+(n2*delta+shift).^2)));
% end

