clc;
clear;
format short g;
% ----------------------------------------------------------------------- %
x = [30 52];
x0 = [38 54];
x1 = [24.489 49.2];
g0 = limitState(x0);
g1 = limitState(x1);

grad = calcGrad(x1)
r = TANA(x0,g0,x1,g1,grad)
functionApp(x,x1,g1,grad,r)
limitState(x)

