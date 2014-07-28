%  hw1_s12 
%  Matlab program for Lab Report #1, Spring 2012 
%  Written by:  Dave Backus, January 2012 
format compact 
clear all 

disp(' ')
disp('Answers Lab Report 1') 
disp('*** I put pauses in the program.  If Matlab stops, hit return')

%%{
disp(' ')
disp('------------------------------------------------------------------')
disp('Question 1') 
syms p delta omega s 

mgf = 1-p+p*exp(s*delta)
cgf = log(mgf)

disp(' ')
kappa1 = subs(diff(cgf,s,1),s,0)    %  mean
kappa2 = subs(diff(cgf,s,2),s,0)    % variance 
kappa3 = subs(diff(cgf,s,3),s,0)
factor(kappa3)
kappa4 = subs(diff(cgf,s,4),s,0)
factor(kappa4)

disp(' ')
gamma1 = kappa3/kappa2^(3/2)
%simplify(gamma1)
gamma2 = kappa4/kappa2^2

pause 
%%}

disp(' ')
disp('------------------------------------------------------------------')
disp('Question 2') 
disp('Moments of simulated normal data')
disp('Ccompare our calculations to Matlab functions')
disp(' ')
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

disp(' ')
disp('------------------------------------------------------------------')
disp('Question 3') 

%{
% This reads data directly from FRED.  I got stuck converting SP500 from 
% daily to monthly.  Also need to align series.  Help welcome.  
[data_ip,desc_ip]=getFredData('INDPRO');
desc_ip
[data_emp,desc_emp]=getFredData('PAYEMS');
desc_emp
[data_con,desc_con]=getFredData('PCEPI');
desc_con
[data_sp500,desc_sp500]=getFredData('SP500');
desc_sp500
%}

% read data from spreadsheet:  INDPRO, PAYEMS, PCEPI, SP500
data = xlsread('FRED_hw1.xls','Monthly');
%data(1:10,:)

% year-on-year growth rates 
diffdata = log(data(13:end,:)) - log(data(1:end-12,:));

disp('Basic moments') 
disp('Variables:  IP, EMP, CON, SP500') 
means = mean(diffdata)
stdev = std(diffdata)
skew = skewness(diffdata)
exkurt = kurtosis(diffdata) - 3
pause 

% histogram to see skewness and kurtosis 
hist(diffdata(:,4))
pause 

disp(' ')
disp('Correlations') 
corrcoef(diffdata)

return
