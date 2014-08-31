"""
Calculations to accompany notes on random variables.
Basic Python version, not as extensive as the Matlab version.  

Prepared for the NYU Course "Macroeconomic Foundations for Asset Prices," 
ECO-UB-233.  More at
* https://sites.google.com/site/nyusternmacrofoundations/home
* https://github.com/DaveBackus/MFAP

Written by Dave Backus @ NYU, August 2014 
Created with Python 3.4 
"""
""" 
1. Plot normal pdf's 
Reference
* http://quant-econ.net/matplotlib.html
"""
import matplotlib.pyplot as plt
import numpy as np
from scipy.stats import norm 

# generate 3 normal pdf's 
x = np.linspace(-4.25, 4.25, 150)     # grid for random variable x 
p1 = norm.pdf(x, loc=0, scale=1)    # std normal:  mean=0, variance=1 
p2 = norm.pdf(x, loc=0, scale=1.5)  # increase variance to 1.5
p3 = norm.pdf(x, loc=1, scale=1)    # change mean to 1

# basic plot a la Matlab 
plt.plot(x, p1, 'r', lw=2)
plt.plot(x, p2, 'b', lw=2)
plt.plot(x, p3, 'm', lw=2)

# another version 
fig, ax = plt.subplots() 
ax.plot(x, p1, 'r', lw=2, label='std normal')
ax.plot(x, p2, 'b', lw=2, label='larger variance')
ax.plot(x, p3, 'm--', lw=2, label='larger mean')
ax.legend(loc='upper left')
plt.show()

#%%     
"""
2. Compute cumulants from cgf (cgf is a Poisson mixture of normals)
References
* sympy:  http://sympy.org/
* subs:  http://docs.sympy.org/latest/modules/core.html#sympy.core.basic.Basic.subs
"""
from sympy import symbols, diff, exp   
s, omega, theta, delta = symbols('s omega theta delta')

# cgf formula for Poisson mixture of normals 
cgf = omega*(exp(s*theta+(delta*s)**2/2)-1) 

# manual version 
kappa1 = diff(cgf, s, 1).subs(s, 0)
kappa2 = diff(cgf, s, 2).subs(s, 0)
kappa3 = diff(cgf, s, 3).subs(s, 0)
kappa4 = diff(cgf, s, 4).subs(s, 0)
kappas = [kappa1, kappa2, kappa3, kappa4] 
type(kappas) 
print('\nCumulants') 
[print(kappa) for kappa in kappas]
 
gammas = [kappa3/kappa2**(3/2), kappa3/kappa2**2] 
print('\nSkewness and excess kurtosis') 
[print(gamma) for gamma in gammas]

# automated version 
ncums = list(range(4))
kappas = [diff(cgf, s, n+1).subs(s, 0) for n in ncums]  # n+1 due to range
print("\nCumulant formulas (automated)") 
[print(kappa) for kappa in kappas]

# set parameter values in a dictionary 
par_values = {omega: 0.5, theta: 0, delta: 0.15} 
kappas_values = [kappas[n].subs(par_values) for n in range(len(kappas))]
print('\nCumulant values followed by skewness and excess kurtosis') 
print(kappas_values)
gamma1 = float(kappas_values[2]/kappas_values[1]**(3/2))
gamma2 = float(kappas_values[3]/kappas_values[1]**2)
print([gamma1, gamma2]) 

