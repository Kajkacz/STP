function [f] = P4_DMC_Draw(kk, y, y_zad,u,Lambda)

f = figure('visible','off');
t = linspace(1,kk,kk);
hold on
plot(t, y_zad, 'g'); stairs(t, u, 'b'); stairs(t, y, 'r');
grid on
grid minor
legend('y_{zad}(k)', 'u(k)', 'y(k)');
xlabel('k');ylabel('y');
title(['Symulacja DMC Lambda = ' int2str(Lambda)] );
hold off
    print(f, ['Resources/P4_DMC_Lambda_' int2str(Lambda) '.png'], '-dpng');