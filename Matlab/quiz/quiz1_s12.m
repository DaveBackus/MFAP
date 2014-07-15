%  quiz1_s12 
%  Matlab program for Quiz #1, Spring 2012 
%  Written by:  Dave Backus, February 2012 
format compact 
clear all 

%disp(' ')
disp('Answers to Quiz #1') 


disp(' ')
disp('------------------------------------------------------------------')
disp('Question 1 ("trinomial")') 
syms s omega delta 

mgf = omega*(exp(-delta*s) + exp(delta*s)) + (1-2*omega)
cgf = log(mgf) 

disp(' ')
disp('Cumulants') 
kappa1 = subs(diff(cgf,s,1),s,0)    %  mean
kappa2 = subs(diff(cgf,s,2),s,0)    % variance 
kappa3 = subs(diff(cgf,s,3),s,0)
kappa4 = subs(diff(cgf,s,4),s,0)

disp(' ')
gamma1 = kappa3/kappa2^(3/2)
simplify(gamma1)
gamma2 = kappa4/kappa2^2
simplify(gamma2)

disp(' ')
disp('------------------------------------------------------------------')
disp('Question 2 ("trinomial" continued)') 
syms beta alpha p x m real 

p = [omega, 1-2*omega, omega] 
x = [-delta, 0, delta] 
m = beta*[exp(-alpha*x)]
q1 = p*m'
pstar = p.*m/q1
simplify(pstar)

return 

