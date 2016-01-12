function out = TANA(x0,g0,x1,g1,grad)

% r0 = 1;
% r = fsolve(@(r)TANAinput(r,x0,g0,x1,g1,grad),r0);
% out = r;

r0 = 1;
options = optimset('Algorithm','interior-point','MaxIter',1E15,'MaxFunEvals',1E15,'TolCon',1E-15,'TolX',1E-15,'Display','on');
r = fmincon(@(r) TANAinput(r,x0,g0,x1,g1,grad),r0,[],[],[],[],-3,3,[],options);
out = r;

function out = TANAinput(r,x0,gx0,x1,gx1,grad)

sum = 0;
for ii=1:length(x1)
    sum = sum + x1(ii)^(1-r) * grad(ii) * (x0(ii)^r - x1(ii)^r);
end
out = gx0 - (sum / r + gx1);