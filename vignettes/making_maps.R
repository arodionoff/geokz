## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup--------------------------------------------------------------------
library(geokz)

## ---- eval = FALSE------------------------------------------------------------
#  # install from CRAN
#  install.packages("geokz")
#  
#  # Install development version from GitHub
#  remotes::install_github("arodionoff/geokz")

## ----kaz_adm1_sf--------------------------------------------------------------
library(geokz)
library(dplyr)
library(sf)

IQR <- data(package = "geokz")
dplyr::as_tibble(IQR$results) %>% 
  dplyr::select(Item, Title) %>% 
    dplyr::filter(grepl("kaz_adm1_sf", Item))

## ----kaz_adm1_sf_names--------------------------------------------------------
names(geokz::kaz_adm1_sf)

## ----kaz_adm1_sf_key_count----------------------------------------------------
geokz::kaz_adm1_sf %>%
  sf::st_drop_geometry() %>% 
    dplyr::count(ADM1_PCODE, ADM1_EN, ADM1_KK, ADM1_RU, ISO_3166_2)

## ----kaz_adm2_sf--------------------------------------------------------------
IQR <- data(package = "geokz")
dplyr::as_tibble(IQR$results) %>% 
  dplyr::select(Item, Title) %>% 
    dplyr::filter(grepl("kaz_adm2_sf", Item))

## ----kaz_adm2_sf_names--------------------------------------------------------
names(geokz::kaz_adm2_sf)

## ----kaz_adm2_sf_key_count----------------------------------------------------
geokz::kaz_adm2_sf %>%
  sf::st_drop_geometry() %>% 
    dplyr::count(ADM1_PCODE, ADM1_EN, ADM1_KK, ADM1_RU, ISO_3166_2)

## ----kaz_cnt1_sf_names--------------------------------------------------------
names(geokz::kaz_cnt1_sf)

## ----kaz_adm1_sf_map, fig.height = 4, fig.width = 7---------------------------
rayons <- get_kaz_oblasts_map()
plot(rayons["ADM1_EN"], border = NA, 
     main = "Maps of All Kazakhstani Administrative units level 1 - Oblasts")

## ----Non-latin characters-----------------------------------------------------
x <- "\u041d\u04b1\u0440-\u0421\u04b1\u043b\u0442\u0430\u043d (\u049b\u0430\u043b\u0430)"
get_kaz_oblasts_map(ADM1_KK = x) %>%
  dplyr::select("KATO", "ADM1_EN", "ADM1_KK", "ADM1_RU", "ADM1_PCODE", "ISO_3166_2") %>% 
    sf::st_drop_geometry() %>% 
      knitr::kable(., caption = "Administrative unit level 1 - \nThe Capital (kaz. <b>'\u041d\u04b1\u0440-\u0421\u04b1\u043b\u0442\u0430\u043d (\u049b\u0430\u043b\u0430)'</b>")


## ----kaz_adm2_sf_map, fig.height = 4, fig.width = 7---------------------------
rayons <- get_kaz_rayons_map()
plot(rayons["ADM2_EN"], border = NA, 
     main = "Maps of All Kazakhstani Administrative units level 2 - Rayons")

## ----kaz_cnt1_sf, fig.height = 4, fig.width = 7-------------------------------
kaz_cnt1_sf <-
  sf::st_transform(x = kaz_cnt1_sf,
                   crs = "+proj=lcc +lon_0=67 +lat_1=45 +lat_2=51 +ellps=krass")

kaz_cnt1_sf$punch <- (5 - kaz_cnt1_sf$TYPE_CNT1)

# adding to a plot of an sf object only works when using reset=FALSE in the first plot
plot(x = get_kaz_oblasts_map()["ADM1_EN"], reset = FALSE, cex.main = 1.0,
     main = "KAZ: The Capital, Cities of Republican Significance & Oblast Centers (ADM1)")
plot(kaz_cnt1_sf["KATO"], col = "red", pch = "o", add = TRUE)


## ----Population density, fig.height = 4, fig.width = 7------------------------

library(geokz)
library(dplyr)
library(knitr)

