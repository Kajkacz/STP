%%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% 
% Projekt nr. 2 STP - Kajetan Kaczmarek
% Punkt 4 symulacja regulatora DMC, wybrane par. : D - D = 50, N = 15,
% Nu = 2
%%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% 
clear;
% Model
systems = P1();
sys = systems(:,:,4);
% Wartosc oceniana
value = 'Nu';

lambda = 1; 
D = 50;
Numax = 20;
N=25;
kk = 500;
for Nu = Numax:-1:1
    [y,y_zad,u] = DMCnoLimit(sys ,N,Nu,D,lambda,kk);
    P4_DMC_Draw(kk, y,y_zad, u,Nu,value);
end