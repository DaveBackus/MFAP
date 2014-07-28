%  quiz2_s13 
%  Matlab program for Quiz #2, Spring 2013 
%  Written by:  Dave Backus 
format compact 
clear all 

disp('Answers to Question 1 of Quiz #2') 
disp('--------------------------------------------------------------')

omega = 0.5
beta = 0.98 
alpha = 5

%z = [-1; 1];
p = [1-omega; omega];
g = [1; 1.1];

disp(' ')
disp('(a)')
logg = log(g);
Elogg = sum(p.*logg)
Stdlogg = sqrt(sum(p.*logg.^2) - Elogg^2)

disp(' ')
disp('(b)')
m = beta./g.^alpha 
Q = p.*m

disp(' ')
disp('(c)')
q1 = sum(p.*m)
r1 = 1/q1 

disp(' ')
disp('(d)')
ps = p.*m/q1
ps = Q/q1 

return 