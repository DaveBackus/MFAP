%  root_finding.m 
%  Calculations for solving f(x) = 0 for x 
%  Example:  f(x) = x^2 - a  
%  Examples of bisection, Newton's method, and the secant method 
%  See Wikipedia ("root-finding") or Atkinson, "Numerical Analysis." 
%  NYU course ECON-UB 233, Macro foundations for asset pricing, Mar 2012.  
format compact
format short 
clear all

disp(' ')
disp('1. Bisection') 
disp('---------------------------------------------------------------')

a = 8;

% convergence parameters 
tol = 1.e-8;
maxit = 50;

% starting values 
x_lo = zeros(size(a));
x_hi = 10*ones(size(a));
f_lo = x_lo.^2 - a;
f_hi = x_hi.^2 - a;

% can we vectorize this?
if sign(f_lo)==sign(f_hi), disp('*** Error: solution not bracketed'), end        

t0 = cputime;
for it = 1:maxit      
    x_new = (x_lo+x_hi)/2;      % cut interval in half 
    f_new = x_new.^2 - a;
    diff_x = max(abs(x_lo-x_hi));
    diff_f = max(abs(f_new));
    if max(diff_x,diff_f)<tol, break, it, end 
    if sign(f_new)==sign(f_lo)
        x_lo = x_new; 
        f_lo = f_new;
    else 
        x_hi = x_new;
        f_hi = f_new;
    end 
end    

it 
diffs = [diff_x diff_f]
f_new
x_new 
time = cputime-t0 

%return 

disp(' ')
disp('2. Newtons method') 
disp('---------------------------------------------------------------')

a = 8; 

% convergence parameters 
tol = 1.e-8;
maxit = 50;

% starting values 
x_now = 10;
f_now = x_now.^2 - a;

t0 = cputime; 
for it = 1:maxit        
    fp_now = 2*x_now;
    x_new = x_now - f_now./fp_now;
    f_new = x_new.^2 - a;
    diff_x = max(abs(x_new-x_now));
    diff_f = max(abs(f_new));
    if max(diff_x,diff_f)<tol, break, it, end 
    x_now = x_new;
    f_now = f_new; 
end    

it 
diffs = [diff_x diff_f]
f_new
x_new
time = cputime-t0 

%return

disp(' ')
disp('3. Secant method') 
disp('---------------------------------------------------------------')

a = 8; 

% convergence parameters 
tol = 1.e-8;
maxit = 50;

% starting values 
x_before = 8;
x_now = 10;
f_before = x_before.^2 - a;
f_now = x_now.^2 - a;

t0 = cputime; 
for it = 1:maxit        
    fp = (f_now-f_before)./(x_now-x_before);
    x_new = x_now - f_now./fp;
    f_new = x_new.^2 - a;
    diff_x = max(abs(x_new-x_now));
    diff_f = max(abs(f_new));
    if max(diff_x,diff_f)<tol, break, it, end 
    x_before = x_now;
    x_now = x_new;
    f_before = f_now;
    f_now = f_new; 
end    

it 
diffs = [diff_x diff_f]
f_new
x_new
time = cputime-t0 

return