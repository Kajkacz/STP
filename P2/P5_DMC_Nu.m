%%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% 
% Projekt nr. 2 STP - Kajetan Kaczmarek
% Punkt 4 i 5- symulacja regulatora DMC
%%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% 

% Inicjalizacja
kk = 500;
y_zad = zeros(1,kk); y_zad(13:kk) = 1;
du = zeros(1,kk); N = 1;
lambda = 1; D = 35;
N =55;
for Nu = 5:5:55
    % Parametry podane w zadaniu
    K0 = 2.7 ;  T0 = 5;
    T1 = 1.83; T2 = 5.31; Tp = 0.5;

    % Obliczenie transmitancjiQ
    s = tf('s');
    cont = (K0 * exp(-s*T0))/((T1*s + 1)*(T2*s +1));
    % Konwersja do postaci dyskretnej
    disc = c2d(cont, Tp, 'zoh');
    u=zeros(1,kk);
    u(13:kk) = 1;
    y=zeros(1,kk);

    % Symulacja
    for k =13:kk
             y(k)=b1*u(k-11)+b0*u(k-12)-a1*y(k-1)-a0*y(k-2);
    end

    resp = step(disc, 0:Tp:1.5*D);

    % Wyzerowanie do kolejnych obliczen
    y_zad = zeros(1,kk);
    y_zad(D:kk) = 1;
    y=zeros(1,kk);
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
        y(k)=b1*u(k-11)+b0*u(k-12)-a1*y(k-1)-a0*y(k-2);
        swob = 0;
        for j=1:(D-1)
            ku = K1*Mp(:,j);
            swob = swob + ku*du(k-j);
        end
        du(k) = ke*(y_zad(k) - y(k)) - swob;
        u(k) = u(k-1) + du(k);
    end

    P4_DMC_Draw(kk, y,y_zad, u,Nu)
end