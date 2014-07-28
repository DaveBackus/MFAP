%  Shiller_data.m 
%  Properties of returns and consumption growth using Shiller's long data 
%  set:  http://www.econ.yale.edu/~shiller/data.htm   
%  Data read from data sheet from Shiller and updated, headings at top
%  NB:  in his data, prices and rates are start of period, returns and 
%  growth rates are forward looking (see monthly version for comparison). 
%  Material originally used in Backus, Chernov, and Martin, "Disasters," 
%  JF, 2011.  
%  Adapted for NYU course ECON-UB 233, Macro foundations for asset pricing.  
%  Written:  February 2009 and after
format compact
clear all
close all

disp(' ')
disp('Properties of Shiller data') 
disp('---------------------------------------------------------------')

%  1. Data input 
%%

data = xlsread('Shiller_data.xls','DKB_data_new');

%return

%  2. Statistics 

[nobs,nvar] = size(data);
year = data(:,1);
logr1 = log(data(:,8));
logre = data(:,14);
logxr = logre - logr1;
r1 = exp(logr1);
re = exp(logre);
xr = re - r1;
cons = data(:,9);
g = 0*cons;
g(1:nobs-1) = cons(2:nobs)./cons(1:nobs-1);
logg = log(g);

date1 = find(year==1889);
date2 = find(year==1986);
date3 = find(year==2009);
longdates = [date1:date3]';
shortdates = [date2:date3]';

%data_short = newdata(shortdates,:);
%year_long = year(longdates,:);

disp(' ')
disp('Levels')
disp('Variables (g r1 re xr)')
disp('Stats (mean, std, skew, kurt)')
disp('Long sample (1889-2009)') 
newdata = [g r1 re xr];
data_long = newdata(longdates,:);
stats_long = [mean(data_long); std(data_long); skewness(data_long); kurtosis(data_long)-3]' 

disp(' ')
SharpeRatio = stats_long(4,1)/stats_long(4,2)

disp(' ')
disp('Logs') 
disp('Variables (logg logr1 logre logxr)')
disp('Stats (mean, std, skew, kurt)')
disp('Long sample (1889-2009)') 
newdata = [logg logr1 logre logxr];
data_long = newdata(longdates,:);
stats_long = [mean(data_long); std(data_long); skewness(data_long); kurtosis(data_long)-3]' 

%disp(' ')
%ApproxLevelre = exp(stats_long(3,1)+stats_long(3,2)^2/2) 

%disp('Short sample') 
%stats_short = [mean(data_short); std(data_short); skewness(data_short); kurtosis(data_short)-3; acf(data_short,1)]' 


%  3. Graph excess return and consumption growth 
%%

FontSize = 14;
FontName = 'Helvetica';  % or 'Times' 
LineWidth = 2;

figure(1) 
plot(data_long(:,1),data_long(:,4),'LineWidth',1,'Color','k','Linestyle','o')
hold on
plot(data_long(:,1),data_long(:,4),'LineWidth',LineWidth,'Color','k','Linestyle','*')
set(gca,'LineWidth',1.5,'FontSize',FontSize,'FontName',FontName)
axis([-0.125 0.125 -0.7 0.7]) 
line([0; 0],[-0.7, 0.7])
line([-0.125;0.125],[0; 0])
%text(-0.092,-0.58,'1931','FontSize',FontSize,'FontName',FontName)
xlabel('Log Consumption Growth','FontSize',FontSize,'FontName',FontName)
ylabel('Log Excess Return on Equity','FontSize',FontSize,'FontName',FontName)

print -depsc scatter_gxr.eps
print -dpdf  scatter_gxr.pdf

return 