Population_Density_df <- 
  data.frame(
    ISO_3166_2 = c("KZ-AKM", "KZ-AKT", "KZ-ALM", "KZ-ATY", "KZ-VOS", "KZ-ZHA", "KZ-KAR", "KZ-KUS", "KZ-KZY", "KZ-MAN", "KZ-SEV", "KZ-PAV", "KZ-YUZ", "KZ-ZAP", "KZ-AST", "KZ-ALA", "KZ-SHY"), 
    Region = c("Akmola Region", "Aktobe Region", "Almaty Region", "Atyrau Region", "East Kazakhstan Region", "Jambyl Region", "Karaganda Region", "Kostanay Region", "Kyzylorda Region", "Mangystau Region", "North Kazakhstan Region", "Pavlodar Region", "Turkistan Region", "West Kazakhstan Region", "Nur-Sultan", "Almaty", "Shymkent"),
    Area = c(146219, 300629, 223924, 118631, 283226, 144264, 427982, 196001, 226019, 165642, 97993, 124800, 117249, 151339, 710, 319, 1170),
    Population = c(735481, 893669, 2077656, 657118, 661172, 1139151, 1375788, 864529, 814461, 719559, 751011, 543679, 2044551, 1363656, 1184469, 1977011, 1074167)
) %>% 
  dplyr::mutate(Population_Density = round( Population / Area, 1))

knitr::kable(Population_Density_df, caption = 'Demographic statistics of <b>Kazakhstan</b>',
             format.args = list(big.mark = ' '))

dplyr::inner_join( x = get_kaz_oblasts_map(),
                   y = Population_Density_df[, c("ISO_3166_2", "Population_Density")],
                   by = c("ISO_3166_2" = "ISO_3166_2") ) %>% 
  tmap::qtm(
    shp = ., 
    fill = "Population_Density", 
    fill.n = 6,
    fill.style = "quantile",
    fill.text  = "Population_Density",
    fill.title = "Population Density \n(people per sq.km)",
    text = "Population_Density",
    title = "Population Density of Kazakhstan (2021)",
    format = "World"
    )


## ----Natural Zones, fig.height=4, fig.width=7---------------------------------
data(natural_zones)

natural_zones %>% 
  dplyr::count(ZONE_EN) %>%
    dplyr::bind_rows(., data.frame( ZONE_EN = "TOTAL", n = nrow(natural_zones))) %>% 
      knitr::kable(., 
         caption = "Administrative units level 2 by Zones according to <b>natural conditions</b>",
         format.args = list(big.mark = ' '))

dplyr::inner_join( x = get_kaz_rayons_map(),
                   y = natural_zones[, c("ADM2_PCODE", "ZONE_EN")],
                   by = c("ADM2_PCODE" = "ADM2_PCODE") ) %>%
tmap::tm_shape(shp = .) +
  tmap::tm_polygons(
    col = "ZONE_EN",
    title = "Zones according \nto natural conditions"
  ) +
tmap::tm_shape(shp = get_kaz_oblasts_map()) +
  tmap::tm_borders(col = "red", lwd = 3) +
tmap::tm_format(format = 'World_wide') +  
tmap::tm_layout(main.title = "Zones are distinguished according to natural conditions") +
tmap::tm_credits('Source: package {geokz}', position = c('right', 'BOTTOM'))


## ----Torgay Region, fig.height=4, fig.width=7---------------------------------
Torgay_Region <-
  get_kaz_rayons_map(ADM2_EN = c(
    "Esil",
    "Zhaksy",
    "Zharkain")) %>%
  dplyr::filter(ADM1_EN == "Akmola") %>%  # There are three rayons named Esil by Esil (Ishim) river
  dplyr::bind_rows(
    get_kaz_rayons_map(ADM2_PCODE = c(
      "KZ391600",                         # Arkalyk city was a Center of Torgay Oblast
      "KZ393400",                         # Amangeldi rayon
      "KZ394200")                         # Zhangeldi rayons
      )
  ) %>% 
  dplyr::mutate(ADM2_EN = factor(ADM2_EN, levels = ADM2_EN))

center_sf <-
  data.frame(
    NAME = c("Arkalyk"),
    BRANCH = c("The Center"),
    LINK = c("https://en.wikipedia.org/wiki/Arkalyk"),
    LAT = c(50.24861),
    LON = c(66.91139)
  ) %>%
  sf::st_as_sf(
    coords = c("LON", "LAT"), # columns with geometry by x - "LON" and y - "LAT"
    crs = "+proj=longlat +datum=WGS84"
  )

