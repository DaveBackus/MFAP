%  hw1_s13.m 
%  Matlab program for Lab Report #1, Spring 2013 
%  Written by:  Dave Backus, February 2013 
format compact 
clear all 

%%
disp(' ')
disp('Answers Lab Report #1') 
disp('*** I put pauses in the program.  If Matlab stops, hit return')

disp(' ')
disp('------------------------------------------------------------------')
disp('Question 1') 
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

pause

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

pause 

%%
disp(' ')
disp('------------------------------------------------------------------')
disp('Question 3') 
clear all 

% read data from spreadsheet:  INDPRO, PAYEMS, SP500
data = xlsread('FRED_hw1_13.xls','Data');

% year-on-year growth rates 
diffdata = log(data(13:end,:)) - log(data(1:end-12,:));

disp('Basic moments') 
disp('Variables:  IP, EMP, SP500') 
means = mean(diffdata)
stdev = std(diffdata)
skew = skewness(diffdata)
exkurt = kurtosis(diffdata) - 3
pause(1)

disp(' ')
disp('Correlations') 
corrcoef(diffdata)

% histogram to see skewness and kurtosis 
subplot(3,1,1), hist(diffdata(:,1))
subplot(3,1,2), hist(diffdata(:,2))
subplot(3,1,3), hist(diffdata(:,3))
pause(1)

return
