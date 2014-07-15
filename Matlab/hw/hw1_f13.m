%  hw1_f13.m 
%  Matlab program for Lab Report #1, Fall 2013 
%  Written by:  Dave Backus, September 2013 
format compact 
clear all 

%%
disp(' ')
disp('Answers Lab Report #1') 

disp(' ')
disp('------------------------------------------------------------------')
disp('Question 1') 
syms s 

mgf = exp(s^2/2); 

disp('raw moments')
% differentiate moment generating function 
mu1p = subs(diff(mgf,s,1),s,0)       % mean
mu2p = subs(diff(mgf,s,2),s,0)       % second moment (why not variance?) 
mu3p = subs(diff(mgf,s,3),s,0)
mu4p = subs(diff(mgf,s,4),s,0)


%%
disp(' ')
disp('------------------------------------------------------------------')
disp('Question 2') 
disp('Moments of simulated normal data')
disp('Compare our calculations to Matlab functions')
disp(' ')
clear all 

% set parameters 
mu = 0;
sigma = 1;
nobs = 1000;

x = normrnd(mu,sigma,nobs,1); 

xbar = mean(x)
moments = mean([x (x-xbar).^2 (x-xbar).^3 (x-xbar).^4])

disp(' ')
var_x = var(x)
compare = moments(2) 

disp(' ') 
std_x = std(x)
compare = sqrt(moments(2))

disp(' ') 
skw_x = skewness(x)
compare = moments(3)/moments(2)^(3/2) 

disp(' ') 
krt_x = kurtosis(x)
compare = moments(4)/moments(2)^2 


%%
disp(' ')
disp('------------------------------------------------------------------')
disp('Question 3') 
syms p delta omega s 

mgf = 1-omega+omega*exp(s*delta)
cgf = log(mgf)

disp(' ')
kappa1 = subs(diff(cgf,s,1),s,0)    %  mean
kappa2 = subs(diff(cgf,s,2),s,0)    % variance 
kappa3 = subs(diff(cgf,s,3),s,0)
factor(kappa3)  % sometimes this cleans up the expression; see also simplify
kappa4 = subs(diff(cgf,s,4),s,0)
factor(kappa4)

disp(' ')
gamma1 = kappa3/kappa2^(3/2)
gamma2 = kappa4/kappa2^2


%%
disp(' ')
disp('------------------------------------------------------------------')
disp('Question 4') 
syms alpha beta lambda s 

cgf = -alpha*log(1-s/beta)

disp(' ')
kappa1 = subs(diff(cgf,s,1),s,0)    %  mean
kappa2 = subs(diff(cgf,s,2),s,0)    % variance 
kappa3 = subs(diff(cgf,s,3),s,0)
kappa4 = subs(diff(cgf,s,4),s,0)

disp(' ')
gamma1 = kappa3/kappa2^(3/2)
gamma2 = kappa4/kappa2^2
