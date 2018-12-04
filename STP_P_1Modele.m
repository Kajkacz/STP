%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%	Wyliczenie modelu metodą numeryczną
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Przeksztalcenie licznika -   (s + 1)(s + 9) = 1 + 10s^-1 + 9s^-2
% Przeksztalcenie mianownika - (s + 10)(s + 11)(s + 12) = 1 + 33s^-1 + 362s^-2 + 1320s^-3

l = [1,10,9];
m = [1,33,362,1320];
% I Wariant : 
[A,B,C,D]=tf2ss(l,m);
% II Wariant
A2 = transpose(A);
B2 = transpose(C);
C2 = transpose(B);
D2 = D;