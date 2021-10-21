data("kaz_adm1_sf")
data("kaz_adm2_sf")

library(sf)

# A Lambert Conformal Conic projection (LCC) with Krasovsky 1940 ellipsoid
# <https://proj.org/operations/projections/lcc.html>
# First standard parallel - 45 N, Second standard parallel - 51 N,
# Longitude of projection center - 67 E, Latitude of projection center - 48 N.
# See https://epsg.io/2502

kaz_adm2_sf <-
  sf::st_transform(x = kaz_adm2_sf,
                   crs = "+proj=lcc +lon_0=67 +lat_1=45 +lat_2=51 +ellps=krass")

plot(x = kaz_adm2_sf["ADM2_EN"], border = "grey",
     main = "Kazakhstan: Rayons & Cities of Oblast Significance (ADM2)")

# Administrative Map of Units Level 1 & Level 2
kaz_adm1_sf <-
  sf::st_transform(x = kaz_adm1_sf,
                   crs = "+proj=lcc +lon_0=67 +lat_1=45 +lat_2=51 +ellps=krass")

plot(x = kaz_adm2_sf["ADM2_EN"],  reset = FALSE,
     col = rev(sf::sf.colors(nrow(kaz_adm2_sf))), border = "grey",
     main = "Kazakhstani Oblasts: Rayons & Cities of Oblast Significance (ADM2)")
# when plotting some coverages, the reset = FALSE is needed:
plot(x = sf::st_geometry(kaz_adm1_sf), lwd = 2, border = "darkred", add = TRUE)


# Use {tmap} package for draw of Thematic Maps

if (requireNamespace("tmap", quietly = TRUE)) {

library(tmap)

tmap::qtm(shp = kaz_adm2_sf, fill = "ADM1_PCODE",
        border = 'grey', scale = 0.8, frame = TRUE,
        title = "Kazakhstan: Adm. units level 2 (Rayons & Cities of Oblast Significance)\n",
        fill.title = "Oblasts & \nCities of Republican \nSignificance",
        fill.labels = kaz_adm1_sf$ADM1_KK,
        format = 'World_wide'
) +
tmap::tm_graticules(lines = FALSE)

# Facets with {tmap}: by splitting the spatial data with the by argument of tmap::tm_facets

tmap::tm_shape(
  kaz_adm2_sf,
  # Web Mercator / Pseudo Mercator. See <https://proj.org/operations/projections/webmerc.html>.
  projection = "+proj=webmerc +datum=WGS84"
  ) +
  tmap::tm_polygons(
    col = "ADM1_PCODE",
    palette = "RdYlBu",
    border.col = 'grey',
    legend.show = FALSE
  ) +
  tmap::tm_facets(by = "ADM1_EN") +
  tmap::tm_layout(
    main.title = "Kazakhstan: Administrative units level 1
(Oblasts & Cities of Republican Significance)",
    legend.position = NULL
  )

}  # The end for {tmap} package


# Use {ggplot2} package for draw of Advanced Maps as `sf` objects

if (requireNamespace(c("ggplot2", "RColorBrewer", "dplyr"), quietly = TRUE)) {

library(ggplot2)
library(RColorBrewer)
library(dplyr)

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

}  # The end for {ggplot2} package


# Use {leaflet} package for draw of Interactive Maps as `sf` objects

if (requireNamespace("leaflet", "magrittr", quietly = TRUE)) {

library(leaflet)
library(magrittr)

pal <- leaflet::colorNumeric("Pastel2", domain =as.integer(kaz_adm1_sf$KATO))

leaflet::leaflet(data = sf::st_zm(geokz::kaz_adm1_sf, geometry)) %>%
  leaflet::addProviderTiles(provider = "Esri.WorldShadedRelief") %>%
  leaflet::addPolygons(
    weight = 2,
    color = "darkred",
    opacity = 1,
    fillColor = ~pal(as.integer(KATO)),
    fillOpacity = 0.3,
    smoothFactor = 0.5,
  ) %>%
  leaflet::addPolygons(
    data = geokz::kaz_adm2_sf,
    weight = 1,
    color = "grey",
    fillColor = NULL,
    smoothFactor = 0.5,
    label = ~paste(ADM1_EN, "Region :", ADM2_EN),
    labelOptions = labelOptions(direction = "auto"),
    highlightOptions = highlightOptions(color = "red", weight = 3, bringToFront = TRUE)
  )

}  # The end for {leaflet} package
