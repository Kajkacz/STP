%%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% 
% Projekt nr. 2 STP - Kajetan Kaczmarek
% Punkt 4 symulacja regulatora DMC,  wybrane par. : D - D = 50
%%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% 
clear;
% Inicjalizacja
% Model
systems = P1();
sys = systems(:,:,4);

value = 'D';
lambda = 1; 
Dmax = 200;
Nu = 20;
N=100;
kk = 500;

for D = Dmax:-5:5
    [y,y_zad,u,Jy,Jx] = DMCnoLimit(sys ,N,Nu,D,lambda,kk);

    P4_DMC_Draw(kk, y,y_zad, u,D,value);
end