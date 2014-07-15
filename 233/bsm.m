%  bsm.m 
%  Various calculations using the Black-Scholes-Merton formula. 
%  Notation is nonstandard:
%       underlying:     q (often s)
%       strike:         b (often k)
%       bond price:     b_tau (often exp(-tau*r))
%  NYU course ECON-UB 233, Macro foundations for asset pricing, Mar 2012.  
%  Written by:  Dave Backus, March 2012 
format compact
format short 
clear all

%%
disp(' ')
disp('1. BSM calculations') 
disp('---------------------------------------------------------------')

% inputs 
yield = 0.02
tau = 1/24 
q_tau = exp(-tau*yield)
q = 1385.75 
b = [1385; 1390]
sigma = [0.1477; 0.1440] 

% define price as function of sigma 
d = @(b) (log(q./(q_tau.*b))+tau*sigma.^2/2)./(sqrt(tau)*sigma);
call = @(sigma) q*normcdf(d(b)) - q_tau.*b.*normcdf(d(b)-sqrt(tau)*sigma);

disp(' ')
q_call = call(sigma)

return 

%%
disp(' ')
disp('2. Call price v volatility') 
disp('---------------------------------------------------------------')
clear all

% inputs 
yield = 0.01
tau = 0.25
q_tau = exp(-tau*yield) 
q = 1388
b = q_tau*q     % roughly at the money 

% define price as function of sigma 
d2 = @(sigma) (log(q./(q_tau.*b))+tau*sigma.^2)./(sqrt(tau)*sigma);
call2 = @(sigma) q*normcdf(d2(sigma)) - q_tau.*b.*normcdf(d2(sigma)-sqrt(tau)*sigma);

sigma = [0.0001:0.01:0.50]';
q_call = call2(sigma);

plot(sigma,q_call,'LineWidth',2)
xlabel('Volatility') 
ylabel('Call price') 

return 