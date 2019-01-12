function [l] = hlprTFtoLatex(tf,precision)
[num,den] = tfdata(tf);
den= cell2mat(den);
den = den(2:3);
syms('z');
digits(precision);
t_sym = poly2sym(vpa(cell2mat(num)),z)/poly2sym(vpa(den),z);
l=latex(t_sym);