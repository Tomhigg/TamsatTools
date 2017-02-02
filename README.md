---
output: pdf_document
---
# TamsatTools
Download and process TAMSAT rainfall estimates

## Introduction
A collection of functions to ease the downloading and processing of rainfall estimate from the University of Reading's Tropical Applications of Meteorology using SATellite data and ground-based observations [TAMSAT](http://www.tamsat.org.uk/) project .

These observations cover the Africa continent at 4 km resolution since 1983 with daily, dekadal (10-daily), monthly, and seasonal  products available.

## Installation

The package can be in R directly from github using devtools

```R
library(devtools)
install_github('Tomhigg/TamsatTools')
library(TamsatTools)
```
## Functions

### Downloading Data

There are two functions to download data.

Daily estimates can be dowloaded for desired years as follows 

```R
tamsat_daily_download(years= 1984:1990, outlocation = "C:/Data/Rainfall/Tamsat/", unZip=FALSE){
```

Aggregated layers must be downloaded for the entire period. Options cover the type (rainfall estimates or annomalies), and the aggregation period (dekadal, monthly, seasonal) 

```R
tamsat_all_download(type= "e", period ="m", outlocation ="C:/Data/Rainfall/Tamsat/", unZip=FALSE)
##Downloaded rainfall estiamte at monthly resolution.
```

###Manipulating Data
#### Monthly Data
Note: the following only applies to rainfall estimates not annomalies
To make monthly summaries of the downloaded data 







Current functionality includes:
- Downloading daily rainfall estimates for selected years
- Calculating statistical  summaries of daily rainfall for either a calendar  year or a user-defined period
- Calculating the number of rainy day (rainfall greater than zero or specified threshold) for either a calendar  year or a user defined period


