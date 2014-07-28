%  quiz2_s12 
%  Matlab program for Quiz #2, Spring 2012 
%  Written by:  Dave Backus, April 2012  
format compact 
clear all 

disp('Answers to Quiz #1') 

disp(' ')
disp('--------------------------------------------------------------')
disp('Question 1 (Sharpe ratios)') 

omega = 0.3
p = [1-omega; omega]
beta = 0.98 
alpha = 5
g = [1; 1.1];

disp('(a)')
m = beta./g.^alpha 
q = p.*m

disp(' ')
disp('(b)')
q1 = sum(p.*m)
r1 = 1/q1 

disp(' ')
disp('(c)')
qe = sum(p.*m.*g)
re = g/qe

Mean_re = sum(p.*re)
Std_re = sqrt(sum(p.*re.^2) - Mean_re^2) 

Sharpe_ratio = (Mean_re - r1)/Std_re

disp(' ')
disp('(d)')
Mean_m = sum(p.*m)
Std_m = sqrt(sum(p.*m.^2) - Mean_m^2) 

Max_Sharpe_ratio = Std_m/Mean_m

return 

