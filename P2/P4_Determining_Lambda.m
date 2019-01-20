%%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% 
% Projekt nr. 2 STP - Kajetan Kaczmarek
% Punkt 4 symulacja regulatora DMC, wybrane par. : D - D = 50, N = 15,     
% Nu = 2, lambda = 3
%%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% 
clear;
% Inicjalizacja
% Model
systems = P1();
sys = systems(:,:,4);
a=sys.Denominator;b=sys.Numerator;T= sys.Ts;
value = 'Lambda';
lambdaMax = 100; 
D = 50;
Nu = 2;
N = 25;
kk = 500;
Ju = zeros(lambdaMax,2);
Jy = zeros(lambdaMax,2);
i=1;
for lambda = lambdaMax:-1:1
    [y,y_zad,u,Jy(i,1),Ju(i,1)] = DMCnoLimit(sys ,N,Nu,D,lambda,kk);
    Jy(i,2) = lambda;Ju(i,2) = lambda;

    DMC_Draw(kk, y,y_zad, u,lambda,value,'P4');
    i=i+1;
end
DrawJ(Jy,'lambda','Jy',10);
DrawJ(Ju,'lambda','Ju',1);