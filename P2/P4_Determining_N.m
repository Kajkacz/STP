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
for N = Nmax:-step:5
    [y,y_zad,u] = DMCnoLimit(sys ,N,Nu,D,lambda,kk);

    P4_DMC_Draw(kk, y,y_zad, u,N,value);
    Jy(N/step) = sum((y - y_zad).^2);
    Ju(N/step) = sum((u - circshift(u,[0,-1])).^2);
end