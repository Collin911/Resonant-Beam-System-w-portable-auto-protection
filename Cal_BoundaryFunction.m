function [T] = Cal_BoundaryFunction(radius, r_CatEye, shift_x, shift_y)
    if(~exist('shift_y','var'))
        shift_y = 0;  % 如果未出现该变量，则对其进行赋值
    end
    [~, M, ~, ~, delta, ~] = Para_FFTAlgorithm(r_CatEye); 
    [m1, m2]=meshgrid(linspace(-M/2, M/2-1, M));                           %生成采样点下标
    T = zeros(M, M);                                                       %初始化边界函数矩阵
    a = 0.5; b = 0.5;                                                      %圆面对应圆心坐标
%     D = ((m1 + a).^2+(m2 + b).^2).^(1/2)*delta;                            %角锥棱镜对应圆面
    %公式（10）对应边界函数
    %角锥棱镜对应圆面位置为1
    i = find(((m1+a)*delta+shift_x).^2 + ((m2+b)*delta+shift_y).^2 <= radius.^2); 
    T(i)=1;
end