data("kaz_adm0_sf")

library(sf)

# EPSG:4326 or WGS84 - see https://github.com/r-spatial/sf/issues/1419
sf::st_crs(x = kaz_adm0_sf) <- 4326L

# A Lambert Conformal Conic projection (LCC) with Krasovsky 1940 ellipsoid
# <https://proj.org/operations/projections/lcc.html>
# First standard parallel - 45 N, Second standard parallel - 51 N,
# Longitude of projection center - 67 E, Latitude of projection center - 48 N.
# See https://epsg.io/????

kaz_adm0_sf <-
  sf::st_transform(x = kaz_adm0_sf,
                   crs = "+proj=lcc +lon_0=67 +lat_1=45 +lat_2=51 +ellps=krass")

plot(kaz_adm0_sf["ADM0_EN"], main = "Kazakhstan (ADM0)")


# Use {tmap} package for draw of Thematic Maps

if (requireNamespace("tmap", quietly = TRUE)) {

library(tmap)

tmap::qtm(shp = kaz_adm0_sf, fill  = 'coral',
          text = "ADM0_EN", text.col = "gray10", shadow = TRUE,
          border = 'red', frame = TRUE,
          title = "Kazakhstan: Administrative units level 0 (country)"

) +
  tmap::tm_graticules(lines = TRUE)

}  # The end for {tmap} package


# Use {ggplot2} package for draw of Advanced Maps as `sf` objects

if (requireNamespace("ggplot2", quietly = TRUE)) {

library(ggplot2)

ggplot2::ggplot(kaz_adm0_sf) +
  ggplot2::geom_sf(mapping = ggplot2::aes(fill="ADM0_EN"), show.legend=FALSE) +
  ggplot2::ggtitle('Kazakhstan: Administrative units level 0 (country)')

}  # The end for {ggplot2} package

#' @section leaflet:
#' Use {leaflet} package for draw of Interactive Maps as `sf` objects

# Use {leaflet} package for draw of Interactive Maps as `sf` objects

if (requireNamespace("leaflet", "magrittr", quietly = TRUE)) {

library(leaflet)
library(magrittr)

# Transform the data frame from plain dataset one to spatial features
# Geographic degrees (Datum: World Geodetic System 1984) and then plot them
data.frame(
  name = c("Nur-Sultan", "Almaty"),
  branch = c("The Capital", "The Biggest City"),
  link = c("https://en.wikipedia.org/wiki/Nur-Sultan",
           "https://en.wikipedia.org/wiki/Almaty"),
  lat = c(51.166667, 43.2775),
  lon = c(71.433333, 76.8958)
) |>
  sf::st_as_sf(
    coords = c("lon", "lat"), # columns with geometry by x - "lon" and y - "lat"
    crs = "+proj=longlat +datum=WGS84"
    ) |>
leaflet::leaflet() |>                           # Create leaflet object
  leaflet::addProviderTiles(provider = "Wikimedia") |>   # Add basemap
  leaflet::addPolygons(                                  # Add data layer - polygon
    data = geokz::kaz_adm0_sf |> sf::st_zm(geometry),    # Drop or add Z and/or M dimensions
    fill = NA,
    color = "grey"
    ) |>
  leaflet::addCircleMarkers(                             # Add data layer - markers
    color = "red",
    opacity = 0.5,
    radius = 3,
    popup = ~paste(branch, ":", '<a href = ', '"', link, '"> ', name, '</a>'),
    label = ~paste(branch, ":", name)
    )

}  # The end for {leaflet} package
