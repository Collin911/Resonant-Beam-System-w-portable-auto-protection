function P_e = Cal_PowerPV(P_pv, rho_pv, I_0, L_pv, R_s, R_p, n_s, A, k, T)
AkT = A * k * T;
q = 1.6021892e-19;
P_e = gather(P_pv);
for i = 1:length(P_e)
    if P_e(i)>0
        syms i_e
        %v_e = i_e * L_pv;
        voltage = i_e * L_pv + i_e .* R_s;
        exp_term = (voltage .*q) ./ (n_s .* AkT);
        frac_term = voltage ./ R_p;
        
        eq = P_e(i) .* rho_pv - I_0 .* (exp(exp_term) - 1) - frac_term - i_e;
        
        ie = double(solve(eq, i_e));
        P_e(i) = ie .* ie .* L_pv;
    else
        P_e(i)=0;
    end

end

end