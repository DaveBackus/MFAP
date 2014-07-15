% -------------------------------------------------------------------------
%  notes_risk_neutral_probs.m
%  Take arbitrary distribution over a state space and compute 
%  pricing kernel and risk neutral probabilities for power utility.  
%  Notation:  c^(1-alpha)/(1-alpha)
%  Written by:  Dave Backus
% -------------------------------------------------------------------------
format compact 
format short 
clear all 
clf
disp(' ') 
disp('------------------------------------------------------------------')
disp('Pricing kernel and risk-neutral probs with power utility')
disp('------------------------------------------------------------------')
disp(' ')

% disp(' ')
disp('1. Basic inputs') 

% define probs over arbitrary state grid 
zmax = 4; dz = 0.1; 
z = [-zmax:dz:zmax]';
%nz = length(z);
% skewness and (excess) kurtosis
gamma1 = -1 
gamma2 = 0.0     
% Gram-Charlier distribution (normal if gamma1 = gamma2 = 0) 
p = exp(-z.^2/2).*(1 + gamma1*(z.^3-3*z)/6 + gamma2*(z.^4-6*z.^2+3)/24);       
checkprobssum2one = sum(p)*dz/sqrt(2*pi)
p = p/sum(p);

% rep agent parameters 
alpha = 10
beta = 0.99 
lambda = 1

%{
% Bernoulli (an alternative, comment out if not needed)
z = [-1; 1];
p = [0.5; 0.5];  
%}

% logg is a linear function of z 
mug = 0.02  
sigmag = 0.035 
logg = mug + sigmag*z;                      
g = exp(logg);

disp(' ')
disp('Properties of log g (check to see if we replicate inputs)') 
disp('mean, std, gamma1, gamma2') 
kappa1 = p'*logg;
dev = logg - kappa1;
kappa2 = p'*dev.^2;
kappa3 = p'*dev.^3;
kappa4 = p'*dev.^4;
[kappa1 sqrt(kappa2) kappa3/kappa2^1.5 kappa4/kappa2^2-3]

%%
% pricing kernel
m = beta*g.^(-alpha);

% entropy 
disp(' ')
disp('Moments of log m (mean, std, gamma1, gamma2)') 
logm = log(m);
kappa1 = p'*logm;
dev = logm - kappa1;
kappa2 = p'*dev.^2;
kappa3 = p'*dev.^3;
kappa4 = p'*dev.^4;
[kappa1 sqrt(kappa2) kappa3/kappa2^1.5 kappa4/kappa2^2-3]
Elogm = kappa1;
logEm = log(p'*m);
Lm = logEm - Elogm
Lm_lognormal = kappa2/2

% p*
q1 = p'*m
pstar = p.*m/q1;
checkonepstar = sum(pstar)
% equity 
qe = sum(p.*m.*g)

% Figures 
FontSize = 12;
FontName = 'Helvetica';  % or 'Times' 
LineWidth = 1.5;

figure(1) 
bar(z, [p pstar])
line([0 0], [-0.005 0.045])
title('True (blue) and Risk-Neutral (red) Probabilities','FontSize',FontSize,'FontName',FontName) 
xlabel('State z','FontSize',FontSize,'FontName',FontName)
ylabel('Probability density function','FontSize',FontSize,'FontName',FontName)

%%
syms s alpha lambda

k = - log(1-s/lambda)
kstar = subs(k,s,s-alpha) - subs(k,s,-alpha)

