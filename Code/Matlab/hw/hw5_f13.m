%  hw5_f13.m 
%  Matlab program for Lab Report #5, Fall 2013 
%  NYU course ECON-UB 233, Macro foundations for asset pricing.  
%  Written by:  Dave Backus, October 2013 

disp('Answers to Lab Report 5') 

%% 
disp(' ')
disp('------------------------------------------------------------------')
disp('Question 1 (disaster risk)') 
format compact 
clear all 

syms s omega mu sigma delta 

disp(' ')
disp('Analytics for cumulants') 
mgf = omega*exp(s*(mu-delta)) + 0.5*(1-omega)*(exp(s*(mu-sigma))+exp(s*(mu+sigma)));
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

% consumption process (adjust as needed) 
omega = 0.01;
delta = -0.3;
mu = 0.0200 + omega*delta
sigma = sqrt(0.0350^2 - omega*(1-omega)*delta^2)

p = [(1-omega)/2; (1-omega)/2; omega]; 
logg = [mu + sigma; mu-sigma; mu-delta];
g = exp(logg);

% preferences
beta = 0.99; 
alpha = 10;

% asset prices 
m = beta*g.^(-alpha);
d = g;

q1 = sum(p.*m); 
r1 = 1/q1
logr1 = log(r1) 

qe = sum(p.*m.*d) 
re = d./qe;
Elogre = sum(p.*log(d)) - log(qe) 
check = sum(p.*log(re))

eq_prem = Elogre - logr1

% entropy 
H = log(sum(p.*m)) - sum(p.*log(m))


%%
disp(' ')
disp('------------------------------------------------------------------')
disp('Question 3 (gamma risk)') 
format compact 
clear all

% cgf of x
syms s lambda theta 

disp(' ') 
disp('properties of x') 
cgf = -theta*log(1-s/lambda)

disp(' ')
kappa1 = subs(diff(cgf,s,1),s,0)    %  mean
kappa2 = subs(diff(cgf,s,2),s,0)    % variance 
kappa3 = subs(diff(cgf,s,3),s,0)
kappa4 = subs(diff(cgf,s,4),s,0)

disp(' ')
gamma1 = kappa3/kappa2^(3/2)
gamma2 = kappa4/kappa2^2

disp(' ')
disp('properties of log m') 
syms mu alpha beta 
mu = 0;     % we don't need this one
beta = 1;   % ditto 
% note repurposing of cgf function 
cgf = (log(beta) + alpha*mu)*s + subs(cgf, s, s*alpha)

disp(' ')
kappa1 = subs(diff(cgf,s,1),s,0)    %  mean
kappa2 = subs(diff(cgf,s,2),s,0)    % variance 
kappa3 = subs(diff(cgf,s,3),s,0)
kappa4 = subs(diff(cgf,s,4),s,0)

disp(' ')
gamma1 = kappa3/kappa2^(3/2)
gamma2 = kappa4/kappa2^2

disp(' ')
disp('parameter values')
alpha_num = 10
theta_num = 2      % change as needed 
lambda_num = sqrt(theta_num)/0.0350 

disp(' ')
disp('entropy')
H = subs(cgf-kappa1, [s alpha theta lambda], [1 alpha_num theta_num lambda_num])
H_lognormal = alpha_num^2*0.0350^2/2 

disp(' ')
skewness_term = alpha_num^3*2*theta_num/(lambda_num^3*6)
kurtosis_term = alpha_num^4*6*theta_num/(lambda_num^4*24)

return
