%  notes_risk.m
%  notes_math_rvs 
%  Calculations to accompany notes on risk and risk aversion 
%  For:  "Macro-foundations for asset prices"
%  Written by:  Dave Backus, NYU, August 2013 and after 
clear all 
format compact

%%
disp('Find your risk aversion') 
c = [100; 200];
p = [1/2; 1/2]; 
cbar = sum(p.*c)

alpha = 1.5;
mu = sum(p.*c.^(1-alpha)).^(1/(1-alpha)) 

%plot(alphagrid, rp)

%%
disp('Find your risk aversion -- upside risk version') 
% inputs 
c = [100; 200; 1000];
omega = 0.495;
p = [omega; omega; 1-2*omega]; 

% calculations 
cbar = sum(p.*c)
alpha = 5;
mu = sum(p.*c.^(1-alpha))^(1/(1-alpha)) 

rp = log(cbar/mu) 

% variance term of cumulant expansion 
kappa1 = sum(p.*log(c))
kappa2 = sum(p.*(log(c)-kappa1).^2)
varianceterm = alpha*kappa2/2 


%%
disp('Exponential utility') 
syms s alpha delta omega lambda 

mgf = exp(omega*(exp(s*delta)-1))       % Poisson 

cbar = subs(diff(mgf,s,1),s,0) 

%%
% playing 

alpha = 0.5;
c = [0.1:0.1:5];

u = c.^(1-alpha)/(1-alpha);

plot(c,u)






