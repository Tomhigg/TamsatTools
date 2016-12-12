#' Annual; Summary Statistics 
#'
#' Calculate statistical summaries of rainfall over a calender year 
#' 
#' @param daily_rfe Folder containing the downloaded daily-rfe from tamsat_daily_download
#' @param stat statistic to calculate, must be compatible with raster::calc()
#' @param years Years as interger(s) for which statistics will be calculated
#' @param id Charecter sting to identify the outputs eg "long_integer/ jan_march etc"
#' @param outlocation Folder (string) to save summary layers into
#


annual_summary   <- function(daily_rfe, years, stat, id, outlocation){
  
  listFiles <- list.files(path = daily_rfe, pattern = ".nc", recursive = TRUE, full.names = TRUE)
  for (i in years){
    print(i)
    
    year_list <- grep(pattern = i,x = listFiles,value = TRUE)

    year_stack <-   raster::stack(sapply(year_list, FUN = raster::raster))
    
    flname <- paste0(outlocation,"/", id,"_",stat, i,".tif")
    
    raster::calc(x = year_stack,fun = sum, filename = flname)
  }}
