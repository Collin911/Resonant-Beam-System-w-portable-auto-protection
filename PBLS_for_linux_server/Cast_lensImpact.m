function [U] = Cast_lensImpact(U_pre, H_lens, B_lens)
    U = U_pre.*H_lens.*B_lens;
end