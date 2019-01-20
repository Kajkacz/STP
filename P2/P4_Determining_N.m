%%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% 
% Projekt nr. 2 STP - Kajetan Kaczmarek
% Punkt 4 symulacja regulatora DMC,  wybrane par. : D - D = 50, N = 15
%%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% 
clear;
% Inicjalizacja
% Model
systems = P1();
sys = systems(:,:,4);

value = 'N';
lambda = 1; 
D = 50;
Nu = 20;
Nmax=100;
kk = 500;
step = 5;
Ju = zeros(Nmax/step,2);
Jy = zeros(Nmax/step,2);
i=1;
for N = Nmax:-step:5
    [y,y_zad,u,Jy(i,1),Ju(i,1)] = DMCnoLimit(sys ,N,Nu,D,lambda,kk);
    Jy(i,2) = N;Ju(i,2) = N;
    DMC_Draw(kk, y,y_zad, u,N,value,'P4');
    i=i+1;
end
DrawJ(Jy,'N','Jy',10);
DrawJ(Ju,'N','Ju',1);