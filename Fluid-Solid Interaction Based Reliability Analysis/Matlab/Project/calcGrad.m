function out = calcGrad(x)
perturbation = 0.01;
pertVec = ones(length(x),1);
grad = zeros(length(x),1);
g0 = limitState(x);
for ii=1:length(x)
    pertVec(ii,1) = 1 + perturbation;
    pertX = pertVec .* x;
    gPert = limitState(pertX);
    grad(ii) = (gPert - g0) / (x(ii) * perturbation);
    pertVec(ii,1) = 1;
end
out = grad;