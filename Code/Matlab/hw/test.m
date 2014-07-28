%  test.m 
format compact 
clear all 

%%
% checking log exp in Matlab (doesn't simplify) 
syms s x1 x2 

cgf1 = log(exp(s*x1)*exp(s*x2))
cgf2 = log(exp(s*x1))+log(exp(s*x2))

checkzero = cgf1 - cgf2

f = log(exp(s))
f = simple(simple(f)) 
fp = diff(f,s)

%%  

syms s kappa1 kappa2 real 
mgf = exp(kappa1*s + kappa2*s^2/2) 
cgf = log(mgf)
cgf = simple(simple(cgf));
cgf

%%
% normal mixture 

syms omega delta s
mgf=(1-omega)*exp(s^2/2)+omega*exp(delta*s^2/2)
cgf=log(mgf);
kappa1 = subs(diff(mgf,s,1),s,0)
kappa2=subs(diff(cgf,s,2),s,0)
kappa3=subs(diff(cgf,s,3),s,0)
kappa4=subs(diff(cgf,s,4),s,0)
gamma1=(kappa3)/(kappa2)^(3/2)
gamma2=(kappa4)/(kappa2)^2
