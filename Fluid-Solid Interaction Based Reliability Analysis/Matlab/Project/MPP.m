function out = MPP(x,MU,SIGMA)
u = (x - MU) ./ SIGMA;
out = sqrt(u'*u);