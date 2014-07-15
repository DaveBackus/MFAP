%  test_ccf.m 
%  Test ccf function 
%  Written by:  Dave Backus, March 2012 and after 
%%
format compact 
clear all
close all

disp(' ') 
disp('CCF test') 
disp('---------------------------------------------------------------')

data = [1, 5, 3, 2, -1, 7; 5, 2, 3, 1, 6, 7]'

x = data(:,1);
y = data(:,2);
n = length(x)

mean(x)
mean(y)

xdev = x-mean(x);
ydev = y-mean(y);

gamma0 = sum(xdev.*ydev)
denom = sqrt(sum(xdev.^2)*sum(ydev.^2))
rho0 = gamma0/denom

[xdev(1:n-1)+mean(x) ydev(2:n)+mean(y)] 
[xdev(1:n-1) ydev(2:n)] 

gammam1 = sum(xdev(1:n-1).*ydev(2:n))
rhom1 = gammam1/denom

gamma1 = sum(ydev(1:n-1).*xdev(2:n))
rho1 = gamma1/denom

return 

nlags = 2;
rho_acf = acf(x, nlags)
rho_ccf = ccf(x, y, nlags)
rho_ccf = ccf(y, x, nlags)

return 