This project creates a simple GUI to visualize the distribution of COVID-19 
across countries and their corresponding states or regions if any

COVID19APP.mlapp
This is GUI designed using MATLAB AppDesigner
It plots the confirmed cases or death of a selected country
and their corresponding selected state if any
It has 5 widgets:
1. An axes for plot the data
2. Two list box the shows the countries and their corresponding states if any
3. Two radio buttons for selecting whether to plot Death/Cases or Cumulative/Daily cases
And lastly, it has a slider for selecting averaging window length

LandArea.m 
This is MATLAB user-defined class
The countries and their states are created as objects of this class
For countries with states, their states are contained the country objects as states objects of the same class

covid_data.mat
This is cell array that contains the data to use.
Source of data: Johns Hopkins Hospital

