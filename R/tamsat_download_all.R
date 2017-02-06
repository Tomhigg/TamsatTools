#' Download Tamsat Rainfall Estimate
#'
#' Automate downloading of daily RFE's from the TAMSAT server
#' Note that the unZip utilities within R are particually slow
#'
#'
#' @param type string, data to be downloaded of 'e', (estimates) 'a' (annomalies) or 'both'
#' @param period string, temporal resolution of data to download of 'd' (dekadal), 'm' (monthly), 's' (seasonal),or 'all'
#' @param outlocation Folder (string) to save downloaded .zip files into
#' @param unZip Should the downloaded zips be unzipped
# 

tamsat_all_download <- function(type, period, outlocation, unZip) {
    
    # check that type is ok
    if (any(type == c("e", "a", "both")) == FALSE) {
        stop("type must be a, e, or both")
    }
    # check that period is ok
    if (any(period == c("d", "m", "s", "all")) == FALSE) {
        stop("period must be d, m, s, or all")
    }
    # set outlocation if missing
    if (missing(outlocation) == TRUE) {
        outlocation <- getwd()
    }
    
    # make vector of download file path index
    paths_positions <- 1:6
    
    # set value to NA depending on type and period
    if (type == "all" & period == "all") {
        paths_positions = 1:6
    }
    if (type == "a") {
        paths_positions[c(1, 3, 5)] <- NA
    }
    if (type == "e") {
        paths_positions[c(2, 4, 6)] <- NA
    }
    if (period == "d") {
        paths_positions[3:6] <- NA
    }
    if (period == "m") {
        paths_positions[c(1:2, 5:6)] <- NA
    }
    if (period == "s") {
        paths_positions[1:4] <- NA
    }
    
    # make vector of download targets
    paths <- c("http://www.tamsat.org.uk/public_data/TAMSAT_rfe_dekadal.zip", "http://www.tamsat.org.uk/public_data/TAMSAT_rfe_anom_dekadal.zip", 
        "http://www.tamsat.org.uk/public_data/TAMSAT_rfe_monthly.zip", "http://www.tamsat.org.uk/public_data/TAMSAT_rfe_anom_monthly.zip", 
        "http://www.tamsat.org.uk/public_data/TAMSAT_rfe_seasonal.zip", "http://www.tamsat.org.uk/public_data/TAMSAT_rfe_anom_seasonal.zip")
    
    # index based on the desired paths
    paths_to_use <- paths[paths_positions]
    # remove na'd paths
    paths_to_use <- na.omit(paths_to_use)
    
    
    
    # start for loop to being downloading files
    for (i in paths_to_use) {
        # make output path name
        destPath <- paste0(outlocation, basename(i))
        # print location of downloading file
        print(i)
        # initiate download
        curl::curl_download(url = i, destfile = destPath, mode = "wb")
    }
    
    # unzip if willing to endure endless hours
    if (unZip == TRUE) {
        for (i in list.files(pattern = ".zip", path = outlocation)) {
            
            unzip_folder <- paste0(outlocation, "/", file_path_sans_ext(i))
            print("Un-ziping to folder-", unzip_folder)
            
            unzip(zipfile = i, exdir = unzip_folder, overwrite = TRUE)
            file.remove(i)
        }
    }
}


