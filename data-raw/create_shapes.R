# Create ESRI ArcGIS Shapefiles in `shape` subdirectory with The Administrative units of Kazakhstan
# with driver = 'ESRI Shapefile' (*.cpg, *.dbf, *.prj, *.shp, *.shx)

library('sf')               # Simple Features for R
library('dplyr')            # A Grammar of Data Manipulation
library('magrittr')         # A Forward-Pipe Operator for R

# ADM0: Administrative units level 0 (The the boundaries of a Kazakhstan)
load(file = "data/kaz_adm0_sf.rda")
sf::st_write(obj = sf::st_zm(kaz_adm0_sf), dsn = 'inst/shape/kaz_admbnda_adm0_2018.shp',
             driver = 'ESRI Shapefile', layer_options = 'ENCODING=UTF-8', delete_layer = TRUE)

# ADM1: Administrative units level 1 (the principal units of a country) of Kazakhstan

# Version 2018 Year
load(file = "data/kaz_adm1_2018_sf.rda")
sf::st_write( obj = sf::st_zm(kaz_adm1_2018_sf) # |> dplyr::filter( Year == 2018L )
            , dsn = 'inst/shape/kaz_admbnda_adm1_2018.shp'
            , driver = 'ESRI Shapefile', layer_options = 'ENCODING=UTF-8', delete_layer = TRUE )

# Version 2024 Year
load(file = "data/kaz_adm1_sf.rda")
sf::st_write( obj = sf::st_zm(kaz_adm1_sf) # |> dplyr::filter( Year == 2024L )
              , dsn = 'inst/shape/kaz_admbnda_adm1_2024.shp'
              , driver = 'ESRI Shapefile', layer_options = 'ENCODING=UTF-8', delete_layer = TRUE )

# ADM2: Administrative units level 2 (the district units of principal units) of Kazakhstan

# Version 2018 Year
load(file = "data/kaz_adm2_2018_sf.rda")
sf::st_write( obj = kaz_adm2_2018_sf # |> dplyr::filter( Year == 2018L )
            , dsn = 'inst/shape/kaz_admbnda_adm2_2018.shp'
            , driver = 'ESRI Shapefile', layer_options = 'ENCODING=UTF-8', delete_layer = TRUE)

# Version 2024 Year
load(file = "data/kaz_adm2_sf.rda")
sf::st_write( obj = kaz_adm2_sf # |> dplyr::filter( Year == 2024L )
            , dsn = 'inst/shape/kaz_admbnda_adm2_2024.shp'
            , driver = 'ESRI Shapefile', layer_options = 'ENCODING=UTF-8', delete_layer = TRUE)

# CNT1: Administrative centers level 1 of Kazakhstan
load(file = "data/kaz_cnt1_sf.rda")
sf::st_write( obj = kaz_cnt1_sf
            , dsn = 'inst/shape/kaz_admbnda_cnt1_2022.shp'
            , driver = 'ESRI Shapefile', layer_options = 'ENCODING=UTF-8', delete_layer = TRUE)
