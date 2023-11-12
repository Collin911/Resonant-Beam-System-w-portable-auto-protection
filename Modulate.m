function [U] = Modulate(U_pre, lambda, equiv_length)
    if equiv_length ~= 0
        k = 2 * pi ./ lambda;
        U = U_pre * exp(1i.*k.*equiv_length);
    else
        U = U_pre;
    end
end