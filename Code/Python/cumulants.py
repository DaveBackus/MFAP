"""
Cumulant expansions for Poisson mixtures of normals, a useful framework for
generating nonnormal behavior.  Here we look at some simple mixtures, compute
the cumulant generating function symbolically using SymPy, and compute 
cumulants from it derivatives.  All automated.  

The program is organized in several subprograms (cells) that can be run 
separately.  There's also some messing around as I experiment with syntax. 

Prepared for the NYU Course "Macroeconomic Foundations for Asset Prices," 
ECO-UB-233.  More at
* https://sites.google.com/site/nyusternmacrofoundations/home
* https://github.com/DaveBackus/MFAP

References
* sympy:  http://sympy.org/
* subs:  http://docs.sympy.org/latest/modules/core.html#sympy.core.basic.Basic.subs

Written by Dave Backus @ NYU 
"""
# 
# 1. Compute cumulants from cgf 
from sympy import symbols, diff, exp   
s, omega, theta, delta = symbols('s omega theta delta')

# cgf formula for Poisson mixture of normals 
cgf = omega*(exp(s*theta+(delta*s)**2/2)-1) 

"""
# manual version 
kappa1 = diff(cgf, s, 1).subs(s, 0)
kappa2 = diff(cgf, s, 2).subs(s, 0)
kappa3 = diff(cgf, s, 3).subs(s, 0)
kappa4 = diff(cgf, s, 4).subs(s, 0)
kappas = [kappa1, kappa2, kappa3, kappa4] 
type(kappas) 
print(kappas)

# using a dictionary to make multiple substitutions 
kappa4 = diff(cgf, s, 4).subs({s: 0, theta: 1})
numbers = {s: 0, theta: 1}
kappa4 = diff(cgf, s, 4).subs(numbers)

gamma1 = kappa3/kappa2**(3/2) 
gamma2 = kappa3/kappa2**2
print([gamma1, gamma2]) 
"""

# automated version 
# the n+1 is because range starts at zero 
print("\nCumulant formulas") 
ncums = list(range(4))
kappas = [diff(cgf, s, n+1).subs(s, 0) for n in ncums]  # n+1 due to range
[print(kappa) for kappa in kappas]

par_values = {omega: 0.5, theta: 0, delta: 0.15} 
kappas_values = [kappas[n].subs(par_values) for n in range(len(kappas))]
print("\nCumulant values followed by skewness and excess kurtosis") 
#[print(kappa) for kappa in kappas_values]
print(kappas_values)
gamma1 = float(kappas_values[2]/kappas_values[1]**(3/2))
gamma2 = float(kappas_values[3]/kappas_values[1]**2)
print([gamma1, gamma2]) 

#%%
print("contributions")
from scipy.special import gamma 
numbers = {s: 0, omega: 2, theta: -3, delta: 2}
kappas = [diff(cgf, s, n+1).subs(numbers) for n in range(8)]
#factorials = [gamma(n+2) for n in range(8)]
contributions = [diff(cgf, s, n+1).subs(numbers)/gamma(n+2) for n in range(8)]

print(kappas)
print(contributions)

#contributions = [kappas(n)/factorials(n) for n in range(8)]
#contributions = [kappas/factorials for n in zip(kappas,factorials)]

#%%

#from matplotlib import plot, show 
import matplotlib.pyplot as plt
#plt.plot(range(8), kappas)
plt.bar(range(8), contributions)

#%%
# http://docs.sympy.org/latest/tutorial/calculus.html

#%%
for i in range(2,5):
    print(i) 
