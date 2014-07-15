%  hw8_s13.m 
%  Matlab program for Quiz #3, Spring 2013 
%  NYU course ECON-UB 233, Macrofoundations for asset pricing.  
%  Written by:  Dave Backus 
format compact
format short 
clear all

%%disp(' ')
disp('------------------------------------------------------------')
disp('Answers to Quiz 3') 
disp('Question 2 (equity valuation)') 

syms alpha beta gamma lambda sigma x

logq1 = -x;
logr1 = x;

logqe = alpha - (beta - (1+lambda^2/2) + (gamma+lambda)^2/2)*x 
logqe = simplify(logqe)
Elogre = alpha + beta*x - logqe 

Elogx = Elogre - logr1 
Elogx = simplify(Elogx)
