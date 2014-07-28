%  quiz2_f13 
%  Matlab program for Quiz #2, Fall 2013 
%  Written by:  Dave Backus 
format compact 
clear all 

disp('Quiz #2, Fall 2013') 
disp('Question 1') 
disp('--------------------------------------------------------------')

Q = [1/3 2/3];
p = [1/4 3/4];
m = Q./p

Em = sum(p.*m)
Varm = sum(p.*m.^2) - Em^2 
Stdm = sqrt(Varm)


%%
disp('Question 2') 
disp('--------------------------------------------------------------')
% http://www.mathworks.com/help/symbolic/int.html

syms lambda x k 

p = lambda*exp(-lambda*x) 

intp  = int(p,x,0,k) 
intpx = int(p*x,x,0,k)

putk = k*intp - intpx 
simplify(putk) 

return 