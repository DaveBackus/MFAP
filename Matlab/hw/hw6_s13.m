%  hw6_s13.m 
%  Matlab program for Lab Report #5, Spring 2012 
%  NYU course ECON-UB 233, Macro foundations for asset pricing, Mar 2012.  
%  Written by:  Dave Backus, March 2012 
format compact
format short 
clear all

%%
disp('Answers to Lab Report 6s') 

disp(' ')
disp('------------------------------------------------------------------')
disp('Question 1 (option prices)') 

disp(' ')
disp('Inputs') 
tau = 1;                 % maturity 
q_tau = 0.98;           % bond price
s = 100.00;              % current price of underlying 
k = [95; 100; 105];     % strike prices 

% BSM formula
% define price as function of sigma, two steps for clarity 
% NB:  these are what Matlab calls anonymous functions, see 
% http://www.mathworks.com/help/matlab/matlab_prog/anonymous-functions.html
d = @(sigma,k) (log(s./(q_tau.*k))+tau*sigma.^2/2)./(sqrt(tau)*sigma);
call = @(sigma,k) s*normcdf(d(sigma,k)) - q_tau.*k.*normcdf(d(sigma,k)-sqrt(tau)*sigma);

disp('(a)') 
q_call_10 = call(0.10,k)

disp('(b)') 
% compute put prices using put-call parity 
q_put_10 = q_call_10 + q_tau*k - s

disp('(c)') 
% compute call prices with higher sigma 
q_call_125 = call(0.125,k)

%disp(' ')
%disp('Strike, Call Prices at vol 0.10 and 0.15, Put Prices at 0.10') 
%[k q_call_10 q_call_15 q_put_10]

disp('(d)') 
% call price v sigma 
sigma = [0.001:0.001:0.50]';

q_call_90 = call(sigma,90);
q_call_100 = call(sigma,100);
q_call_110 = call(sigma,110);

figure(1) 
clf
plot(sigma,q_call_90,'k')
hold on 
plot(sigma,q_call_100,'b')
plot(sigma,q_call_110,'m')
axis([0 0.5 0 25])
xlabel('Volatility') 
ylabel('Call Price') 
text(0.02,22,'Strikes of 90, 100, and 110 as you move down')

%print ...  

disp('(e)')
disp(' ') 
[dummy,i] = min(abs(q_call_110-2.00));
sigma_implied_parte = sigma(i)


%%
disp(' ')
disp('------------------------------------------------------------------')
disp('Question 2 (implied volatilities)') 
clear all 
format compact 

disp(' ')
disp('Inputs') 
tau = 3/12
q_tau = 1.00 
q = 1395.75 

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

b = data(:,1);
call_bid = data(:,2);
call_ask = data(:,3);
put_bid = data(:,4);
put_ask = data(:,5);

call_mid = (call_bid+call_ask)/2;
put_mid = (put_bid+put_ask)/2;

disp(' ')
disp('(a) Calls from puts')

call_fromputs = q - q_tau*b + put_mid;

figure(2) 
clf
plot(b, call_bid, 'b')
hold on 
plot(b, call_ask, 'm')
plot(b, call_fromputs, 'k*')
title('Bid and Ask Call Prices') 
xlabel('Strike Price') 
ylabel('Call Price') 
text(1350,30,'blue is bid, magenta is ask, * is from puts')

print -dpdf hw6_q2a.pdf

%%
disp(' ')
disp('(b) Implied vols for mid calls via secant method')
clear functions 

% BSM formula
% define f = call price as function of sigma, two steps for clarity (or not?) 
d = @(sigma,b) (log(q./(q_tau.*b))+tau*sigma.^2/2)./(sqrt(tau)*sigma);
f = @(sigma,b) q*normcdf(d(sigma,b)) - q_tau.*b.*normcdf(d(sigma,b)-sqrt(tau)*sigma) ... 
        - call_mid;

% convergence parameters 
tol = 1.e-8;
maxit = 50;

% starting values 
% NB:  we do this for log(sigma), which makes sure sigma is positive
x_before = log(0.08) + zeros(size(b));
x_now = log(0.12) + zeros(size(b));
f_before = f(exp(x_before),b);
f_now = f(exp(x_now),b);

% compute implied vol 
t0 = cputime; 
for it = 1:maxit        
    fprime = (f_now - f_before)./(x_now - x_before);
    x_new = x_now - f_now./fprime;
    f_new = f(exp(x_new),b);
    diff_x = max(abs(x_new - x_now));
    diff_f = max(abs(f_new));
%    [it diff_x diff_f]
    
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
vol = exp(x_new);
[b/1000 vol]

figure(3) 
clf
plot(b, vol, 'b')
hold on
plot(b, vol, 'b+')
xlabel('Strike Price') 
ylabel('Implied Volatility') 

print -dpdf hw6_q2b.pdf

return