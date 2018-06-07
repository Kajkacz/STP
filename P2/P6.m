%%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% 
% Projekt nr. 2 STP - Kajetan Kaczmarek
% Punkt 6 -porownanie PID vs DMC
%%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% 

% Inicjalizacja
a1=-1.671; a0=0.6925; b1=0.03078; b0=0.02723;

kk = 500;
y_zad = zeros(1,kk); y_zad(13:kk) = 1;
du = zeros(1,kk); N = 1;
lambda = 1; D = 35;
N =55; Nu = 5; lambda = 2;
% Parametry podane w zadaniu
K0 = 2.7 ;  T0 = 5;
T1 = 1.83; T2 = 5.31; Tp = 0.5;

% Obliczenie transmitancji
s = tf('s');
cont = (K0 * exp(-s*T0))/((T1*s + 1)*(T2*s +1));
% Konwersja do postaci dyskretnej
disc = c2d(cont, Tp, 'zoh');
u=zeros(1,kk);
u(13:kk) = 1;
y_DMC=zeros(1,kk);

% Symulacja
for k =13:kk
         y_DMC(k)=b1*u(k-11)+b0*u(k-12)-a1*y_DMC(k-1)-a0*y_DMC(k-2);
end

resp = step(disc, 0:Tp:1.5*D);

% Wyzerowanie do kolejnych obliczen
y_zad = zeros(1,kk);
y_zad(D:kk) = 1;
y_DMC=zeros(1,kk);
u=zeros(1,kk);

% Wyznaczenie macierzy dynamicznej
M_D = zeros(N, Nu);
for i=1:Nu
    for j=1:N
        if j >= i
            M_D(j+i-1,i) = resp(j);
        else
            M_D(j,i) = 0;
        end
    end
end

M_D = M_D(1:N, 1:Nu);

% Obliczanie macierzy predykcji
Mp = zeros(N,D-1);

for j=1:(D-1)
    for i=1:N
        Mp(i,j) = resp(i+j) - resp(j);
    end
end

% Wyznaczenie wektora K

K = (M_D'*M_D + lambda*eye(Nu))^-1 * M_D';

K1 = K(1,1:N);
ke = sum(K1);

for k=D:kk
    y_DMC(k)=b1*u(k-11)+b0*u(k-12)-a1*y_DMC(k-1)-a0*y_DMC(k-2);
    swob = 0;
    for j=1:(D-1)
        ku = K1*Mp(:,j);
        swob = swob + ku*du(k-j);
    end
    du(k) = ke*(y_zad(k) - y_DMC(k)) - swob;
    u(k) = u(k-1) + du(k);
end
%inicjalizacja
a1=-1.671; a0=0.6925; b1=0.03078; b0=0.02723;
K_p =0.815; T = 18; T_p = 0.5;
kk=500; 
y_zad = zeros(1,kk);
y_zad(13:kk) = 1;
y_PID=zeros(1,kk);
u=zeros(1,kk);
e=zeros(1,kk);

% Wartosci PID testowe
K_p = 0.46; T_i = 18; T_d = -2;

% Wartosci PID dyskretnego policzone z ww.


r1 = K_p*(1 + T_p/(2*T_i) + T_d/T_p );
r2 = K_p*(T_p/(2*T_i) - 2*T_d/T_p - 1);
r3 = K_p*T_d/T_p;

%warunki poczatkowe
u(1:4)=0; y_PID(1:4)=0;
yzad(1:9)=0; yzad(10:kk)=1;
e(1:4)=0; 

for k=13:kk
    y_PID(k)=b1*u(k-11)+b0*u(k-12)-a1*y_PID(k-1)-a0*y_PID(k-2);
    e(k) = y_zad(k) - y_PID(k);
    u(k) = u(k-1) + r1*e(k) + r2*e(k) +r3*e(k);
end

f = figure();

   
t = linspace(1,kk,kk);
hold on
plot(t, y_zad, 'g');stairs(y_PID); stairs(t, u, 'b'); stairs(t, y_DMC, 'r');
grid on
grid minor
legend('y_{zad}(k)','PID' ,'u(k)', 'DMC)');
xlabel('k');ylabel('y');
title('Porownanie DMC oraz PID ' );
hold off
print(f, ['Resources/P6_PIDvDMC.png'], '-dpng');

f = figure();
   
Kp = K/K0;
T=[1:0.1:2];
t = linspace(1,kk,kk);
hold on
for i = 1:5
    plot(Kp(i,1:5:55),T);
end
grid on
grid minor
title('K^0/K^0Nom' );
ylabel('K');
xlabel('T');
hold off
    print(f, ['Resources/P6_K.png'], '-dpng');