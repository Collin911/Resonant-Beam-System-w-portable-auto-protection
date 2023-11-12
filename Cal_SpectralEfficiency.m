function C = Cal_SpectralEfficiency(P_channel, rho_apd, L_apd, I_b, K, T, B)
q = 1.6021892e-19;
signal = P_channel.*rho_apd;
signal = signal.^2;
n_white = 4*K*T*B/L_apd;
n_shot = 2*q*B.*(P_channel.*rho_apd+I_b);
noise = n_white + n_shot;
noise = noise .*2*pi*exp(1);
SNR = signal./noise;
C = 0.5.*log2(1+SNR);
plot(P_channel, C)
end
