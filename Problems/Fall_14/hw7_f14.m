% Matlab program for Lab Report #7, Fall 2014 
% NYU course ECON-UB 233, Macro foundations for asset pricing.  
% Written by:  Dave Backus 
disp('Answers to Lab Report 7') 
format compact
format short 
clear all

%%
disp(' ')
disp('------------------------------------------------------------')
disp('Question 3 (bond basics)') 

q = [1; 0.98; 0.96; 0.94; 0.92; 0.90];
f = - log(q(2:end)./q(1:end-1))
imat = [1:length(f)]';
y = cumsum(f)./imat
yalt = -log(q(2:end))./imat

return 