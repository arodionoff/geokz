#' @title Kazakhstani administrative divisions & Centers as The Geographic features
#'
#' @description
#'
#' Kazakhstani administrative divisions 0, 1 and 2 levels and Centers as The Geographic features
#'
#' @docType package
#' @name geokz-package
#' @import methods
#' @import utils
#' @import sf
#' @importFrom sf sf.colors st_as_sf st_as_sfc st_bbox st_buffer st_crs
#' @importFrom sf st_drop_geometry st_geometry st_is_valid st_read st_transform st_zm
#' @importFrom utils read.csv str
#'
#' @section Functions:
#'
#'
#' * [get_kaz_oblasts_map](get_kaz_oblasts_map.html) - Get Oblasts & Cities of Republican Significance of Kazakhstan
#'   as `sf` polygons.
#'
#' * [get_kaz_rayons_map](get_kaz_rayons_map.html) - Get Rayons Oblasts & Cities of Oblast Significance of Kazakhstan
#'   as `sf` polygons.
#'
#' @section Datasets with geographic features:
#'
#'   * **kaz_adm?**: Geographic coverage (MULTIPOLYGON) of the country, regions (oblasts) and districts (rayons),
#'     i.e. Administrative units 0, 1 and 2 levels respectively.
#'   * **kaz_cnt1**: Geographic coverage (POINT) the Capital of Kazakhstan (Nur-Sultan),
#'     Cities of Republican Significance (`r prettyNum(nrow(base::subset(geokz::kaz_cnt1_sf, TYPE_CNT1 == 2 | TYPE_CNT1 == 4)))`)
#'     and administrative centers(`r prettyNum(nrow(base::subset(geokz::kaz_cnt1_sf, (TYPE_CNT1 == 3))))`)
#'      of regions (oblasts).
#'
#'   Several languages in datasets is available.
#'
#' @note Languages available are:
#'
#'   * **"en"**: English
#'   * **"kk"**: Kazakh
#'   * **"ru"**: Russian
#'
#' Although in Kazakhstan people mainly use codes [KATO](https://data.egov.kz/datasets/view?index=kato)
#' (rus. - Classifier of Administrative Territorial Objects), an analogue of the Russian classifier **OKATO**,
#' we offer to apply:
#'
#' **ADM1_PCODE** = Two first characters of code according ISO 3166-2 ("KZ") +
#' **AB** characters of \emph{KATO} (two first characters from \emph{TE}),  and
#'
#' **ADM2_PCODE** = Two first characters of code according ISO 3166-2 ("KZ") +
#' **AB** + **CD** + **EF** characters of \emph{KATO} (two six characters from \emph{TE}),
#' for administrative units 1 level there are also geocodes according to [ISO 3166-2](https://en.wikipedia.org/wiki/ISO_3166-2:KZ).
#'
#' [Almaty](https://en.wikipedia.org/wiki/Almaty), [Shymkent](https://en.wikipedia.org/wiki/Shymkent) and
#' [Baykonyr](https://en.wikipedia.org/wiki/Baykonur) has an specific status (City of Republican Significance),
#' but Baykonur (a city near the World's First Spaceport) considered as the city and the rayon
#' in a surrounding [Kyzylorda Region](https://en.wikipedia.org/wiki/Kyzylorda_Region) on this **POINT** dataset.
#'
NULL
