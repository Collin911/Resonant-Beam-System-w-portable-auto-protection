function [T] = Cal_PowerThresh(Rin, Rout, Vin_out, Vout_in, Vs, eta_excit, Sg, Is)
    T = abs(log(sqrt(Rin .* Rout .* Vin_out .* Vout_in) .* Vs));
    T = (T .* Sg .* Is) ./ eta_excit;
end