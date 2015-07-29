%  hw3_f13.m 
%  Matlab program for Lab Report #4 
%  Written by:  Dave Backus, October 2014 
format compact 
clear all 

%%
disp(' ')
disp('Answers to Lab Report #4') 

disp(' ')
disp('------------------------------------------------------------------')
disp('Question 1') 

disp(' ')
disp('Inputs') 

Q = [1/2; 1/3; 1/4];
p = [1/3; 1/3; 1/3];

disp(' ')
disp('(a,b,c)')
m = Q./p 

q1 = sum(p.*m)
r1 = 1/q1

pstar = p.*m/q1

disp(' ')
disp('(d,e,f)')

d = [1; 2; 3];
qe = sum(p.*m.*d)

re = d./qe
Ere = sum(p.*re)
rp = Ere - r1 
