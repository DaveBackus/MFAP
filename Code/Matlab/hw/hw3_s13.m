%  hw3_s13 
%  Matlab program for Lab Report #3, Spring 2013 
%  Written by:  Dave Backus, February 2013 
format compact 
clear all 

%disp(' ')
disp('Answers to Lab Report 3') 

%%
disp(' ')
disp('------------------------------------------------------------------')
clear 
disp('Question 1') 
syms s lambda alpha 

cgf_x = -log(1-s./lambda)
cgf = subs(cgf_x,s,-s)

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

% cgf evaluated at s=1
log_cbar = subs(cgf,s,1)       
% cgf evaluated at s=1-alpha, then divided by (1-alpha) 
log_mu = subs(cgf,s,1-alpha)/(1-alpha)  

rp = log_cbar - log_mu 
rp = simplify(rp)

rp_alpha2  = subs(rp,[alpha,lambda],[2,1/0.02])
rp_alpha10 = subs(rp,[alpha,lambda],[10,1/0.02])
rp_alpha20 = subs(rp,[alpha,lambda],[20,1/0.02])


%%
disp(' ')
disp('------------------------------------------------------------------')
disp('Question 3') 
disp('Portfolio choice:  2-state case')
disp(' ')
% set parameters 
beta = 1/1.1;
r1 = 1.1; 
re_1 = 1.0;
re_2 = 1.4; 
y0 = 1;

% Arrow securities 
disp('Prices and returns of Arrow securities') 
Q = inv([1 1; 1 1.4])*[1/r1; 1]
rA = 1./Q

% approximate portfolio weight a: find value that sets foc closest to zero
agrid = [0.1:0.001:2];

disp(' ')
disp('Portfolio weight a') 
alpha = 2;
foc2 = 0.5*((1-agrid)*r1+agrid*re_1).^(-alpha).*(re_1-r1) + ...
        0.5*((1-agrid)*r1+agrid*re_2).^(-alpha).*(re_2-r1);
[focmin,i] = min(abs(foc2));
a2 = agrid(i)

alpha = 5;
foc5 = 0.5*((1-agrid)*r1+agrid*re_1).^(-alpha).*(re_1-r1) + ...
        0.5*((1-agrid)*r1+agrid*re_2).^(-alpha).*(re_2-r1);
axis = 0*agrid;
[focmin,i] = min(abs(foc5));
a5 = agrid(i)

% Digression on Merton's formula  
% See:  http://en.wikipedia.org/wiki/Merton's_portfolio_problem
disp('Compare Merton share') 
% next few lines aren't needed
E_rx = 0.5*(re_1+re_2) - r1 
var_re = 0.2^2
E_logre = 0.5*(log(re_1)+log(re_2)) 
E_logrx = 0.5*(log(re_1)+log(re_2)) - log(r1)
var_logre = 0.5*(log(re_1)-E_logre)^2 + 0.5*(log(re_2)-E_logre)^2
E_rx_approx = E_logrx + var_logre/2

amerton5 = (0.1+var_re/2)/(alpha*var_re)
amerton2 = (0.1+var_re/2)/(2*var_re)
ratio2 = amerton2/a2
ratio5 = amerton5/a5
% end of digression 

plot(agrid,foc2,'b')    
hold on
plot(agrid,foc5,'m')    
plot(agrid,axis,'k')    
ylabel('First-order condition') 
xlabel('Portfolio weight a') 
title('Blue is \alpha=2, Magenta is \alpha=5')

disp(' ')
disp('Consumption quantities') 
alpha = 5; a = a5;          % change as needed 
S = 0.5*((1-a)*r1+a*re_1)^(1-alpha) + 0.5*((1-a)*r1+a*re_2)^(1-alpha)
SBA = (S*beta)^(-1/alpha)

c0 = y0/(1+SBA)
saving = y0 - c0

c1_1 = saving*((1-a)*r1+a*re_1)
c1_2 = saving*((1-a)*r1+a*re_2)

return
