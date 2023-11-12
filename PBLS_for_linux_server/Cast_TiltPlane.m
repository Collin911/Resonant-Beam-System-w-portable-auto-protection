%%
function [U] = Cast_TiltPlane(U_pre, B_lens, B_aper, psi, sampN, lambda, deltaF) %计算过程参考（22） fftshift无影响
   B = U_pre.*B_aper;
   B = ifftshift(B);
   B = fft2(B);
   B = fftshift(B);                           %孔阑处原始光场的FFT变换
   B = CoordMapping(B, psi, sampN, lambda, deltaF);   %坐标映射
   B = fSpectrum_Centralize(B, sampN);
   B = ifftshift(B);
   B = ifft2(B);
   B = fftshift(B);
   U = B.*B_lens;             %此处直接使用ifft，引入误差
end

function [F] = CoordMapping_primitive(G_ori, psi, sampN, lambda, deltaF)
    G_ori = gpuArray(G_ori');
    low = -sampN/2;
    high = sampN/2 - 1;
    F = gpuArray(zeros(sampN, sampN));
    for v_hat = low: high
        for u_hat = low: high
            w_hat = sqrt(lambda^(-2)-(u_hat*deltaF)^2 - (v_hat*deltaF)^2) / deltaF;
            u = (u_hat*cos(psi) + w_hat * sin(psi));
            v = v_hat;
            u = round(real(u));%仅取实数部分、四舍五入取整 此处引入误差
            v = round(v);
            coef = abs(cos(psi) - u_hat / w_hat * sin(psi));
            uF = Coord2Index(u_hat, sampN);
            vF = Coord2Index(v_hat, sampN);
            if u<=high
                uG = Coord2Index(u, sampN);
                vG = Coord2Index(v, sampN);
                F(uF, vF) = coef * G_ori(uG, vG);
            else 
            	F(uF, vF) = 0;
            end
        end
    end
    F = gather(F');   
end

function [F] = CoordMapping(G_ori, psi, sampN, lambda, deltaF)
    G_ori = gpuArray(G_ori);
    low = -sampN/2;
    high = sampN/2 - 1;
    v_hat = low: high;
    u_hat = low: high;
    [U_hat, V_hat] = meshgrid(u_hat, v_hat);
    w_hat = sqrt(lambda^(-2)-(u_hat*deltaF).^2 - (v_hat*deltaF).^2)./deltaF;
    W_hat = sqrt(lambda^(-2)-(U_hat*deltaF).^2 - (V_hat*deltaF).^2)./deltaF;
    coef = abs(cos(psi) - U_hat ./ W_hat .* sin(psi));
    u = real(u_hat*cos(psi) + w_hat * sin(psi));
    v = v_hat;
    [U, V] = meshgrid(u, v);
    G = interp2(U_hat,V_hat,G_ori,U,V,'cubic');
    G = gather(G);
    F = coef .* G;
end


function [F] = CoordMapping_Modify(G_ori, psi, sampN, lambda, deltaF)
    low = -sampN/2;
    high = sampN/2 - 1;
    
    v_hat = low: high;
    u_hat = low: high;
    [U_hat, V_hat] = meshgrid(u_hat, v_hat);
    w_hat = sqrt(lambda^(-2)-(u_hat*deltaF).^2 - (v_hat*deltaF).^2)./deltaF;
    coef = abs(cos(psi) - u_hat ./ w_hat .* sin(psi));
    u = real(u_hat*cos(psi) + w_hat * sin(psi));
    v = v_hat;
    [U, V] = meshgrid(u, v);
    G = interp2(U_hat,V_hat,G_ori,U,V,'cubic');
    F = coef .* G;
end

function [C] = Spectrum_Centralize(F, sampN)
    F = gpuArray(F');
    [~,v0]=max(max(F));
    [~,u0]=max(F(:,v0));                     
    u_center = Coord2Index(0, sampN);
    % v_center = Coord2Index(0, sampN);
    diff = u0 - u_center;
    [u,v] = size(F);
    res = gpuArray(zeros(u, v));
    for vi = 1:v
        for ui = diff:u
            if ui-diff+1>0 && ui-diff+1<=sampN && ui > 0 && ui <= sampN
                res(ui - diff + 1,vi) = F(ui,vi);
            end
        end
    end
    C = gather(res');
end

function [C] = fSpectrum_Centralize(F, sampN)
    F = gpuArray(F);
	[~, u0] = max(max(F));
	u_center = Coord2Index(0, sampN);
	diff = u0 - u_center;
	C = circshift(F, [0, -diff]);
    C = gather(C);
end

function [ind] = Coord2Index(crd, N)
%用于将坐标转换为数组下标，即-N/2 -> 1
    ind = crd + N/2 +1;
end