%  notes_bsm.m 
%  Matlab code for the options chapter, mostly calculations using the 
%  Black-Scholes-Merton formula. 
%  Notation:
%       underlying:     s
%       strike:         k
%       bond price:     q_tau 
%       volatility:     sigma 
%  NYU course ECON-UB 233, Macro foundations for asset pricing.  
%  Written by:  Dave Backus, March 2012 and after 
format compact
format short 
clear all

%%
disp(' ')
disp('BSM calculations') 
disp('---------------------------------------------------------------')

% inputs 
tau = 1
q_tau = 0.98 
s = 100 
k = [95; 105]
sigma = [0.2104] 

% define price as function of sigma in two steps 
% this is set up so that either k and sigma have the same dimensions 
% or one (or both) is a scalar
d = @(k) (log(s./(q_tau.*k))+tau*sigma.^2/2)./(sqrt(tau)*sigma);
call = @(sigma) s*normcdf(d(k)) - q_tau.*k.*normcdf(d(k)-sqrt(tau)*sigma);

disp(' ')
q_call = call(sigma)
 

%%
disp(' ')
disp('Call price v volatility') 
disp('---------------------------------------------------------------')
clear all

% inputs 
yield = 0.01
tau = 0.25
q_tau = exp(-tau*yield) 
s = 1388
k = q_tau*q     % roughly at the money 

% define price as function of sigma 
d2 = @(sigma) (log(s./(q_tau.*k))+tau*sigma.^2)./(sqrt(tau)*sigma);
call2 = @(sigma) s*normcdf(d2(sigma)) - q_tau.*k.*normcdf(d2(sigma)-sqrt(tau)*sigma);

sigma = [0.0001:0.01:0.50]';
q_call = call2(sigma);

plot(sigma,q_call,'LineWidth',2)
xlabel('Volatility') 
ylabel('Call price') 


%%
disp(' ')
disp('Implied volatility') 
disp('---------------------------------------------------------------')
clear all
format compact 

% inputs 
yield = 0.005
tau = 0.125 
q_tau = exp(-tau*yield) 

% http://www.cmegroup.com/trading/equity-index/us-index/e-mini-sandp500.html
% data for 2013-11-05 
s = 1757
data = [1735 42.75; 1740 39.25; 1745 36.25; 1750 33; 1755 30; ...
        1760 27.25; 1765 24.50; 1770 22; 1775 19.50; 1780 17.50];

k = data(:,1);
call_last = data(:,2);

% BSM formula
% define f = call price as function of sigma, two steps for clarity (or not?) 
d = @(sigma,k) (log(s./(q_tau.*k))+tau*sigma.^2/2)./(sqrt(tau)*sigma);
f = @(sigma,k) s*normcdf(d(sigma,k)) - q_tau.*k.*normcdf(d(sigma,k)-sqrt(tau)*sigma) ... 
        - call_last;
fp = @(d) s*sqrt(tau)*exp(-d.^2/2)/sqrt(2*pi);    

% convergence parameters 
tol = 1.e-8;
maxit = 50;

% starting values 
% NB:  we do this for log(sigma), which makes sure sigma is positive
x_now = 0.12 + zeros(size(k));
f_now = f(x_now,k);

% compute implied vol 
t0 = cputime; 
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
time = cputime - t0 
diffs = [diff_x diff_f]
disp(' ')
disp('Strike/1000 and Vol') 
vol = x_new;
[k/1000 vol]

figure(1) 
clf
plot(k, vol, 'b')
hold on
plot(k, vol, 'b+')
xlabel('Strike Price') 
ylabel('Implied Volatility') 


%%
disp(' ')
disp('Bernoulli mixture') 
disp('---------------------------------------------------------------')
clear all
format compact 

disp('Inputs') 
tau = 1;
q1 = 1; 
q_tau = q1;
s = 100.00 
k = [90:2:110]';

sigma = 0.04;
omega = 0.01;       % alternate 0.0 (BSM) and 0.01 (mixture) 
theta = -0.3; 
delta = 0.15; 

% apply no-arb condition 
mu = log(s/q1) - sigma^2/2 - log((1-omega)+omega*exp(theta+delta^2/2))

% branch 1 
d1 = (log(k)-mu)/sigma;
put1 = q1*k.*normcdf(d1) - q1*exp(mu+sigma^2/2)*normcdf(d1-sigma);

% branch 2 
d2 = (log(k)-(mu+theta))/sqrt(sigma^2+delta^2);
put2 = q1*k.*normcdf(d2) - ... 
     q1*exp((mu+theta)+(sigma^2+delta^2)/2)*normcdf(d2-sqrt(sigma^2+delta^2));

puts = (1-omega)*put1 + omega*put2;
calls = puts + s - q1*k;

disp(' ')
disp('Strike, puts, calls') 
[k puts calls]

% BSM formula
% define f = call price as function of sigma, in two steps
% fp is the derviative (the vega), used in Newton's method routine 
d = @(sigma,k) (log(s./(q_tau.*k))+tau*sigma.^2/2)./(sqrt(tau)*sigma);
f = @(sigma,k) s*normcdf(d(sigma,k)) - q_tau.*k.*normcdf(d(sigma,k) ...
        - sqrt(tau)*sigma) - calls;  % note: we subtract true price 
fp = @(d) s*sqrt(tau)*exp(-d.^2/2)/sqrt(2*pi);    

% convergence parameters 
tol = 1.e-8;
maxit = 50;

% starting values 
x_now = 0.12 + zeros(size(k));
f_now = f(x_now,k);

% compute implied vol 
t0 = cputime; 
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
time = cputime - t0 
diffs = [diff_x diff_f]
disp(' ')
disp('Strike/1000 and Vol') 
vol = x_new;
[k/1000 vol]

% plot smile 
figure(1) 
clf
plot(k, vol, 'b')
hold on
plot(k, vol, 'b+')
axis([90 110 0.035 0.07])
xlabel('Strike Price') 
ylabel('Implied Volatility') 

