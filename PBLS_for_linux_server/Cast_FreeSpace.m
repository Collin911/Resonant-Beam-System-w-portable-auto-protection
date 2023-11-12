function [U] = Cast_FreeSpace(U_pre, H_fs, B_dest, B_start)
%    H = fftshift(fft2(ifftshift(H_fsdf)));                                  %传输矩阵FFT变换
%    B = fftshift(fft2(ifftshift(U_pre.*B_aper)));                           %孔阑处原始光场的FFT变换
%    U = fftshift(ifft2(ifftshift(H.*B))).*B_lens.*delta.*delta;             %L2入射面光场

   B = fftshift(fft2(ifftshift(U_pre.*B_start)));                           %孔阑处原始光场的FFT变换
   U = fftshift(ifft2(ifftshift(H_fs.*B))).*B_dest;             %L2入射面光场
end