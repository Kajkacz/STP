%%%%%%%%%%%%
%Rozklad na ulamki proste
%%%%%%%%%%%%

% Przeksztalcenie licznika - (s + 0.5)(s + 1.5) = s^2 + 2s + 0.75
% Przeksztalcenie mianownika - (s-4)(s+2)(s+3) = s^3 + s^2 - 14 s - 24

a = [1 1 -14 -24];
b = [1 2 0.75];
[r , p, k] = residue(b,a)
% r - wspolczynniki w mianowniku po rozkladzie
% p wspolczynniki w liczniku po rozkladzie
