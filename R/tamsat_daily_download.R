#' Download Tamsat Daily Rainfall Estimate
#'
#' Automate downloading of daily RFE's from the TAMSAT server
#' Note that the unZip utilities within R are particually slow
#' 
#' 
#' @param years Years as interger(s) for which data will be downloaded
#' @param outlocation Folder (string) to save downloaded .zip files into
#' @param unZip Should the downloaded zips be unzipped
#

tamsat_daily_download <- function(years,outlocation,unZip){
 
  for (i in years){
    filePath<-  paste0("http://www.tamsat.org.uk/public_data/", i, "/TAMSAT_rfe_daily",i, ".zip")
    destPath <- paste0(outlocation, basename(filePath))
    print("downloading year-", i)
    curl::curl_download(url = filePath,destfile =destPath, mode="wb")
  }
  
if(unZip==TRUE){
  for (i in list.files(pattern = ".zip",path = outlocation)){
    
    unzip_folder <- paste0(outlocation,"/",file_path_sans_ext(i))
    print("Un-ziping to folder-", unzip_folder)
    
        unzip(zipfile = i,exdir =unzip_folder, overwrite = TRUE)
        file.remove(i)
}}}


