%%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% 
% Projekt nr. 2 STP - Kajetan Kaczmarek
% Punkt 6 symulacja regulatora DMC, wybrane par. : D - D = 50, N = 15,
% Nu = 2
% Wybrane wartosci : dulimit = 0.27 , dlimit = 0.09
%%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% 
%%%   Inicjalizacja
%%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% 
% Model
systems = P1();sys = systems(:,:,4);
% Parametry
a=sys.Denominator;b=sys.Numerator;T= sys.Ts;
kk=500;lambda = 2; D = 50;Nu = 2;N = 25;
% Odpowiedz skokowwa systemu
skok = step(sys,1:T:N+Nu+D);
% Ograniczenia dla symulacji
dumax=0.09;umax=0.27;
% Macierze wynikowe
y_zad = zeros(1,kk);y_zad(D:kk) = 1;
y=zeros(1,kk);
u=zeros(1,kk);
du = zeros(1,kk);

%%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% 
%%%   Obliczenia
%%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% 
% Obliczanie macierzy predykcji
M_P = zeros(N,D-1);
for j=1:(D-1)
    for i=1:N
        M_P(i,j) = skok(i+j) - skok(j);
    end
end

% Wyznaczenie macierzy dynamicznej
M_D = zeros(N, Nu);
for i=1:Nu
    for j=1:N
        if j >= i
            M_D(j+i-1,i) = skok(j);
        else
            M_D(j,i) = 0;
        end
    end
end

% Wyznaczenie macierzy K
K = (M_D'*M_D + lambda*eye(Nu))^-1 * M_D';
K1 = K(1,1:N); ke = sum(K1);
for k=D:kk
    y(k)=b(2)*u(k-3)+b(3)*u(k-4)-a(2)*y(k-1)-a(3)*y(k-2);
    swob = 0;
    for j=1:(D-1)
        ku = K1*M_P(:,j);
        swob = swob + ku*du(k-j);
    end
    du(k) = ke*(y_zad(k) - y(k)) - swob;
    % Ograniczenia
    if(u(k) > umax)
        u(k) = umax;
    end
    if(u(k) < -umax)
        u(k) = -umax;
    end

    if(du(k) > dumax)
        du(k) = dumax;
    end
    if(du(k) < -dumax)
        du(k) = -dumax;
    end

    u(k) = u(k-1) + du(k);
end
%%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% 
%%%   Drukuje wykres dla wybrancyh wartosci
%%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% 

f = figure('visible','off');
t = linspace(1,kk,kk);
hold on
plot(t, y_zad, 'g'); stairs(t, u, 'b'); stairs(t, y, 'r');
grid on
grid minor
legend('y_{zad}(k)', 'u(k)', 'y(k)');
xlabel('k');ylabel('y');
title('DMC dla warto¶ci finalnych');
hold off
print(f, sprintf(strcat('P6_3_DMC_Koncowe_.png')),'-dpng');