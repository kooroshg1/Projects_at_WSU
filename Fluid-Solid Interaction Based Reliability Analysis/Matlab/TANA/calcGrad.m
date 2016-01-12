function out = calcGrad(x)
perturbation = 0.01;
pertVec = ones(1,length(x));
grad = zeros(1,length(x));
g0 = limitState(x);
for ii=1:length(x)
    pertVec(1,ii) = 1 + perturbation;
    pertX = pertVec .* x;
    gPert = limitState(pertX);
    grad(ii) = (gPert - g0) / (x(ii) * perturbation);
    pertVec(1,ii) = 1;
end
out = grad;