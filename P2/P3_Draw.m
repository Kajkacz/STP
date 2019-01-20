%%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% 
% Projekt nr. 2 STP - Kajetan Kaczmarek
% Punkt 3 - dobor parametrow metoda Zieglera-Nicholsona, wydrukowanie
% obrazku
%%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% %%%%% 
function [f] = P3_Draw(K_r,y, yzad)
    f = figure('visible','off');  stairs(y); hold on; stairs(yzad,':');
    title(['Procedura Zieglera Nicholsa '  num2str(K_r) ]); xlabel('k'); ylabel('y');
    legend('y_{zad}');
    fileTitle = sprintf(strcat(strrep(['ModelsP3/ZN/P2_K' num2str(K_r) '.png'],'.','')));
    print(f, fileTitle, '-dpng');