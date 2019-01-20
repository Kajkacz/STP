function [f] = DrawJ(J,value,whichJ,limitationY)

f = figure('visible','off');
hold on
plot(J(:,2),J(:,1), 'b');
grid on;
grid minor;
legend(whichJ);
ylabel(whichJ);xlabel(value);
title(whichJ);
hold off;
ylim([0 limitationY]);
print(f, ['ModelsP4_J/',whichJ ,value,'.png'],'-dpng');