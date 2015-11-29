% Stochastic processes 
% NYU course ECON-UB 233, Macro foundations for asset pricing.  
% Written by:  Dave Backus  
format compact 
clear all 

%%
disp(' ')
disp('Hairer example') 

syms phi pi 

p  = [(1+phi)/2; (1-phi)/2];
x0 = [pi; 1-pi];

x1 = sum(p.*x0) 
simplify(x1)

x2 = sum(p.*[x1; 1-x1]) 
simplify(x2)
