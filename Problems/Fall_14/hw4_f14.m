% Matlab program for Lab Report #4 
% For the course, "Macroeconomic Foundations for Asset Prices," NYU Stern.
% Written by:  Dave Backus, October 2014 
format compact 
clear all 

%%
disp(' ')
disp('Answers to Lab Report #4') 

disp(' ')
disp('------------------------------------------------------------------')
disp('Question 1') 

disp(' ')
disp('Inputs') 

Q = [1/2; 1/3; 1/4];
p = [1/3; 1/3; 1/3];

disp(' ')
disp('(a,b,c)')
m = Q./p 

q1 = sum(p.*m)
r1 = 1/q1

pstar = p.*m/q1
check_pstar = sum(pstar)

disp(' ')
disp('(d,e,f)')

d = [1; 2; 3];
qe = sum(p.*m.*d)

re = d./qe
Ere = sum(p.*re)
rp = Ere - r1 

%%
disp(' ')
disp('------------------------------------------------------------------')
disp('Question 2')

nz = 10;
z = [0:nz]';

omega = 4;
alpha = 1;

p = exp(-omega)*omega.^z./gamma(z+1);
omegastar = omega*exp(-alpha)
pstar = exp(-omegastar)*omegastar.^z./gamma(z+1);

disp(' ')
disp('True and risk-neutral probabilities') 
[z p pstar]

figure(1)
bar(z, [p pstar]) 
xlabel('State z')
ylabel('True and Risk-Neutral Probabilities') 


%%
disp(' ')
disp('------------------------------------------------------------------')
disp('Question 3')

% arbitrary state grid
zmax = 4; dz = 0.5;
z = [-zmax:dz:zmax]';
pstar = exp(-z.^2/2)*dz/sqrt(2*pi);
checksumprobs = sum(pstar)

% underlying
q1 = 0.95;
sigma = 0.1;
mu = log(100/q1) - sigma^2/2
logs = mu + sigma*z;
s = exp(logs);

% option cash flows 
k = 110;
dcall = [s>=k].*(s-k);
qcall = q1*sum(pstar.*dcall)

% underlying revisited
s0 = q1*sum(pstar.*s)

figure(1)
plot(s, dcall, 'r', 'LineWidth', 2)
ylabel('Call Option Cash Flow')

