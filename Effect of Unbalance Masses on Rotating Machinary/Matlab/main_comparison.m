clc;
clear all;
format short g;
close all;
% ----------------------------------------------------------------------- %
LineWidth = 3;
fontSize = 30;
% ----------------------------------------------------------------------- %
load('C:\Users\ecsroot\Desktop\Koorosh\Courses\ME7690_Vibration_testing\Lab3\Matlab\DATA\TIME_noMass.mat')
load('C:\Users\ecsroot\Desktop\Koorosh\Courses\ME7690_Vibration_testing\Lab3\Matlab\DATA\leftAcc_noMass.mat')
load('C:\Users\ecsroot\Desktop\Koorosh\Courses\ME7690_Vibration_testing\Lab3\Matlab\DATA\rightAcc_noMass.mat')
tNM = TIME;
leftNM = leftAcc;
rightNM = rightAcc;

load('C:\Users\ecsroot\Desktop\Koorosh\Courses\ME7690_Vibration_testing\Lab3\Matlab\DATA\TIME_Mass.mat')
load('C:\Users\ecsroot\Desktop\Koorosh\Courses\ME7690_Vibration_testing\Lab3\Matlab\DATA\leftAcc_Mass.mat')
load('C:\Users\ecsroot\Desktop\Koorosh\Courses\ME7690_Vibration_testing\Lab3\Matlab\DATA\rightAcc_Mass.mat')
tM = TIME;
leftM = leftAcc;
rightM = rightAcc;
clear TIME leftAcc rightAcc

figure,
plot(tNM,leftNM,'k',tM,leftM,'r','LineWidth',LineWidth)
% title('Left Accelerometer','fontSize',fontSize)
xlabel('Time (s)','fontSize',fontSize)
ylabel('Magnitude','fontSize',fontSize)
legend('Without Unbalance Mass','With Unbalance Mass')
xlim([0 tNM(end)])
set(gca,'fontSize',fontSize)

figure,
plot(tNM,rightNM,'k',tM,rightM,'r','LineWidth',LineWidth)
% title('Right Accelerometer','fontSize',fontSize)
xlabel('Time (s)','fontSize',fontSize)
ylabel('Magnitude','fontSize',fontSize)
legend('Without Unbalance Mass','With Unbalance Mass')
xlim([0 tNM(end)])
set(gca,'fontSize',fontSize)

%% ASD Plots
T = tNM(end);
N = length(tNM);
dt = T / length(tNM);
fs = 1 / dt;
fNyq = fs / 2;
df = fs / N;

XleftNM = fft(leftNM) * dt;
XrightNM = fft(rightNM) * dt;
XleftM = fft(leftM) * dt;
XrightM = fft(rightM) * dt;

omega = 0:df:fNyq;
XleftNM = XleftNM(1:length(omega));
XrightNM = XrightNM(1:length(omega));
XleftM = XleftM(1:length(omega));
XrightM = XrightM(1:length(omega));

GxXleftNM = conj(XleftNM) .* XleftNM / T;
GxXrightNM = conj(XrightNM) .* XrightNM / T;
GxXleftM = conj(XleftM) .* XleftM / T;
GxXrightM = conj(XrightM) .* XrightM / T;

figure,
plot(omega,20*log10(abs(GxXleftNM)),'k',omega,20*log10(abs(GxXleftM)),'r','LineWidth',LineWidth)
xlabel('Frequency (Hz)','fontSize',fontSize)
ylabel('Magnitude','fontSize',fontSize)
legend('Without Unbalance Mass','With Unbalance Mass')
set(gca,'fontSize',fontSize)
figure,
plot(omega,20*log10(abs(GxXrightNM)),'k',omega,20*log10(abs(GxXrightM)),'r','LineWidth',LineWidth)
xlabel('Frequency (Hz)','fontSize',fontSize)
ylabel('Magnitude','fontSize',fontSize)
legend('Without Unbalance Mass','With Unbalance Mass')
set(gca,'fontSize',fontSize)