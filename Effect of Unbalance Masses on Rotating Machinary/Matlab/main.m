%% Header
clc;
clear all;
close all;
LineWidth = 3;
fontSize = 30;
% ----------------------------------------------------------------------- %
%% Load file / Calculate ensemble durations
load('C:\Users\ecsroot\Desktop\Koorosh\Courses\ME7690_Vibration_testing\Lab3\Data\case 5 - rotating.mat')
% load('C:\Users\ecsroot\Desktop\Koorosh\Courses\ME7690_Vibration_testing\Lab3\Data\case 5 - rotating - unbala.sdd.mat')
timePeaks= [];
iiPrevious = 1;
for ii=1:length(Time_chan_1)
    if Time_chan_1(ii) > 2.0689
        if abs(iiPrevious - ii) < 3
            continue;
        end
        timePeaks = [timePeaks;Time_domain(ii) ii];
        iiPrevious = ii;
    end
end
ensembleLength = floor(mean(timePeaks(2:end,2) - timePeaks(1:end-1,2)));
figure,
subplot(2,1,1)
plot(Time_domain,Time_chan_1,'k');
hold on
scatter(timePeaks(:,1),Time_chan_1(timePeaks(:,2)))
subplot(2,1,2)
plot(Time_domain,Time_chan_3,'r');
% ----------------------------------------------------------------------- %
%% Average time domain data over each ensemble
motorData = 0;
leftAcc = 0;
rightAcc = 0;
for ii=2:length(timePeaks)-1
    motorData = motorData + Time_chan_2(timePeaks(ii,2):timePeaks(ii,2) + ensembleLength - 1);
    leftAcc = leftAcc + Time_chan_3(timePeaks(ii,2):timePeaks(ii,2) + ensembleLength - 1);
    rightAcc = rightAcc + Time_chan_4(timePeaks(ii,2):timePeaks(ii,2) + ensembleLength - 1);
end
opticalSensor = Time_chan_1(timePeaks(10,2):timePeaks(10,2)+ensembleLength - 1);
motorData = motorData / (length(timePeaks)-1);
leftAcc = leftAcc / (length(timePeaks)-1);
rightAcc = rightAcc / (length(timePeaks)-1);
time = Time_domain(timePeaks(10,2):timePeaks(10,2)+ensembleLength - 1);
TIME = linspace(0,time(end),length(time));

figure,
subplot(2,1,1)
plot(time,motorData,'k')
title('Motor Data')
subplot(2,1,2)
plot(time,opticalSensor,'r')

figure,
subplot(2,1,1)
plot(time,leftAcc,'k')
title('Left Accelerometer')
subplot(2,1,2)
plot(time,opticalSensor,'r')

figure,
subplot(2,1,1)
plot(time,rightAcc,'k')
title('Right Accelerometer')
subplot(2,1,2)
plot(time,opticalSensor,'r')

% The following plots show the effect of ensemble averaging on the noise
% removal from the data.
% figure,
% subplot(2,1,1)
% plot(TIME,motorData,'k','LineWidth',LineWidth)
% title('Ensemble Averaged','fontSize',fontSize)
% xlabel('Time (s)','fontSize',fontSize)
% xlim([0 TIME(end)])
% set(gca,'fontSize',fontSize)
% subplot(2,1,2)
% plot(TIME,Time_chan_2(timePeaks(10,2):timePeaks(10,2) + ensembleLength - 1),'k','LineWidth',LineWidth)
% title('Signle Ensemble','fontSize',fontSize)
% xlabel('Time (s)','fontSize',fontSize)
% xlim([0 TIME(end)])
% set(gca,'fontSize',fontSize)
figure,
plot(TIME,motorData,'r',TIME,Time_chan_2(timePeaks(10,2):timePeaks(10,2) + ensembleLength - 1),'k--','LineWidth',LineWidth)
title('Ensemble Averaged','fontSize',fontSize)
xlabel('Time (s)','fontSize',fontSize)
ylabel('Magnitude','fontSize',fontSize)
legend('Ensemble averaged','Origional')
xlim([0 TIME(end)])
set(gca,'fontSize',fontSize)

