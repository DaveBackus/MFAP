%  notes_consumption.m
%  notes_econ_consumption 
%  Calculations to accompany notes on consumption and portfolioo choice  
%  For:  "Macro-foundations for asset prices"
%  Written by:  Dave Backus, NYU, August 2013 and after 
clear all 
format compact

%%
disp('Portfolio choice') 
% inputs
beta = 1/1.1;
r1 = 1.1;
re_1 = 1.0;
re_2 = 1.4;
y0 = 1;

% Arrow securities
disp('Prices of Arrow securities')
Q = inv([1 1; 1 1.4])*[1/r1; 1]

% portfolio weight a: find value that sets foc closest to zero
agrid = [0.1:0.001:2];

disp('Portfolio shares for alpha equal to 2 and 5')
alpha = 2;
foc2 = 0.5*((1-agrid)*r1+agrid*re_1).^(-alpha).*(re_1-r1) + ...
        0.5*((1-agrid)*r1+agrid*re_2).^(-alpha).*(re_2-r1);
[focmin,i] = min(abs(foc2));
a2 = agrid(i)

alpha = 5;
foc5 = 0.5*((1-agrid)*r1+agrid*re_1).^(-alpha).*(re_1-r1) + ...
        0.5*((1-agrid)*r1+agrid*re_2).^(-alpha).*(re_2-r1);
axis = 0*agrid;
[focmin,i] = min(abs(foc5));
a5 = agrid(i)

plot(agrid,foc2,'b')
hold on
plot(agrid,foc5,'m')
plot(agrid,axis,'k')
ylabel('First-order condition')
xlabel('Portfolio weight a')
title('Blue is \alpha=2, Magenta is \alpha=5')

disp(' ')
disp('Consumption quantities')
alpha = 5; a = a5;          % change as needed
S = 0.5*((1-a)*r1+a*re_1)^(1-alpha) + 0.5*((1-a)*r1+a*re_2)^(1-alpha)
SBA = (S*beta)^(-1/alpha)

c0 = y0/(1+SBA)
saving = y0 - c0

c1_1 = saving*((1-a)*r1+a*re_1)
c1_2 = saving*((1-a)*r1+a*re_2)

% Merton's formula
% See:  http://en.wikipedia.org/wiki/Merton's_portfolio_problem
disp('Compare answers to Merton formula')
E_rx = 0.5*(re_1+re_2) - r1
var_re = 0.2^2

amerton2 = E_rx/(2*var_re)
amerton5 = E_rx/(5*var_re)

% variant a la Campbell 
var_logre = 0.5*(log(re_1)-E_logre)^2 + 0.5*(log(re_2)-E_logre)^2
E_rx_approx = E_logrx + var_logre/2

amerton5 = (0.1+var_re/2)/(alpha*var_re)
amerton2 = (0.1+var_re/2)/(2*var_re)
