function [itr, samplingNum, windowExpandFactor, windowSize, delta, deltaF, lambda] = Para_FFTAlgorithm(r)
    radius =r;                                                             %角锥棱镜等效入射面半径 r
    itr = 400;                                                              %迭代次数 itr
%     if r > 1e-3
%         samplingNum = 8192;                                                    %空域/频域采样点数量 M
%     else 
%         samplingNum = 512; 
%     end
samplingNum = 16384;
    windowExpandFactor = 1.5;                                                %计算窗口扩充因子 G
    windowSize = 2 * windowExpandFactor * radius;                          %计算窗口尺寸 2Gr
    delta = windowSize./samplingNum;                                       %空域采样间隔 delta=2Gr/M
    deltaF = 1./(windowSize);                                              %频域采样间隔 deltaF=(2Gr)^(-1)
    lambda = 1064E-9;
end