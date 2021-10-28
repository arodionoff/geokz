data("kaz_adm1_sf")

library(sf)

# EPSG:4326 or WGS84 - see https://github.com/r-spatial/sf/issues/1419
sf::st_crs(x = kaz_adm1_sf) <- 4326L

# A Lambert Conformal Conic projection (LCC) with Krasovsky 1940 ellipsoid
# <https://proj.org/operations/projections/lcc.html>
# First standard parallel - 45 N, Second standard parallel - 51 N,
# Longitude of projection center - 67 E, Latitude of projection center - 48 N.
# See https://epsg.io/????

kaz_adm1_sf <-
  sf::st_transform(x = kaz_adm1_sf,
                   crs = "+proj=lcc +lon_0=67 +lat_1=45 +lat_2=51 +ellps=krass")

plot(x = kaz_adm1_sf["ADM1_EN"],
     main = "Kazakhstan: Oblasts & Cities of Republican Significance (ADM1)")


# Use {tmap} package for draw of Thematic Maps

if (requireNamespace("tmap", quietly = TRUE)) {

library(tmap)

tmap::tm_shape(kaz_adm1_sf) +
tmap::tm_polygons(
  col = "ADM1_PCODE",
  border.col = "black",
  border.alpha = 0.3,
  title = "Administrative \nunits level 1",
  labels = kaz_adm1_sf$ADM1_KK,
  palette = c("coral", "orange", "green", "blue")
) +
tmap::tm_text("ADM1_EN", col = "gray10", size = 0.9, shadow = TRUE) +
tmap::tm_graticules(lines = FALSE) +
tmap::tm_format(format = 'World_wide') +
tmap::tm_layout(
  main.title = "Kazakhstan: Administrative units level 1
(Oblasts & Cities of Republican Significance)",
  main.title.size = 0.9,
  legend.position = c("left", "bottom")
) +
tmap::tm_credits('Source: package {geokz}', position = c('right', 'BOTTOM'), size = 1.2)

}  # The end for {tmap} package


# Use {ggplot2} package for draw of Advanced Maps as `sf` objects

if (requireNamespace(c("ggplot2", "dplyr"), quietly = TRUE)) {

library(ggplot2)
library(dplyr)

kaz_adm1_sf %>%
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

}  # The end for {ggplot2} package


#' @section leaflet:
#' Use {leaflet} package for draw of Interactive Maps as `sf` objects

# Use {leaflet} package for draw of Interactive Maps as `sf` objects

if (requireNamespace("leaflet", "magrittr", quietly = TRUE)) {

library(leaflet)
library(magrittr)

# A Lambert Conformal Conic projection (LCC) with Krasovsky 1940 ellipsoid
# <https://proj.org/operations/projections/lcc.html>
# First standard parallel - 45 N, Second standard parallel = 51 N,
# Longitude of projection center - 67 E, Latitude of projection center = 48 N.
# See https://epsg.io/????

points <-
  data.frame(
    name = c("Nur-Sultan", "Almaty"),
    branch = c("The Capital", "The Biggest City"),
    link = c("https://en.wikipedia.org/wiki/Nur-Sultan",
             "https://en.wikipedia.org/wiki/Almaty"),
    lat = c(51.166667, 43.2775),
    lon = c(71.433333, 76.8958)
  ) %>%
  sf::st_as_sf(
    coords = c("lon", "lat"), # columns with geometry by x - "lon" and y - "lat"
    crs = "+proj=longlat +datum=WGS84"
  )

pal <- leaflet::colorNumeric("Blues", domain =as.integer(kaz_adm1_sf$KATO))
epsg102027 <- leaflet::leafletCRS(
  crsClass = "L.Proj.CRS",
  code = "EPSG:2502",
  proj4def = "+proj=tmerc +lat_0=0 +lon_0=69 +k=1 +x_0=500000 +y_0=0 +ellps=krass
              +towgs84=25,-141,-78.5,0,0.35,0.736,0 +units=m +no_defs",
  resolutions = 2^(16:7))

leaflet::leaflet(
  kaz_adm1_sf %>% sf::st_transform(crs = "+proj=longlat +datum=WGS84") %>% sf::st_zm(geometry),
  options = leafletOptions(crs = epsg102027)
  ) %>%
  leaflet::addPolygons(
    weight = 2,
    color = "grey",
    opacity = 1,
    fillColor = ~pal(as.integer(KATO)),
    fillOpacity = 0.7,
    smoothFactor = 0.5,
    label = ~paste(ADM1_KK, ":", KATO),
    labelOptions = labelOptions(direction = "auto")
    ) %>%
  leaflet::addCircleMarkers(
    data = points,
    color = "red",
    radius = 3,
    label = ~paste(branch, ":", name)
    )

}  # The end for {leaflet} package
