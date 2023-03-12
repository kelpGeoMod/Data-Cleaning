# Visualize habitat data coverage

# set working directory
setwd("/Users/jfrench/Documents/MEDS/Capstone/DATA/Benthic_Habitat_2")

# Read in packages

library(tidyverse)
library(tmap)
library(sf) 
library(terra)

# read in offshore carpenteria shape file

carpenteria <- st_read("Santa Barbara Channel _coastline/Carpinteria_Loon/Habitat_OffshoreCarpinteria/Habitat_OffshoreCarpinteria.shp") |> 
  st_make_valid()

coal_oil <- st_read("Santa Barbara Channel _coastline/CoalOil_Naples/Habitat_OffshoreCoalOilPoint/Habitat_OffshoreCoalOilPoint.shp") |> 
  st_make_valid()


## Gaviota has different variable names than the coal oil point and carpenteria
gaviota <- st_read("Santa Barbara Channel _coastline/Gaviota/Habitat_Offshor/Habitat_OffshoreGaviota/Habitat_OffshoreGaviota.shp") |> 
  st_make_valid() # Need to ask about suing st_make_valid here

# Read in habitat raster sbc_f_2msub
## What habitat types 0 and 1 correspnd to is in the metadata. 
sbc_f_2msub <- rast("Habitat_tiffs/sbc_f_2msub.tif")

# Read in habitat sbc_g_2msub

sbc_g_2msub <- rast("Habitat_tiffs/sbc_g_2msub.tif")

# read in habitat sbc_h_2msub
sbc_h_2msub <- rast("Habitat_tiffs/sbc_h_2msub.tif")

# read in cp_2msub
santa_cruz_rosa_cp2msub <- rast("Habitat_tiffs/santacruz_rosa_cp_2msub.tif")

# read in gi_2msub
santa_cruz_rosa_gi2msub <- rast("Habitat_tiffs/santacruz_rosa_gi_2msub.tif")

# read in scpt_2msub

santacrus_rosa_scpt2msub <- rast("Habitat_tiffs/santacruz_rosa_scpt_2msub.tif")

#### END of DATA that was emailed to us

# read in offshore point conception data from USGS

off_pointC_usgs <- st_read("Habitat_Offshor/Habitat_OffshorePointConception/Habitat_OffshorePointConception.shp")

off_ventura_usgs <- st_read("Habitat_OffshoreVentura/Habitat_OffshoreVentura.shp") |> 
  st_make_valid()

HuenemeCanyon <- st_read("Habitat_HuenemeCanyon/Habitat_HuenemeCanyon.shp")

refugio <- st_read("Habitat_OffshoreRefugioBeach (1)/Habitat_OffshoreRefugioBeach.shp")

santa_barbara <- st_read("Habitat_OffshoreSantaBarbara/Habitat_OffshoreSantaBarbara.shp") |> 
  st_make_valid()

# Data from USGS here https://pubs.usgs.gov/of/2005/1170/catalog.html, bottom id is the variable of interest

# N_anacapa <- st_read("nanphab/nanphab.shp") |>
#   st_make_valid()
# 
# S_anacapa <- st_read("sanahab/sanahab.shp") |> 
#   st_make_valid()

# For this one pulled the .prj, and other metadata files from another in the same series. 
# san_miguel <- st_read("s_mig/smighab.shp") |> 
#   st_make_valid()
#   
#plot(san_miguel)

# tm_shape(san_miguel) + 
#   tm_polygons()

# The habitat uses different binary indicators at different depth ranges so for our purposes I think we should stick with substrate layers
# sbc_f_2mhab <- rast("/Users/jfrench/Documents/sbc_f_2mhab.tif")
# plot(sbc_f_2mhab)
# plot(sbc_f_2msub)

# read in new AOI

AOI <- st_read("/Users/jfrench/Documents/MEDS/Capstone/DATA/New_AOI_SBchannel_shp/New_AOI_SBchannel.shp")

###### read in 5m substrate

sbc_f_5msub <- rast("/Users/jfrench/Documents/MEDS/Capstone/DATA/Benthic_Habitat_2/Habitat_tiffs/sbc_f_5msub.tif")

tmap_mode(mode = "view")

tm_shape(carpenteria) +
  tm_polygons(col = "Hab_Type", legend.show = FALSE) +
tm_shape(coal_oil) +
  tm_polygons(col = "Hab_Type", legend.show = FALSE) +
tm_shape(gaviota) +
  tm_polygons(col = "CMECSDESC", legend.show = FALSE) +
tm_shape(sbc_f_2msub) +
  tm_raster(legend.show = FALSE) +
tm_shape(sbc_g_2msub) +
  tm_raster(legend.show = FALSE) +
tm_shape(sbc_h_2msub) +
  tm_raster(legend.show = FALSE) +
tm_shape(santa_cruz_rosa_cp2msub) +
  tm_raster(legend.show = FALSE) +
tm_shape(santa_cruz_rosa_gi2msub) +
  tm_raster(legend.show = FALSE) +
tm_shape(santacrus_rosa_scpt2msub) +
  tm_raster(legend.show = FALSE) +
tm_shape(off_pointC_usgs) +
  tm_polygons(col = "CMECSDESC", legend.show = FALSE) +
# tm_shape(N_anacapa) +
#   tm_polygons(col = "BOTTOM_ID") +
tm_shape(off_ventura_usgs) +
  tm_polygons(col = "Hab_Type", legend.show = FALSE) +
tm_shape(HuenemeCanyon) +
  tm_polygons(col = "Hab_Type", legend.show = FALSE) +
tm_shape(refugio) +
  tm_polygons(col = "Hab_Type", legend.show = FALSE) +
tm_shape(santa_barbara) +
  tm_polygons(col = "Hab_Type", legend.show = FALSE) +
# tm_shape(S_anacapa) +
#   tm_polygons(col = "BOTTOM_ID", legend.show = FALSE) +
# tm_shape(san_miguel) +
#   tm_polygons(col = "BOTTOM_ID") +
tm_shape(sbc_f_5msub) +
  tm_raster() +
tm_shape(AOI, is.master = TRUE) +
  tm_borders(col = "red") 
  
