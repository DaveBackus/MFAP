%  hw2_f14.m 
%  Matlab program for Lab Report #2  
%  Written by:  Dave Backus @ NYU
format compact 
clear all 

%%
disp(' ')
disp('Answers to Lab Report #2') 

disp(' ')
disp('------------------------------------------------------------------')
disp('Question 2') 
syms omega theta s

mgf = (1-omega)*exp(s^2/2)+omega*exp(theta*s+s^2/2)
cgf = log(mgf);

kappa1 = subs(diff(mgf,s,1),s,0)
kappa2 = subs(diff(cgf,s,2),s,0)
kappa3 = subs(diff(cgf,s,3),s,0);
kappa3 = simplify(kappa3)
kappa4 = subs(diff(cgf,s,4),s,0);
kappa4 = simplify(kappa4) 

gamma1 = (kappa3)/(kappa2)^(3/2);
gamma1 = simplify(gamma1) 
gamma2 = (kappa4)/(kappa2)^2;
gamma2 = simplify(gamma2) 

%check_gamma2 = subs(gamma2, [omega delta], [0.05 4.05])

%%
disp(' ')
disp('------------------------------------------------------------------')
disp('Question 3') 
clear all 

% read data from spreadsheet:  INDPRO, PAYEMS, SP500
data = xlsread('FRED_hw1.xls');

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

%%
disp(' ')
disp('------------------------------------------------------------------')
disp('Question 4') 
syms omega beta delta s

disp(' ')
disp('Generating functions and cumulants') 
mgf = (1-omega)*exp(beta*s)+omega*exp((beta+delta)*s)
cgf = log(mgf);

kappa1 = subs(diff(mgf,s,1),s,0);
simplify(kappa1)
kappa2 = subs(diff(cgf,s,2),s,0);
simplify(kappa2)
kappa3 = subs(diff(cgf,s,3),s,0);
simplify(kappa3)
kappa4 = subs(diff(cgf,s,4),s,0);
simplify(kappa4) 

gamma1 = (kappa3)/(kappa2)^(3/2)
gamma2 = (kappa4)/(kappa2)^2

disp(' ')
disp('Consumption and utility') 
cbar = subs(mgf,s,1)
alpha = 5 
Eu = subs(mgf,s,1-alpha)


disp(' ') 
disp('Numerical values (note names differ so we can tell them apart)') 
% inputs 
std_logc = 0.25 
mean_logc = 1.0 

omega_num = 0.75;
delta_num = std_logc/sqrt(omega_num*(1-omega_num))
beta_num = mean_logc - delta_num*omega_num 

cbar_num = subs(cbar, [beta delta omega], [beta_num delta_num omega_num]) 
Eu_num = subs(Eu, [beta delta omega], [beta_num delta_num omega_num]) 
mu = Eu_num^(1/(1-alpha))
rp = log(cbar_num/mu) 



return
