function [rho]=ccf(x,y,nrho)
%  function [rho]=acf(x,nrho)
%  Sample cross-correlation function for vectors (x,y) of data 
%  gamma is sample cross-covariance, rho is sample cross-correlation 
%  gamma(k) and rho(k) start at k=0 
%  NB: I don't divide sums by T (=nobs):  gamma below is really the 
%  cross-covariance times T.   
%
nobs = length(x);

xbar = mean(x);
xdev = x - xbar;
xvar = sum(xdev.^2);

ybar = mean(y);
ydev = y - ybar;
yvar = sum(ydev.^2);

gamma = zeros(2*nrho+1,1);
gamma(nrho+1) = sum(xdev.*ydev);

for k = 1:nrho;
    xlags = zeros(nobs,1);
    ylags = xlags;
    xlags(1:nobs-k) = xdev(1+k:nobs);
    ylags(1:nobs-k) = ydev(1+k:nobs);
    gamma(nrho+1+k) = sum(xlags.*ydev);     % k>0
    gamma(nrho+1-k) = sum(xdev.*ylags);     % k<0 
end

denom = sqrt(xvar*yvar);
rho = gamma/denom;

return 