to_bb <-
  Torgay_Region %>%
  sf::st_bbox() %>%
  sf::st_as_sfc() %>%
  sf::st_buffer(dist = 50000)

tmap::tm_shape(Torgay_Region) +
  tmap::tm_polygons(
    col = "ADM2_EN",
    border.col = "grey",
    title = "Administrative \nunits level 2",
    labels = Torgay_Region$ADM2_KK
  ) +
  tmap::tm_text("ADM2_KK", col = "gray10", size = 0.9, shadow = TRUE) +
tmap::tm_shape(
  shp  = get_kaz_oblasts_map(),
  bbox = to_bb
  ) +
  tmap::tm_borders(
    col = "red",
    lwd = 4
  ) +
  tmap::tm_text("ADM1_KK", col = "gray10", size = 1.2, shadow = TRUE) +
tmap::tm_shape(center_sf) +
  tmap::tm_dots(size = 1) +
tmap::tm_graticules(lines = FALSE) +
  tmap::tm_format(format = 'World') +
  tmap::tm_layout(
    main.title = "Disbanded Torgay Oblast (1970-1988, 1990-1997)",
    main.title.size = 0.9,
    legend.position = c("left", "top")
  ) +
  tmap::tm_credits('Source: package {geokz}', position = c('right', 'bottom'), size = 1.2)


## ----ADM1: ggplot2 & KAZ, fig.height=4, fig.width=7---------------------------
library(ggplot2)
library(dplyr)

get_kaz_oblasts_map() %>%
  dplyr::mutate(ADM1_EN = factor(ADM1_EN, levels = ADM1_EN)) %>%
  ggplot2::ggplot(data = .) +
    ggplot2::geom_sf(mapping = ggplot2::aes(fill = ADM1_EN)) +  # forcats::fct_inorder(ADM1_EN)
    ggplot2::geom_sf_text(mapping = ggplot2::aes(label = ADM1_EN)) +
    ggplot2::theme_bw() +
    ggplot2::guides(fill = ggplot2::guide_legend(title = "Administrative \nunits level 1")) +
    ggplot2::labs(title = "Kazakhstan: Administrative units level 1
(Oblasts & Cities of Republican Significance)",
      x = NULL,
      y = NULL,
      caption = "Source: package {geokz}"
    )

## ----ADM2: ggplot2 & Mangystau, fig.height=4, fig.width=7---------------------
library(dplyr)
library(ggplot2)
library(RColorBrewer)

kaz_adm2_sf %>%
  dplyr::filter(ADM1_EN =="Mangystau") %>%
  dplyr::mutate(ADM2_EN = factor(ADM2_EN, levels = ADM2_EN)) %>%
  ggplot2::ggplot(data = .) +
    ggplot2::geom_sf(mapping = ggplot2::aes(fill = ADM2_EN)) +   # forcats::fct_inorder(ADM2_EN)
    ggplot2::geom_sf_text(
      mapping = ggplot2::aes(label = ADM2_EN),
      size = 3
      ) +
    ggplot2::coord_sf(crs=2499) + # Pulkovo 1942 / Gauss-Kruger CM 51E. See <https://epsg.io/2499>.
    ggplot2::scale_fill_brewer(palette = "Pastel2") +  # uses library(RColorBrewer)
    ggplot2::theme_light() +
    ggplot2::guides(fill = ggplot2::guide_legend(title = "Administrative \nunits level 2")) +
    ggplot2::labs(title = "Kazakhstan: Mangystau Oblast
(Rayons & Cities of Oblast Significance)",
      x = NULL,
      y = NULL,
      caption = "Source: package {geokz}"
    )



## ----CNT1: ggplot2 & Kyzyorda, fig.height=4, fig.width=7----------------------
library(dplyr)
library(sf)
library(ggplot2)

ko_bb <-
  dplyr::filter(kaz_adm1_sf, ADM1_EN == 'Kyzylorda') %>%
  sf::st_transform(crs = 2501) %>% # Pulkovo 1942 / Gauss-Kruger CM 63E. See <https://epsg.io/2501>.
  sf::st_bbox() %>%
  sf::st_as_sfc() %>%
  sf::st_buffer(dist = 30000)

