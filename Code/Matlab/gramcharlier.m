%  gramcharlier.m
%  Gram-Charlier calculations:  polynomials, generating functions, expansions 
%  Written by:  Dave Backus, June 2004.  
format compact
clear all

syms f x fgc gamma1 gamma2 mu sig t
g1 = gamma1;
g2 = gamma2;
disp('***************************************************************')
disp('Gram-Charlier polynomials') 
f = exp(-x^2/2) %/(2*pi)^(1/2);
f1 = diff(f,x);
f2 = diff(f1,x);
f3 = diff(f2,x);
f4 = diff(f3,x);

p1 = simplify(f1/f)
p2 = simplify(f2/f)
p3 = simplify(f3/f)
p4 = simplify(f4/f)

factor(p2)
factor(p3)
factor(p4)

disp(' ')
disp('***************************************************************')
disp('Gram-Charlier integrals (note extra sqrt(2pi))') 
disp('Warning:  this is slow...') 
fgc = f*(1 - g1*p3/6 + g2*p4/24);
mu = 0; sig = 1;
int1 = int(exp(t*(mu+sig*x))*fgc,x,-inf,inf)
disp(' ')
disp('Moment and cumulant generating functions') 
mgf = simplify(int1)
cgf = log(mgf)

disp(' ')
disp('Expansion of moment generating function') 
mgfexp = taylor(mgf,t,5,0);
mu1 = taylor(mgf,t,2,0) - taylor(mgf,t,1,0)
mu2 = taylor(mgf,t,3,0) - taylor(mgf,t,2,0)
mu3 = taylor(mgf,t,4,0) - taylor(mgf,t,3,0)
mu4 = taylor(mgf,t,5,0) - taylor(mgf,t,4,0);
mu4 = simplify(mu4)

disp(' ')
disp('Expansion of cumulant generating function') 
cgfexp = taylor(cgf,t,5,0)
kappa1 = taylor(cgf,t,2,0) - taylor(cgf,t,1,0)
kappa2 = taylor(cgf,t,3,0) - taylor(cgf,t,2,0)
kappa3 = simplify(taylor(cgf,t,4,0) - taylor(cgf,t,3,0))
kappa4 = simplify(taylor(cgf,t,5,0) - taylor(cgf,t,4,0))

return 