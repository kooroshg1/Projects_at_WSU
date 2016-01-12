clc;
clear;
format short g;
% ----------------------------------------------------------------------- %
numberOfSimulation = 13;
U = rand(numberOfSimulation,1) * 80 + 220;
alpha = normrnd(7,2,numberOfSimulation,1);
C_0 = rand(numberOfSimulation,1) * 0.3 + 0.3;
E = wblrnd(2E11,5,numberOfSimulation,1);
L = lognrnd(-0.0049752,0.099751,numberOfSimulation,1);
I = lognrnd(-14.474,0.099751,numberOfSimulation,1);
input = [U alpha C_0 E L I]
OUTPUT = [];
for ii=1:size(input,1)
    output = limitState(input(ii,:));
    OUTPUT = [OUTPUT;output input(ii,:)];
end