function [rho]=acf(x,nrho)
%  function [rho]=acf(x,nrho)
%  Sample autocorrelation function for vector x of data
%  gamma is the sample autocovariance, rho is the sample autocorrelation 
%  k in gamma(k) and rho(k) starts at k=0 and runs to k=nrho
%  NB: gamma below is really the autocovariance times T; dividing by T 
%  not needed since we take ratios anyway.  
%
nobs = length(x);
xbar = mean(x);
xdev = x - xbar;
gamma = zeros(nrho+1,1);

for k = 0:nrho;
    xlags = zeros(nobs,1);
    xlags(k+1:nobs) = xdev(1:nobs-k);
    gamma(k+1) = sum(xlags.*xdev);
end

rho = gamma/gamma(1);

return