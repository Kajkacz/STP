function [E] = getSquareError(y1,y2)
E = 0;
for i = 1:size(y1)
    E=+ (y1(i) - y2(i))^2;
end