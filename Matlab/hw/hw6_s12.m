%  hw6_s12.m 
%  Matlab program for Lab Report #6, Spring 2012 
%  NYU course ECON-UB 233, Macro foundations for asset pricing, Mar 2012.  
%  Written by:  Dave Backus, March 2012 
format compact
format short 
clear all

%%
disp('Answers to Lab Report 6') 

disp(' ')
disp('------------------------------------------------------------------')
disp('Question 1 (sums and mixtures)') 
syms s mu sigma omega theta delta  

cgf_x1 = mu*s + sigma^2*s^2/2;
cgf_x2 = log((1-omega)+omega*exp(theta*s + delta^2*s^2/2));
cgf = cgf_x1 + cgf_x2 

disp(' ')
disp('Cumulants') 
kappa1 = subs(diff(cgf,s,1),s,0)    %  mean
kappa2 = subs(diff(cgf,s,2),s,0)    % variance 
kappa3 = subs(diff(cgf,s,3),s,0);
kappa4 = subs(diff(cgf,s,4),s,0);

kappa3 = simplify(kappa3)
kappa4 = simplify(kappa4)


%%
disp(' ')
disp('------------------------------------------------------------------')
disp('Question 2 (Merton-like option pricing)') 
disp(' ')
clear all 
format compact 

disp('Inputs') 
tau = 1;
q1 = 1; 
s = 100.00 
%k = [80; 90; 100; 110; 120];
k = [90:2:110]';

sigma = 0.04;
omega = 0.01;
theta = -0.3; 
delta = 0.15; 

% apply arb condition 
mu = log(s/q1) - sigma^2/2 - log((1-omega)+omega*exp(theta+delta^2/2))

% term 1 
d1 = (log(k)-mu)/sigma;
put1 = q1*k.*normcdf(d1) - q1*exp(mu+sigma^2/2)*normcdf(d1-sigma);

% term 2 
d2 = (log(k)-(mu+theta))/sqrt(sigma^2+delta^2);
put2 = q1*k.*normcdf(d2) - ... 
     q1*exp((mu+theta)+(sigma^2+delta^2)/2)*normcdf(d2-sqrt(sigma^2+delta^2));

puts = (1-omega)*put1 + omega*put2;
calls = puts + s - q1*k;

[k puts calls]

% implied vols 
% define call price as function f of (vol,k) 
d = @(vol,k) (log(s./(q1.*k))+vol.^2/2)./vol;
f = @(vol,k) s*normcdf(d(vol,k)) - q1.*k.*normcdf(d(vol,k)-vol) - calls 

% convergence parameters 
tol = 1.e-8;
maxit = 50;

% starting values (they need tweaking, maybe worse) 
x_before = log(0.07) + zeros(size(k));
x_now = log(0.065) + zeros(size(k));
f_before = f(exp(x_before),k);
f_now = f(exp(x_now),k);

% compute implied vol by secant method on log vol 
t0 = cputime; 
for it = 1:maxit        
    fprime = (f_now - f_before)./(x_now - x_before);
    x_new = x_now - f_now./fprime;
    f_new = f(exp(x_new),k);
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
time = cputime - t0 
diffs = [diff_x diff_f]
disp(' ')
disp('Strike and Vol') 
vol = exp(x_new);
[k vol]

figure(1) 
clf
plot(k, vol, 'b')
hold on
plot(k, vol, 'bo')
xlabel('Strike Price') 
ylabel('Implied Volatility') 

return 

