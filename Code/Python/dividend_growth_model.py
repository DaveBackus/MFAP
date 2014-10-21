"""
Calculations of dividend growth model (aka Gordon growth model):  p = d/(r-g).
Verify convexity of price in growth rate.    

Prepared for the NYU Course "Macroeconomic Foundations for Asset Prices," 
ECO-UB-233.  More at
* https://sites.google.com/site/nyusternmacrofoundations/home
* https://github.com/DaveBackus/MFAP

Reference
* http://en.wikipedia.org/wiki/Dividend_discount_model 

Written by Dave Backus @ NYU, October 2014 
Created with Python 3.4 
"""
import matplotlib.pyplot as plt
import numpy as np
#from scipy.stats import norm 

# generate 3 normal pdf's 
g = np.linspace(0.01, 0.10, 11)      # grid for random variable x 

d = 1
r = 0.15 
p = 1/(r-g)

# basic plot a la Matlab 
plt.plot(g, p, 'b', lw=2)
plt.show()

