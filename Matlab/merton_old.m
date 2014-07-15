%  merton.m 
%  Option prices and implied vols for Merton model (poisson-normal mixture)  
%  See Merton (JFE, 1976) for the general setup
%  Notation 
%    log re = log r1 + N(mu,sigma^2) + j N(theta,delta^2)
%    j = # poisson jumps, intensity omega 
%  Parameters are true (names as is) and risk-neutral (extra s at the end) 
%  Backus, Chernov, and Martin, "Disasters in equity index options"
%  Written:  April 2009 and after 
format compact 
clear all
%close all

disp(' ')
disp('Merton option model') 
disp('---------------------------------------------------------------')
disp(' ')
%
%  1. parameter inputs 
disp('Parameter values') 
% data 
tau = 1/4;         % maturity of option
logr1 = tau*0.020;
q1 = exp(-logr1);
ep = 0.0400;
sigmare = 0.1800;

% true distribution (sigma is all we need here) 
omega = 1.5120;
theta = -0.0259;
delta = 0.0407;
mu = ep - omega*theta
sigma = sqrt(sigmare^2-omega*(theta^2+delta^2))

% risk-neutral distribution 
disp('omega* theta* delta*')
omegas = 1.5120; deltas = 0.0981; thetas = log(1-0.0482)-deltas^2/2;    %  Chernov
[omegas thetas deltas] 

% set mu* to satisfy arb condition 
mus = - sigma^2/2 - omegas*(exp(thetas+deltas^2/2)-1)

%  2. Option prices (Merton model) 
disp(' ')
disp('Option prices') 

% strike grid 
ngrid = 10;
bscale = 0.08;  %bscale = 0.3;
bgrid = bscale*[-ngrid:ngrid]'/ngrid + 1;
logbgrid = log(bgrid);

% probs 
nprob = 10;
jgrid = [0:nprob]';
probs = exp(-tau*omegas)*(tau*omegas).^jgrid./gamma(jgrid+1)
checksumprobs = sum(probs)  %  should be exactly 1.0 

% vectorize instead of looping 
logbarray = logbgrid(:,ones(1,nprob+1));

% base parameters 
kappa1j = (tau*mus + jgrid*thetas)';
kappa1jarray = kappa1j(ones(1,2*ngrid+1),:);
kappa2j = (tau*sigma^2 + jgrid*deltas^2)';
kappa2jarray = kappa2j(ones(1,2*ngrid+1),:);
darray = (logbarray - logr1 - kappa1jarray)./sqrt(kappa2jarray);
putarray = q1*exp(logbarray).*normcdf(darray) ... 
        - exp(kappa1jarray+kappa2jarray/2).*normcdf(darray-sqrt(kappa2jarray));
put_base = putarray*probs;

% small theta 
thetasmall = 0*thetas/2;
mus_thetasmall = - sigma^2/2 - omegas*(exp(thetasmall+deltas^2/2)-1);
kappa1j = (tau*mus_thetasmall + jgrid*thetasmall)';          
kappa1jarray = kappa1j(ones(1,2*ngrid+1),:);
kappa2j = (tau*sigma^2 + jgrid*deltas^2)';
kappa2jarray = kappa2j(ones(1,2*ngrid+1),:);
darray = (logbarray - logr1 - kappa1jarray)./sqrt(kappa2jarray);
putarray = q1*exp(logbarray).*normcdf(darray) ... 
        - exp(kappa1jarray+kappa2jarray/2).*normcdf(darray-sqrt(kappa2jarray));
put_smalltheta = putarray*probs;

% small delta
deltasmall = 0*deltas/sqrt(2);
mus_deltasmall = - sigma^2/2 - omegas*(exp(thetas+deltasmall^2/2)-1);
kappa1j = (tau*mus_deltasmall + jgrid*thetas)';          
kappa1jarray = kappa1j(ones(1,2*ngrid+1),:);
kappa2j = (tau*sigma^2 + jgrid*deltasmall^2)';      
kappa2jarray = kappa2j(ones(1,2*ngrid+1),:);
darray = (logbarray - logr1 - kappa1jarray)./sqrt(kappa2jarray);
putarray = q1*exp(logbarray).*normcdf(darray) ... 
        - exp(kappa1jarray+kappa2jarray/2).*normcdf(darray-sqrt(kappa2jarray));
put_smalldelta = putarray*probs;

% consumption-based model 1:  univariate with perfect corr betw cons and return 
% (subscript 1 refrs to cons, 2 to returns)
disp('Univariate consumption model') 
sigmag = 0.035;
sigmare = 0.18;
lambda = sigmare/sigmag
omega = 0.01;
%omega = 0;
theta1 = -0.3;
delta1 = 0.15;
sigma1 = sqrt(sigmag^2-omega*(theta1^2+delta1^2))

alpha = 5.1893;
omegas = omega*exp(-alpha*theta1+(alpha*delta1)^2/2)
theta1s = theta1 - alpha*delta1^2
delta1s = delta1;

sigma2 = lambda*sigma1;
theta2s = lambda*theta1s
delta2s = lambda*delta1s;
mu2s = - sigma2^2/2 - omegas*(exp(theta2s+delta2s^2/2)-1)

