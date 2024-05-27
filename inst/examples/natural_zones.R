data("natural_zones")

# Use {tmap} package for draw of Thematic Maps

if (requireNamespace("tmap", "dplyr", "knitr", quietly = TRUE)) {

library(tmap)
library(dplyr)
library(knitr)

natural_zones |>
  dplyr::count(ZONE_EN) |>
  dplyr::bind_rows(data.frame( ZONE_EN = "TOTAL", n = nrow(natural_zones))) |>
  knitr::kable(
    caption = "Administrative units level 2 by Zones according to <b>natural conditions</b>",
    format.args = list(big.mark = ' ')
  )

dplyr::inner_join( x = get_kaz_rayons_map(),
                   y = natural_zones[, c("ADM2_PCODE", "ZONE_EN")],
                   by = c("ADM2_PCODE" = "ADM2_PCODE") ) |>
  tmap::qtm(
    fill = "ZONE_EN",
    fill.title = "Zones according \nto natural conditions",
    main.title = "Zones are distinguished according to natural conditions",
    format = "World"
  )

}  # The end for {tmap} package


# Use {ggplot2} package for draw of Advanced Maps as `sf` objects

if (requireNamespace("ggplot2", "dplyr", quietly = TRUE)) {

library(ggplot2)
library(dplyr)

Zones_EN_labels <-
  c("Steppe", "Dry-steppe", "Foothill-desert-steppe", "Desert",
    "South Siberian mountain and foothill", "Semi-desert")

Zones_pallete <- c("yellowgreen", "khaki", "darkolivegreen1", "peachpuff2",
                   "olivedrab", "navajowhite") |>
  stats::setNames(Zones_EN_labels)

natural_zones_df <-
system.file("extdata", "kaz_zones.csv", package = "geokz", mustWork = TRUE) |>
utils::read.csv(encoding = "UTF-8")


dplyr::inner_join( x = get_kaz_rayons_map(),
                 y = natural_zones_df[, c("ADM2_PCODE", "ZONE_EN")],
                 by = c("ADM2_PCODE" = "ADM2_PCODE") ) |>
ggplot2::ggplot() +
  ggplot2::geom_sf(mapping = ggplot2::aes(fill = ZONE_EN)) +  # Rayons - Zones by natural conditions
  ggplot2::geom_sf(                                           # Boundaries of Kazakhstani Oblasts
    data  = sf::st_geometry(get_kaz_oblasts_map()),
    fill = NA,
    color = "red",
    size  = 1.25,
    show.legend = FALSE
  ) +
  ggplot2::scale_fill_manual(
    values = Zones_pallete,
    name = "Zones according \nto natural conditions"
  ) +
  ggplot2::theme_light() +
  ggplot2::labs(title = "Zones are distinguished according to natural conditions",
                x = NULL,
                y = NULL,
                caption = "Source: package {geokz}"
  )

}  # The end for {ggplot2} package

