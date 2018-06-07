%%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% 
% Projekt nr. 2 STP - Kajetan Kaczmarek
% Punkt 4 -symulacja regulatora PID
%%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% 

% inicjalizacja
a1=-1.671; a0=0.6925; b1=0.03078; b0=0.02723;
K_r =0.815; T = 18; T_p = 0.5;
kk=500; 
y_zad = zeros(1,kk);
y_zad(13:kk) = 1;
y=zeros(1,kk);
u=zeros(1,kk);
e=zeros(1,kk);

% Wartosci PID otrzymane z Zieglera-Nicholsa

K_p = 0.489; T_i = 9; T_d = 2.25;

% Wartosci PID dyskretnego policzone z ww.

r1 = 2.2005; r2 = -4.876416; r3 = 2.70308;

%warunki poczatkowe
u(1:4)=0; y(1:4)=0;
yzad(1:9)=0; yzad(10:kk)=1;
e(1:4)=0; 

for k=13:kk
    y(k)=b1*u(k-11)+b0*u(k-12)-a1*y(k-1)-a0*y(k-2);
    e(k) = y_zad(k) - y(k);
    u(k) = u(k-1) + r1*e(k) + r2*e(k) +r3*e(k);
end
    f = figure();  stairs(y); hold on; stairs(yzad,':');
    title(['Symulacja  PID Z-N' ]); xlabel('k'); ylabel('y');
    legend('y_{zad}');
    print(f, ['Resources/P4-1_r1' num2str(r1) 'r2' num2str(r2) 'r3'  num2str(r3) '.png'], '-dpng');

%%%%%
%Powtorzenie doswiadczenia celem dostrojenia PID
%%%%%%

%inicjalizacja
a1=-1.671; a0=0.6925; b1=0.03078; b0=0.02723;
K_p =0.815; T = 18; T_p = 0.5;
kk=500; 
y_zad = zeros(1,kk);
y_zad(13:kk) = 1;
y=zeros(1,kk);
u=zeros(1,kk);
e=zeros(1,kk);

% Wartosci PID testowe
K_p = 0.46; T_i = 18; T_d = -2;

% Wartosci PID dyskretnego policzone z ww.


r1 = K_p*(1 + T_p/(2*T_i) + T_d/T_p );
r2 = K_p*(T_p/(2*T_i) - 2*T_d/T_p - 1);
r3 = K_p*T_d/T_p;

%warunki poczatkowe
u(1:4)=0; y(1:4)=0;
yzad(1:9)=0; yzad(10:kk)=1;
e(1:4)=0; 

for k=13:kk
    y(k)=b1*u(k-11)+b0*u(k-12)-a1*y(k-1)-a0*y(k-2);
    e(k) = y_zad(k) - y(k);
    u(k) = u(k-1) + r1*e(k) + r2*e(k) +r3*e(k);
end
    f = figure()
    stairs(y); hold on; stairs(yzad,':');
    title(['Symulacja  PID Poprawionego' ]); xlabel('k'); ylabel('y');
    print(f, ['Resources/P4-2_r1' num2str(r1) 'r2' num2str(r2) 'r3'  num2str(r3) '.png'], '-dpng');
