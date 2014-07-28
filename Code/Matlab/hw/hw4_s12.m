%  hw4_s12 
%  Matlab program for Lab Report #4, Spring 2012 
%  NYU course ECON-UB 233, Macro foundations for asset pricing, Mar 2012.  
%  Written by:  Dave Backus, March 2012 

disp('Answers to Lab Report 4') 

%% 
disp(' ')
disp('------------------------------------------------------------------')
disp('Question 1 (disaster risk)') 
format compact 
clear all 

syms s omega mu sigma delta 

disp(' ')
disp('Analytics for cumulants') 
mgf = omega*exp(s*(mu-delta)) + 0.5*(1-omega)*(exp(s*(mu+sigma))+exp(s*(mu-sigma)));
cgf = log(mgf);

disp(' ')
disp('Cumulants') 
kappa1 = subs(diff(cgf,s,1),s,0);    %  mean
kappa2 = subs(diff(cgf,s,2),s,0);    % variance 
kappa3 = subs(diff(cgf,s,3),s,0);
kappa4 = subs(diff(cgf,s,4),s,0);

kappa1 = simplify(kappa1)
kappa2 = simplify(kappa2)

gamma1 = simplify(kappa3/kappa2^(3/2))
gamma2 = simplify(kappa4/kappa2^2) 

disp(' ') 
disp('Asset prices and returns') 
clear all 

% consumption process 
omega = 0.01;
delta = 0.3;
mu = 0.0200 + omega*delta
sigma = sqrt(0.0350^2 - omega*(1-omega)*delta^2)

p = [(1-omega)/2; (1-omega)/2; omega]; 
logg = [mu + sigma; mu-sigma; mu-delta];
g = exp(logg);

% preferences
beta = 0.99; 
alpha = 20;

% asset prices 
m = beta*g.^(-alpha);
d = g;

q1 = sum(p.*m); 
r1 = 1/q1
logr1 = log(r1) 

qe = sum(p.*m.*d) 
Elogre = sum(p.*log(d)) - log(qe); 

eq_prem = Elogre - logr1

% entropy 
H = log(sum(p.*m)) - sum(p.*log(m))

return 

%%
disp(' ')
disp('------------------------------------------------------------------')
disp('Question 2') 
format compact 
clear all

% read spreadsheet with Fama-French returns
% dates monthly from 1926 07 to end of 2011 
% series:  Date1, MKTXS, SMB, HML, RF, Date2, DUMMY, LO30, MED40, HI30 

FF_returns = xlsread('FamaFrench_returns.xlsx');
[nobs,nvars] = size(FF_returns)

disp(' ')
disp('Extra stuff to make sure things are lined up with the right units')
disp('Mean of inputs (mktxs, rf, small, med, big)')
mean(FF_returns(:,[2 5 8:10])) 

rf = FF_returns(:,5);     
rfbig = FF_returns(:,[5 5 5 5]);     % expand to make subtraction easy 
returns = FF_returns(:,[2 8:10]);
returns(:,1) = returns(:,1) + rf;
xs_returns = returns - rfbig;

disp(' ')
disp('Moments of xs returns (mean, std, skew, kurt, sharpe)') 
disp('(mkt, rf, small, med, big)')
[mean(xs_returns); std(xs_returns); skewness(xs_returns); ...
    kurtosis(xs_returns) - 3;  mean(xs_returns)./std(xs_returns)]

disp(' ')
disp('Moments of log xs returns (mean, std, skew, kurt, sharpe)') 
disp('(mkt, rf, small, med, big)')

lxs_returns = log(1+returns/100) - log(1+rfbig/100);
lxs_returns = 100*lxs_returns;

[mean(lxs_returns); std(lxs_returns); skewness(lxs_returns); ...
    kurtosis(lxs_returns) - 3]

figure(1) 
clf 
plot(std(xs_returns),mean(xs_returns),'k*')
hold on 
plot(std(lxs_returns),mean(lxs_returns),'b*')
ylabel('Mean Excess Return') 
xlabel('Std Dev of Excess Return') 
text(0.45,8.5,'black is levels, blue is logs')

print -depsc hw4_q2c.eps

figure(2) 
clf 
plot(mean(xs_returns)./std(xs_returns),mean(xs_returns),'b*')
ylabel('Mean Excess Return') 
xlabel('Sharpe Ratio') 
text(0.45,8.5,'black is levels, blue is logs')

print -depsc hw4_q2d.eps

return
