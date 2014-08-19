"""
Cumulant expansions for normal and Poisson mixtures, univariate and bivariate.
The program is organized in several subprograms (cells) that can/should be run 
separately.
Also some messing around to check syntax.  

Prepared for the NYU Course "Macroeconomic Foundations for Asset Pricing," 
ECO-UB-233.  

Written by Dave Backus @ NYU 
"""
# 
# 1. Compute cumulants symbolically from cumulant generating function
# uses the SymPy library:  http://sympy.org/
# comes automatically with most scientific code distributions 
from sympy import symbols, diff, exp   # subs not needed? 
s, omega, theta, delta = symbols('s omega theta delta')

# cgf formula for Poisson mixture of normals 
cgf = omega*(exp(s*theta+(delta*s)**2/2)-1) 

# crude version 
kappa1 = diff(cgf, s, 1).subs(s, 0)
kappa2 = diff(cgf, s, 2).subs(s, 0)
kappa3 = diff(cgf, s, 3).subs(s, 0)
kappa4 = diff(cgf, s, 4).subs(s, 0)
kappas = [kappa1, kappa2, kappa3, kappa4] 
kappas
type(kappas) 

# using a dictionary to make multiple substitutions 
kappa4 = diff(cgf, s, 4).subs({s: 0, theta: 1})
kappa4

print("or this way")
numbers = {s: 0, theta: 1}
#kappa4 = diff(cgf, s, 4).subs(numbers)
kappa4 = diff(cgf, s, 4).subs(numbers)
kappa4 

#%%
# automated version 
# the n+1 is because range starts at zero 
kappas = [diff(cgf, s, n+1).subs(s, 0) for n in range(8)]
print("44") 
kappas

print("47")
numbers = {s: 0, omega: 2, theta: 1, delta: 1}
kappas = [diff(cgf, s, n+1).subs(numbers) for n in range(8)]
kappas
contribution = [kappas/gamma()]
type(kappas)

#%%

import matplotlib.pyplot as plt 
plt.plot(range(8), kappas)

gamma()


#%%
# http://docs.sympy.org/latest/tutorial/calculus.html

#%%

