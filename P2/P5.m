%%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% 
% Projekt nr. 2 STP - Kajetan Kaczmarek
% Punkt 5 symulacja regulatora DMC z zakloceniem, wybrane par. : D = 50, N = 15,
% Nu = 2, lambda = 3 
%%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% % Model
systems = P1();
sys = systems(:,:,4);
a=sys.Denominator;b=sys.Numerator;T= sys.Ts;
value = 'Disturbance';
lambda = 2; 
D = 50;
Nu = 2;
N = 25;
a=sys.Denominator;b=sys.Numerator;T= sys.Ts;
skok = step(sys,1:T:N+Nu+D);

for disturbance_amp = 0.1:0.1:5
    % Wyzerowanie do kolejnych obliczen
    y_zad = zeros(1,kk);
    disturbance = zeros(1,kk);
    disturbance(kk/2:end) = disturbance_amp;
    y=zeros(1,kk);
    u=zeros(1,kk);
    du = zeros(1,kk);

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

    K1 = K(1,1:N);
    ke = sum(K1);

    for k=D:kk
        y(k)=b(2)*u(k-3)+b(3)*u(k-4)-a(2)*y(k-1)-a(3)*y(k-2) + disturbance(k);
        swob = 0;
        for j=1:(D-1)
            ku = K1*M_P(:,j);
            swob = swob + ku*du(k-j);
        end
        du(k) = ke*(y_zad(k) - y(k)) - swob;
        u(k) = u(k-1) + du(k);
    end
    DMC_Draw(kk, y,y_zad, u,disturbance_amp,value,"P4");
end
