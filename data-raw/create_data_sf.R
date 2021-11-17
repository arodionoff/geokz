## code to prepare `kaz_amd0_sf`, `kaz_amd1_sf` & `kaz_amd2_sf` dataset goes here
##

library('sf')               # Simple Features for R
library('dplyr')            # A Grammar of Data Manipulation
library('magrittr')         # A Forward-Pipe Operator for R

# MultiPolygon `sf` object for Kazakhstan country (Administrative unit level 0 - Country) in `UTF-8` encoding

agr = c(ADM0_EN = "constant", ADM0_KK = "constant", ADM0_RU = "constant", ADM0_PCODE = "constant")

kaz_adm0_sf <- sf::st_read('maps/kaz_admbnda_adm0_2019.shp', agr = agr)    # Create 'sf' class from package 'sf'
kaz_adm0_sf <-
  dplyr::transmute( kaz_adm0_sf,
                    KATO       = "000000000",
                    ADM0_EN, ADM0_KK, ADM0_RU, ADM0_PCODE
    )

base::Encoding(kaz_adm0_sf$ADM0_KK)

# Coordinate Reference System of object - sf::sf_extSoftVersion()
# EPSG:4326 or WGS84 for older version GDAL - see https://github.com/r-spatial/sf/issues/1419
sf::st_crs(x = kaz_adm0_sf) <- 4326L

sf::st_agr(kaz_adm0_sf) <-
  factor( x = c(KATO = "identity", agr)
          , levels = c("constant", "aggregate", "identity") )

usethis::use_data(kaz_adm0_sf, overwrite = TRUE, compress = 'xz', version = 3)

# MultiPolygon `sf` object for Kazakhstan's oblasts
# Administrative unit level 1 - the largest subnational unit of a country
agr = c(ADM0_EN = "constant", ADM0_KK = "constant", ADM0_RU = "constant", ADM0_PCODE = "constant",
        ADM1_EN = "identity", ADM1_KK = "identity", ADM1_RU = "identity", ADM1_PCODE = "identity")

kaz_adm1_sf <- sf::st_read('maps/kaz_admbnda_adm1_2019.shp', agr = agr)    # Create 'sf' class from package 'sf'

kaz_adm1_sf <-
  dplyr::transmute( kaz_adm1_sf,
    KATO       = paste0(substr(ADM1_PCODE, 3, 4), "0000000"),
    ADM0_EN, ADM0_KK, ADM0_RU, ADM0_PCODE, ADM1_EN, ADM1_KK, ADM1_RU, ADM1_PCODE,
    ISO_3166_2 = c("KZ-AKM", "KZ-AKT", "KZ-ALM", "KZ-ATY", "KZ-ZAP", "KZ-ZHA",
                   "KZ-KAR", "KZ-KUS", "KZ-KZY", "KZ-MAN", "KZ-PAV", "KZ-SEV",
                   "KZ-YUZ", "KZ-VOS", "KZ-AST", "KZ-ALA", "KZ-SHY")
    )

sf::st_agr(kaz_adm1_sf) <-
  factor( x = c(KATO = "identity", agr, ISO_3166_2 = "identity")
        , levels = c("constant", "aggregate", "identity") )

usethis::use_data(kaz_adm1_sf, overwrite = TRUE, compress = 'xz', version = 3)

# MultiPolygon `sf` object for Kazakhstan's rayons
# Administrative unit level 2 - the secondary subnational unit of a country

agr = c(ADM0_EN = "constant", ADM0_KK = "constant", ADM0_RU = "constant", ADM0_PCODE = "constant",
        ADM1_EN = "constant", ADM1_KK = "constant", ADM1_RU = "constant", ADM1_PCODE = "constant",
        ADM2_EN = "identity", ADM2_KK = "identity", ADM2_RU = "identity", ADM2_PCODE = "identity")

kaz_adm2_sf <- sf::st_read('maps/kaz_admbnda_adm2_2021.shp', agr = agr)    # Create 'sf' class from package 'sf'
# kaz_adm2_sf <-                                                 # 26 times more slower
#   sf::st_join( x = kaz_adm2_sf,
#                y = dplyr::select(kaz_adm1_sf, ISO_3166_2),
#                left = TRUE )
kaz_adm2_sf <-
  dplyr::inner_join( x = kaz_adm2_sf,
                     y = dplyr::select(kaz_adm1_sf, ADM1_PCODE, ISO_3166_2) %>%
                            sf::st_drop_geometry(),
                     by = c('ADM1_PCODE' = 'ADM1_PCODE')
                   ) %>%
    dplyr::transmute(
      KATO       = paste0(substr(ADM2_PCODE, 3, 8), "000"),
      ADM0_EN, ADM0_KK, ADM0_RU, ADM0_PCODE,
      ADM1_EN, ADM1_KK, ADM1_RU, ADM1_PCODE,
      ADM2_EN, ADM2_KK, ADM2_RU, ADM2_PCODE,
      ISO_3166_2
    ) %>%
    dplyr::arrange(KATO)  # Change order of Turkistani Cities

sf::st_agr(kaz_adm2_sf) <-
  factor( x = c(KATO = "identity", agr, ISO_3166_2 = "constant")
        , levels = c("constant", "aggregate", "identity") )

