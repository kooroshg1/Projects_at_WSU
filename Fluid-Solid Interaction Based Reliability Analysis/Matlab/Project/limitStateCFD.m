function out = limitState(X)
A = X(1);
U = X(2);
theta_wind = X(3);
momentCord = X(4);
E = X(5);
L = X(6);
I = X(7);
% ----------------------------------------------------------------------- %
workingDicCFD = '/home/koorosh/Desktop/Koorosh/Structural_Reliability_Project/CFD';
workingDicFEA = '/home/koorosh/Desktop/Koorosh/Structural_Reliability_Project/FEA';
% ----------------------------------------------------------------------- %
% Read domain dimensions
r = 3;
l = 15;
theta = 0.1;
rho = 0.30267;
% A = 1.0;            % Random variable
% U = 265;            % Random varialbe
% theta_wind = 0;     % Random varialbe
% momentCord = 0.5;   % Random variable
% E = 2E+11;          % Random variable
% L = 1.0;              % Random variable
% I = 5.2E-7;         % Random variable
epsilon = 1.0;
output = [];
while epsilon > 0.1
    cd(workingDicCFD);
    initialCondition(U,theta+theta_wind)
    runOpenFOAM;

    [top, bottom] = getData(momentCord,theta+theta_wind,'full');
    [Fx, Fy, M] = getData(momentCord,theta+theta_wind)

    Cl = Fy / (0.5 * rho * A * U ^ 2)
    Cd = Fx / (0.5 * rho * A * U ^ 2)
    % ----------------------------------------------------------------------- %
    cd(workingDicFEA);
    % ----------------------------------------------------------------------- %
    global sol
    global model
    global catalog
    global grids
    global element
    global opt
    global result
    global analysis
    % ----------------------------------------------------------------------- %
    FEAmodify(L,I,E)
    fem4d('beam.fem4d');
    % ----------------------------------------------------------------------- %
    Fx = Fx;
    Fy = Fy;
    M = M;
    analysis(1).Fa(4) = Fx;
    analysis(1).Fa(5) = Fy;
    analysis(1).Fa(6) = M;
    fem4dSolver();
    displacement = full(analysis(1).Ug);
    thetaOld = theta;
    theta = atand(displacement(6) / L) + displacement(6) * 180 / pi;
    epsilon = abs((thetaOld - theta) / thetaOld);
    output = [output;Fx Fy M displacement' thetaOld theta epsilon]
end
out = Fy;