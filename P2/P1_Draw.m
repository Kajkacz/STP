function [f] = P1_Draw(TransferFunction, tsym, T_p)

discTF = c2d(TransferFunction, T_p, 'z');

% Rysowanie wykresu
f = figure('Name', 'Transmitancja ci¹g³a i dyskretna - Porównanie odp. skokowej');
set(gcf, 'Position', [100, 100, 800, 600])
hold on;
t = linspace(0, tsym, tsym/T_p + 1);
contTF = step(TransferFunction,  t);
discTF = step(discTF, t);
plot(t, contTF);
stairs(t, discTF);
legend('Model ci¹g³y', 'Model dyskretny');
title('Odpowiedzi skokowe transmitancji ci¹g³ej i dyskretnej');
xlabel('Czas');

