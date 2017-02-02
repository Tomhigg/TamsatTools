#' Monthy; Summary Statistics
#'
#' Calculates monthly statistical summaries of rainfall for each month for a defined period
#'
#'  Note: There seems to be some problem with some 1983 layers, for ease stick to 1984+
#'
#' @param download_folder Folder containing the downloaded monthly estimates from tamsat_all_download
#' @param stat statistic to calculate, must be compatible with raster::calc()
#' @param period Years as interger(s) for which statistics will be calculated
#' @param months months to calculate eg c(1:12), c(1,4,6,10:12)


monthly_summary <- function(download_folder, months, period, stat){

  dir_list <- list.dirs(path = download_folder,full.names = T,recursive = F)

  dirs_to_use <- dir_list[grep(pattern = paste(period,collapse="|") ,x = dir_list)]

  all_files <- vector()

  for (i in dirs_to_use ){
    files_to_join <- list.files(path = i ,pattern = ".nc",full.names = T,recursive = T)
    all_files <- c(all_files,files_to_join)
  }


  ### change this for an if orig statement
  all_files_test <- all_files[-grep(pattern ="orig.nc",x =  all_files)]


monthy_stats  <- stack(sapply(X = months, FUN = function(i){

    if(i < 10){ i <- paste0(0,i)}

  monthCode <- paste0("/",i,"/")


  year_paths <- all_files[grep(pattern =monthCode,x =  all_files)]

  rasStack <- stack(sapply(year_paths, raster))
 rasStack <- crop(x = rasStack, y = limpopo)
 summary_statistics <- calc(x = rasStack,fun = stat)
}))

months_names <- c( "January", "February", "March", "April",
             "May", "June", "July", "August", "September",
             "October", "November", "December")

months_labels <- months_names[c(months_names)]
names(monthy_stats) <- months_labels



  return(monthy_stats)
}
