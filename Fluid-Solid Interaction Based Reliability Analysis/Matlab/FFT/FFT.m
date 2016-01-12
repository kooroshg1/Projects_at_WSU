clc;
clear all;
format short g;
close all;
% ----------------------------------------------------------------------- %
lineWidth = 3.0;
fontSize = 40.0;
load('C:\Users\ecsroot\Dropbox\Structural_Reliability_Project\Result\RESULTS_NORMAL+WEIBULL_0005SENSITIVITY.mat')
load('C:\Users\ecsroot\Dropbox\Structural_Reliability_Project\Result\GRAD_01_005_001_0005_0001_.mat')
GRAD = vec2mat(GRAD,6);
X = ones(5,1) * RESULT(end,2:7);
% GRAD = GRAD .* X;
GRAD = GRAD(3,:)';



U = linspace(100,400,1000);
Updf = normpdf(U,265,40);
alpha = linspace(0.1,16,1000);
alphaPdf = normpdf(alpha,7,3);
C_0 = linspace(0.1,0.8,1000);
C_0pdf = normpdf(C_0,0.5,0.1);
E = linspace(1E9,5E11,1000);
Epdf = wblpdf(E,2E11,5);
L = linspace(0.2,1.8,1000);
Lpdf = lognpdf(L,-0.0049752,0.099751);
I = linspace(2e-7,10e-7,1000);
Ipdf = lognpdf(I,-14.474,0.099751);

X0 = RESULT(end,2:7)';
A = abs(1 / 3 .* (X0 .^ (1 - 3)) .* GRAD);
% A = (1 / 3 .* (X0 .^ (1 - 3)) .* GRAD);
G = RESULT(4,14) - (1 / 3) * sum(X0 .* GRAD);

yU = G + A(1) * U .^ 3;
yAlpha = A(2) * alpha .^ 3; 
yC_0 = A(3) * C_0 .^ 3;
yE = A(4) * E .^ 3;
yL = A(5) * L .^ 3;
yI = A(6) * I .^ 3;



dU_dyU = 1 / (3 * A(1)) * ((yU - G) / A(1)) .^ ((1 - 3) / 3);
dAlpha_dyAlpha = 1 / (3 * A(2)) * (yAlpha / A(2)) .^ ((1 - 3) / 3);
dC_0_dyC_0 = 1 / (3 * A(3)) * (yC_0 / A(3)) .^ ((1 - 3) / 3);
dE_dyE = 1 / (3 * A(4)) * (yE / A(4)) .^ ((1 - 3) / 3);
dL_dyL = 1 / (3 * A(5)) * (yL / A(5)) .^ ((1 - 3) / 3);
dI_dyI = 1 / (3 * A(6)) * (yI / A(6)) .^ ((1 - 3) / 3);

% yU_pdf = dU_dyU .* unifpdf(((yU - G) / A(1)) .^ (1 / 3),220,300);
% yAlpha_pdf = dAlpha_dyAlpha .* normpdf((yAlpha / A(2)) .^ (1 / 3),7,2);
% yC_0_pdf = dC_0_dyC_0 .* unifpdf((yC_0 / A(3)) .^ (1 / 3),0.3,0.6);
% yE_pdf = dE_dyE .* wblpdf((yE / A(4)) .^ (1 / 3),2E11,5);
% yL_pdf = dL_dyL .* lognpdf((yL / A(5)) .^ (1 / 3),-0.0049752,0.099751);
% yI_pdf = dI_dyI .* lognpdf((yI / A(6)) .^ (1 / 3),-14.474,0.099751);

yU_pdf = dU_dyU .* normpdf(U,265,40);
yAlpha_pdf = dAlpha_dyAlpha .* normpdf(alpha,7,3);
yC_0_pdf = dC_0_dyC_0 .* normpdf(C_0,0.5,0.1);
yE_pdf = dE_dyE .* wblpdf(E,2E11,5);
yL_pdf = dL_dyL .* lognpdf(L,-0.0049752,0.099751);
yI_pdf = dI_dyI .* lognpdf(I,-14.474,0.099751);

figure,
plot(yU,yU_pdf)
figure,
plot(yAlpha,yAlpha_pdf)
figure,
plot(yC_0,yC_0_pdf)
figure,
plot(yE,yE_pdf)
figure,
plot(yL,yL_pdf)
figure,
plot(yI,yI_pdf)
close all;

fft_n = 2^(nextpow2(2*length(yU_pdf)-1));
G = ifft(fft(yU_pdf,fft_n) .* fft(yAlpha_pdf,fft_n) .* fft(yC_0_pdf,fft_n) .* fft(yE_pdf,fft_n) .* fft(yL_pdf,fft_n) .* fft(dI_dyI,fft_n));
% length([fft(fz1(z1),fft_n)]);
G_min = min(yU) + min(yAlpha) + min(yC_0) + min(yE) + min(yL) + min(yI)
% G_min = min([min(yU) min(yAlpha) min(yC_0) min(yE) min(yL) min(yI)])
G_max = max(yU) + max(yAlpha) + max(yC_0) + max(yE) + max(yL) + max(yI)
% G_max = max([max(yU) max(yAlpha) max(yC_0) max(yE) max(yL) max(yI)])
G = G / trapz(linspace(G_min,G_max,length(G)),G);
[r c] = min(G);
G = [G(c:end) G(1:c-1)];
Gx = linspace(G_min,G_max,length(G));
figure
plot(Gx,G,'k','linewidth',lineWidth)
xlabel('g(X)','fontSize',fontSize)
ylabel('f_g','fontSize',fontSize)
set(gca,'fontSize',fontSize)
[r c] = min(abs(Gx));
trapz(Gx(1:c),G(1:c))