kaz_adm2_sf %>%
  dplyr::filter(ADM1_EN =="Kyzylorda") %>%
  dplyr::mutate(ADM2_EN = factor(ADM2_EN, levels = ADM2_EN)) %>%
  ggplot2::ggplot(data = .) +
    ggplot2::geom_sf(                                           # Boundaries of Kazakhstani Oblasts
      data  = sf::st_geometry(kaz_adm1_sf),
      color = "red",
      size  = 1
    ) +
    ggplot2::geom_sf(                                           # Rayons of Kyzylorda Oblasts
      mapping = ggplot2::aes(fill = ADM2_EN)
      ) +  # forcats::fct_inorder(ADM2_EN)
    ggplot2::geom_sf_text(                                      # Labels of Rayons
      data = dplyr::filter(kaz_adm2_sf, (ADM1_EN == 'Kyzylorda' &
                              magrittr::and(ADM2_EN != "Kyzylorda", ADM2_EN != "Baykonyr"))),
      mapping = ggplot2::aes(label = ADM2_EN),
      size = 2.5
    ) +
    ggplot2::scale_fill_brewer(palette = "Pastel1") +
    ggplot2::geom_sf(                     # Administrative Center & City of Republican Significance
      data  = dplyr::filter(kaz_cnt1_sf, ADM1_EN == 'Kyzylorda'),
      size = 3,
      col = "red",
      shape = 19
    ) +
    ggplot2::geom_sf_text(                                      # Labels of Cities
      data  = dplyr::filter(kaz_cnt1_sf, ADM1_EN == 'Kyzylorda'),
      mapping = ggplot2::aes(label = NAME_EN),
      nudge_x = 65000,
      nudge_y = -9000,
      size = 4
    ) +
    ggplot2::geom_sf(                                           # Boundaries of Kazakhstan
      data  = sf::st_geometry(kaz_adm0_sf),
      alpha  = 0,
      color = "brown",
      size  = 2
    ) +
  # Set new Coordinate System: Pulkovo 1942 / Gauss-Kruger CM 63E. See <https://epsg.io/2501>.
    ggplot2::coord_sf(xlim = c(sf::st_bbox(ko_bb)$xmin, sf::st_bbox(ko_bb)$xmax),
                      ylim = c(sf::st_bbox(ko_bb)$ymin, sf::st_bbox(ko_bb)$ymax),
                      crs = 2501, expand = FALSE) +
    ggplot2::theme_linedraw() +
    ggplot2::guides(fill = ggplot2::guide_legend(title = "Administrative \nunits level 2")) +
    ggplot2::labs(title = "Kazakhstan: Kyzylorda Oblast
(Administrative Center, Rayons & City of Republican Significance)",
      x = NULL,
      y = NULL,
      caption = "Source: package {geokz}"
      )


## ----CNT1 leaflet, fig.height=4, fig.width=7----------------------------------
  library(leaflet)
  library(magrittr)

  urls <-
    c("Akmola_Region", "Aktobe_Region", "Almaty_Region", "Atyrau_Region", "West_Kazakhstan_Region",
      "Jambyl_Region" , "Karaganda_Region", "Kostanay_Region", "Kyzylorda_Region",
      "Mangystau_Region", "Pavlodar_Region", "North_Kazakhstan_Region", "Turkistan_Region",
      "East_Kazakhstan_Region", "Nur-Sultan", "Almaty", "Shymkent")

  leaflet::leaflet() %>%
    leaflet::addProviderTiles(provider = "Esri.WorldPhysical") %>%
    leaflet::addPolygons(
      data = sf::st_zm(geokz::kaz_adm1_sf, geometry),
      weight = 1,
      color = "darkred",
      fillColor = "coral",
      fillOpacity = 0.3,
      smoothFactor = 0.5,
      popup = ~paste0("Region: ", '<a href = "https://en.wikipedia.org/wiki/', urls, '"> ',
                      ADM1_EN, "</a><br>", "KATO: ", KATO, "<br>", "ISO 3166-2: ", ISO_3166_2),
      label = ~paste(ADM1_EN, ":", ADM1_PCODE),
      labelOptions = labelOptions(direction = "auto")
    ) %>%
    leaflet::addCircleMarkers(
      data = geokz::kaz_cnt1_sf,
      color = "brown",
      radius = 3,
      label = ~paste0("Center of ", ADM1_EN,": ", NAME_EN)
    )


