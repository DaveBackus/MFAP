%  vasicek_model.m 
%  Compute parameters for Vasicek model from features of forward rates 
%  NYU course ECON-UB 233, Macro foundations for asset pricing, Mar 2012.  
%  Written by:  Dave Backus, March 2012 
format compact
format short 
clear all

%%
disp(' ')
disp('Vasicek model numerical example') 
disp('---------------------------------------------------------------')

% -------------------------------------------------------------------------
%  1. Inputs 
% 
% dimensions
maxmat = 120 
imat0 = [0:maxmat]';
imat1 = [1:maxmat]';

% data input 
autocorr_f0 = 0.959 
var_f0 = (2.73/1200)^2
Ef0 = 6.683/1200 
Ef120 = 8.858/1200
Efp120 = Ef120 - Ef0 

% -------------------------------------------------------------------------
%  2. Parameters 
% 
phi = autocorr_f0
a1 = -sqrt((1-phi^2)*var_f0)    %  note sign convention 

disp(' ')
disp('Parameters to match forward premium') 
a = a1*phi.^(imat0-1);
a0 = 0.124     % play with this number till we hit the target term premium 
a(1) = a0;
A = cumsum(a);

forward_premium = (a0^2 - A.^2)/2;
fp = forward_premium;
fp120 = 0*fp + Efp120;

%  ------------------------------------------------------------------------
%  3.  Figures 
%
clf
figure(1) 
FontSize = 12;
FontName = 'Helvetica';  % or 'Times' 
LineWidth = 1.5;

plot(imat0,1200*fp,'b','LineWidth',LineWidth)
hold on 
plot(imat0,1200*fp120,'m--','LineWidth',LineWidth)
title('Mean Forward Rate Spread for ARMA(1,1) Pricing Kernel','FontSize',FontSize,'FontName',FontName)
ylabel('Mean Forward fn-f0','FontSize',FontSize,'FontName',FontName)
xlabel('Maturity n in Months','FontSize',FontSize,'FontName',FontName)
set(gca,'LineWidth',LineWidth,'FontSize',FontSize,'FontName',FontName)

figure(2) 
bar(imat0,a) %,'b','LineWidth',LineWidth)
title('Moving Average Coefficients for ARMA(1,1) Pricing Kernel','FontSize',FontSize,'FontName',FontName)
ylabel('Moving Average Coefficients a_j','FontSize',FontSize,'FontName',FontName)
xlabel('Order j in Months','FontSize',FontSize,'FontName',FontName)
set(gca,'LineWidth',LineWidth,'FontSize',FontSize,'FontName',FontName)

return 