probs = exp(-tau*omegas)*(tau*omegas).^jgrid./gamma(jgrid+1);
checksumprobs = sum(probs)  %  should be exactly 1.0 
kappa1j = (tau*mu2s + jgrid*theta2s)';
kappa1jarray = kappa1j(ones(1,2*ngrid+1),:);
kappa2j = (tau*sigma2^2 + jgrid*delta2s^2)';
kappa2jarray = kappa2j(ones(1,2*ngrid+1),:);
darray = (logbarray - logr1 - kappa1jarray)./sqrt(kappa2jarray);
putarray = q1*exp(logbarray).*normcdf(darray) ... 
        - exp(kappa1jarray+kappa2jarray/2).*normcdf(darray-sqrt(kappa2jarray));
put_con = putarray*probs;

% consumption-based model 2:  bivariate distribution of cons and returns 
disp('Bivariate consumption model') 
sigmag = 0.035;
sigmare = 0.18;
lambda = 0.18/0.035;
omega = 0.01;
theta1 = -0.3;
delta11 = 0.15^2;
sigma11 = sigmag^2-omega*(theta1^2+delta11);
sqrt(sigma11)      %  check

alpha = 6.427; rho = -0.637;  
%alpha = 5.1893; rho = 1;        % test: should replicate univariate example 
sigma12 = rho*lambda*sigma11;
sigma22 = lambda^2*sigma11;
theta2 = lambda*theta1;
mu2 = ep - omega*theta2;
delta12 = rho*lambda*delta11;
delta22 = lambda^2*delta11;

theta2s = theta2 - alpha*delta12
omegas = omega*exp(-alpha*theta1+alpha^2*delta11/2)
mu2s = - sigma22/2 - omegas*(exp(theta2s+delta22/2)-1)

mu2 = ep - omega*theta2
mu2s_alt = mu2 - alpha*sigma12 

probs = exp(-tau*omegas)*(tau*omegas).^jgrid./gamma(jgrid+1);
kappa1j = (tau*mu2s + jgrid*theta2s)';          
kappa1jarray = kappa1j(ones(1,2*ngrid+1),:);
kappa2j = (tau*sigma22 + jgrid*delta22)';      
kappa2jarray = kappa2j(ones(1,2*ngrid+1),:);
darray = (logbarray - logr1 - kappa1jarray)./sqrt(kappa2jarray);
putarray = q1*exp(logbarray).*normcdf(darray) ... 
        - exp(kappa1jarray+kappa2jarray/2).*normcdf(darray-sqrt(kappa2jarray));
put_bivar = putarray*probs;

puts = [put_base put_smalltheta put_smalldelta put_con put_bivar];

%return 

%  3. Implied vols  
disp(' ')
disp('Implied volatilities') 
vol = zeros(size(puts)) + sigmare; 
kappa1 = zeros(size(puts)); 
kappa2 = kappa1; 

maxit = 100;
tol = 1.e-10;   % tolerance set on relative price error  
put = puts;     % true put prices 
[nstrike,nput] = size(put);

logbarray = logbgrid(:,ones(1,nput));       % replicate for each set of options

% Newton's method on function f[log(vol)] = bsm_price[log(vol)] - price
% Derivative fp is the "vega" divided by vol (chain rule)
% Note:  solution works for arrays of put prices and strikes 
for it=1:maxit
    it;
    kappa2 = vol.^2;
    kappa1 = -kappa2/2;
    darray = (logbarray - logr1 - kappa1)./vol;
    putbsmguess = q1*exp(logbarray).*normcdf(darray) - normcdf(darray-vol);
    f = putbsmguess - put;
    fp = normpdf(darray-vol).*vol;      
    if max(max(abs(f./put))) < tol, break, end      %  two maxes needed for array 
    logvolnew = log(vol) - f./fp;
    volnew = exp(logvolnew);
    vol = volnew;
end  
disp('Convergence indicators for vols')
it 
maxerror = max(max(f))
maxrelerror = max(max(f./put))
vol = vol/sqrt(tau);

%disp('Strike and implied vols') 
%[bgrid vol]

%  4. Figures
disp(' ')
disp('Smile figures') 
disp(' ')

%  figure parameters 
FontSize = 14;
FontName = 'Helvetica';  % or 'Times' 
LineWidth = 2;

moneyness = bgrid-1;

figure(1) 
clf
plot(moneyness,vol(:,1),'LineWidth',LineWidth,'Color','k','LineStyle','-')
set(gca,'LineWidth',LineWidth,'FontSize',FontSize,'FontName',FontName)
hold on
axis([-0.06 0.06 0.17 0.23])  
plot(moneyness,vol(:,2),'LineWidth',LineWidth,'Color','b','LineStyle','--')
plot(moneyness,vol(:,3),'LineWidth',LineWidth,'Color','m','LineStyle','--')
xlabel('Moneyness = (s-k)/s','FontSize',FontSize,'FontName',FontName)
ylabel('Implied Volatility (annual)','FontSize',FontSize,'FontName',FontName)

%print -depsc options_identify.eps

return

