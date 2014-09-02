"""
Messing around with Google finance. 

Prepared for the NYU Course "Macroeconomic Foundations for Asset Prices," 
ECO-UB-233.  More at
* https://sites.google.com/site/nyusternmacrofoundations/home
* https://github.com/DaveBackus/MFAP

References 
* https://www.google.com/finance
* http://pandas.pydata.org/pandas-docs/stable/remote_data.html#google-finance

Written by Dave Backus @ NYU, August 2014  
Created with Python 3.4 
"""
import pandas.io.data as web
import datetime as dt 

import matplotlib as mpl
mpl.rcParams['figure.figsize'] = 6, 4.5  # default is 6, 4
mpl.rcParams['legend.fontsize'] = 10  
mpl.rcParams['legend.labelspacing'] = 0.25
mpl.rcParams['legend.handlelength'] = 3

import matplotlib.pylab as plt

"""
1. Read in Google stock prices   
"""
ticker = 'spy' 

# get stock price first (most recent date) 
start = dt.datetime(2008, 8, 1)     
today = dt.datetime(2014, 8, 29)

stock = web.DataReader(ticker, 'google', start) 

stock.tail()

#%%
# OLD PLOTS FROM ANOTHER PROGRAM
plt.plot(calls_strikes, calls_mid, 'r', lw=2, label='calls')
#plt.plot(calls_strikes, calls_ask, 'r', lw=2, label='calls ask')
plt.plot(puts_strikes, puts_mid, 'b', lw=2, label='puts')
plt.axis([120, 250, 0, 50])
plt.axvline(x=atm, color='k', linestyle='--', lw=2, label='atm')
plt.xlabel('Strike')               
plt.ylabel('Option Price')
plt.legend(loc='upperleft')

