function [R] = Cal_EquivalentReflect_V2_own(opd, lambda, phi_0, R1, R2, V)
k = 2 * pi ./ lambda; %波数
delta_phi = k .* opd; %相位差
phi = phi_0 + delta_phi;%初始相位+光程相位
phi = mod(phi, 2*pi);

r1 = sqrt(R1); %接收端腔镜振幅反射率
r2 = sqrt(R2); %保护光反射镜振幅反射率

numerator =  r2 .* V.^2 .* exp(1j .* phi) - r1; %分子项
denominator = 1 - r1 .* r2 .* V.^2 .* exp(1j .* phi); %分母项

R = numerator ./ denominator;
R = abs(R) .^ 2;
end