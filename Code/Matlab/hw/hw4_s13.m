%  hw4_s12 
%  Matlab program for Lab Report #4, Spring 2012 
%  NYU course ECON-UB 233, Macro foundations for asset pricing, Mar 2012.  
%  Written by:  Dave Backus, March 2012 

disp('Answers to Lab Report 4') 

%% 
disp(' ')
disp('------------------------------------------------------------------')
disp('Question 1 (three-state example)') 
format compact 
clear all 

syms s omega mu delta 

disp(' ')
disp('Analytics for cumulants') 
mgf = omega*exp(s*(mu-delta)) + (1-2*omega)*exp(s*mu) + omega*exp(s*(mu+delta));
cgf = log(mgf);

disp(' ')
disp('Cumulants') 
kappa1 = subs(diff(cgf,s,1),s,0);    %  mean
kappa2 = subs(diff(cgf,s,2),s,0);    % variance 
kappa3 = subs(diff(cgf,s,3),s,0);
kappa4 = subs(diff(cgf,s,4),s,0);

kappa1 = simplify(kappa1)
kappa2 = simplify(kappa2)
kappa3 = simplify(kappa3)
kappa4 = simplify(kappa4)

gamma1 = simplify(kappa3/kappa2^(3/2))
gamma2 = simplify(kappa4/kappa2^2) 

% pricing kernel, state prices, and risk-neutral probs 
syms beta alpha 
p = [omega; 1-2*omega; omega];
z = [-1; 0; 1];
x = mu + delta*z

m = beta*exp(-alpha*x)
Q = p.*m
q1 = sum(Q)
pstar = Q/q1

% this is ugly, mu should drop out
pstar = simplify(pstar)


%% 
disp(' ')
disp('------------------------------------------------------------------')
disp('Question 2 (continued)') 

% enter numbers 
omeganum = 1/20
p = subs(p, omega, omeganum)
gamma2 = 1/(2*omeganum) - 3

munum = 0.02
deltanum = 0.035/sqrt(2*omeganum)

% asset pricing
alpha = 10;
beta = 0.99

x = munum + deltanum*z
m = beta*exp(-alpha*x)

q1 = sum(p.*m)
r1 = 1/q1

d = exp(x);
qe = sum(p.*m.*d)
re = d/qe
Ere = sum(p.*re)

eqprem = Ere - r1 


% in logs 
logr1 = log(r1) 

qe = sum(p.*m.*d) 
Elogre = sum(p.*log(d)) - log(qe); 

eq_prem = Elogre - logr1

return 

