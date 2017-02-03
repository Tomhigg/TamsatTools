#' Download Tamsat Rainfall Estimate
#'
#' Automate downloading of daily RFE's from the TAMSAT server
#' Note that the unZip utilities within R are particually slow
#'
#'
#' @param type string, data to be downloaded of "e", (estimates) "a" (annomalies) or "both"
#' @param period string, temporal resolution of data to download of "d" (dekadal), "m" (monthly), "s" (seasonal),or "all"
#' @param outlocation Folder (string) to save downloaded .zip files into
#' @param unZip Should the downloaded zips be unzipped
#

tamsat_all_download <- function(type, period, outlocation, unZip){

  paths_positions <- 1:6

  if (type == "all" & period =="all") { paths_positions = 1:6}

  if (type == "a") { paths_positions[c(1,3,5)] <- NA}
  if (type == "e") { paths_positions[c(2,4,6)] <- NA}

  if (period == "d") { paths_positions[3:6] <- NA}
  if (period == "m") { paths_positions[c(1:2,5:6)] <- NA}
  if (period == "s") { paths_positions[1:4] <- NA}

  paths <- c("http://www.tamsat.org.uk/public_data/TAMSAT_rfe_dekadal.zip",
             "http://www.tamsat.org.uk/public_data/TAMSAT_rfe_anom_dekadal.zip",
             "http://www.tamsat.org.uk/public_data/TAMSAT_rfe_monthly.zip",
             "http://www.tamsat.org.uk/public_data/TAMSAT_rfe_anom_monthly.zip",
             "http://www.tamsat.org.uk/public_data/TAMSAT_rfe_seasonal.zip",
             "http://www.tamsat.org.uk/public_data/TAMSAT_rfe_anom_seasonal.zip")

  paths_to_use <- paths[paths_positions]
  paths_to_use <- na.omit(paths_to_use)


  for (i in paths_to_use){

    destPath <- paste0(outlocation, basename(i))
    print(i)
    curl::curl_download(url = i,destfile =destPath, mode="wb")
  }

  if(unZip==TRUE){
    for (i in list.files(pattern = ".zip",path = outlocation)){

      unzip_folder <- paste0(outlocation,"/",file_path_sans_ext(i))
      print("Un-ziping to folder-", unzip_folder)

      unzip(zipfile = i,exdir =unzip_folder, overwrite = TRUE)
      file.remove(i)
    }}}


