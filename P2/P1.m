%%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% 
% Projekt nr. 2 STP - Kajetan Kaczmarek
% Punkt 1 - wyznaczenie modelu oraz symulacja
%%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% 
function [systems] = P1()
%%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% 
% Inicjalizacja - okres próbkowania i maksymalne testowane opoznienie
Ts = 1; maxTau = 20;
%%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% 
% Pobranie danych z pliku
[u,y]=getDataFromFile("dane9.txt");
% Wyliczenie modeli wej¶ciowych w oparciu o dane
modelData = iddata(y,u,Ts);
systems = idtf(zeros(1,1,maxTau));
% Wyznaczenie modeli o opoznieniu do maxTau
for j = 0:maxTau
    tau = j;
    delay = tau + 1;
    % Podajemy licznik i mianownik tak aby otrzymaæ model z dwoma
    % skladnikami w mianowniku i liczniku
    N = [zeros(delay ,1)' NaN NaN];
    D = [ 1 NaN NaN];

    model = idtf(N,D,Ts);
    % Oznaczamy warto¶ci licznika do dwóch ostatnich jako niezmienialne
    % zera na potrzeby tfest
    for i = 1:delay
        model.Structure.num.Free(i) = false;
    end
    % Wyliczamy po kolei nasze systemy
    systems(:,:,j+1) = tfest(modelData,model);
end
% Wyznaczenie bledu dla kazdego modelu i narysowanie wykresow 
Errors = zeros(1,maxTau+1);
for j = 0:maxTau
   [~,Errors(j+1)]=P1_Draw(systems(:,:,j+1),u,y,j);
end