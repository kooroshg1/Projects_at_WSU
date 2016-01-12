% function out = extractData()
for inputLocation = 1:3
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

%         omega = 0:df:fNyq;
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

%     figure,
%     subplot(2,1,1)
%     plot(omega,20*log10(abs(H1_n1)),'r',omega,20*log10(abs(H2_n1)),'k','lineWidth',lineWidth)
%     legend('H_1','H_2')
%     xlabel('Frequency (Hz)','fontSize',fontSize)
%     ylabel('Magnitude (dB)','fontSize',fontSize)
%     titleName = ['Input at node ' num2str(inputLocation) ' , Output at node 1'];
%     title(titleName,'fontSize',fontSize)
%     set(gca,'fontSize',fontSize)
%     subplot(2,1,2)
%     plot(omega,gamma_n1,'k','lineWidth',lineWidth)
%     xlabel('Frequency (Hz)','fontSize',fontSize)
%     ylabel('Coherence','fontSize',fontSize)
%     set(gca,'fontSize',fontSize)
% 
%     figure,
%     subplot(2,1,1)
%     plot(omega,20*log10(abs(H1_n2)),'r',omega,20*log10(abs(H2_n2)),'k','lineWidth',lineWidth)
%     legend('H_1','H_2')
%     xlabel('Frequency (Hz)','fontSize',fontSize)
%     ylabel('Magnitude (dB)','fontSize',fontSize)
%     titleName = ['Input at node ' num2str(inputLocation) ' , Output at node 2'];
%     title(titleName,'fontSize',fontSize)
%     set(gca,'fontSize',fontSize)
%     subplot(2,1,2)
%     plot(omega,gamma_n2,'k','lineWidth',lineWidth)
%     xlabel('Frequency (Hz)','fontSize',fontSize)
%     ylabel('Coherence','fontSize',fontSize)
%     set(gca,'fontSize',fontSize)
% 
%     figure,
%     subplot(2,1,1)
%     plot(omega,20*log10(abs(H1_n3)),'r',omega,20*log10(abs(H2_n3)),'k','lineWidth',lineWidth)
%     legend('H_1','H_2')
%     xlabel('Frequency (Hz)','fontSize',fontSize)
%     ylabel('Magnitude (dB)','fontSize',fontSize)
%     titleName = ['Input at node ' num2str(inputLocation) ' , Output at node 3'];
%     title(titleName,'fontSize',fontSize)
%     set(gca,'fontSize',fontSize)
%     subplot(2,1,2)
%     plot(omega,gamma_n3,'k','lineWidth',lineWidth)
%     xlabel('Frequency (Hz)','fontSize',fontSize)
%     ylabel('Coherence','fontSize',fontSize)
%     set(gca,'fontSize',fontSize)

    nameH1_n1 = genvarname(['H1_1' num2str(inputLocation)]);
    assignin('base',nameH1_n1,H1_n1);
    namegamma_n1 = genvarname(['gamma_1' num2str(inputLocation)]);
    assignin('base',namegamma_n1,gamma_n1);
    nameH1_n2 = genvarname(['H1_2' num2str(inputLocation)]);
    assignin('base',nameH1_n2,H1_n2);
    namegamma_n2 = genvarname(['gamma_2' num2str(inputLocation)]);
    assignin('base',namegamma_n2,gamma_n2);
    nameH1_n3 = genvarname(['H1_3' num2str(inputLocation)]);
    assignin('base',nameH1_n3,H1_n3);
    namegamma_n3 = genvarname(['gamma_3' num2str(inputLocation)]);
    assignin('base',namegamma_n3,gamma_n3);

    clearvars -except H1_12 gamma_12 H1_22 gamma_22 H1_32 gamma_32 ...
                        H1_11 gamma_11 H1_21 gamma_21 H1_31 gamma_31 ...
                        H1_13 gamma_13 H1_23 gamma_23 H1_33 gamma_33 ...
                        inputLocation fontSize lineWidth omega
end
% close all;
H(1,1,:) = H1_11;
H(1,2,:) = H1_12;
H(1,3,:) = H1_13;
H(2,1,:) = H1_21;
H(2,2,:) = H1_22;
H(2,3,:) = H1_23;
H(3,1,:) = H1_31;
H(3,2,:) = H1_32;
H(3,3,:) = H1_33;

save 'H1_11.mat' H1_11
save 'H1_12.mat' H1_12
save 'H1_13.mat' H1_13
save 'H1_21.mat' H1_21
save 'H1_22.mat' H1_22
save 'H1_23.mat' H1_23
save 'H1_31.mat' H1_31
save 'H1_32.mat' H1_32
save 'H1_33.mat' H1_33
save 'H.mat' H
save 'omega.mat' omega