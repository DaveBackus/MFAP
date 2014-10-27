% Quick overview of Matlab control flow 
% For the course, "Macroeconomic Foundations for Asset Prices," NYU Stern.
%
% links 
% http://www.mathworks.com/help/matlab/ref/if.html
% http://www.mathworks.com/help/matlab/ref/relationaloperators.html 
% http://www.mathworks.com/help/matlab/ref/for.html
% http://www.mathworks.com/help/matlab/matlab_prog/anonymous-functions.html
%
% Written by:  Dave Backus, October 2014 
format compact 
clear all 

%%
disp(' ')
disp('if statements') 
disp('--------------------------------------------------------------') 

disp(' ')
disp('brute force abs value') 
x = 4;
if x <= 0
    x = -x;
end
x

%%
disp(' ')
disp('the else option') 
x = 7;
if x <= 0
    x = -x;
else 
    x = 2*x; 
end  
disp(x)

%%
disp(' ')
disp('multiple conditions') 

x = 11;
if x >= 0 && x <= 10        %  && = and, || = or 
    x = 0;
end 
x

    
%%
disp(' ')
disp('for loops') 
disp('--------------------------------------------------------------') 

disp(' ')
disp('factorials') 

maxit = 8;
total = 1;
for it = 2:2:maxit 
    total = total*it;
    if total >= 10, break, end     
    [it total] 
end 

%%
disp(' ')
disp('go through an arbitrary list') 

list = [1 8 3 99];
for x = list 
    x
end


%%

disp(' ')
disp('find first negative number in list') 

list = [1 8 -3 99];
for x = list 
    x 
    if x <= 0
        break
    end     
end


%%
disp(' ')
disp('anonymous functions') 
disp('--------------------------------------------------------------') 

disp(' ')
disp('x-squared') 
f = @(x) x^2
f(7)

%%
disp(' ')
disp('vectorized') 
f = @(x) x.^2
f([3 7])
f([3; 7])
f([1 2; 3 4]) 

