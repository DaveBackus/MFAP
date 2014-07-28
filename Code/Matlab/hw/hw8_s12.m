%  hw8_s12.m 
%  Matlab program for Lab Report #7, Spring 2012 
%  NYU course ECON-UB 233, Macro foundations for asset pricing, Apr 2012.  
%  Written by:  Dave Backus, April 2012 
disp('Answers to Lab Report 8') 
format compact
format short 
clear all
clf

%%
disp(' ')
disp('------------------------------------------------------------')
disp('Question 1 (more Vasicek)') 

% dimensions
maxmat = 120 
imat0 = [0:maxmat]';
imat1 = [1:maxmat]';

% data input 
autocorr_f0 = 0.959 
var_f0 = (2.73/1200)^2
Ef0 = 6.683/1200 
Ef60 = 8.714/1200
Efp60 = Ef60 - Ef0 

%  Parameters 
% 
phi = autocorr_f0
a1 = -sqrt((1-phi^2)*var_f0)    %  note sign convention 

disp(' ')
disp('Parameters to match forward premium') 
a = a1*phi.^(imat0-1);
a0 = 0.1244     % play with this number till we hit the target term premium 
delta = - Ef0 - a0^2/2 

a(1) = a0;
A = cumsum(a);

forward_premium = (a0^2 - A.^2)/2;
fp = forward_premium;
disp(' ')
disp('These should match')
[1200*fp(61) 1200*Efp60]
1200*fp(37)
1200*fp(121)
fp60 = 0*fp + Efp60;

%  Figures 
%
clf
figure(1) 
FontSize = 12;
FontName = 'Helvetica';  
LineWidth = 1.5;

plot(imat0,1200*fp,'b','LineWidth',LineWidth)
hold on 
plot(imat0,1200*fp60,'m--','LineWidth',LineWidth)
title('Mean Forward Rate Spread for ARMA(1,1) Pricing Kernel','FontSize',FontSize,'FontName',FontName)
ylabel('Mean Forward Spread fn-f0','FontSize',FontSize,'FontName',FontName)
xlabel('Maturity n in Months','FontSize',FontSize,'FontName',FontName)
set(gca,'LineWidth',LineWidth,'FontSize',FontSize,'FontName',FontName)

% Standard deviations 
fstd_data = [2.703 2.822 2.828 2.701 2.495 2.135 2.013 1.946]';
fstd = 2.703*phi.^imat0; 

figure(2) 
FontSize = 12;
FontName = 'Helvetica';  % or 'Times' 
LineWidth = 1.5;

plot(imatf,fstd,'b','LineWidth',LineWidth)
hold on 
plot(imatsome,fstd_data,'b*','LineWidth',LineWidth)
title('Standard Deviations of Forward Rates for Vasicek Model','FontSize',FontSize,'FontName',FontName)
ylabel('Standard Deviation','FontSize',FontSize,'FontName',FontName)
xlabel('Maturity n in Months','FontSize',FontSize,'FontName',FontName)
set(gca,'LineWidth',LineWidth,'FontSize',FontSize,'FontName',FontName)

print -depsc hw8q1e.eps

return 

%%
disp(' ')
disp('------------------------------------------------------------')
disp('Question 2 (another affine model)') 

%  Inputs 
% 
disp(' ')
disp('Data input')  
autocorr_f0 = 0.959 
var_f0 = (2.703/1200)^2
Ef0 = 6.683/1200 
Ef120 = 8.858/1200
Efp120 = Ef120 - Ef0 

%  Parameters and recursions
% 
disp(' ')
disp('Parameter values')  
delta = Ef0
phi = autocorr_f0
sigma = sqrt((1-phi^2)*var_f0)    %  note sign convention 
lambda0 = 0 %.125
lambda1 = 0.0972/delta 

% initializations  
maxmat = 122;
A = zeros(maxmat,1);
B = A;
A(1) = 0; 
B(1) = 0;

for mat = 2:maxmat 
    % NB:  maturities start at n=0, makes initial conditions simple  
   
    A(mat) = A(mat-1) + B(mat-1)*((1-phi)*delta+sigma*lambda0) + (B(mat-1)*sigma)^2/2;
    B(mat) = (phi+sigma*lambda1)*B(mat-1) - 1;

end

Adiff = diff(A);
Bdiff = diff(B);

f_bar = -Adiff - Bdiff*delta;
imatf = [0:maxmat-2]';

imatsome = [0 1 3 6 12 36 60 120]';
f_data = [6.683 7.098 7.469 7.685 7.921 8.498 8.714 8.858]';

%  Figures 

% means 
clf 
figure(1) 
FontSize = 12;
FontName = 'Helvetica';  % or 'Times' 
LineWidth = 1.5;

plot(imatf,1200*f_bar,'b','LineWidth',LineWidth)
hold on 
plot(imatsome,f_data,'b*','LineWidth',LineWidth)
title('Mean Forward Rate for Vasicek Model','FontSize',FontSize,'FontName',FontName)
ylabel('Mean Forward Rate','FontSize',FontSize,'FontName',FontName)
xlabel('Maturity n in Months','FontSize',FontSize,'FontName',FontName)
set(gca,'LineWidth',LineWidth,'FontSize',FontSize,'FontName',FontName)

return 

