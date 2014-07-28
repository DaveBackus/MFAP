%  hw3_f13.m 
%  Matlab program for Lab Report #3, Fall 2013 
%  Written by:  Dave Backus, September 2013 
format compact 
clear all 

return 
%%
disp(' ')
disp('Answers Lab Report #3') 

disp(' ')
disp('------------------------------------------------------------------')
disp('Question 3') 

disp(' ')
disp('Returns') 
d1 = [1 1];
q1 = 5/6;
r1 = d1/q1 

de = [2 3];
qe = 2;
re = de/qe 

%%
disp(' ')
disp('------------------------------------------------------------------')
disp('Question 4') 

disp(' ')
disp('Return properties') 
r1 = [1.1 1.1 1.1];
re = [0.8 1.2 1.6]; 
omega = 1/3;
p = [omega 1-2*omega omega];

Er1 = sum(p.*r1)
Ere = sum(p.*re)
Varre = sum(p.*re.^2) - Ere^2 
Varre = sum(p.*(re-Ere).^2) 

disp(' ')
disp('State prices') 
D = [r1; re];
q = [1; 1];
Q = pinv(D'*D)*D'*q 

disp(' ')
disp('Portfolio choice') 

% Digression on Merton's formula  
% See:  http://en.wikipedia.org/wiki/Merton's_portfolio_problem
amerton2 = (1/2)*(Ere-Er1)/Varre
amerton5 = (1/5)*(Ere-Er1)/Varre

% portfolio weight a: pick value, check foc, find optimal a manually  
alpha = 2, a = 0.541
%alpha = 5, a = 0.214
foc = sum(p.*((1-a)*r1+a*re).^(-alpha).*(re-r1)) 

% graph foc v. a 
agrid = [-1.5:0.1:1.5]';
foc = 0*agrid;
zero = 0*agrid;

for it = 1:length(agrid)
    a = agrid(it);
    foc(it) = sum(p.*((1-a)*r1+a*re).^(-alpha).*(re-r1));
    rp = (1-a)*r1+a*re;
end     

clf
figure(1)
plot(agrid,foc) 
hold on
plot(agrid,zero,'k') 
xlabel('Fraction a Invested in Risky Asset')
ylabel('First-Order Condition') 

return
