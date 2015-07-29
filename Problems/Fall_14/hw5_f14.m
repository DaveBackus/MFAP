%  Matlab program for Lab Report #5, Fall 2014 
%  NYU course ECON-UB 233, Macro foundations for asset pricing.  
%  Written by:  Dave Backus  
format compact 
clear all 

disp('Answers to Lab Report 5') 

%%
disp(' ')
disp('------------------------------------------------------------------')
disp('Question 1 (disaster risk)') 
format compact 
clear all 

syms s omega mu sigma theta 

disp(' ')
disp('Analytics for cumulants') 
mgf = omega*exp(s*(mu-theta)) + 0.5*(1-omega)*(exp(s*(mu-sigma))+exp(s*(mu+sigma)));
cgf = log(mgf);

disp(' ')
disp('Cumulants') 
kappa1 = subs(diff(cgf,s,1),s,0);    %  mean
kappa2 = subs(diff(cgf,s,2),s,0);    % variance 
kappa3 = subs(diff(cgf,s,3),s,0);
kappa4 = subs(diff(cgf,s,4),s,0);

kappa1 = simplify(kappa1)
kappa2 = simplify(kappa2)

mu2p = subs(diff(mgf,s,2),s,0)

disp(' ') 
disp('Asset prices and returns') 
clear all 

% consumption process  
omega = 0.01;       % change as needed 
theta = 0.3;
mu = 0.0200 + omega*theta
sigma = sqrt(0.0350^2 - omega*(1-omega)*theta^2)

p = [(1-omega)/2; (1-omega)/2; omega]; 
logg = [mu + sigma; mu-sigma; mu-theta];
g = exp(logg);

% preferences
beta = 0.99; 
alpha = 10;

% asset prices 
m = beta*g.^(-alpha);
d = g;

q1 = sum(p.*m) 
r1 = 1/q1

qe = sum(p.*m.*d) 
re = d./qe;
Ere = sum(p.*re)

eq_prem = Ere - r1

x = re - r1;
Ex = sum(p.*x);

disp(' ') 
disp('Sharpe ratios and entropy') 

Stdx = sqrt(sum(p.*(x-Ex).^2));
SRmodel = Ex/Stdx

SRdata = 0.0571/0.1873

Em = q1
Stdm = sqrt(sum(p.*(m-Em).^2))
SRmax = Stdm/Em 

Hm = log(sum(p.*m)) - sum(p.*log(m))


%%
disp(' ')
disp('------------------------------------------------------------------')
disp('Question 2 (normal mixture)') 
format compact 
clear all

%{
disp(' ') 
disp('Verify moments')
syms s theta delta omega 

% normal mgf 
%theta=0, delta=1
mgf1 = exp(s^2/2);
mgf2 = exp(s*theta + delta*s^2/2);
mgf = (1-omega)*mgf1 + omega*mgf2;
cgf = log(mgf);

disp('cumulants ')
% differentiate cumulant generating function 
kappa1 = subs(diff(cgf,s,1),s,0)    % mean
kappa2 = subs(diff(cgf,s,2),s,0)    % variance 
kappa3 = subs(diff(cgf,s,3),s,0);
kappa4 = subs(diff(cgf,s,4),s,0);

% disp('skewness and kurtosis')
% gamma1 = kappa3/kappa2^(3/2);
% gamma2 = kappa4/kappa2^2;
%}

disp(' ')
disp('discrete approximation') 
% grid 
zmax = 6;
dz = 0.1;
z = [-zmax:dz:zmax]';

% mixture 
omega = 0.2; theta = -1; delta = 2;
p1 = exp(-z.^2/2)*dz/sqrt(2*pi);
p2 = exp(-(z-theta).^2/(2*delta))*dz/sqrt(2*pi*delta);
p  = (1-omega)*p1 + omega*p2;
checksump = sum(p)

clf 
figure(1)
bar(z, [p1 p])
axis([-5 5 0 0.045])
title('Standard normal (blue) and mixture (red)') 
xlabel('State variable z') 
ylabel('Probability density function') 
%plot(z, p, 'b', 'LineWidth', 2)

disp(' ')
disp('moments') 
meanz = sum(p.*z)
stdz  = sqrt(sum(p.*(z-meanz).^2)) 
skewz = sum(p.*(z-meanz).^3)/stdz^3 
xkurz = sum(p.*(z-meanz).^4)/stdz^4 - 3 

disp(' ')
disp('parameters (mu,sigma)') 
mu = 0.0200 - omega*theta 
sigma = 0.0350/sqrt(1-omega+omega*(theta^2+delta))

logg = mu + sigma*z;

beta = 0.99; alpha = 1;
logm = log(beta) - alpha*logg;
g = exp(logg);
m = exp(logm);

disp(' ')
disp('asset prices') 
q1 = sum(p.*m)
r1 = 1/q1 

d = 100*g;
qe = sum(p.*m.*d)
Ere = sum(p.*d)/qe

disp(' ') 
disp('option prices') 
k = 125;
f = (k-d).*(k > d);
qput = sum(p.*m.*f) 

Erput = sum(p.*f)/qput 

figure(2)
plot(d, f, 'b', 'LineWidth', 1.5)
text(k, qput, 'o', 'LineWidth', 2) 

