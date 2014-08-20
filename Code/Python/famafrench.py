"""
Calculations with Fama-French equity return data: 
* xs = excess return on market 
* smb = small minus big portfolio 
* hml = high minus low book to market 
* rf = riskfree rate (so market = xs + rf)
All series are percentages, not annualized.

Prepared for the NYU Course "Macroeconomic Foundations for Asset Prices," 
ECO-UB-233.  More at
* https://sites.google.com/site/nyusternmacrofoundations/home
* https://github.com/DaveBackus/MFAP

References
* http://mba.tuck.dartmouth.edu/pages/faculty/ken.french/data_library.html#Research
* http://quant-econ.net/pandas.html
* http://pandas.pydata.org/pandas-docs/dev/remote_data.html 
* http://pandas.pydata.org/pandas-docs/dev/remote_data.html#fama-french

Written by Dave Backus @ NYU 
"""

# 1. Read data from Ken French's website (built into Pandas)
import pandas.io.data as web

ff = web.DataReader("F-F_Research_Data_Factors", "famafrench")[0] 
ff.columns = ['xs', 'smb', 'hml', 'rf']

print(ff.describe())
print(ff.kurtosis())
print(ff.skew())



