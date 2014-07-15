%  hw8_s13.m 
%  Matlab program for Lab Report #8, Spring 2013 
%  NYU course ECON-UB 233, Macro foundations for asset pricing.  
%  Written by:  Dave Backus 
disp('Answers to Lab Report 8') 
format compact
format short 
clear all

%%
disp(' ')
disp('------------------------------------------------------------')
disp('Question 1 (bond basics)') 

f = [0.05; 0.06; 0.07; 0.07; 0.07]
imat = [1:length(f)]'
q = exp(-cumsum(f))
y = cumsum(f)./imat

%%
disp(' ')
disp('------------------------------------------------------------')
disp('Question 2 (equity valuation)') 

syms alpha beta lambda0 lambda1 lambdat sigma x

logq1 = -x;
logr1 = x;

logqe = alpha - x + beta^2/2 + lambdat*beta
Elogre = alpha - logqe 

Elogx = Elogre - logr1 
