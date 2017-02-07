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

```{r,eval=TRUE}
#library(devtools)
#install_github('Tomhigg/TamsatTools')
library(TamsatTools)
```
## Functions

### Downloading Data

There are two functions to download data. Functions have the option to automate unzipping the files after download, however, this is very slow in R and probably not recommended 

Daily estimates can be downloaded for desired years as follows 

```{r,eval=FALSE}
#Download daily rainfall estimate for 1984 to 1990, don't unzip
tamsat_daily_download(years= 1984:1990, 
                      outlocation = "C:/Data/Rainfall/Tamsat/", 
                      unZip = FALSE)
```

Aggregated layers must be downloaded for the entire period. Options cover the type (rainfall estimates or anomalies), and the aggregation period (dekadal, monthly, seasonal) 

```{r,eval=FALSE}
#Downloaded rainfall estimates at monthly resolution.
tamsat_all_download(type = "e", 
                    period ="m", 
                    outlocation = "C:/Data/Rainfall/Tamsat/", 
                    unZip = FALSE)
```

###Manipulating Data
#### Monthly Data

Note1: Currently only monthly data manipulation is supported, seasonal/dekadal will be added soon
Note2: the following only applies to rainfall estimates not anomalies

To make monthly summaries over a time period use the `monthly_summary()` function 



```{r,eval=TRUE,cache=TRUE}
rainfall_folder <- "G:/LimpopoWoodyChange/Rainfall/TAMSAT_rfe_monthly/"
limpopo <- rgdal::readOGR(dsn ="G:/LimpopoWoodyChange" ,layer ="LimpopoBasin" )
library(TamsatTools)
#Calculate mean monthly rainfall for every month, over the 1984-2010 period.
mean_month_rainfall <- monthly_summary(download_folder = rainfall_folder, 
                                     months = 1:12, 
                                     period = 1984:2010, 
                                     ex = limpopo)
```
To make nice figures the `rasterVis` package is very efficient 

```{r,eval=TRUE,cache=TRUE}
library(rasterVis)
p <- levelplot(mean_month_rainfall,
par.settings = RdBuTheme,main = "Mean monthly rainfall (mm) 1984-2015")
p + layer(sp.lines(limpopo, lwd=1, col='darkgray'))


```



Making monthly summaries is a useful as it allows missing months to be filled based on the averages.

```{r,eval=FALSE}
#Calculate total annual rainfall, over the 1984-2010 period, replacing missing months with average values
annual_sum_rainfall <- annual_summary_from_months(download_folder = "C:/Data/Rainfall/Tamsat/",
                                                  years = 1984:2010,  
                                                  fill_with = mean_month_rainfall)
```


To make a complete time series, again filling the missing months with averages, use the `make_monthly_stack()` function

```{r,eval=FALSE}
#Make monthly raster stack time series, for the 1984-2010 period, replacing missing months with average values
rainfall_time_series <- monthly_stack(download_folder = "C:/Data/Rainfall/Tamsat/", 
                                      years = 1984:2019, 
                                      fill_with = mean_month_rainfall)
```






#### Daily Data













