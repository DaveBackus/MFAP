% hw2_f14.m 
% Matlab program for Lab Report #2 
% For the course, "Macroeconomic Foundations for Asset Prices," NYU Stern.
% Written by:  Dave Backus @ NYU
format compact 
clear all 

%%
disp(' ')
disp('Answers to Lab Report #2') 

%%
disp(' ')
disp('------------------------------------------------------------------')
disp('Question 1') 
clear all 

% I did this in Python, reading the data straight in without the xls step 
% https://www.wakari.io/sharing/bundle/DaveBackus/Bootcamp_1_Examples
% See example 2 


%%
disp(' ')
disp('------------------------------------------------------------------')
disp('Question 2') 
syms omega theta s

% Sums should be obvious

disp(' ')
disp('Mixture') 
mgf = (1-omega)*exp(s^2/2)+omega*exp(theta*s+s^2/2)
cgf = log(mgf);

kappa1 = subs(diff(mgf,s,1),s,0);
kappa1 = simplify(kappa1)
kappa2 = subs(diff(cgf,s,2),s,0);
kappa2 = simplify(kappa2)
kappa3 = subs(diff(cgf,s,3),s,0);
kappa3 = simplify(kappa3)
kappa4 = subs(diff(cgf,s,4),s,0);
kappa4 = factor(kappa4) 
gamma1 = (kappa3)/(kappa2)^(3/2)
gamma1 = simplify(gamma1)
gamma2 = (kappa4)/(kappa2)^2
gamma2 = simplify(gamma2)

%%
disp(' ')
disp('------------------------------------------------------------------')
disp('Question 3') 

x = [100; 200];
p = [0.5; 0.5] 
Ex = sum(p.*x)

disp(' ') 
disp('(a)')
Efx = sum(p.*log(x))
fEx = log(Ex)

disp(' ') 
disp('(b)')
Efx = sum(p.*exp(x))
fEx = exp(Ex)

disp(' ') 
disp('(c)')
Efx = sum(p.*x.^2)
fEx = Ex^2

disp(' ') 
disp('(d)')
Efx = sum(p.*x.^2)
fEx = Ex^2



return
