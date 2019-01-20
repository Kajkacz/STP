function[Jy,Ju]  = getJ(y,yzad,u,kk)
Jy = 0;
Ju = 0;
for i=1 : kk
    Jy = Jy +(y(i)-yzad(i))^2;
end
for i=2 : kk
    Ju = Ju +(u(i)-u(i-1))^2;
end