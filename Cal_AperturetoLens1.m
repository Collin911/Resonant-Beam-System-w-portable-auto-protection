function [U] = Cal_AperturetoLens1(U_pre, H_fsdf, B_lens, B_aper, delta)
%    H = fftshift(fft2(ifftshift(H_fsdf)));                                  %传输矩阵FFT变换
%    B = fftshift(fft2(ifftshift(U_pre.*B_aper)));                           %孔阑处原始光场的FFT变换
%    U = fftshift(ifft2(ifftshift(H.*B))).*B_lens.*delta.*delta;             %L2入射面光场

   B = fftshift(fft2(ifftshift(U_pre.*B_aper)));                           %孔阑处原始光场的FFT变换
   U = fftshift(ifft2(ifftshift(H_fsdf.*B))).*B_lens;             %L2入射面光场
end