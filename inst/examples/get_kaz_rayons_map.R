kaz <- get_kaz_rayons_map()

plot(
  kaz["ADM1_EN"],
  main = "Rayons of Oblasts & Cities of Oblast Significance of Kazakhstan"
)


if (requireNamespace("dplyr", "tmap", quietly = TRUE)) {

library(dplyr)
library(tmap)

# Northern Regions

Northern_Region <-
  c(
    "Akmola",
    "Kostanay",
    "Pavlodar",
    "North Kazakhstan",
    "Nur-Sultan (city)"
  )

tmap::tm_shape(shp = get_kaz_oblasts_map(ADM1_EN = Northern_Region)) +
  tmap::tm_fill(
    "ADM1_EN",
    title = "Administrative \nunits level 1"
    ) +
tmap::tm_shape(
  shp = get_kaz_rayons_map(ADM1_EN = Northern_Region),
  is.master = TRUE
  ) +
  tmap::tm_polygons(
    "MAP_COLORS",
    palette = "Greys",
    alpha = 0.25
    ) +
tmap::tm_shape(get_kaz_oblasts_map()) +
  tmap::tm_borders(lwd = 2) +
  tmap::tm_text("ADM1_KK", size = 1.5, shadow = TRUE) +
  tmap::tm_format(
    format  = "World",
    title    = "Northern Region of Kazakhstan",
    bg.color = "white"
    )

# Simultaneous use of several types of International & National codes or
# names in different languages **is allowed** with binding geographic features

# Torgay Oblast is disbanded Region of the Kazakh Soviet Socialist Republic from 1970 to 1988
# and of independent Kazakhstan and from 1990 to 1997 <https://en.wikipedia.org/wiki/Torgay_Region>.

Torgay_Region <-
  get_kaz_rayons_map(ADM2_EN = c(
    "Esil",
    "Zhaksy",
    "Zharkain")) |>
  dplyr::filter(ADM1_EN == "Akmola") |>  # There are three rayons named Esil by Esil (Ishim) river
  dplyr::bind_rows(
    get_kaz_rayons_map(ADM2_PCODE = c(
      "KZ391600",                         # Arkalyk city was a Center of Torgay Oblast
      "KZ393400",                         # Amangeldi rayon
      "KZ394200")                         # Zhangeldi rayons
      )
  )

center_sf <-
  data.frame(
    NAME = c("Arkalyk"),
    BRANCH = c("The Center"),
    LINK = c("https://en.wikipedia.org/wiki/Arkalyk"),
    LAT = c(50.24861),
    LON = c(66.91139)
  ) |>
  sf::st_as_sf(
    coords = c("LON", "LAT"), # columns with geometry by x - "LON" and y - "LAT"
    crs = "+proj=longlat +datum=WGS84"
  )

to_bb <-
  Torgay_Region |>
  sf::st_bbox() |>
  sf::st_as_sfc() |>
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

}    # The end for {dplyr} & {tmap} package

\dontrun{
  get_kaz_rayons_map("a")
  get_kaz_rayons_map(crs = "a")
}

