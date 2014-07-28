%  hw6_f13.m 
%  Matlab program for Lab Report #6, Fall 2013 
%  NYU course ECON-UB 233, Macro foundations for asset pricing. 
%  Written by:  Dave Backus, October 2013 
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
x = [1:0.025:2]';
f = x.*cos(x)  % note the .* for vectorization 

plot(x,f)
hold on
plot(x,0*f,'k')
plot(x,0*f+0.5,'k--')
plot(x,0*f-0.5,'k--')

disp(' ')
disp('(b) solutions')

% function and it's derivative 
c = [1/2; 0; -1/2];
f = @(x) x.*cos(x)-c;
fp = @(x) cos(x)-x.*sin(x)

% convergence parameters 
tol = 1.e-5;
maxit = 50;

% starting values 
x_now = 1.6+zeros(size(c));
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
tau = 1
q_tau = 0.95 
s = 102 
k = [90; 100; 110]
sigma = [0.1] 

% define price as function of sigma and k in two steps 
% this is set up so that k and sigma must have the same dimension -- 
% unless one of them is a scalar
d = @(sigma,k) (log(s./(q_tau.*k))+tau*sigma.^2/2)./(sqrt(tau)*sigma);
call = @(sigma,k) s.*normcdf(d(sigma,k)) - q_tau.*k.*normcdf(d(sigma,k)-sqrt(tau)*sigma);

disp('(a,b) call and put prices')
q_call = call(sigma,k)
q_put = q_call + q_tau*k - s

disp('(c) call prices with higher vol')
q_call_125 = call(0.125,k)

disp('(d) plot call price v sigma') 
sigma = [0.01:0.01:0.50]';

q_call_90 = call(sigma,90);
q_call_100 = call(sigma,100);
q_call_110 = call(sigma,110);

figure(1) 
clf
plot(sigma,q_call_90,'k')
hold on 
plot(sigma,q_call_100,'b')
plot(sigma,q_call_110,'m')
%axis([0 0.5 0 25])
xlabel('Volatility') 
ylabel('Call Price') 
text(0.02,25,'Strikes of 90, 100, and 110 as you move down')

disp('(e) implied vol') 
% manual method 
check = call(0.1128, 110)
% automated -- use grid, pick closest 
sig_grid = [0.1:0.0001:0.12];
[dummy,i] = min(abs(call(sig_grid,110)-3.50));
sigma_implied = sig_grid(i)


%%
disp(' ')
disp('------------------------------------------------------------------')
disp('Question 3 (option prices and implied vols)') 

disp(' ')
disp('Inputs') 
tau = 3/12
q_tau = 1.00 
s = 1395.75 

data = [
    1340  82.50 85.75 28.25 30.25; 
    1350  75.25 78.25 30.75 32.75;
    1360  68.00 71.00 33.25 35.50;
    1370  61.25 64.00 36.25 38.75;
    1380  54.50 57.25 39.50 42.25;
    1390  48.25 50.75 43.25 45.75; 
    1400  42.25 44.75 47.00 50.00; 
    1410  36.75 39.25 51.25 54.50; 
    1420  31.75 33.75 56.00 59.25; 
    1430  27.00 29.00 61.25 64.50]; 

k = data(:,1);
call_bid = data(:,2);
call_ask = data(:,3);
put_bid = data(:,4);
put_ask = data(:,5);

call_mid = (call_bid+call_ask)/2;
put_mid = (put_bid+put_ask)/2;

disp(' ')
disp('(a) Calls from puts')

call_fromputs = s - q_tau*k + put_mid;

figure(1) 
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

data = [
    1340  82.50 85.75 28.25 30.25; 
    1350  75.25 78.25 30.75 32.75;
    1360  68.00 71.00 33.25 35.50;
    1370  61.25 64.00 36.25 38.75;
    1380  54.50 57.25 39.50 42.25;
    1390  48.25 50.75 43.25 45.75; 
    1400  42.25 44.75 47.00 50.00; 
    1410  36.75 39.25 51.25 54.50; 
    1420  31.75 33.75 56.00 59.25; 
    1430  27.00 29.00 61.25 64.50]; 

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

figure(2) 
clf
plot(k, vol, 'b')
hold on
plot(k, vol, 'b+')
xlabel('Strike Price') 
ylabel('Implied Volatility') 

return