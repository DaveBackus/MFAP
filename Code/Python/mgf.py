#!/usr/bin/python
# coding: utf-8
# generating function example with sympy
# Written by:  Paul Backus, April 2014 

# Import sympy module
from sympy import *

# Create symbol objects and assign them to python variables
# The string can be anything; it determines how the symbol will appear when
# python prints it as part of a symbolic expression
s = Symbol("s")
mu = Symbol("μ")
sigma = Symbol("σ")

# You can create multiple symbols in one line with the 'symbols' function
s, mu, sigma = symbols("s μ σ")

# Moment generating function for a Gaussian random variable
# Once you've defined your variables as symbols, any expression that uses
# them will be treated symbolically
mgf = exp(mu*s + (sigma*s)**2/2)

# Now we can calculate moments by differentiating mgf and substituting s = 0
# 'diff(f, s)' differentiates the symbolic expression f with respect to the
# symbol s
# 'expr.subs(s, v)' substitutes the value v for the symbol s in expr; v can be
# a number, a symbol, or even another expression
mean = diff(mgf, s).subs(s, 0)
# This should print 'μ'
print "The mean is ", mean

# To calculate moments about the mean, it's easier to use the cumulant
# generating function, which is the log of the mgf
cgf = log(mgf)

# Calculate and print the variance; this should print 'σ**2'
# The third argument to diff tells sympy to take the second derivative
variance = diff(cgf, s, 2).subs(s, 0)
print "The variance is:", variance