usethis::use_data(kaz_adm2_sf, overwrite = TRUE, compress = 'xz', version = 3)

# Point `sf` object for Kazakhstan's oblasts (City - Administrative Center of unit level 1)

agr = c(KATO = "identity", NAME_KK = "identity", NAME_RU = "identity", NAME_EN = "identity")

kaz_cnt1_sf <- sf::st_read('maps/kaz_admcntr_adm1_2018.shp', agr = agr)  # Create 'sf' class from package 'sf'
kaz_cnt1_sf <-
  dplyr::mutate( kaz_cnt1_sf,
      TYPE_CNT1 = dplyr::case_when(  # c(rep(3L, times = 14L), 1L, 2L, 2L, 4L),
        KATO               == "710000000" ~ 1L, # Nur-Sultan - The Capital
        # base::substr(KATO, 3, 9) ==   "0000000" ~ 2L  # Cities of Republican Significance
        KATO               == "431900000" ~ 4L, # Baykonyr - the World's First Spaceport
        TRUE                              ~ 3L  #  Center of Administrative unit level 1
      ),
      ISO_3166_2 =
        c("KZ-AKM", "KZ-AKT", "KZ-ALM", "KZ-ATY", "KZ-ZAP", "KZ-ZHA", "KZ-KAR",
          "KZ-KUS", "KZ-KZY", "KZ-BAY", "KZ-MAN", "KZ-PAV", "KZ-SEV", "KZ-YUZ",
          "KZ-VOS", "KZ-AST", "KZ-ALA", "KZ-SHY") ) %>%
  sf::st_join(
    x = .,
    y = dplyr::select(kaz_adm1_sf, ADM0_EN, ADM0_KK, ADM0_RU, ADM0_PCODE,
                      ADM1_EN, ADM1_KK, ADM1_RU, ADM1_PCODE),
    left = TRUE
  ) %>%
  dplyr::transmute(
    KATO,
    ADM0_EN, ADM0_KK, ADM0_RU, ADM0_PCODE,
    ADM1_EN, ADM1_KK, ADM1_RU, ADM1_PCODE,
    TYPE_CNT1, ISO_3166_2, NAME_EN, NAME_KK, NAME_RU
  )

kaz_cnt1_sf$TYPE_CNT1 <-
  ifelse( kaz_cnt1_sf$KATO != "710000000" & # Nur-Sultan - The Capital
          substr(kaz_cnt1_sf$KATO, 3, 9) ==   "0000000", # Cities of Republican Significance
          2L, kaz_cnt1_sf$TYPE_CNT1 )

sf::st_agr(kaz_cnt1_sf) <-
  factor( x = c(KATO = "identity", ADM0_EN = "constant", ADM0_KK = "constant", ADM0_RU = "constant", ADM0_PCODE = "constant",
                ADM1_EN = "identity", ADM1_KK = "identity", ADM1_RU = "identity", ADM1_PCODE = "identity",
                TYPE_CNT1 = "identity", ISO_3166_2 = "identity",
                NAME_EN = "identity", NAME_KK = "identity", NAME_RU = "identity")
        , levels = c("constant", "aggregate", "identity") )

usethis::use_data(kaz_cnt1_sf, overwrite = TRUE, compress = 'xz', version = 3)

# Zones Of Kazakhstan according to the natural conditions

natural_zones <-
  dplyr::inner_join( x = utils::read.csv( file = "data-raw/kaz_zones.csv", encoding = "UTF-8" ),
                     y = data.frame(ZONE_RU = c("Степная", "Сухостепная", "Полупустынная",
                                                "Предгорно-пустынно-степная", "Пустынная",
                                                "Южно-Сибирская горная и предгорная"),
                                    ZONE_KK = c("Дала", "Құрғақ дала", "Жартылай шөл",
                                                "Тау етегі-шөл-дала", "Шөл",
                                                "Оңтүстік Сібір тауы мен тау бөктері"),
                                    ZONE_EN = c("Steppe", "Dry-steppe", "Semi-desert",
                                                "Foothill-desert-steppe", "Desert",
                                                "South Siberian mountain and foothill")),
                     by  = c("ZONE_RU" = "ZONE_RU") ) %>%
    dplyr::transmute(KATO = as.character(KATO),
                     ZONE_EN = factor(ZONE_EN,
                        levels = c("Steppe", "Dry-steppe", "Foothill-desert-steppe",
                                   "Desert", "South Siberian mountain and foothill", "Semi-desert")),
                     ZONE_KK = factor(ZONE_KK,
                                      levels = c("Дала", "Құрғақ далаe", "Тау етегі-шөл-дала",
                                                 "Шөл", "Оңтүстік Сібір тауы мен тау бөктері", "Жартылай шөл")),
                     ZONE_RU = factor(ZONE_RU,
                                      levels = c("Степная", "Сухостепная", "Предгорно-пустынно-степная",
                                                 "Пустынная", "Южно-Сибирская горная и предгорная", "Полупустынная")),
                     ADM1_RU, ADM2_RU, ADM2_PCODE)

utils::write.csv(natural_zones, file = paste0("inst/extdata/", "kaz_zones.csv"),
                 row.names = FALSE, fileEncoding = "UTF-8")

usethis::use_data(natural_zones, overwrite = TRUE, compress = 'xz', version = 3)