% figure,
% subplot(2,1,1)
% plot(TIME,leftAcc,'k','LineWidth',LineWidth)
% title('Ensemble Averaged','fontSize',fontSize)
% xlabel('Time (s)','fontSize',fontSize)
% xlim([0 TIME(end)])
% set(gca,'fontSize',fontSize)
% subplot(2,1,2)
% plot(TIME,Time_chan_3(timePeaks(10,2):timePeaks(10,2) + ensembleLength - 1),'k','LineWidth',LineWidth)
% title('Signle Ensemble','fontSize',fontSize)
% xlabel('Time (s)','fontSize',fontSize)
% xlim([0 TIME(end)])
% set(gca,'fontSize',fontSize)
figure,
plot(TIME,leftAcc,'r',TIME,Time_chan_3(timePeaks(10,2):timePeaks(10,2) + ensembleLength - 1),'k--','LineWidth',LineWidth)
title('Ensemble Averaged','fontSize',fontSize)
xlabel('Time (s)','fontSize',fontSize)
ylabel('Magnitude','fontSize',fontSize)
legend('Ensemble averaged','Origional')
xlim([0 TIME(end)])
set(gca,'fontSize',fontSize)

% figure,
% subplot(2,1,1)
% plot(TIME,rightAcc,'k','LineWidth',LineWidth)
% title('Ensemble Averaged','fontSize',fontSize)
% xlabel('Time (s)','fontSize',fontSize)
% xlim([0 TIME(end)])
% set(gca,'fontSize',fontSize)
% subplot(2,1,2)
% plot(TIME,Time_chan_4(timePeaks(10,2):timePeaks(10,2) + ensembleLength - 1),'k','LineWidth',LineWidth)
% title('Signle Ensemble','fontSize',fontSize)
% xlabel('Time (s)','fontSize',fontSize)
% xlim([0 TIME(end)])
% set(gca,'fontSize',fontSize)
figure,
plot(TIME,rightAcc,'r',TIME,Time_chan_4(timePeaks(10,2):timePeaks(10,2) + ensembleLength - 1),'k--','LineWidth',LineWidth)
title('Ensemble Averaged','fontSize',fontSize)
xlabel('Time (s)','fontSize',fontSize)
ylabel('Magnitude','fontSize',fontSize)
legend('Ensemble averaged','Origional')
xlim([0 TIME(end)])
set(gca,'fontSize',fontSize)
% ----------------------------------------------------------------------- %
%% Kurtosis calculating for the bearings
leftBearingkurtosis = kurtosis(leftAcc) - 3.0
rightBearingkurtosis = kurtosis(rightAcc) - 3.0

% plot(linspace(0,time(end),2 * ensembleLength),Time_chan_3(timePeaks(10,2):timePeaks(10,2) + 2 * ensembleLength - 1))
% ----------------------------------------------------------------------- %
%% ASD Plots
T = TIME(end);
N = length(TIME);
dt = T / length(TIME);
fs = 1 / dt;
fNyq = fs / 2;
df = fs / N;

Xleft = fft(leftAcc) * dt;
Xright = fft(rightAcc) * dt;
omega = 0:df:fNyq;
Xleft = Xleft(1:length(omega));
Xright = Xright(1:length(omega));
GxxLeft = conj(Xleft) .* Xleft / T;
GxxRight = conj(Xright) .* Xright / T;
figure,
plot(omega,20*log10(abs(GxxLeft)))
figure,
plot(omega,20*log10(abs(GxxRight)))
% ----------------------------------------------------------------------- %
%% ASD Plots with Windowing
T = TIME(end);
N = length(TIME);
dt = T / length(TIME);
fs = 1 / dt;
fNyq = fs / 2;
df = fs / N;

leftAcc = leftAcc .* hamming(N);
rightAcc = leftAcc .* hamming(N);

Xleft = fft(leftAcc) * dt;
Xright = fft(rightAcc) * dt;
omega = 0:df:fNyq;
Xleft = Xleft(1:length(omega));
Xright = Xright(1:length(omega));
GxxLeft = conj(Xleft) .* Xleft / T;
GxxRight = conj(Xright) .* Xright / T;
figure,
plot(omega,20*log10(abs(GxxLeft)))
figure,
plot(omega,20*log10(abs(GxxRight)))