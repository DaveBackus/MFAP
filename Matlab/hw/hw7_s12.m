%  hw7_s12.m 
%  Matlab program for Lab Report #7, Spring 2012 
%  NYU course ECON-UB 233, Macro foundations for asset pricing, Apr 2012.  
%  Written by:  Dave Backus, March 2012 
disp('Answers to Lab Report 7') 
format compact
format short 
clear all
clf

%%
disp(' ')
disp('------------------------------------------------------------')
disp('Question 1 (properties of long and short rates)') 

disp(' ')
disp('Data input from spreadsheet') 
data = xlsread('fed_yield_data.xlsx');

y3m = data(:,1);
y10y = data(:,2);

disp(' ')
disp('Mean and Std Dev')
mean(data)
std(data)

disp(' ')
disp('Compute acfs')
nlag = 40;
lags = [0:nlag]';
acf_3m = acf(y3m,nlag);
acf_10y = acf(y10y,nlag);
acf = [acf_3m(2) acf_10y(2)]

%  approximate with AR(1)s
acf_3m_ar1 = acf_3m(2).^lags;
acf_10y_ar1 = acf_10y(2).^lags;

figure(1)
FontSize = 12;
FontName = 'Helvetica';  % or 'Times' 
LineWidth = 1.5;

plot(lags,acf_3m,'b','LineWidth',LineWidth)
hold on 
plot(lags,acf_3m_ar1,'b--','LineWidth',LineWidth)
plot(lags,acf_10y,'m','LineWidth',LineWidth)
plot(lags,acf_10y_ar1,'m--','LineWidth',LineWidth)
xlabel('Lag in Months','FontSize',FontSize,'FontName',FontName)
ylabel('Autocorrelation Function','FontSize',FontSize,'FontName',FontName)
text(2,0.2,'blue is 3m, magenta is 10y','FontSize',FontSize,'FontName',FontName)
text(2,0.16,'solid is estimated acf, dashed is AR(1) extrapolation','FontSize',FontSize,'FontName',FontName)
set(gca,'LineWidth',1,'FontSize',FontSize,'FontName',FontName)

print -depsc hw7_q1ab.eps


%%
format compact 
disp(' ')
disp('------------------------------------------------------------')
disp('Question 2 (2-state Markov chain)') 
syms omega phi P

Pstar = [omega 1-omega; omega 1-omega]
P = (1-phi)*Pstar + phi*eye(2);

simplify(Pstar^2) 
simplify(P^2) 

eig(P)
simplify(Pstar^2) 


return

