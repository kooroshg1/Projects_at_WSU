function out = FORM()
clc;
clear;
%% Reading distribution data
distData = [];
fileName = fopen('distributoin_inputData.txt','r');
while ~feof(fileName)
    distDataStr = fgetl(fileName);
    [prop1,address] = strtok(distDataStr,',');
    distDataStr = address(2:end);
    [prop2,address] = strtok(distDataStr,',');
    type = address(2:end);
    if strcmp(type,'normal')
        typeInt = 0;
    elseif strcmp(type,'lognormal')
        typeInt = 1;
    elseif strcmp(type,'uniform')
        typeInt = 2;
    elseif strcmp(type,'weibull')
        typeInt = 3;
    end
    [str2double(prop1) str2double(prop2) typeInt];
    distData = [distData;str2double(prop1) str2double(prop2) typeInt];
end
fclose all;
%% Calculating the first point using HL-RF
MU = [];
SIGMA = [];
X0 = [40;50]; % PAY ATTENTION TO THIS VALUE!!
for ii = 1:size(distData,1)
    [muP_x sigmaP_x] = eqNorm(X0(ii),distData(ii,:));
    MU = [MU;muP_x];
    SIGMA = [SIGMA;sigmaP_x];
end
GRAD = calcGrad(MU);

mu_gBar = limitState(MU);
sigma_gBar = sqrt(sum((GRAD .* SIGMA) .^ 2));
beta = mu_gBar / sigma_gBar;

ALPHA = zeros(length(MU),1);
for ii=1:length(MU)
    ALPHA(ii) = - (GRAD(ii) .* SIGMA(ii)) / sqrt(sum((GRAD .* SIGMA) .^ 2));
end
U = beta * ALPHA;
X1 = MU + U .* SIGMA;
g0 = limitState(X0);
g1 = limitState(X1);
%% Calculating \beta point using FORM
counter = 0;
epsilon = 1.0;
RESULT = [];
while (epsilon > 1E-5) && (counter < 10)
    betaOld = beta;
    X_ = X1;  
    
    MU = [];
    SIGMA = [];
    for ii = 1:size(distData,1)
        [muP_x sigmaP_x] = eqNorm(X1(ii),distData(ii,:));
        MU = [MU;muP_x];
        SIGMA = [SIGMA;sigmaP_x];
    end   
   
    GRAD = calcGrad(X1);
    r = TANA(X0,g0,X1,g1,GRAD);

    RESULT = [RESULT;X1' GRAD' r beta epsilon];
    
    options = optimset('Algorithm','sqp','MaxIter',1E5,'MaxFunEvals',1E5,'TolCon',1E-10,'TolX',1E-10,'Display','off');
    X = fmincon(@(X) MPP(X,MU,SIGMA),X_,[],[],[],[],[],[],@(X) functionApp(X,X1,g1,GRAD,r),options);

    beta = MPP(X,MU,SIGMA);
    epsilon = abs(beta - betaOld) / abs(beta);
    X1 = X;
    g0 = g1;
    g1 = limitState(X1);
    
    counter = counter + 1;
end
RESULT = [RESULT;X1' GRAD' r beta epsilon]

