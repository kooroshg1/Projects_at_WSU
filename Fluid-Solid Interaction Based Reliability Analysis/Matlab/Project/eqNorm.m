function [muP_x sigmaP_x] = eqNorm(x,prop1,prop2,type)
if nargin == 2
    prop2 = prop1(1,2);
    type = prop1(1,3);
    prop1 = prop1(1,1);
end
sigmaP_x = normpdf(norminv(distFuncCdf(x,prop1,prop2,type))) ./ distFuncPdf(x,prop1,prop2,type);
muP_x = x - norminv(distFuncCdf(x,prop1,prop2,type)) .* sigmaP_x;
% ----------------------------------------------------------------------- %
function out = distFuncPdf(x,prop1,prop2,type)
if type == 0
    out = normpdf(x,prop1,prop2);
end
if type == 1
    out = lognpdf(x,prop1,prop2);
end
if type == 2
%     out = unifpdf(x,prop1,prop2);
    out = unifpdf(x,prop1-1E-5*prop1,prop2+1E-5*prop2);
end
if type == 3
    out = wblpdf(x,prop1,prop2)
end
% ----------------------------------------------------------------------- %
function out = distFuncCdf(x,prop1,prop2,type)
if type == 0
    out = normcdf(x,prop1,prop2);
end
if type == 1
    out = logncdf(x,prop1,prop2);
end
if type == 2
%     out = unifcdf(x,prop1,prop2);
    out = unifcdf(x,prop1-1E-5*prop1,prop2+1E-5*prop2);
end
if type == 3
    out = wblcdf(x,prop1,prop2);
end
% ----------------------------------------------------------------------- %