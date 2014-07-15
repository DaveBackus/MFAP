%  notes_2period.m 
%  Matlab program for asset pricing example in 2-period notes, Spring 2012 
%  Written by:  Dave Backus, February 2012 
format compact 
clear all 

%disp(' ')
disp('------------------------------------------------------------------')
disp('Lognormal example') 
syms s kappa1 kappa2 alpha beta lambda 

q1 = beta*exp(-alpha*kappa1 + alpha^2*kappa2/2)
r1 = 1/q1 

qe = beta*exp(-alpha*kappa1 + alpha^2*kappa2/2)

C = datastream('XNYU901','PICKLE','Datastream',...
               'http://dataworks.thomson.com/Dataworks/Enterprise/1.0')

return
