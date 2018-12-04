function [f] = P3_Draw_All(K_r,y, yzad,imax)
    f = figure(); 
    hold on; 
    for i = 1:imax
        stairs(y(:,i));
    end
    stairs(yzad,':');
    title(['Procedura Zieglera Nicholsa']); xlabel('k'); ylabel('y');
    legend('y_{zad}');
    print(f, ['Resources/P2_K' int2str(K_r) '.png'], '-dpng');