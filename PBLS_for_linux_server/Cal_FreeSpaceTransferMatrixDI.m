function [H] = Cal_FreeSpaceTransferMatrixDI(length, lambda, r_CatEye)
   [~, samplingNum, ~, ~, delta, ~] = Para_FFTAlgorithm(r_CatEye);
   k = 2 * pi ./ lambda;
   M = samplingNum;
   [n1, n2]=meshgrid(linspace(-M/2, M/2-1, M)); 
   
  H=exp(j*k*length)*exp((j*k*((n1*delta).^2+(n2*delta).^2))/(2*length))/(j*lambda*length);
%    x_p1 = 0; y_p1 = 0;   
%    r = sqrt((n1*delta-ones(M,M).*delta*x_p1).^2+...
%         (n2*delta-ones(M,M).*delta*y_p1).^2+length^2);
%    H = 1./(2*pi).*(exp(j*k*r)./r).*(length./r).*(1./r-j*k);
end