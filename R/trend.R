raster_lm <- function(raster_brick, mask_insig){

  time <- 1:nlayers(raster_brick)


  slope <- calc(x =raster_brick,fun = function(x)
                    { if (is.na(x[1])){ NA } else { m = lm(x ~ time); summary(m)$coefficients[2] }}  )

  slope <- slope*nlayers(raster_brick)

  p_values <- calc(x = raster_brick,fun = function(x)
    { if (is.na(x[1])){ NA } else { m = lm(x ~ time); summary(m)$coefficients[8] }})


 out <- stack(slope, p_values)

 if(mask_insig==TRUE){

   m = c(0, 0.05, 1, 0.05, 1, 0)
   rclmat = matrix(m, ncol=3, byrow=TRUE)

   p.mask = reclassify(p_values, rclmat)

   p.mask.NA = calc(p.mask, fun = function(x) { x[x<1] <- NA; return(x)})

   slope = mask(slope, p.mask.NA)
    }


 names(out) <- c("slopes","p-values")
 return(out)

}
