function [itr, samplingNum, windowExpandFactor, windowSize, delta, deltaF, lambda] = Para_FFTAlgorithm_V2(r, f, psi)
    radius =r;                                                             %角锥棱镜等效入射面半径 r
    itr = 400;                                                              %迭代次数 itr
    lambda = 1064E-9;
    
    windowExpandFactor = 1.5;                                                %计算窗口扩充因子 G
    windowSize = 2 * windowExpandFactor * radius;                          %计算窗口尺寸 2Gr

    if psi == 0
        requiredSample  = 12 * r ^ 2 / (lambda * f);
    else
        requiredSample = windowSize/lambda*2;
    end 
    samplingNum = 2 ^ ceil(log2(requiredSample))

    delta = windowSize./samplingNum;                                       %空域采样间隔 delta=2Gr/M
    deltaF = 1./(windowSize);                                              %频域采样间隔 deltaF=(2Gr)^(-1)
    
end