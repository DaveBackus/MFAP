%  hw3_s12 
%  Matlab program for Lab Report #3, Spring 2012 
%  Written by:  Dave Backus, February 2012 
format compact 
clear all 

%disp(' ')
disp('Answers to Lab Report 3') 

disp(' ')
disp('------------------------------------------------------------------')
disp('Question 2 (downside derivative)') 
syms z kappa1 kappa2 alpha 
kappa2=1

logm = -alpha*z
logy = z
logp = -(z-kappa1)^2/(2*kappa2)

logmyp = logm + logy + logp 

guess = -(z-(kappa1+(1-alpha)*kappa2))^2/(2*kappa2) + ((1-alpha)*kappa1+(1-alpha)^2*kappa2/2) 

zero = simplify(logmyp - guess)




return
