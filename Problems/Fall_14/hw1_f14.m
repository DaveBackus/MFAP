% Matlab program for Lab Report #1 
% For the course, "Macroeconomic Foundations for Asset Prices," NYU Stern.
% Written by:  Dave Backus @ NYU
format compact 
clear all 

%%
disp(' ')
disp('Answers to Lab Report #1') 

disp(' ')
disp('------------------------------------------------------------------')
disp('Question 1') 
syms s x

% Finding the mgf by integration doesn't quite work, not sure why  
pdf = exp(-x^2/2)/sqrt(2*pi)
mgf = int(exp(s*x)*pdf, [-Inf, Inf]) 

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
disp('Moments of simulated data')
disp('Compare our calculations to Matlab functions')
disp(' ')
clear all 

% set parameters 
mu = 0;
sigma = 1;
nobs = 1000;

x = normrnd(mu,sigma,nobs,1); 
histc(x, 20)                    % histogram with 20 bins 

disp('(a)') 
xbar = mean(x)
moments = mean([x (x-xbar).^2 (x-xbar).^3 (x-xbar).^4])

disp(' ') 
disp('(b)')
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
syms  omega s 

mgf = (1-omega)/(1-omega*exp(s))
cgf = log(mgf)

disp(' ')
kappa1 = subs(diff(cgf,s,1),s,0)    %  mean
kappa2 = subs(diff(cgf,s,2),s,0)    % variance 
kappa2 = factor(kappa2) 
kappa3 = subs(diff(cgf,s,3),s,0)
kappa3 = factor(kappa3)  
kappa4 = subs(diff(cgf,s,4),s,0)
kappa4 = factor(kappa4)

disp(' ')
gamma1 = kappa3/kappa2^(3/2)
simplify(gamma1) 
gamma2 = kappa4/kappa2^2

return 