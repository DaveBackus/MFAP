%  moments.m
%  Use mgf to compute moments, and cgf to compute cumulants 
format compact

syms s omega mu sigma

%mgf = 1-omega + omega*exp(s)
mgf = exp(mu*s + (sigma*s)^2/2)

mom1 = subs(diff(mgf,s,1),s,0)
mom2 = subs(diff(mgf,s,2),s,0)
mom3 = subs(diff(mgf,s,3),s,0)
mom4 = subs(diff(mgf,s,4),s,0)

cgf = log(mgf)

cum1 = subs(diff(cgf,s,1),s,0)
cum2 = subs(diff(cgf,s,2),s,0)
cum3 = subs(diff(cgf,s,3),s,0)
cum4 = subs(diff(cgf,s,4),s,0)


