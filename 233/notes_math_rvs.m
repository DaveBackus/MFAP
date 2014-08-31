%  notes_math_rvs 
%  Calculations to accompany notes on random variables
%  For:  "Macro-foundations for asset prices"
%  Written by:  Dave Backus, NYU, August 2013 and after 
clear all 
format compact

%%
disp('Poisson probabilities')
j = [0:8]';
jfac = gamma(j+1);

omega = 0.1;
p1 = exp(-omega)*omega.^j./jfac;

omega = 1.5;
p2 = exp(-omega)*omega.^j./jfac;

p = [p1 p2];

clf 
bar(j, p) 
title('Poisson probabilities', 'FontSize', 12)
% color controls, ignore 
cmap = [0 0 1; 1 0 1];
colormap(cmap) 


%%
disp('Normal density functions')
x = [-4:0.1:4]';

mu = 0;
sigma = 1;
p1 = exp(-(x-mu).^2/(2*sigma^2))./sqrt(2*pi*sigma^2);

mu = 0;
sigma = 1.5;
p2 = exp(-(x-mu).^2/(2*sigma^2))./sqrt(2*pi*sigma^2);

clf 
plot(x, p1, 'b', 'LineWidth', 2)
hold on
plot(x, p2, 'm', 'LineWidth', 2)
xlabel('Value of Random Variable x') 
ylabel('Density Function p(x)') 
title('Normal density functions', 'FontSize', 12)


%%
disp('Generating functions')
syms s mu sigma                     % defines these as symbols 

% normal mgf 
mgf = exp(s*mu + (s*sigma)^2/2);
cgf = log(mgf);

disp('raw moments')
% differentiate moment generating function 
mu1p = subs(diff(mgf,s,1),s,0)       % mean
mu2p = subs(diff(mgf,s,2),s,0)       % second moment (why not variance?) 
mu3p = subs(diff(mgf,s,3),s,0)
mu4p = subs(diff(mgf,s,4),s,0)

disp('cumulants ')
% differentiate cumulant generating function 
kappa1 = subs(diff(cgf,s,1),s,0)    % mean
kappa2 = subs(diff(cgf,s,2),s,0)    % variance 
kappa3 = subs(diff(cgf,s,3),s,0)
kappa4 = subs(diff(cgf,s,4),s,0)

disp('skewness and kurtosis')
gamma1 = kappa3/kappa2^(3/2)
gamma2 = kappa4/kappa2^2


%%
disp('More generating functions')
syms s mu sigma                     % defines these as symbols 

cgf_x = s^2/2; 
cgf_y = s*mu + subs(cgf_x, s, s*sigma); 

% differentiate cumulant generating function 
kappa1 = subs(diff(cgf_y,s,1),s,0)  % mean
kappa2 = subs(diff(cgf_y,s,2),s,0)  % variance 


%%
% 3-state moments 
syms s omega delta % defines these as symbols 

mgf = omega*(exp(-s*delta)+exp(s*delta)) + (1-2*omega);
cgf = log(mgf);

disp(' ')
kappa1 = subs(diff(cgf,s,1),s,0)    % mean
kappa2 = subs(diff(cgf,s,2),s,0)    % variance 
kappa3 = subs(diff(cgf,s,3),s,0)
factor(kappa3)  % sometimes this cleans up the expression; see also simplify
kappa4 = subs(diff(cgf,s,4),s,0)
factor(kappa4)

disp(' ')
gamma1 = kappa3/kappa2^(3/2)
gamma2 = kappa4/kappa2^2
simplify(gamma2)


%%
disp('Gram-Charlier examples of skewness and kurtosis')

% arbitrary state grid 
zmax = 4; dz = 0.1; 
z = [-zmax:dz:zmax]';

% skewness and (excess) kurtosis
gamma1 = 1
gamma2 = 0.0 

% Gram-Charlier distribution (normal if gamma1 = gamma2 = 0) 
p1 = exp(-z.^2/2)*dz/sqrt(2*pi);       
p2 = gamma1.*p1.*(z.^3-3*z)/6;
p3 = gamma2.*p1.*(z.^4-6*z.^2+3)/24;  
p = p1+p2+p3;
checkprobssum2one = sum(p)

subplot(3,1,1), bar(z,p,'b')
title('distribution')
subplot(3,1,2), bar(z,p2,'b')
title('skewness')
subplot(3,1,3), bar(z,p3,'b')
title('kurtosis')


%% 
disp('Normal mixture pictures')
% arbitrary state grid 
zmax = 4; dz = 0.1; 
z = [-zmax:dz:zmax]';

% standard normal N(0,1)
p1 = exp(-z.^2/2)*dz/sqrt(2*pi);
checksump = sum(p1)
p1 = p1/sum(p1);

% different normal N(theta,delta)
theta = -1
delta = 2 
p2 = exp(-(z-theta).^2/(2*delta))*dz/sqrt(2*pi*delta);
checksump = sum(p2)
p2 = p2/sum(p2);

% mixture 
omega = 0.5
p = (1-omega)*p1 + omega*p2;

figure(1)
subplot(3,1,1), bar(z,p1,'b')
subplot(3,1,2), bar(z,p2,'r')
subplot(3,1,3), bar(z,p,'m')
title('Two Normal distributions and their mixture')


%%
% practice problems

disp('Practice: sample moments') 
x = [2,-1,4,3]'
%
mu1p = sum(x)/4
mu2p = sum(x.^2)/4
%
meanx = mu1p
varx = mu2p - mu1p^2
varx_alt = sum((x-mu1p).^2)/4

stddev = sqrt(varx)

%%
disp('Practice: multivariate sample moments')  
x = [2,-1,4,3]'
y = [10, -5, 3, 0]'

xbar = mean(x)
ybar = mean(y) 

varx = mean((x-xbar).^2) 
vary = mean((y-ybar).^2) 
covxy = mean((x-xbar).*(y-ybar))
corrxy = covxy/sqrt(varx*vary)


%%
% Bernoulli mixture of normals
syms s theta omega delta % defines these as symbols 

theta = 0;
%delta = 1;
mgf = (1-omega)*exp(s^2/2) + omega*exp(theta*s + delta*s^2/2);
cgf = log(mgf);

disp(' ')
kappa1 = subs(diff(cgf,s,1),s,0)    % mean
kappa2 = subs(diff(cgf,s,2),s,0)    % variance 
kappa3 = subs(diff(cgf,s,3),s,0)
factor(kappa3)  % sometimes this cleans up the expression; see also simplify
kappa4 = subs(diff(cgf,s,4),s,0)
factor(kappa4)

disp(' ')
gamma1 = kappa3/kappa2^(3/2)
gamma2 = kappa4/kappa2^2
simplify(gamma2)

subs(gamma2, [omega delta], [0.05 4])

% plot 
x = [-4:0.1:4]';
p1 = exp(-x.^2/2)./sqrt(2*pi);

mu = -2; sigma = 1;
p2 = exp(-(x-mu).^2/(2*sigma^2))./sqrt(2*pi*sigma^2);
omega = 0.2;
pmix = (1-omega)*p1 + omega*p2;

plot(x,p1,'b')
hold on
plot(x,pmix,'m')
text(0.4, 0.38, 'blue=std normal, magenta=mixture') 


