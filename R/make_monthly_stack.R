#' Make complete one-month time step raster time series
#'
#' Read and stack raster layers, fill missing months with predefined averages, will crop to extent of fill_with
#'
#' @param download_folder Folder containing the downloaded monthly estimate from tamsat_download_all()
#' @param fill_with raster brick output from monthly_summary() to fill missing months
#' @param years Years as interger(s) for which statistics will be calculated
# 

monthly_stack <- function(download_folder, years, fill_with) {
    
    print("listing files")
    all_files <- list.files(path = download_folder, pattern = ".nc", recursive = TRUE, full.names = TRUE)
    
    print("blank stack")
    all_months <- raster::stack()
    
    for (i in years) {
        print(i)
        
        year_list <- grep(pattern = i, x = all_files, value = TRUE)
        
        year_stack <- raster::stack(sapply(year_list, FUN = raster::raster))
        
        year_stack <- crop(x = year_stack, y = fill_with)
        
        
        if (raster::nlayers(year_stack) < 12) {
            # make data frame of existing months based on month code from file string
            paths.df <- data.frame(Months = substr(x = year_list, start = nchar(year_list) - 4, stop = nchar(year_list) - 
                3))
            # make data fram of all months
            months.df <- data.frame(Months = c("01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12"))
            # dplyr: anti_join return objects not found in both data frames
            missing_months <- dplyr::anti_join(months.df, paths.df, "Months")
            missing_months <- as.numeric(as.character(missing_months$Months))
            # subset the missing rasters from overall annual summary
            missing_months_raster <- raster::subset(x = fill_with, subset = missing_months)
            # add total average to raster stack
            
            year_stack <- stack(year_stack, missing_months_raster)
        }
        
        Months = c("01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12")
        Months <- paste0(i, "_", Months)
        
        names(year_stack) <- Months
        
        all_months <- stack(all_months, year_stack)
    }
    return(all_months)
}


