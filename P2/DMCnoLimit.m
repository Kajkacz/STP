function[y,y_zad,u,Jy,Ju] = DMCnoLimit(sys,N,Nu,D,lambda,kk)
% Model
a=sys.Denominator;b=sys.Numerator;T= sys.Ts;
skok = step(sys,1:T:N+Nu+D);


% Wyzerowanie do kolejnych obliczen
y_zad = zeros(1,kk);
y_zad(D:kk) = 1;
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
    y(k)=b(2)*u(k-3)+b(3)*u(k-4)-a(2)*y(k-1)-a(3)*y(k-2);
    swob = 0;
    for j=1:(D-1)
        ku = K1*M_P(:,j);
        swob = swob + ku*du(k-j);
    end
    du(k) = ke*(y_zad(k) - y(k)) - swob;
    u(k) = u(k-1) + du(k);
end
[Jy,Ju] = getJ(y,y_zad,u,kk);
