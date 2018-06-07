%%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% 
% Projekt nr. 2 STP - Kajetan Kaczmarek
% Punkt 3 - dobor parametrow metoda Zieglera-Nicholsona
% Program w oparciu o algorytm przedstawiony na stronie 90-91 skryptu
% do przedmiotu
%%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% 

%inicjalizacja
a1=-1.671; a0=0.6925; b1=0.03078; b0=0.02723;
K_r_Base =0.05;
kk=200; 
y = zeros(kk,1);
%warunki poczatkowe
u(1:4)=0; y(1:4)=0;
yzad(1:9)=0; yzad(10:kk)=1;
e(1:4)=0; 
for i = 1:20
    K_r=K_r_Base*i;
    for k=13:kk %glowna petla symulacyjna , k_min = 13 dla zachowania ciaglosci
        %symulacja obiektu
         y(k)=b1*u(k-11)+b0*u(k-12)-a1*y(k-1)-a0*y(k-2);
        %uchyb regulacji
         e(k)=yzad(k)-y(k);
        %sygnal sterujacy regulatora PID
         u(k)=K_r*e(k);
    end

% drukuj i zapisz wyniki symulacji
   % P3_Draw(K_r, y, yzad);

end
