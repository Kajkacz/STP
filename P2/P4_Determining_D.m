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
step = 5;
Ju = zeros(Dmax/step,2);
Jy = zeros(Dmax/step,2);
i=1;
for D = Dmax:-step:5
    [y,y_zad,u,Jy(i,1),Ju(i,1)] = DMCnoLimit(sys ,N,Nu,D,lambda,kk);
    Jy(i,2) = D;Ju(i,2) = D;
    DMC_Draw(kk, y,y_zad, u,D,value,'P4');
    i=i+1;
end
DrawJ(Jy,'D','Jy',10);
DrawJ(Ju,'D','Ju',1);