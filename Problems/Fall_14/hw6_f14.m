% Matlab program for Lab Report #6, Fall 2013 
% NYU course ECON-UB 233, Macro foundations for asset pricing. 
% Written by:  Dave Backus  
format compact
format short 
clear all

%%
disp('Answers to Lab Report 6') 

%%
disp(' ')
disp('------------------------------------------------------------------')
disp('Question 1 (root-finding)') 

disp(' ')
disp('(a) plot f(x)') 
x = [0.5:0.025:2.5]';
f = sin(x) + x.*cos(x)  % note the .* for vectorization 

plot(x,f)
hold on
plot(x,0*f,'k')
plot(x,0*f+0.5,'k--')
plot(x,0*f-0.5,'k--')

disp(' ')
disp('(b) solutions')

% function and it's derivative 
c = [1/2; 0; -1/2];
f = @(x) sin(x) + x.*cos(x)-c;
fp = @(x) 2*cos(x)-x.*sin(x) 

% convergence parameters 
tol = 1.e-5;
maxit = 50;

% starting values 
x_now = 1.5 + zeros(size(c));       % note: it matters where you start! 
f_now = f(x_now);

% compute root by Newton's method 
t0 = cputime; 
for it = 1:maxit        
    x_new = x_now - f_now./fp(x_now);
    f_new = f(x_new);
    it, x_new
    diff_x = max(abs(x_new - x_now));
    diff_f = max(abs(f_new));
    
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


%%
disp(' ')
disp('Question 2 (BSM calculations)') 
disp('---------------------------------------------------------------')

% inputs 
tau = 5/12
q_tau = 1 
s = 197.07
k = [180; 197; 220];
k = 197
sigma = [0.1] 

% define price as function of sigma and k in two steps 
% this is set up so that k and sigma must have the same dimension -- 
% unless one of them is a scalar
d = @(sigma,k) (log(s./(q_tau.*k))+tau*sigma.^2/2)./(sqrt(tau)*sigma);
call = @(sigma,k) s.*normcdf(d(sigma,k)) - q_tau.*k.*normcdf(d(sigma,k)-sqrt(tau)*sigma);

disp('(a) call prices')
q_call = call(0.1,197)
q_call = call(0.2,197)

disp('(b,c) call price v vol')
sigma = [0.01:0.01:0.30]';
q_call_atm = call(sigma,197)
q_call_180 = call(sigma,180)
q_call_220 = call(sigma,220)

figure(1)
clf
plot(sigma, q_call_atm, 'k') 
hold on 
plot(sigma, q_call_180, 'm') 
plot(sigma, q_call_220, 'b') 

disp('(d) implied vol') 
% manual method 
check = call(0.1430, 197)

% semi-automated -- use grid, pick closest 
sig_grid = [0.1:0.0001:0.3];
[dummy,i] = min(abs(call(sig_grid,180)-19.68));
sigma_implied_180 = sig_grid(i)
[dummy,i] = min(abs(call(sig_grid,197)-7.28));
sigma_implied_atm = sig_grid(i)
[dummy,i] = min(abs(call(sig_grid,220)-0.32));
sigma_implied_220 = sig_grid(i)


%%
disp(' ')
disp('------------------------------------------------------------------')
disp('Question 3 (option prices and implied vols)') 

disp(' ')
disp('Inputs') 
tau = 5/12
q_tau = 1.00 
s = 197.07 

data = [
    140  57.12   57.45  0.43   0.48;
    150  47.25   47.62  0.73   0.79;
    160  37.61   37.95  1.26   1.32; 
    170  28.28   28.60  2.15   2.22;  
    180  19.56   19.80  3.63   3.69;  
    190  11.83   11.93  5.96   6.07;  
    200   5.57    5.66  9.87   9.99;  
    210   1.69    1.76 16.03  16.37;  
    220   0.29    0.34 24.70  25.11;  
    230   0.04    0.08 34.46  34.93 ]; 

k = data(:,1);
call_bid = data(:,2);
call_ask = data(:,3);
put_bid = data(:,4);
put_ask = data(:,5);

disp(' ')
disp('(a) plot midmarket quotes')

call_mid = (call_bid+call_ask)/2;
put_mid = (put_bid+put_ask)/2;

figure(1) 
clf
plot(k, call_mid, 'b')
hold on 
plot(k, put_mid, 'm')

%%

disp(' ')
disp('(b) Calls from puts')

call_fromputs = s - q_tau*k + put_mid;

figure(2) 
clf
plot(k, call_bid, 'b')
hold on 
plot(k, call_ask, 'm')
plot(k, call_fromputs, 'k*')
title('Bid and Ask Call Prices') 
xlabel('Strike Price') 
ylabel('Call Price') 
text(1350,30,'blue is bid, magenta is ask, * is from puts')

disp(' ')
disp('(b) Implied vols for mid calls via Newton method')
clear functions 

k = data(:,1);
call_bid = data(:,2);
call_ask = data(:,3);
call_mid = (call_bid+call_ask)/2;

% BSM formula
% define f = call price as function of sigma, two steps for clarity (or not?) 
d = @(sigma,k) (log(s./(q_tau.*k))+tau*sigma.^2/2)./(sqrt(tau)*sigma);
f = @(sigma,k) s*normcdf(d(sigma,k)) - q_tau.*k.*normcdf(d(sigma,k)-sqrt(tau)*sigma) ... 
        - call_mid;
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

figure(3) 
clf
plot(k, vol, 'b')
hold on
plot(k, vol, 'b+')
xlabel('Strike Price') 
ylabel('Implied Volatility') 

return