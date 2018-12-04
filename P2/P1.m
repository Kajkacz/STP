%%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% 
% Projekt nr. 2 STP - Kajetan Kaczmarek
% Punkt 1 - wyznaczenie transmitancji dyskretnej
%%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% 
% Dane zadania z wzoru G(s) = (K_0*e^(-T_0*s))/((T_1*s + 1)(T_2*s + 1))
%%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% 

K_0 = 2.7;
T_0=5;
T_1 = 1.83;
T_2=5.31;

% Zadany okres probkowania 0.5 s oraz dobrany empirycznie czas symulacji
T_p = 0.5;
tsym = 40;

% Wyliczenie systemu ciaglego
sys = tf('s');
TransferFunction = (K_0 * exp(-sys*T_0))/((T_1*sys + 1)*(T_2*sys +1));


% Stworzenie systemu dyskretnego na podstawie systemu ciaglego
discTF = c2d(TransferFunction, T_p, 'zoh')

% Rysowanie wykresu - odkomentowac dla wlaczenia rysowania
P1_Draw(TransferFunction,tsym, T_p);