function [f] = DrawJ(J)

f = figure('visible','off');
hold on
plot(J, 'g');
grid on
grid minor
legend('Ju');
xlabel('k');ylabel('Ju');
title('Ju' );
hold off
print(f, 'Ju.png','-dpng');