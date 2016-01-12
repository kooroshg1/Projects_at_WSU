clc;
clear all;
format short g;
close all;
% ----------------------------------------------------------------------- %
x = 80.0402;
sigmaP_x = normpdf(norminv(distFuncCdf(x))) / distFuncPdf(x)
muP_x = x - norminv(distFuncCdf(x)) * sigmaP_x