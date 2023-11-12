function [V] = Cal_DiffractionEfficiency(U_eigen, U_next)
   U_next_abs = abs(U_next); 
   U_next_abs2 = U_next_abs.^2;
   U_eigen_abs = abs(U_eigen);  
   U_eigen_abs2 = U_eigen_abs.^2;
   V = (sum(U_next_abs2(:)))./(sum(U_eigen_abs2(:)));
end

