function out = FRFplot(inputLocation,Freq_range)
if nargin == 1
    Freq_range = [0 0];
end
clc;
format short g;
close all;
fclose all;
% clear -except inputLocation;
% ----------------------------------------------------------------------- %
lineWidth = 3;
fontSize = 30;
Freq_range_min = Freq_range(1);
Freq_range_max = Freq_range(2);
% ----------------------------------------------------------------------- %
% inputLocation = 3;
Gfx_n1 = 0;
Gxf_n1 = 0;
Gff_n1 = 0;
Gxx_n1 = 0;

Gfx_n2 = 0;
Gxf_n2 = 0;
Gff_n2 = 0;
Gxx_n2 = 0;

Gfx_n3 = 0;
Gxf_n3 = 0;
Gff_n3 = 0;
Gxx_n3 = 0;
fileName = 'C:\Users\ecsroot\Desktop\Koorosh\Courses\ME7690_Vibration_testing\Lab4\Data\';
fileName = [fileName num2str(inputLocation)];
for ii=1:10
    readName = [fileName '\' num2str(ii) '.mat'];
    load(readName)
    dt = Time_domain(2) - Time_domain(1);
    T = Time_domain(end);
    fs = 1 / dt;
    fNyq = 0.25 * fs;
    df = 1 / T;

%     omega = 0:df:fNyq;
    omega = Freq_domain;
    F = fft(Time_chan_1) * dt; F = F(1:length(omega));
    X1 = fft(Time_chan_2) * dt; X1 = X1(1:length(omega));
    X2 = fft(Time_chan_3) * dt; X2 = X2(1:length(omega));
    X3 = fft(Time_chan_4) * dt; X3 = X3(1:length(omega));

    % 'n' represents the input location. For 'far' it is (3) 
    Gfx_n1 = Gfx_n1 + conj(F) .* X1 / T;
    Gxf_n1 = Gxf_n1 + conj(X1) .* F / T;
    Gff_n1 = Gff_n1 + real(conj(F) .* F) / T;
    Gxx_n1 = Gxx_n1 + real(conj(X1) .* X1) / T;

    Gfx_n2 = Gfx_n2 + conj(F) .* X2 / T;
    Gxf_n2 = Gxf_n2 + conj(X2) .* F / T;
    Gff_n2 = Gff_n2 + real(conj(F) .* F) / T;
    Gxx_n2 = Gxx_n2 + real(conj(X2) .* X2) / T;

    Gfx_n3 = Gfx_n3 + conj(F) .* X3 / T;
    Gxf_n3 = Gxf_n3 + conj(X3) .* F / T;
    Gff_n3 = Gff_n3 + real(conj(F) .* F) / T;
    Gxx_n3 = Gxx_n3 + real(conj(X3) .* X3) / T;
end
Gfx_n1 = Gfx_n1 / 10;
Gxf_n1 = Gxf_n1 / 10;
Gff_n1 = Gff_n1 / 10;
Gxx_n1 = Gxx_n1 / 10;

Gfx_n2 = Gfx_n2 / 10;
Gxf_n2 = Gxf_n2 / 10;
Gff_n2 = Gff_n2 / 10;
Gxx_n2 = Gxx_n2 / 10;

Gfx_n3 = Gfx_n3 / 10;
Gxf_n3 = Gxf_n3 / 10;
Gff_n3 = Gff_n3 / 10;
Gxx_n3 = Gxx_n3 / 10;

H1_n1 = Gfx_n1 ./ Gff_n1;
H2_n1 = Gxx_n1 ./ Gxf_n1;
gamma_n1 = real(H1_n1 ./ H2_n1);

H1_n2 = Gfx_n2 ./ Gff_n2;
H2_n2 = Gxx_n2 ./ Gxf_n2;
gamma_n2 = real(H1_n2 ./ H2_n2);

H1_n3 = Gfx_n3 ./ Gff_n3;
H2_n3 = Gxx_n3 ./ Gxf_n3;
gamma_n3 = real(H1_n3 ./ H2_n3);

if nargin == 2
    [r minIndex] = min(abs(omega - Freq_range_min));
    [r maxIndex] = min(abs(omega - Freq_range_max));
else
    minIndex = 1;
    maxIndex = length(omega);
end

% figure('units','normalized','outerposition',[0 0 1 1])
% subplot(2,1,1)
% plot(omega(minIndex:maxIndex),20*log10(abs(H1_n1(minIndex:maxIndex))),'r',omega(minIndex:maxIndex),20*log10(abs(H2_n1(minIndex:maxIndex))),'k','lineWidth',lineWidth)
% legend('H_1','H_2')
% xlabel('Frequency (Hz)','fontSize',fontSize)
% ylabel('Magnitude (dB)','fontSize',fontSize)
% titleName = ['Input at node ' num2str(inputLocation) ' , Output at node 1'];
% title(titleName,'fontSize',fontSize)
% set(gca,'fontSize',fontSize)
% subplot(2,1,2)
% plot(omega(minIndex:maxIndex),gamma_n1(minIndex:maxIndex),'k','lineWidth',lineWidth)
% xlabel('Frequency (Hz)','fontSize',fontSize)
% ylabel('Coherence','fontSize',fontSize)
% set(gca,'fontSize',fontSize)
% % print -depsc 'node_1MAG.eps'
% 
figure('units','normalized','outerposition',[0 0 1 1])
subplot(2,1,1)
plot(omega(minIndex:maxIndex),20*log10(abs(H1_n1(minIndex:maxIndex))),'r',omega(minIndex:maxIndex),20*log10(abs(H2_n1(minIndex:maxIndex))),'k','lineWidth',lineWidth)
legend('H_1','H_2')
xlabel('Frequency (Hz)','fontSize',fontSize)
ylabel('Magnitude (dB)','fontSize',fontSize)
titleName = ['Input at node ' num2str(inputLocation) ' , Output at node 1'];
title(titleName,'fontSize',fontSize)
set(gca,'fontSize',fontSize)
subplot(2,1,2)
plot(omega(minIndex:maxIndex),angle(H1_n1(minIndex:maxIndex)),'k','lineWidth',lineWidth)
xlabel('Frequency (Hz)','fontSize',fontSize)
ylabel('Phase (Rad)','fontSize',fontSize)
set(gca,'fontSize',fontSize)
% print -depsc 'node_1PHASE.eps'

% figure('units','normalized','outerposition',[0 0 1 1])
% subplot(2,1,1)
% plot(omega(minIndex:maxIndex),20*log10(abs(H1_n2(minIndex:maxIndex))),'r',omega(minIndex:maxIndex),20*log10(abs(H2_n2(minIndex:maxIndex))),'k','lineWidth',lineWidth)
% legend('H_1','H_2')
% xlabel('Frequency (Hz)','fontSize',fontSize)
% ylabel('Magnitude (dB)','fontSize',fontSize)
% titleName = ['Input at node ' num2str(inputLocation) ' , Output at node 2'];
% title(titleName,'fontSize',fontSize)
% set(gca,'fontSize',fontSize)
% subplot(2,1,2)
% plot(omega(minIndex:maxIndex),gamma_n2(minIndex:maxIndex),'k','lineWidth',lineWidth)
% xlabel('Frequency (Hz)','fontSize',fontSize)
% ylabel('Coherence','fontSize',fontSize)
% set(gca,'fontSize',fontSize)
% % print -depsc 'node_2MAG.eps'
% 
figure('units','normalized','outerposition',[0 0 1 1])
subplot(2,1,1)
plot(omega(minIndex:maxIndex),20*log10(abs(H1_n2(minIndex:maxIndex))),'r',omega(minIndex:maxIndex),20*log10(abs(H2_n2(minIndex:maxIndex))),'k','lineWidth',lineWidth)
legend('H_1','H_2')
xlabel('Frequency (Hz)','fontSize',fontSize)
ylabel('Magnitude (dB)','fontSize',fontSize)
titleName = ['Input at node ' num2str(inputLocation) ' , Output at node 2'];
title(titleName,'fontSize',fontSize)
set(gca,'fontSize',fontSize)
subplot(2,1,2)
plot(omega(minIndex:maxIndex),angle(H1_n2(minIndex:maxIndex)),'k','lineWidth',lineWidth)
xlabel('Frequency (Hz)','fontSize',fontSize)
ylabel('Phase (Rad)','fontSize',fontSize)
set(gca,'fontSize',fontSize)
% print -depsc 'node_2PHASE.eps'

% figure('units','normalized','outerposition',[0 0 1 1])
% subplot(2,1,1)
% plot(omega(minIndex:maxIndex),20*log10(abs(H1_n3(minIndex:maxIndex))),'r',omega(minIndex:maxIndex),20*log10(abs(H2_n3(minIndex:maxIndex))),'k','lineWidth',lineWidth)
% legend('H_1','H_2')
% xlabel('Frequency (Hz)','fontSize',fontSize)
% ylabel('Magnitude (dB)','fontSize',fontSize)
% titleName = ['Input at node ' num2str(inputLocation) ' , Output at node 3'];
% title(titleName,'fontSize',fontSize)
% set(gca,'fontSize',fontSize)
% subplot(2,1,2)
% plot(omega(minIndex:maxIndex),gamma_n3(minIndex:maxIndex),'k','lineWidth',lineWidth)
% xlabel('Frequency (Hz)','fontSize',fontSize)
% ylabel('Coherence','fontSize',fontSize)
% set(gca,'fontSize',fontSize)
% print -depsc 'node_3MAG.eps'

figure('units','normalized','outerposition',[0 0 1 1])
subplot(2,1,1)
plot(omega(minIndex:maxIndex),20*log10(abs(H1_n3(minIndex:maxIndex))),'r',omega(minIndex:maxIndex),20*log10(abs(H2_n3(minIndex:maxIndex))),'k','lineWidth',lineWidth)
legend('H_1','H_2')
xlabel('Frequency (Hz)','fontSize',fontSize)
ylabel('Magnitude (dB)','fontSize',fontSize)
titleName = ['Input at node ' num2str(inputLocation) ' , Output at node 3'];
title(titleName,'fontSize',fontSize)
set(gca,'fontSize',fontSize)
subplot(2,1,2)
plot(omega(minIndex:maxIndex),angle(H1_n3(minIndex:maxIndex)),'k','lineWidth',lineWidth)
xlabel('Frequency (Hz)','fontSize',fontSize)
ylabel('Phase (Rad)','fontSize',fontSize)
set(gca,'fontSize',fontSize)
% print -depsc 'node_3PHASE.eps'

% skip = 10;
% figure('units','normalized','outerposition',[0 0 1 1])
% plot(omega,20*log10(abs(H1_n1)),'r',omega,20*log10(abs(H2_n1)),'k',Freq_domain(1:skip:end),20*log10(abs(Hf_chan_2(1:skip:end))),'b+','lineWidth',lineWidth)
% legend('H_1','H_2','H_f')
% xlabel('Frequency (Hz)','fontSize',fontSize)
% ylabel('Magnitude (dB)','fontSize',fontSize)
% titleName = ['Input at node ' num2str(inputLocation) ' , Output at node 1'];
% title(titleName,'fontSize',fontSize)
% set(gca,'fontSize',fontSize)
% print -depsc 'node_1_comp.eps'
% 
% figure('units','normalized','outerposition',[0 0 1 1])
% plot(omega,20*log10(abs(H1_n2)),'r',omega,20*log10(abs(H2_n2)),'k',Freq_domain(1:skip:end),20*log10(abs(Hf_chan_3(1:skip:end))),'b+','lineWidth',lineWidth)
% legend('H_1','H_2','H_f')
% xlabel('Frequency (Hz)','fontSize',fontSize)
% ylabel('Magnitude (dB)','fontSize',fontSize)
% titleName = ['Input at node ' num2str(inputLocation) ' , Output at node 2'];
% title(titleName,'fontSize',fontSize)
% set(gca,'fontSize',fontSize)
% print -depsc 'node_2_comp.eps'
% 
% figure('units','normalized','outerposition',[0 0 1 1])
% plot(omega,20*log10(abs(H1_n3)),'r',omega,20*log10(abs(H2_n3)),'k',Freq_domain(1:skip:end),20*log10(abs(Hf_chan_4(1:skip:end))),'b+','lineWidth',lineWidth)
% legend('H_1','H_2','H_f')
% xlabel('Frequency (Hz)','fontSize',fontSize)
% ylabel('Magnitude (dB)','fontSize',fontSize)
% titleName = ['Input at node ' num2str(inputLocation) ' , Output at node 3'];
% title(titleName,'fontSize',fontSize)
% set(gca,'fontSize',fontSize)
% print -depsc 'node_3_comp.eps'

clear all;