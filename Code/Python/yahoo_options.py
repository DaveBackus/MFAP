"""
Messing around with Yahoo options data. 
WARNING:  WORK IN PROGRESS, NEEDS HELP!!!
Also:  the pandas guide to this is fuzzy, incomplete 

Prepared for the NYU Course "Macroeconomic Foundations for Asset Prices," 
ECO-UB-233.  More at
* https://sites.google.com/site/nyusternmacrofoundations/home
* https://github.com/DaveBackus/MFAP

References 
* http://finance.yahoo.com/q/op?s=SPY+Options
* http://pandas.pydata.org/pandas-docs/stable/remote_data.html#yahoo-finance
* http://pandas.pydata.org/pandas-docs/stable/remote_data.html#yahoo-finance-options

Written by Dave Backus @ NYU, August 2014  
Created with Python 3.4 
"""
import pandas.io.data as web
from pandas.io.data import Options
import datetime as dt 

import matplotlib as mpl
mpl.rcParams['figure.figsize'] = 6, 4.5  # default is 6, 4
mpl.rcParams['legend.fontsize'] = 10  
mpl.rcParams['legend.labelspacing'] = 0.25
mpl.rcParams['legend.handlelength'] = 3

import matplotlib.pylab as plt

"""
1. Read in Yahoo stock and options prices for SPY (SP 500 "Spyders")  
"""
ticker = 'spy' 

# get stock price first (most recent date) 
start = dt.datetime(2014, 8, 1)     
today = dt.datetime(2014, 8, 29)

stock = web.DataReader(ticker, 'yahoo', today) 
# take last close 
atm = stock.ix[-1,'Close']  # last obs 

# get option prices for same ticker 
option = Options(ticker, 'yahoo')
expiry = dt.date(2014, 11, 20)
data_calls = option.get_call_data(expiry=expiry)
data_puts  = option.get_put_data(expiry=expiry)

# plot puts v strike, call v strike
calls_bid = data_calls['Bid']
calls_ask = data_calls['Ask'] 

calls_strikes = data_calls['Strike']
calls_mid = (data_calls['Bid'] + data_calls['Ask'])/2
puts_strikes = data_puts['Strike']
puts_mid = (data_puts['Bid'] + data_puts['Ask'])/2

plt.plot(calls_strikes, calls_mid, 'r', lw=2, label='calls')
#plt.plot(calls_strikes, calls_ask, 'r', lw=2, label='calls ask')
plt.plot(puts_strikes, puts_mid, 'b', lw=2, label='puts')
plt.axis([120, 250, 0, 50])
plt.axvline(x=atm, color='k', linestyle='--', label='ATM')               
plt.legend(loc='upperleft')

# check put-call parity:  plot bid ask call v call from parity
#%%

"""
2. Implied volatilities 
"""

# BSM formula...

# merge by strike ??