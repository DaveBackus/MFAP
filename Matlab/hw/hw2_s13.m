%  hw2_s13 
%  Matlab program for Lab Report #2, Spring 2013 
%  Written by:  Dave Backus, February 2013 
format compact 
clear all 

%%
disp('Answers to Lab Report 2') 

disp(' ')
disp('------------------------------------------------------------------')
clear 
disp('Question 2') 
syms s omega sigma theta delta 

cgf1 = s^2*sigma^2/2; 
mgf3 = 1-omega + omega*exp(s*theta+s^2*delta^2/2);
cgf3 = log(mgf3);

cgf = cgf1 + cgf3;

disp(' ')
disp('Cumulants') 
kappa1 = subs(diff(cgf,s,1),s,0)    %  mean
simplify(kappa1)
kappa2 = subs(diff(cgf,s,2),s,0)    % variance 
simplify(kappa2)
kappa3 = subs(diff(cgf,s,3),s,0)
simplify(kappa3)
kappa4 = subs(diff(cgf,s,4),s,0)
simplify(kappa4)

disp(' ')
gamma1 = kappa3/kappa2^(3/2)
simplify(gamma1)
gamma2 = kappa4/kappa2^2


%%
disp(' ')
disp('------------------------------------------------------------------')
disp('Question 3 (lognormal risks)') 
syms s kappa1 kappa2 alpha 

cgf_x = kappa1*s + kappa2*s^2/2 
cgf = cgf_x 

% cgf evaluated at s=1
log_cbar = subs(cgf,s,1)       
% cgf evaluated at s=1-alpha, then divided by (1-alpha) 
log_mu = subs(cgf,s,1-alpha)/(1-alpha)  

rp = log_cbar - log_mu 
rp = simplify(rp)

rp_alpha2  = subs(rp,[alpha,kappa2],[2,0.02^2])
rp_alpha10 = subs(rp,[alpha,kappa2],[10,0.02^2])
rp_alpha20 = subs(rp,[alpha,kappa2],[20,0.02^2])

return 
