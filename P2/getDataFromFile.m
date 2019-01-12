function [u,y] = getDataFromFile(fileName)
A = importdata(fileName);
u = A(:,1);
y = A(:,2);