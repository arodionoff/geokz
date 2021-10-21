
kaz <- get_kaz_oblasts_map()

plot(kaz["ADM1_EN"])

if (requireNamespace("dplyr","tmap", quietly = TRUE)) {

library(dplyr)
library(tmap)

# Western Regions

Western_Region <-
  get_kaz_oblasts_map(ADM1_EN = c(
    "Aktobe",
    "Atyrau",
    "Mangystau",
    "West Kazakhstan"
  ),
  crs = 2500) # Pulkovo 1942 / Gauss-Kruger CM 57E. See <https://epsg.io/2500>.

tmap::qtm(Western_Region,
          fill = "ADM1_EN",
          title = "Western Region of Kazakhstan")

# Simultaneous use of several types of International & National codes or
# names in different languages **is allowed** with binding geographic features

South_Region <-
  get_kaz_oblasts_map(ADM1_EN = c(
    "Almaty",
    "Almaty (city)")) %>%
  dplyr::bind_rows(
    get_kaz_oblasts_map(ADM1_KK = c(                                             # Kazakh Language
      "\u0422\u04AF\u0440\u043A\u0456\u0441\u0442\u0430\u043D",                  # Turkestan Region
      "\u0428\u044B\u043C\u043A\u0435\u043D\u0442 (\u049B\u0430\u043B\u0430)"))  # Shymkent City
  ) %>%                                                     # cat(stringi::stri_escape_unicode(x))
  dplyr::bind_rows(
    get_kaz_oblasts_map(ISO_3166_2 = c(
      "KZ-ZHA",
      "KZ-KZY"))
  )

tmap::qtm(
  South_Region,
  fill = "ADM1_KK",
  text = "ADM1_EN",
  title = "South Region of Kazakhstan",
  fill.title = "\u041e\u0431\u043b\u044b\u0441 / \u049a\u0430\u043b\u0430",
  projection = 2502
  )

}    # The end for {dplyr}, {magrittr} & {tmap} package
