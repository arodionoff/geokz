data("natural_zones")

# Use {tmap} package for draw of Thematic Maps

if (requireNamespace("tmap", "dplyr", "knitr", quietly = TRUE)) {

library(tmap)
library(dplyr)
library(knitr)

natural_zones %>%
  dplyr::count(ZONE_EN) %>%
  dplyr::bind_rows(., data.frame( ZONE_EN = "TOTAL", n = nrow(natural_zones))) %>%
  knitr::kable(.,
    caption = "Administrative units level 2 by Zones according to <b>natural conditions</b>",
    format.args = list(big.mark = ' ')
  )

dplyr::inner_join( x = get_kaz_rayons_map(),
                   y = natural_zones[, c("ADM2_PCODE", "ZONE_EN")],
                   by = c("ADM2_PCODE" = "ADM2_PCODE") ) %>%
  tmap::qtm(
    shp = .,
    fill = "ZONE_EN",
    fill.title = "Zones according \nto natural conditions",
    main.title = "Zones are distinguished according to natural conditions of Kazakhstan",
    format = "World"
  )

}  # The end for {tmap} package
