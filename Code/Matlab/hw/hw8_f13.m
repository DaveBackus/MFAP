%  hw8_s13.m 
%  Matlab program for Lab Report #8, Fall 2013 
%  NYU course ECON-UB 233, Macro foundations for asset pricing.  
%  Written by:  Dave Backus 
disp('Answers to Lab Report 8') 
format compact
format short 
clear all

%%
disp(' ')
disp('------------------------------------------------------------')
disp('Question 2 (bond basics)') 

f = [0.03; 0.04; 0.045; 0.05; 0.05]
imat = [1:length(f)]'
q = exp(-cumsum(f))
y = cumsum(f)./imat

return 