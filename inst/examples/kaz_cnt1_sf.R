data("kaz_adm1_sf")
data("kaz_cnt1_sf")

library(sf)

# EPSG:4326 or WGS84 - see https://github.com/r-spatial/sf/issues/1419
sf::st_crs(x = kaz_adm1_sf) <- 4326L
sf::st_crs(x = kaz_cnt1_sf) <- 4326L

# A Lambert Conformal Conic projection (LCC) with Krasovsky 1940 ellipsoid
# <https://proj.org/operations/projections/lcc.html>
# First standard parallel - 45 N, Second standard parallel - 51 N,
# Longitude of projection center - 67 E, Latitude of projection center - 48 N.
# See https://epsg.io/2502

kaz_adm1_sf <-
  sf::st_transform(x = kaz_adm1_sf,
                   crs = "+proj=lcc +lon_0=67 +lat_1=45 +lat_2=51 +ellps=krass")

kaz_cnt1_sf <-
  sf::st_transform(x = kaz_cnt1_sf,
                   crs = "+proj=lcc +lon_0=67 +lat_1=45 +lat_2=51 +ellps=krass")

kaz_cnt1_sf$punch <- (5 - kaz_cnt1_sf$TYPE_CNT1)

# adding to a plot of an sf object only works when using reset=FALSE in the first plot
plot(x = kaz_adm1_sf["ADM1_EN"], reset = FALSE, cex.main = 1.0,
     main = "Kazakhstan: The Capital, Cities of Republican Significance & Oblast Centers (ADM1)")
plot(kaz_cnt1_sf["KATO"], col = "red", pch = "o", add = TRUE)

# Use {tmap} package for draw of Thematic Maps

if (requireNamespace("tmap", quietly = TRUE)) {

  library(tmap)

  kaz_tm <-
    tmap::tm_shape(kaz_adm1_sf) +
    tmap::tm_polygons(
      col = "ADM1_PCODE",
      alpha = 0.5,
      border.col = "grey10",
      border.alpha = 0.3,
      title = "Administrative \nunits level 1",
      labels = kaz_adm1_sf$ADM1_KK,
      palette = c("coral", "orange", "green", "blue"),
      legend.show = FALSE,
      id = "ISO_3166_2",
      popup.vars = "ADM1_EN"
    ) +
    tmap::tm_shape(kaz_cnt1_sf) +
    tmap::tm_dots(
      size = "punch",
      col = "red",
      shape = 23,
      legend.size.reverse = TRUE,
      legend.size.is.portrait = TRUE,
      popup.vars = "NAME_KK",
      sizes.legend.labels = c("Other", "Center of Oblast",
                              "Republican Significance", "Capital"),
      title.size = "Cities - \nADM Centers \nlevel 1") +
    tmap::tm_text(
      text = "NAME_EN",
      col = "gray10",
      xmod = 1,
      ymod = -0.5) +
    tmap::tm_format(format = 'World') +
    tmap::tm_layout(
      main.title = "Kazakhstan: Administrative units level 1
  (The Capital, Cities of Republican Significance & Oblast Centers)",
  main.title.size = 1.1
    ) +
    tmap::tm_credits('Source: package {geokz}', position = c('right', 'BOTTOM'))

  # initial mode: "plot"
  current.mode <- tmap::tmap_mode(mode = "plot")

  # plot map
  print(kaz_tm)

  # {tmap} package uses {leaflet} package for draw of Interactive Maps as
  # `sf` objects switch to Interactiv mode: "view"
  tmap::ttm()  # or tmap::tmap_mode(mode = "view")

  # view map with {leaflet} package
  tmap::tmap_options(check.and.fix = TRUE)
  print(kaz_tm)

  # restore current mode ("plot")
  tmap::tmap_mode(mode = current.mode)

}  # The end for {tmap} package


# Use {ggplot2} package for draw of Advanced Maps as `sf` objects

