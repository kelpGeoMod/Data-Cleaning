library(sf)
library(tmap)
library(terra)
library(tidyverse)
library(cmocean)

# Make an empty raster of 0.008 degree resolution
x <- rast() # make an empty raster
x

crs(x) <- "EPSG:4326" # confirm WGS84
crs(x)
ext(x) <- c(-120.65, -118.80, 33.85, 34.59) # set extent
ext(x)
res(x) <- c(0.008, 0.008) # set resolution
res(x)

nrow(x) # identify how many rows we have
ncol(x) # identify how many columns we have
ncell(x) # identify how many total cells we have
values(x) <- 1 # fill in values 1-10873 by row

colors1 <- cmocean("diff")(5) # Bring in a palette

tmap_mode("view")
tm_shape(x) +
  tm_raster(palette = colors1)

mask <- x

boundaries <- st_read("/Users/elkewindschitl/Downloads/California_County_Boundaries/cnty19_1.shp") 

boundaries <- st_transform(x = boundaries, crs = 4326)

boundaries <- vect(boundaries)
boundaries <- rasterize(x = boundaries, 
                        y = mask)
reclassification_matrix <- matrix(c(NaN, 1, 1, NaN), ncol = 2, byrow = TRUE)

land_bounds <- classify(boundaries, rcl = reclassification_matrix)

plot(land_bounds)

mask <- mask * land_bounds

tmap_mode("plot")
tm_shape(mask) +
  tm_raster(palette = colors1,
            legend.show = FALSE)

terra::writeRaster(mask, "mask_rast.tif", filetype = "GTiff", overwrite = TRUE)

