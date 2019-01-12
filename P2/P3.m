%%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% 
% Projekt nr. 2 STP - Kajetan Kaczmarek
% Punkt 4 -symulacja regulatora PID
%%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% 

%inicjalizacja
kk = 1000; % czas symylacji
y_zad = zeros(1,kk); % wartosc zadana w funkcji czasu
y_zad(13:kk) = 1; % skok wartosci zadanej do 1 w k = 13
y=zeros(1,kk);
u=zeros(1,kk);
e=zeros(1,kk);

%Parametry naszego modelu
a1=-1.664; a0=0.692; b1=0.0535; b0=0.05131; T= 0.5; 
%Procedura ZN 
K_kr = 1.35; T_kr =20 ;
%Wyliczenie parametrów PID
K = 0.6*K_kr; Ti = 0.5*T_kr; Td = 0.12*T_kr;
%The controller parameters are proportional gain K, integral time Ti, and derivative time Td
% Wartosci PID dyskretnego policzone z ww.
r1 = K*(1 + T/(2*Ti) + Td/T  );
r2 = K*(T/(2*Ti) - 2*Td/T - 1);
r3 = K*Td/T;

%warunki poczatkowe
u(1:4)=0; y(1:4)=0;
yzad(1:49)=0; yzad(50:kk)=1;
e(1:4)=0; 

for k=6:kk
    y(k)=b1*u(k-3)+b0*u(k-4)-a1*y(k-1)-a0*y(k-2);
    e(k) = y_zad(k) - y(k);
    u(k) = u(k-1) + r1*e(k) + r2*e(k) +r3*e(k);
end
    f = figure();
    stairs(y); hold on; stairs(yzad,':');
    title('Symulacja  PID' ); xlabel('k'); ylabel('y');
    print(f, sprintf(['ModelsP3/PID/P4-2_r1_' num2str(r1) 'r2_' num2str(r2) 'r3_'  num2str(r3) '.png']), '-dpng');
