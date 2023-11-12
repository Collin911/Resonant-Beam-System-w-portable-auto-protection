function out_U=Cal_FieldNormalization(in_U)
    s_abs_max =  max(max(abs(in_U)));                                       %幅值的最大值1*discrete到1*1
    out_U = in_U./s_abs_max;                                                  %归一化
end