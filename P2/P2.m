%%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% 
% Projekt nr. 2 STP - Kajetan Kaczmarek
% Punkt 2 - wyznaczenie odpowiedzi skokowej
% Model z tau = 3 daje najmniejszy sredni blad
%%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% 
function [] = P2()
systems = P1();
sys = systems(:,:,4);
%Odpowiedz skokowa
s = step(sys)
%Wzmocnienie statyczne 
K = dcgain(sys);
% K = 3,7432
plot(s)