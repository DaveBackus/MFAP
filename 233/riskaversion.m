% riskaversion.m
% Find your risk aversion alpha given introspection about your 
% your certainty equivalent
format compact 

% 1. Risk penalty v alpha 
cbar = 150;
sigma = 75;
c1 = cbar - sigma;
c2 = cbar + sigma;

alphagrid = [0.11:0.1:10]';
mu = (0.5*c1.^(1-alphagrid)+0.5*c2.^(1-alphagrid)).^(1./(1-alphagrid)); 
rp = log(cbar./mu);

plot(alphagrid, rp)

%%
% 2. Find your own risk aversion 
c1 = 100;
c2 = 200;
cbar = 150;

mu = 135;           % input from class discussion 
rp = log(cbar/mu)

alpha = 1.75;       % comment: enter number of your choice 
% the answer 
mu_guess = (0.5*c1^(1-alpha)+0.5*c2^(1-alpha))^(1/(1-alpha)) 