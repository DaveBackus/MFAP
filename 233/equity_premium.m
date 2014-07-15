%  equity_premium.m 
%  Calculations for equity premium class 
%  NYU course ECON-UB 233, Macro foundations for asset pricing, Feb 2012.  
format compact
%clear all
%close all

%  1. Two-state version  

disp(' ')
disp('Equity premium calculations:  two-state version') 
disp('---------------------------------------------------------------')

disp(' ')
disp('Inputs') 
% state and consumption growth 
mu_g = 1.0200
sigma_g = 0.0350
omega = 1/2;

z = [-1; 1];
g = mu_g + sigma_g*z;
% log version 
%logg = mu_g-1 + sigma_g*z;
%g = exp(logg);
p = [omega; 1-omega];

% preferences and asset prices 
beta = 0.99
alpha = 5
lambda = 1

disp(' ')
disp('Asset prices and returns') 
m = beta*g.^(-alpha);
d = g.^lambda;

q1 = sum(p.*m) 
r1 = 1/q1

qe = sum(p.*m.*d) 
Ere = sum(p.*d)/qe 

eq_premium = Ere - r1

return 

% grid for figs 
alphagrid = [0:0.25:50]';
q1grid = beta*(p(1)./g(1).^alphagrid + p(2)./g(2).^alphagrid);
r1grid = 1./q1grid;

qegrid = beta*(p(1).*d(1)./g(1).^alphagrid + p(2).*d(2)./g(2).^alphagrid);
Eregrid = sum(p.*d)./qegrid;
epgrid = Eregrid - r1grid;

% fig parameters 
FontSize = 14;
FontName = 'Helvetica';  % or 'Times' 
LineWidth = 1.5;

figure(1) 
plot(alphagrid,r1grid,'LineWidth',LineWidth)
hold on 
plot(alphagrid,0*r1grid+1)
set(gca,'LineWidth',LineWidth,'FontSize',FontSize,'FontName',FontName)
xlabel('Risk Aversion \alpha','FontSize',FontSize,'FontName',FontName)
ylabel('One-Period Riskfree Rate r_1','FontSize',FontSize,'FontName',FontName)

figure(2) 
plot(alphagrid,epgrid,'LineWidth',LineWidth)
set(gca,'LineWidth',LineWidth,'FontSize',FontSize,'FontName',FontName)
xlabel('Risk Aversion \alpha','FontSize',FontSize,'FontName',FontName)
ylabel('Equity Premium','FontSize',FontSize,'FontName',FontName)

return 

%  2. Lognormal version  

disp(' ')
disp('Equity premium calculations:  lognormal version') 
disp('---------------------------------------------------------------')

% inputs 
mu_g = 0.0200
sigma_g = 0.0350

beta = 0.99 
alphagrid = [0:1:50]';
lambda = 1;

% asset prices and returns 
q1grid = beta*exp(-alphagrid*mu_g + alphagrid.^2*sigma_g^2/2); 
r1grid = 1./q1grid; 

qegrid = beta*exp((1-alphagrid)*mu_g + (1-alphagrid).^2*sigma_g^2/2); 
Eregrid = exp(mu_g + sigma_g^2/2)./qegrid; 

epgrid = Eregrid - r1grid;
epgrid_alt = (1/beta)*exp(alphagrid*mu_g - alphagrid.^2*sigma_g^2/2).* ...
            (exp(alphagrid*lambda*sigma_g^2)-1);

figure(3) 
plot(alphagrid,r1grid,'LineWidth',LineWidth)
set(gca,'LineWidth',LineWidth,'FontSize',FontSize,'FontName',FontName)
xlabel('Risk Aversion \alpha','FontSize',FontSize,'FontName',FontName)
ylabel('One-Period Riskfree Rate r_1','FontSize',FontSize,'FontName',FontName)

figure(4) 
plot(alphagrid,epgrid_alt,'LineWidth',LineWidth)
%plot(alphagrid,qegrid./q1grid,'LineWidth',LineWidth)
set(gca,'LineWidth',LineWidth,'FontSize',FontSize,'FontName',FontName)
xlabel('Risk Aversion \alpha','FontSize',FontSize,'FontName',FontName)
ylabel('Equity Premium','FontSize',FontSize,'FontName',FontName)
