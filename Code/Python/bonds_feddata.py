"""
Calculations with the Gurkaynak, Sack, and Wright interest rate data from 
the Fed.  They estimate a smooth forward rate curve and post its parameters. 
We take the parameter values and reconstruct log bond prices for an arbitrary
set of maturities and use them to 
* Construct an animation of bond yields
* Run forecasating regressions.  
Two versions, standard bonds and inflation-protected bonds (TIPS)  

Prepared for the NYU Course "Macroeconomic Foundations for Asset Prices," 
ECO-UB-233.  More at
* https://sites.google.com/site/nyusternmacrofoundations/home
* https://github.com/DaveBackus/MFAP

References
* http://www.federalreserve.gov/pubs/feds/2006/200628/200628abs.html
* http://www.federalreserve.gov/pubs/feds/2008/200805/200805abs.html

??
* http://quant-econ.net/pandas.html
* http://pandas.pydata.org/pandas-docs/dev/remote_data.html#fama-french
* http://pandas.pydata.org/pandas-docs/stable/10min.html#selection 

Written by Sarah Beckett-Hile for Dave Backus, September 2014  
Created with Python 3.4 
"""

