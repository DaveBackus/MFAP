%  affine_models.m 
%  Solve affine models, pick parameter values 
%  Notation from notes on affine models 
%  NYU course ECON-UB 233, Macro foundations for asset pricing, Apr 2012.  
%  Written by:  Dave Backus, April 2012 
format compact
format long 
clear all

%%
disp(' ')
disp('Vasicek model') 
disp('---------------------------------------------------------------')

%  Inputs 
% 
%disp(' ')
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
phi = autocorr_f0
sigma = sqrt((1-phi^2)*var_f0)    %  note sign convention 
lambda = 0.125
delta = - Ef0 - lambda^2/2; 

% initializations  
maxmat = 122;
A = zeros(maxmat,1);
B = A;
A(1) = 0; 
B(1) = 0;

for mat = 2:maxmat 
    % NB:  maturities start at n=0, makes initial conditions simple     
    A(mat) = A(mat-1) + delta + (lambda + B(mat-1)*sigma)^2/2;
    B(mat) = phi*B(mat-1) - 1;
end

Adiff = diff(A);
Bdiff = diff(B);

disp(' ')
disp('Forward rate regression coefficient b1') 
b1 = (phi-1)/(Bdiff(1)-Bdiff(2))

f_bar = -Adiff;
imatf = [0:maxmat-2]';

imatsome = [0 1 3 6 12 36 60 120]';
f_data = [6.683 7.098 7.469 7.685 7.921 8.498 8.714 8.858]';

%  Figures 

% means 
figure(1) 
clf
FontSize = 12;
FontName = 'Helvetica';  % or 'Times' 
LineWidth = 1.5;

plot(imatf,1200*f_bar,'k','LineWidth',LineWidth)
hold on 
plot(imatsome,f_data,'b*','LineWidth',LineWidth)
title('Mean Forward Rate for Vasicek Model','FontSize',FontSize,'FontName',FontName)
ylabel('Mean Forward Rate','FontSize',FontSize,'FontName',FontName)
xlabel('Maturity n in Months','FontSize',FontSize,'FontName',FontName)
set(gca,'LineWidth',LineWidth,'FontSize',FontSize,'FontName',FontName)

return 

%%
%{
% standard deviations 

fstd_data = [2.703 2.822 2.828 2.701 2.495 2.135 2.013 1.946]';
fstd = sqrt(var_f0)*phi.^imat0; 

figure(2) 
FontSize = 12;
FontName = 'Helvetica';  % or 'Times' 
LineWidth = 1.5;

plot(imatf,1200*fstd,'b','LineWidth',LineWidth)
hold on 
plot(imatsome,fstd_data,'b*','LineWidth',LineWidth)
title('Standard Deviations of Forward Rates for Vasicek Model','FontSize',FontSize,'FontName',FontName)
ylabel('Standard Deviation','FontSize',FontSize,'FontName',FontName)
xlabel('Maturity n in Months','FontSize',FontSize,'FontName',FontName)
set(gca,'LineWidth',LineWidth,'FontSize',FontSize,'FontName',FontName)
%}

%%
disp(' ')
disp('Cox-Ingersoll-Ross model') 
disp('---------------------------------------------------------------')

%  Inputs 

%disp(' ')
disp('Data input')  
autocorr_f0 = 0.959 
var_f0 = (2.73/1200)^2
Ef0 = 6.683/1200 
Ef120 = 8.858/1200
Efp120 = Ef120 - Ef0 

%  Parameters and recursions
 
disp(' ')
disp('Parameter values')  
phi = autocorr_f0
delta = Ef0 
sigma = sqrt((1-phi^2)*var_f0/delta)    %  note sign convention 
lambda = 1.32 %0.0988/sqrt(delta)

% initializations  
maxmat = 122;
A = zeros(maxmat,1);
B = A;
A(1) = 0; 
B(1) = 0;

for mat = 2:maxmat 
    % NB:  maturities start at n=0, makes initial conditions simple  
    A(mat) = A(mat-1) + B(mat-1)*(1-phi)*delta;
    B(mat) = phi*B(mat-1) - (1+lambda^2/2) + (lambda+B(mat-1)*sigma)^2/2;
end

Adiff = diff(A);
Bdiff = diff(B);

disp(' ')
disp('Forward rate regression coefficient b1') 
b1 = (phi-1)/(Bdiff(1)-Bdiff(2))

f_bar = -Adiff - Bdiff*delta;
imatf = [0:maxmat-2]';

imatsome = [0 1 3 6 12 36 60 120]';
f_data = [6.683 7.098 7.469 7.685 7.921 8.498 8.714 8.858]';

%  Figures 

clf
figure(1) 
FontSize = 12;
FontName = 'Helvetica';  % or 'Times' 
LineWidth = 1.5;

plot(imatf,1200*f_bar,'b','LineWidth',LineWidth)
hold on 
plot(imatsome,f_data,'b*','LineWidth',LineWidth)
title('Mean Forward Rate for CIR Model','FontSize',FontSize,'FontName',FontName)
ylabel('Mean Forward Rate','FontSize',FontSize,'FontName',FontName)
xlabel('Maturity n in Months','FontSize',FontSize,'FontName',FontName)
set(gca,'LineWidth',LineWidth,'FontSize',FontSize,'FontName',FontName)

return 

%%
disp(' ')
disp('Another affine model') 
disp('---------------------------------------------------------------')

%  Inputs 

%disp(' ')
disp('Data input')  
autocorr_f0 = 0.959 
var_f0 = (2.73/1200)^2
Ef0 = 6.683/1200 
Ef120 = 8.858/1200
Efp120 = Ef120 - Ef0 

%  Parameters and recursions
 
disp(' ')
disp('Parameter values')  
phi = autocorr_f0
delta = -Ef0 
sigma = sqrt((1-phi^2)*var_f0)    %  note sign convention 
lambda1 = 0 
lambda0 = 0.125 

% initializations  
maxmat = 122;
A = zeros(maxmat,1);
B = A;
A(1) = 0; 
B(1) = 0;

for mat = 2:maxmat 
    % NB:  maturities start at n=0, makes initial conditions simple  
    A(mat) = A(mat-1) + delta + (B(mat-1)*sigma)^2/2 + B(mat-1)*sigma*lambda0;
    B(mat) = phi*B(mat-1) - 1 + B(mat-1)*sigma*lambda1;
end

Adiff = diff(A);
Bdiff = diff(B);

b1 = (phi-1)/(Bdiff(1)-Bdiff(2))

f_bar = -Adiff;
imatf = [0:maxmat-2]';

imatsome = [0 1 3 6 12 36 60 120]';
f_data = [6.683 7.098 7.469 7.685 7.921 8.498 8.714 8.858]';

%  Figures 

clf
figure(1) 
FontSize = 12;
FontName = 'Helvetica';  % or 'Times' 
LineWidth = 1.5;

plot(imatf,1200*f_bar,'b','LineWidth',LineWidth)
hold on 
plot(imatsome,f_data,'b*','LineWidth',LineWidth)
title('Mean Forward Rate for CIR Model','FontSize',FontSize,'FontName',FontName)
ylabel('Mean Forward Rate','FontSize',FontSize,'FontName',FontName)
xlabel('Maturity n in Months','FontSize',FontSize,'FontName',FontName)
set(gca,'LineWidth',LineWidth,'FontSize',FontSize,'FontName',FontName)

return 