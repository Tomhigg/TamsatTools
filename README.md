# TamsatTools
Download and process TAMSAT rainfall estimates

## Introduction
A collection of functions to ease the downloading and processing of rainfall estimate from the University of Reading's Tropical Applications of Meteorology using SATellite data and ground-based observations [TAMSAT](http://www.tamsat.org.uk/) project .

These observations cover the Africa continent at 4 km resolution since 1983 with daily, dekadal (10-daily), monthly, and seasonal  products available.

## Installation

The package can be in R directly from github using devtools

```R
library(devtools)
install_github('loicdtx/bfastSpatial')
```
## Functionality

Current functionality includes:
- Downloading daily rainfall estimates for selected years
- Calculating statistical  summaries of daily rainfall for either a calendar  year or a user-defined period
- Calculating the number of rainy day (rainfall greater than zero or specified threshold) for either a calendar  year or a user defined period

Future functions will cover:
- Dekadal/monthly  data manipulation
- Calculation of trends
 
