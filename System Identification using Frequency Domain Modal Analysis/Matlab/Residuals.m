clc;
clear all;
format short g;
close all;
% ----------------------------------------------------------------------- %
load('C:\Users\ecsroot\Desktop\Koorosh\Courses\ME7690_Vibration_testing\Lab4\Matlab\H data\H1_13.mat')
load('C:\Users\ecsroot\Desktop\Koorosh\Courses\ME7690_Vibration_testing\Lab4\Matlab\H data\H1_21.mat')
load('C:\Users\ecsroot\Desktop\Koorosh\Courses\ME7690_Vibration_testing\Lab4\Matlab\H data\H1_22.mat')
load('C:\Users\ecsroot\Desktop\Koorosh\Courses\ME7690_Vibration_testing\Lab4\Matlab\H data\H1_23.mat')
load('C:\Users\ecsroot\Desktop\Koorosh\Courses\ME7690_Vibration_testing\Lab4\Matlab\H data\H1_31.mat')
load('C:\Users\ecsroot\Desktop\Koorosh\Courses\ME7690_Vibration_testing\Lab4\Matlab\H data\H1_32.mat')
load('C:\Users\ecsroot\Desktop\Koorosh\Courses\ME7690_Vibration_testing\Lab4\Matlab\H data\H1_33.mat')
load('C:\Users\ecsroot\Desktop\Koorosh\Courses\ME7690_Vibration_testing\Lab4\Matlab\H data\omega.mat')
load('C:\Users\ecsroot\Desktop\Koorosh\Courses\ME7690_Vibration_testing\Lab4\Matlab\H data\H.mat')
load('C:\Users\ecsroot\Desktop\Koorosh\Courses\ME7690_Vibration_testing\Lab4\Matlab\H data\H1_11.mat')
load('C:\Users\ecsroot\Desktop\Koorosh\Courses\ME7690_Vibration_testing\Lab4\Matlab\H data\H1_12.mat')


% [485 540] @H_31
% [1260 1300] @1
% FRFplot(1,[485 540])
rangeMin = 485;
rangeMax = 540;
[r cMin] = min(abs(omega - rangeMin));
[r cMax] = min(abs(omega - rangeMax));
omegaR = omega(cMin:cMax);
omegaR = [fliplr(-omegaR')';omegaR];
H_31R = H1_31(cMin:cMax);
H_31R = [fliplr(conj(H_31R'))';H_31R];

P = [(i * omegaR).^2 .* H_31R, ...
    (i * omegaR).^3 .* H_31R, ...
    -(i * omegaR).^0, ...
    -(i * omegaR).^1, ...
    -(i * omegaR).^2, ...
    -(i * omegaR).^3, ...
    -(i * omegaR).^4];
BETA_ALPHA = pinv(P) * (-(i * omegaR).^4 .* H_31R);
BETA = fliplr([0 0 (BETA_ALPHA(1:2,1)).' 1]);
LAMBDA = roots(BETA);

OMEGA_n = abs(LAMBDA)
ZETA = - real(LAMBDA) ./ abs(LAMBDA)

pinv([-1./omegaR, ...
    ones(length(omegaR),1), ...
    1 ./ (i * omegaR - LAMBDA(3)), ...
    1 ./ (i * omegaR - LAMBDA(4))]) * H_31R;