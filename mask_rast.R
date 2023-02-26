# Make an empty raster of 0.008 degree resolution
x <- rast() # make an empty raster
x

crs(x) <- "EPSG:4326" # confirm WGS84
crs(x)
ext(x) <- c(-120.5, -119.45, 33.83, 34.49) # set extent
ext(x)
res(x) <- c(0.008, 0.008) # set resolution
res(x)

nrow(x) # identify how many rows we have
ncol(x) # identify how many columns we have
ncell(x) # identify how many total cells we have
values(x) <- 1:ncell(x) # fill in values 1-10873 by row

tmap_mode("view")
tm_shape(x) +
  tm_raster(style = "cont",
            breaks = seq(0, ncell(x), by = 1000),
            title = "Cell ID",
            palette = "RdPu")

mask <- x

terra::writeRaster(resampled_depth, "mask_rast.tif", filetype = "GTiff", overwrite = TRUE)