if (requireNamespace("ggplot2", "RColorBrewer", "dplyr", quietly = TRUE)) {

library(ggplot2)
library(RColorBrewer)
library(dplyr)

# EPSG:4326 or WGS84 - see https://github.com/r-spatial/sf/issues/1419
sf::st_crs(x = kaz_adm0_sf) <- 4326L
sf::st_crs(x = kaz_adm2_sf) <- 4326L

ko_bb <-
  dplyr::filter(kaz_adm1_sf, ADM1_EN == 'Kyzylorda') |>
  # Pulkovo 1942 / Gauss-Kruger CM 63E. See <https://epsg.io/2501>.
  sf::st_transform(crs = 2501) |>
  sf::st_bbox() |>
  sf::st_as_sfc() |>
  sf::st_buffer(dist = 30000)

kaz_adm2_sf |>
  dplyr::filter(ADM1_EN =="Kyzylorda") |>
  dplyr::mutate(ADM2_EN = factor(ADM2_EN, levels = ADM2_EN)) |>
  ggplot2::ggplot() +
  ggplot2::geom_sf(                       # Boundaries of Kazakhstani Oblasts
    data  = sf::st_geometry(kaz_adm1_sf),
    color = "red",
    size  = 1
  ) +
  ggplot2::geom_sf(                       # Rayons of Kyzylorda Oblasts
    mapping = ggplot2::aes(fill = ADM2_EN)
  ) +  # forcats::fct_inorder(ADM2_EN)
  ggplot2::geom_sf_text(                  # Labels of Rayons
    data = dplyr::filter(kaz_adm2_sf, (ADM1_EN == 'Kyzylorda' &
                            magrittr::and(ADM2_EN != "Kyzylorda",
                                          ADM2_EN != "Baykonyr"))),
    mapping = ggplot2::aes(label = ADM2_EN),
    size = 2.5
  ) +
  ggplot2::scale_fill_brewer(palette = "Pastel1") +
  ggplot2::geom_sf( # Administrative Center & City of Republican Significance
    data  = dplyr::filter(kaz_cnt1_sf, ADM1_EN == 'Kyzylorda'),
    size = 3,
    col = "red",
    shape = 19
  ) +
  ggplot2::geom_sf_text(                # Labels of Cities
    data  = dplyr::filter(kaz_cnt1_sf, ADM1_EN == 'Kyzylorda'),
    mapping = ggplot2::aes(label = NAME_EN),
    nudge_x = 65000,
    nudge_y = -9000,
    size = 4
  ) +
  ggplot2::geom_sf(                     # Boundaries of Kazakhstan
    data  = sf::st_geometry(kaz_adm0_sf),
    alpha  = 0,
    color = "brown",
    size  = 2
  ) +
  # Set new Coordinate System: Pulkovo 1942 /
  #  Gauss-Kruger CM 63E. See <https://epsg.io/2501>.
  ggplot2::coord_sf(xlim = c(sf::st_bbox(ko_bb)$xmin, sf::st_bbox(ko_bb)$xmax),
                    ylim = c(sf::st_bbox(ko_bb)$ymin, sf::st_bbox(ko_bb)$ymax),
                    crs = 2501, expand = FALSE) +
  ggplot2::theme_linedraw() +
  ggplot2::guides(fill = ggplot2::guide_legend(
                     title = "Administrative \nunits level 2")) +
  ggplot2::labs(title = "Kazakhstan: Kyzylorda Oblast
(Administrative Center, Rayons & City of Republican Significance)",
x = NULL,
y = NULL
  )
}  # The end for {ggplot2} package


#' @section leaflet:
#' Use {leaflet} package for draw of Interactive Maps as `sf` objects

# Use {leaflet} package for draw of Interactive Maps as `sf` objects

if (requireNamespace("leaflet", "magrittr", quietly = TRUE)) {

library(leaflet)
library(magrittr)

urls <-
  c("Abay_Region", "Akmola_Region", "Aktobe_Region", "Almaty_Region",
    "Atyrau_Region", "West_Kazakhstan_Region", "Jambyl_Region",
    "Jetisu_Region", "Karaganda_Region", "Kostanay_Region",
    "Kyzylorda_Region", "Mangystau_Region", "Pavlodar_Region",
    "North_Kazakhstan_Region", "Turkistan_Region", "Ulytau_Region",
    "East_Kazakhstan_Region", "Astana", "Almaty", "Shymkent")

# Basemap can be varied from a list of {leaflet} providers
# <https://leaflet-extras.github.io/leaflet-providers/preview>.

leaflet::leaflet() |>
  leaflet::addProviderTiles(provider = "Esri.WorldPhysical") |>
  leaflet::addPolygons(
    data = sf::st_zm(geokz::kaz_adm1_sf, geometry),
    weight = 1,
    color = "darkred",
    fillColor = "coral",
    fillOpacity = 0.3,
    smoothFactor = 0.5,
    popup = ~paste0("Region: ",
                    '<a href = "https://en.wikipedia.org/wiki/', urls, '"> ',
                    ADM1_EN, "</a><br>", "KATO: ", KATO, "<br>",
                    "ISO 3166-2: ", ISO_3166_2),
    label = ~paste(ADM1_EN, ":", ADM1_PCODE),
    labelOptions = labelOptions(direction = "auto")
  ) |>
  leaflet::addCircleMarkers(
    data = geokz::kaz_cnt1_sf,
    color = "brown",
    radius = 3,
    label = ~paste0("Center of ", ADM1_EN,": ", NAME_EN)
  )

}  # The end for {leaflet} package
