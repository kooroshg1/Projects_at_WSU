function out = distFuncCdf(x)
if isreal(distFuncPdf(-100))
    X = linspace(-100,x,10000);
else
    X = linspace(0.0001,x,10000);
end
out = trapz(X,distFuncPdf(X));