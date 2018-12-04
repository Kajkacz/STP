function [f] = P3_Draw(K_r,y, yzad)
    f = figure('visible','off');  stairs(y); hold on; stairs(yzad,':');
    title(['Procedura Zieglera Nicholsa '  num2str(K_r) ]); xlabel('k'); ylabel('y');
    legend('y_{zad}');
    print(f, ['Resources/P2_K' num2str(K_r) '.png'], '-dpng');
