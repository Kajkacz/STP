%%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% 
% Projekt nr. 2 STP - Kajetan Kaczmarek
% Punkt 1 - funkcja pomocnicza do ryswoania wykresow
%%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% 
function [f,E] = P1_Draw(TransferFunction,u,y,tau)
% 'Czas' na potrzeby rysunku
T_sim = 0:999;
% Oblicz blad
y1=lsim(TransferFunction,u,T_sim);
E = getSquareError(y1,y);
% Ustal tytul
titleString = sprintf('%s %d %s %d','Porownanie modelu i danych dla tau = ', tau,' blad E = ',E);
% Stworz obiekt na rysunki bez wy¶wietlanie
f = figure('Name', titleString,'Visible','Off');
set(gcf, 'Position', [100, 100, 800, 600])
hold on;
% Przeprowadz symulacje
lsim(TransferFunction,u,T_sim);
plot(y);
% Dodaj legende i opis
legend('Model', 'Dane', 'Sterowanie');
xlabel('Czas');
title(titleString);

hold off;
saveas(f,strcat('ModelsP1/modelTau',num2str(tau),'.png'));
