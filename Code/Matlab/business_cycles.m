% business_cycles.m 
% Properties of macro-finance data:  macro indicators, asset prices/returns
% Quarterly data constructed from averages of finer intervals via FRED 
% Graph collection in FRED:  MFAP -> quarterly 
% DATE, GDPC96, PCECC96, SP500, INDPRO, PAYEMS, FEDFUNDS, GS10, PCECTPI
% NYU course ECON-UB 233, Macro foundations for asset pricing.  
% Written by:  Dave Backus, March 2012 and after 
%%
format compact 
clear all
close all

disp(' ') 
disp('Properties of macro-finance data') 
disp('---------------------------------------------------------------')
disp(' ') 
disp('0. Data input') 

data = xlsread('FRED_qtrly.xls','edited');
[nobs,nvars] = size(data);
nobs
nvars
dates = 1960 - 1/8 + [1:nobs]/4;

levels = log(data(:,[1:5 8]));
rates = data(:,6:7);

% growth rates 
gq = 400*diff(levels,1);
gyoy = 100*(levels(5:end,:)-levels(1:end-4,:));

%%
disp(' ')
disp('1. Autocorrelation functions')

nlags = 12;
acf_gdp_yoy = acf(gyoy(:,1),nlags);
acf_gdp = acf(gq(:,1),nlags);
acf_con = acf(gq(:,2),nlags);
acf_sp500 = acf(gq(:,3),nlags);
acf_rfed = acf(rates(:,1),nlags);
acf_rg10 = acf(rates(:,2),nlags);
acf_pce = acf(gq(:,6),nlags);

figure(1)
plot([0:nlags]',acf_gdp,'b','LineWidth',2)
grid on
title('GDP Growth') 
xlabel('Lag in quarters')
ylabel('Autocorrelation') 

pause  

%{
clf 
figure(1) 
plot([0:nlags]',acf_gdp_yoy,'b','LineWidth',2)
grid on
title('GDP Growth:  Year-on-Year') 
xlabel('Lag in quarters')
ylabel('Autocorrelation') 

pause 

clf
plot([0:nlags]',acf_sp500,'b','LineWidth',2)
grid on
title('S&P 500') 
xlabel('Lag in quarters')
ylabel('Autocorrelation') 

pause 
%}

clf
plot([0:nlags]',acf_rfed,'b','LineWidth',2)
grid on
title('Fed Funds Rate') 
xlabel('Lag in quarters')
ylabel('Autocorrelation') 

pause 

clf
plot([0:nlags]',acf_rg10,'b','LineWidth',2)
grid on
title('10-Year Treasury') 
xlabel('Lag in quarters')
ylabel('Autocorrelation') 

pause 

clf
plot([0:nlags]',acf_pce,'b','LineWidth',2)
grid on
title('Inflation') 
xlabel('Lag in quarters')
ylabel('Autocorrelation') 

%return 


%%
disp(' ')
disp('2. Cross-correlation functions')

nlags = 12;
ccf_yy = ccf(gq(:,1),gq(:,1),nlags);

figure(1)
clf
bar([-nlags:nlags]',ccf_yy,'b','LineWidth',2)
grid on
axis([-12 12 -1 1])
title('GDP growth with itself') 
xlabel('Lag in quarters')
ylabel('Cross-correlation') 

pause 

ccf_ysp = ccf(gq(:,3),gq(:,1),nlags);

clf
bar([-nlags:nlags]',ccf_ysp,'b','LineWidth',2)
grid on
axis([-12 12 -1 1])
title('GDP and SP500') 
xlabel('Lag in quarters')
ylabel('Cross-correlation') 

pause 

ccf_ysp_yoy = ccf(gyoy(:,3),gyoy(:,1),nlags);

clf
bar([-nlags:nlags]',ccf_ysp_yoy,'b','LineWidth',2)
grid on
axis([-12 12 -1 1])
title('GDP and SP500') 
xlabel('Lag in quarters')
ylabel('Cross-correlation') 

pause 

ccf_yts = ccf(rates(2:nobs,2)-rates(2:nobs,1),gq(:,1),nlags);

clf
bar([-nlags:nlags]',ccf_yts,'b','LineWidth',2)
grid on
axis([-12 12 -1 1])
title('GDP and Term Spread') 
xlabel('Lag in quarters')
ylabel('Cross-correlation') 

pause 

ccf_yrf = ccf(rates(2:nobs,1),gq(:,1),nlags);

clf
bar([-nlags:nlags]',ccf_yrf,'b','LineWidth',2)
grid on
axis([-12 12 -1 1])
title('GDP and Fed Funds') 
xlabel('Lag in quarters')
ylabel('Cross-correlation') 

pause 

ccf_yr10 = ccf(rates(2:nobs,2),gq(:,1),nlags);

clf
bar([-nlags:nlags]',ccf_yr10,'b','LineWidth',2)
grid on
axis([-12 12 -1 1])
title('GDP and 10-Year Treasury') 
xlabel('Lag in quarters')
ylabel('Cross-correlation') 

return 