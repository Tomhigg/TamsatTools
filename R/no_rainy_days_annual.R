#' Number of rainy days Annaul
#'
#' Calculate number of days where rainfall (above a threshold) occurs within a calender year
#' 
#' @param daily_rfe Folder containing the downloaded daily-rfe from tamsat_daily_download
#' @param threshold threshold for classifying a rainy day, in mm/day, defaults to zero is missing
#' @param years Years as interger(s) for which statistics will be calculated
#' @param id Charecter sting to identify the outputs eg "long_integer/ jan_march etc"
#' @param outlocation Folder (string) to save summary layers into
#


no_rainy_days_window <- function(daily_rfe, years, threshold, id, outlocation){
  
  if(missing(threshold)==TRUE){threshold = 0}
  
  listFiles <- list.files(path = daily_rfe,pattern = ".nc",recursive = TRUE,full.names = TRUE)
  for (i in years){
    print(i)

      year_list <- grep(pattern = i,x = listFiles,value = TRUE)
      
      year_stack <-   raster::stack(sapply(year_list, FUN = raster::raster))
    
    flname <- paste0(outlocation,"/", id, "_", "rainy_days_", i,".tif" )
    
    # count wet days 
    raster::calc(year_stack, function(x) sum(x > threshold),filename = flname) 
    removeTmpFiles(h = 0) 
  }}







