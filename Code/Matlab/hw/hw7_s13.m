%  hw7_s13.m 
%  Matlab program for Lab Report #7, Spring 2013 
%  NYU course ECON-UB 233, Macro foundations for asset pricing.  
%  Written by:  Dave Backus
disp('Answers to Lab Report 7') 
format compact 
format short  
clear all 

%%
disp(' ')
disp('------------------------------------------------------------')
disp('Question 1 (e)') 
disp('Are eigenvalues stable?') 

% this is a linear algebra version of (e) 
% it's a vector AR with autoregressive matrix A 
% to be stable, we need all its eigenvalues to be less than one in abs val
phi1 = 1.2;
phi2 = 0.1
A = [phi1 phi2; 1 0]

eigs = eig(A)
abs(eigs)

%%
disp(' ')
disp('------------------------------------------------------------')
disp('Question 2 (properties of long and short rates)') 

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
acfs = [acf_3m(2) acf_10y(2)]

%  approximate with AR(1)s
acf_3m_ar1 = acf_3m(2).^lags;
acf_10y_ar1 = acf_10y(2).^lags;

figure(1)
clf
FontSize = 12;
FontName = 'Helvetica';  % or 'Times' 
LineWidth = 1.5;

plot(lags,acf_3m,'b','LineWidth',LineWidth)
hold on 
plot(lags,acf_3m_ar1,'b--','LineWidth',LineWidth)
plot(lags,acf_10y,'m','LineWidth',LineWidth)
plot(lags,acf_10y_ar1,'m--','LineWidth',LineWidth)
xlabel('Lag k in Months','FontSize',FontSize,'FontName',FontName)
ylabel('Autocorrelation Function','FontSize',FontSize,'FontName',FontName)
text(2,0.34,'blue is 3m, magenta is 10y','FontSize',FontSize,'FontName',FontName)
text(2,0.3,'solid is estimated acf, dashed is AR(1) extrapolation','FontSize',FontSize,'FontName',FontName)
set(gca,'LineWidth',1,'FontSize',FontSize,'FontName',FontName)

print -dpdf hw7_q2.pdf


%%

return

