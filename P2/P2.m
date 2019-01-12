%%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% 
% Projekt nr. 2 STP - Kajetan Kaczmarek
% Punkt 2 - wyznaczenie odpowiedzi skokowej
% Model z tau = 3 daje najmniejszy ¶redni blad
%%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% 
function [] = P2()
systems = P1();
sys = systems(:,:,4);
%Odpowiedz skokowa
step(sys);
%Wzmocnienie statyczne 
K = dcgain(sys);
% K = 3,7432
