function [c,ceq] = functionApp(x,x1,g1,grad,r)

sum = 0;
for ii=1:length(x1)
    sum = sum + (x1(ii) ^ (1 - r)) * (x(ii) ^ r - x1(ii) ^ r) * grad(ii);
end
sum = g1 + sum / r;
c = [];
ceq = [sum];