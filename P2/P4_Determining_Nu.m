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
Ju = zeros(Numax,2);
Jy = zeros(Numax,2);
i=1;
for Nu = Numax:-1:1
    [y,y_zad,u,Jy(i,1),Ju(i,1)] = DMCnoLimit(sys ,N,Nu,D,lambda,kk);
    Jy(i,2) = Nu;Ju(i,2) = Nu;
    DMC_Draw(kk, y,y_zad, u,Nu,value,'P4');
    i=i+1;
end
DrawJ(Jy,'Nu','Jy',10);
DrawJ(Ju,'Nu','Ju',1);