function out = limitState(x)
out = 1 + sqrt(3) / (3 * x(1)) - 2 / (x(2) + 0.25 * x(1));
% out = x(1) * x(2) - 1140;
% out = x(1) + x(2);
% out = x(1).^2 + x(2).^2 + x(3).^2 + x(4).^2;