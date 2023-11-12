function [R] = Cal_EquivalentReflect(opd, lambda, phi_0, R1, R2, V, modu, thresh)
k = 2 * pi ./ lambda; %波数
delta_phi = k .* opd; %相位差
phi = phi_0 + delta_phi;%初始相位+光程相位
phi = mod(phi, 2*pi);

r1 = sqrt(R1); %接收端腔镜振幅反射率
r2 = sqrt(R2); %保护光反射镜振幅反射率

numerator = (1 - R1) .* r2 .* V.^2 .* exp(1j .* phi); %分子项
denominator = 1 - r1 .* r2 .* V.^2 .* exp(1j .* phi); %分母项
remainder = r1 .* exp(1j .* (phi_0 + pi)); %余项
R = numerator ./ denominator + remainder;
R = abs(R) .^ 2;
% Reff = (R1 + R2 - 2 * sqrt(R1 * R2) .* cos(phi)) ./ (1 + R1 * R2 - 2 * sqrt(R1 * R2) .* cos(phi));
    if modu == 1    
        indices = find(R<thresh);
        for index = indices
    %         for cnt=1:7
                phi(index) = phi(index) + 3*pi/2;
                numerator(index) = (1 - R1(index)) .* r2(index) .* V(index).^2 .* exp(1j .* phi(index)); %分子项
                denominator(index) = 1 - r1(index) .* r2(index) .* V(index).^2 .* exp(1j .* phi(index)); %分母项
                remainder(index) = r1(index) .* exp(1j .* (phi_0 + pi)); %余项
                tmp = numerator(index) ./ denominator(index) + remainder(index);
    %             if tmp > R(index)
                    R(index) = abs(tmp) .^ 2;
    %             end
    %             if R(index) > thresh
    %                 break
    %             end
    %         end
        end
    end    
end