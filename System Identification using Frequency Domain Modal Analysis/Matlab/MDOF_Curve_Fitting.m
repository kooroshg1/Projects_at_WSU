clc;
format short g;
close all;
fclose all;
clear all;
% ----------------------------------------------------------------------- %
lineWidth = 3;
fontSize = 20;
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

Hbig = [];
BtildeBig = [];
% [220 380]
rangeMin = 220;
rangeMax = 380;
[r cMin] = min(abs(omega - rangeMin));
[r cMax] = min(abs(omega - rangeMax));

omega = omega * 2 * pi;
omegaR = omega(cMin:cMax);
omegaR = [fliplr(-omegaR')';omegaR];
HH = H(:,:,cMin:cMax);
H_ = zeros(3,3,length(omegaR));
for ii=1:length(omegaR)
    if omegaR(ii) < 0
        H_(:,:,ii) = conj(HH(:,:,length(HH) - ii + 1));
    else
        H_(:,:,ii) = HH(:,:,ii - length(HH));
    end
end

% FRFplot(2,[220 380])
for ii=1:length(omegaR)
	Hbig = [Hbig;...
        -omegaR(ii)^2*H_(:,:,ii).' ...
        i*omegaR(ii)*H_(:,:,ii).' ...
        H_(:,:,ii).'];
    BtildeBig = [BtildeBig;eye(3,3) * -omegaR(ii)^2];
end

MCK = pinv(Hbig) * BtildeBig;

M = abs(MCK(1:3,1:3));
C = abs(MCK(4:6,1:3));
K = abs(MCK(7:9,1:3));