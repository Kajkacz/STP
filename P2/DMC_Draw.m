function [f] = DMC_Draw(kk, y, y_zad,u,value,valueDescrpitor,dir)

f = figure('visible','off');
t = linspace(1,kk,kk);
hold on
plot(t, y_zad, 'g'); stairs(t, u, 'b'); stairs(t, y, 'r');
grid on
grid minor
legend('y_{zad}(k)', 'u(k)', 'y(k)');
xlabel('k');ylabel('y');
title(sprintf(strcat('DMC dla ' ,' ' , valueDescrpitor ,  ' = ' ,num2str(value))) );
hold off
fileName = strcat('Models',dir,'_' ,valueDescrpitor, '/P4_DMC_' ,valueDescrpitor, '_', num2str(value),".png");
fileName = strrep(fileName,".","_");
fileName = sprintf(strcat(fileName));
print(f,fileName,'-dpng');
