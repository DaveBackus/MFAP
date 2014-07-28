%  markov_chain.m 
%  Calculations of conditional distributions from finite-state Markov chain
%  with transition matrix P 
%  NYU course ECON-UB 233, Macro foundations for asset pricing.  
%  Written by:  Dave Backus, March 2012 and after 
%%
format compact 
clear all
close all

disp(' ') 
disp('Markov chains') 
disp('---------------------------------------------------------------')
disp(' ') 

P = [0.8 0.2; 0.3 0.7]; 
P = [0.95 0.025 0.025; 0 1 0 ; 0 0 1];

maxit = 20;
Pn = P

for it=1:maxit 
    Pn = Pn*P;
    disp(' ')
    it 
    Pn 
    pause 
end    

return 