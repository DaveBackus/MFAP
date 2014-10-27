%  root_finding_pjb.m 
%  Calculations for finding x* such that f(x*) = 0 
%  Example:  f(x) = x^2 - a  
%  Examples of bisection, Newton's method, and secant method 
%  See Wikipedia ("root-finding") or Atkinson, "Numerical Analysis" 
%  Matlab links
%     loops:  http://www.mathworks.com/help/matlab/matlab_prog/loop-control-statements.html
%     if/then/else:  http://www.mathworks.com/help/matlab/ref/if.html   
%  NYU course ECON-UB 233, Macro foundations for asset pricing  
%  Adapted by Paul Backus to include internally defined functions (@) 

%% Initialization
format compact
format short 
clear all

%% Bisection
disp(' ')
disp('1. Bisection') 
disp('---------------------------------------------------------------')

% example function
% the @ here is what Matlab calls an anonymous function, which "can 
% contain only a single executable statement"
% http://www.mathworks.com/help/matlab/matlab_prog/anonymous-functions.html
a = 2;
f = @(x) x.^2 - a;

% convergence parameters
tol = 1.e-8;
maxit = 50;

% starting values 
x_lo = zeros(size(a));
x_hi = 10*ones(size(a));
f_lo = f(x_lo);
f_hi = f(x_hi);

% can we vectorize this?
if sign(f_lo)==sign(f_hi), disp('*** Error: solution not bracketed'), end        

% find root
t0 = cputime;
for it = 1:maxit      
    x_new = (x_lo + x_hi)/2;      % cut interval in half 
    f_new = f(x_new);
    diff_x = max(abs(x_lo - x_hi));
    diff_f = max(abs(f_new));
    [it x_new]
    
    if max(diff_x,diff_f) < tol, break, end
    
    if sign(f_new)==sign(f_lo)
        x_lo = x_new; 
        f_lo = f_new;
    else 
        x_hi = x_new;
        f_hi = f_new;
    end 
end 

% display results
it 
diffs = [diff_x diff_f]
f_new
x_new 
time = cputime - t0 

%return 

%% Newton's method
disp(' ')
disp('2. Newtons method') 
disp('---------------------------------------------------------------')

% note vector of a's 
a = [2];

% example function and its derivative 
f = @(x) x.^2 - a;
fprime = @(x) 2*x;

% convergence parameters 
tol = 1.e-8;
maxit = 50;

% starting values 
x_now = 10;
f_now = f(x_now);

% find root
t0 = cputime; 
for it = 1:maxit
    fp_now = fprime(x_now);
    x_new = x_now - f_now./fp_now;
    f_new = f(x_new);
    diff_x = max(abs(x_new - x_now));
    diff_f = max(abs(f_new));
    [it f_new] 
    
    if max(diff_x,diff_f) < tol, break, end
    
    x_now = x_new;
    f_now = f_new; 
end    

% display results
it 
diffs = [diff_x diff_f]
f_new
x_new
time = cputime - t0 

%return

%% Secant method
disp(' ')
disp('3. Secant method') 
disp('---------------------------------------------------------------')

% you can also try a vector of a's, then ask yourself why it often fails 
a = 8; 

% example function
f = @(x) x.^2 - a;

% convergence parameters 
tol = 1.e-8;
maxit = 50;

% starting values 
x_before = 8;
x_now = 10;
f_before = f(x_before);
f_now = f(x_now);

% find root 
t0 = cputime; 
for it = 1:maxit        
    fp = (f_now - f_before)./(x_now - x_before);
    x_new = x_now - f_now./fp;
    f_new = f(x_new);
    diff_x = max(abs(x_new - x_now));
    diff_f = max(abs(f_new));
    
    if max(diff_x,diff_f) < tol, break, end
    
    x_before = x_now;
    x_now = x_new;
    f_before = f_now;
    f_now = f_new; 
end    

% display results
it 
diffs = [diff_x diff_f]
f_new
x_new
time = cputime - t0 


%% Newton applied to implied vol for call prices 

disp(' ')
disp('4. Implied volatility via Newton method') 
disp('---------------------------------------------------------------')

disp(' ')
disp('Inputs') 
tau = 3/12
q_tau = 1.00 
s = 1395.75 
k = 1350 
call_price = 76.75 

% f = BSM formula - call price 
% fp = vega
d = @(sigma,k) (log(s./(q_tau.*k))+tau*sigma.^2/2)./(sqrt(tau)*sigma);
f = @(sigma,k) s*normcdf(d(sigma,k)) - q_tau.*k.*normcdf(d(sigma,k)-sqrt(tau)*sigma) ... 
        - call_price;
fp = @(d) s*sqrt(tau)*exp(-d.^2/2)/sqrt(2*pi);    

% convergence parameters 
tol = 1.e-8;
maxit = 50;

% starting values 
% NB:  we do this for log(sigma), which makes sure sigma is positive
x_now = 0.12 + zeros(size(k));
f_now = f(x_now,k);

% compute implied vol 
for it = 1:maxit        
    fp_now = fp(d(x_now,k));
    x_new = x_now - f_now./fp_now;
    f_new = f(x_new,k);
    diff_x = max(abs(x_new - x_now));
    diff_f = max(abs(f_new));
    
    if max(diff_x,diff_f) < tol, break, end
    
    x_before = x_now;
    x_now = x_new;
    f_before = f_now;
    f_now = f_new; 
end    

% display results
it 
diffs = [diff_x diff_f]
disp(' ')
disp('Strike and implied volatility') 
vol = x_new;
[k/1000 vol]
