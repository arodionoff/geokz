#' @title Map of Administrative units level 0 (The the boundaries of a Kazakhstan)
#'
#' @family datasets with geographic features
#'
#' @name kaz_adm0_sf
#'
#' @docType data
#'
#' @keywords datasets
#'
#' @description
#' A `sf` object including Administrative units level 0 (the boundaries of Kazakhstan)
#' `MULTIPOLYGON` object of Kazakhstan (2018 version) without administrative divisions of the country itself.
#'
#' @source
#' <https://data.humdata.org/dataset/kazakhstan-administrative-boundaries-taxonomy>, files
#' `kaz_admbnda_adm0_2019.shp`, `kaz_admbnda_adm0_2019.shx`, `kaz_admbnda_adm0_2019.dbf`,
#' `kaz_admbnda_adm0_2019.prj` & `kaz_admbnda_adm0_2019.cpg`.
#'
#' @usage data(kaz_adm0_sf)
#'
#' @format
#' A `MULTIPOLYGON` data frame (resolution: 1:1million, EPSG:4326 or WGS84 - World Geodetic System 1984) object with
#' `r prettyNum(nrow(geokz::kaz_adm0_sf), big.mark=",")` rows and fields:
#'   * KATO: Classifier of Administrative Territorial Objects (rus.
#'       [KATO](https://data.egov.kz/datasets/view?index=kato)) - for contry is "000000000"
#'   * ADM0_EN: Name of country on Latin characters
#'   * ADM0_KK: Name of country on Kazakh (Cyrillic) characters
#'   * ADM0_RU: Name of country on Russian (Cyrillic) characters
#'   * ADM0_PCODE: Two first characters of code according ISO 3166-2 ("KZ")
#'   * geometry: geometry field (`sf` object)
#'
#' @seealso [get_kaz_oblasts_map]
#'
#' [package vignette](../doc/making_maps.html#spatial_data) or `vignette("making_maps", package = "geokz")`
#'
#' @example inst/examples/kaz_adm0_sf.R
NULL

#' @title Map of All Administrative units level 1 (the principal units of a country) of Kazakhstan
#'
#' @family datasets with geographic features
#'
#' @name kaz_adm1_sf
#'
#' @docType data
#'
#' @keywords datasets
#'
#' @description
#' A `sf` object including All Administrative units level 1 (the largest subnational units of a country)
#' **MULTIPOLYGON** object of Kazakhstan (2018 version after the separation of Shymkent into a City of Republican
#' Significance). It contains 14 regions, the Capital - Nur-Sultan (city) and 3 Cities of Republican Significance.
#'
#' @source
#' <https://data.humdata.org/dataset/kazakhstan-administrative-boundaries-taxonomy>, files
#' `kaz_admbnda_adm1_2019.shp`, `kaz_admbnda_adm1_2019.shx`, `kaz_admbnda_adm1_2019.dbf`,
#' `kaz_admbnda_adm1_2019.prj` & `kaz_admbnda_adm1_2019.cpg`.
#'
#' @usage data(kaz_adm1_sf)
#'
#' @format
#' A `MULTIPOLYGON` data frame (resolution: 1:1million, EPSG:4326 or WGS84 - World Geodetic System 1984) object with
#' `r prettyNum(nrow(geokz::kaz_adm1_sf), big.mark=",")` rows and fields:
#'   * KATO: Classifier of Administrative Territorial Objects (rus.
#'       [KATO](https://data.egov.kz/datasets/view?index=kato))
#'   * ADM0_EN: Name of country on Latin characters
#'   * ADM0_KK: Name of country on Kazakh (Cyrillic) characters
#'   * ADM0_RU: Name of country on Russian (Cyrillic) characters
#'   * ADM0_PCODE: Two first characters of code according ISO 3166-2 ("KZ")
#'   * ADM1_EN: Name of Administrative units level 1 on Latin characters
#'   * ADM1_KK: Name of Administrative units level 1 on Kazakh (Cyrillic) characters
#'   * ADM1_RU: Name of Administrative units level 1 on Russian (Cyrillic) characters
#'   * ADM1_PCODE: Two first characters of code according ISO 3166-2 ("KZ") + __AB__ characters of _KATO_ (two first characters from _TE_)
#'   * ISO_3166_2: Codes for the principal subdivisions coded in [ISO 3166-2](https://en.wikipedia.org/wiki/ISO_3166-2:KZ).
#'   * geometry: geometry field (`sf` object)
#'
#' @seealso [get_kaz_oblasts_map]
#'
#' [package vignette](../doc/making_maps.html#spatial_data) or `vignette("making_maps", package = "geokz")`
#'
#' @example inst/examples/kaz_adm1_sf.R
NULL

#' @title Map of All Administrative units level 2 (the district units of principal units) of Kazakhstan
#'
#' @family datasets with geographic features
#'
#' @name kaz_adm2_sf
#'
#' @description
#' A **MULTIPOLYGON** `sf` object including all districts (rayons) of Kazakhstan (2018 version).
#' They contain Rayons of Oblast & City of Oblast Significance and also Rayons of City of
#' Republican Significance. The borders of districts were corrected by Alexander Rodionov in
#' [QGIS](https://qgis.org/).
#'
#' @docType data
#'
#' @keywords datasets
#'
#' @source
#' <https://data.humdata.org/dataset/kazakhstan-administrative-boundaries-taxonomy>, files
#' `kaz_admbnda_adm2_2019.shp`, `kaz_admbnda_adm2_2019.shx`, `kaz_admbnda_adm2_2019.dbf`,
#' `kaz_admbnda_adm2_2019.prj` & `kaz_admbnda_adm2_2019.cpg`.
#'
#' @usage data(kaz_adm2_sf)
#'
#' @format
#' A `MULTIPOLYGON` data frame (resolution: 1:1million, EPSG:4326 or WGS84 - World Geodetic System 1984) object with
#' `r prettyNum(nrow(geokz::kaz_adm2_sf), big.mark=",")` rows and fields:
#'   * KATO: Classifier of Administrative Territorial Objects (rus.
#'       [KATO](https://data.egov.kz/datasets/view?index=kato))
#'   * ADM0_EN: Name of country on Latin characters
#'   * ADM0_KK: Name of country on Kazakh (Cyrillic) characters
#'   * ADM0_RU: Name of country on Russian (Cyrillic) characters
#'   * ADM0_PCODE: Two first characters of code according ISO 3166-2 ("KZ")
#'   * ADM1_EN: Name of Administrative units level 1 on Latin characters
#'   * ADM1_KK: Name of Administrative units level 1 on Kazakh (Cyrillic) characters
#'   * ADM1_RU: Name of Administrative units level 1 on Russian (Cyrillic) characters
#'   * ADM1_PCODE: Two first characters of code according ISO 3166-2 ("KZ") + __AB__ characters of _KATO_ (two first characters from _TE_)
#'   * ADM2_EN: Name of Administrative units level 2 on Latin characters
#'   * ADM2_KK: Name of Administrative units level 2 on Kazakh (Cyrillic) characters
#'   * ADM2_RU: Name of Administrative units level 2 on Russian (Cyrillic) characters
#'   * ADM2_PCODE: Two first characters of code according ISO 3166-2 ("KZ") + (__AB__ characters of _KATO_ + __CD__ characters of _KATO_ + __EF__ characters of _KATO_) or six first characters from _TE_
#'   * ISO_3166_2: Codes for the principal subdivisions coded in [ISO 3166-2](https://en.wikipedia.org/wiki/ISO_3166-2:KZ).
#'   * geometry: geometry field (`sf` object)
#'
#' @seealso [get_kaz_rayons_map]
#'
#' [package vignette](../doc/making_maps.html#spatial_data) or `vignette("making_maps", package = "geokz")`
#'
#' @section Figures:
#' \if{html}{\figure{Kazakhstan.png}{options: width=100\%}}  % man/figures/Kazakhstan.png
#' \if{latex}{\figure{Kazakhstan.png}{options: width=7.5in}}
#'
#' @example inst/examples/kaz_adm2_sf.R
#'
NULL

#' @title Map of All Administrative centers level 1 of Kazakhstan
#'
#' @family datasets with geographic features
#'
#' @name kaz_cnt1_sf
#'
#' @description
#' A **POINT** `sf` object including the Capital Nur-Sultan (formerly Astana), 3 Cities of
#' Republican Significance (Almaty, Shymkent and also Baikonur or Baykonyr, near is
#' the World's First Spaceport) and all center of Oblasts (the principal units
#' of a country) of Kazakhstan (2019 version).  The cities mapped by Alexander Rodionov in
#' [QGIS](https://qgis.org/).
#'
#' @docType data
#'
#' @keywords datasets
#'
#' @source
#' <https://en.wikipedia.org/wiki/List_of_cities_in_Kazakhstan>.
#'
#' @usage data(kaz_cnt1_sf)
#'
#' @format
#' A `POINT` data frame (resolution: 1:1million, EPSG:4326 or WGS84 - World Geodetic System 1984) object with
#' `r prettyNum(nrow(geokz::kaz_cnt1_sf), big.mark=",")` rows and fields:
#'   * KATO: Classifier of Administrative Territorial Objects (rus.
#'       [KATO](https://data.egov.kz/datasets/view?index=kato))
#'   * ADM0_EN: Name of country on Latin characters
#'   * ADM0_KK: Name of country on Kazakh (Cyrillic) characters
#'   * ADM0_RU: Name of country on Russian (Cyrillic) characters
#'   * ADM0_PCODE: Two first characters of code according ISO 3166-2 ("KZ")
#'   * ADM1_EN: Name of Administrative units level 1 on Latin characters
#'   * ADM1_KK: Name of Administrative units level 1 on Kazakh (Cyrillic) characters
#'   * ADM1_RU: Name of Administrative units level 1 on Russian (Cyrillic) characters
#'   * ADM1_PCODE: Two first characters of code according ISO 3166-2 ("KZ") + __AB__ characters of _KATO_ (two first characters from _TE_)
#'   * TYPE_CNT1:  Type of cities (1 - Capital, 2 - Republican Significance, 3 - Center of Oblasts, 4 - Baykonyr:
#'         near is the world's first spaceport)
#'   * ISO_3166_2: Codes for the principal subdivisions coded in [ISO 3166-2](https://en.wikipedia.org/wiki/ISO_3166-2:KZ).
#'   * NAME_EN: Name of cities on Latin characters
#'   * NAME_KK: Name of cities on Kazakh (Cyrillic) characters
#'   * NAME_RU: Name of cities on Russian (Cyrillic) characters
#'   * geometry: geometry field (`sf` object)
#'
#' @seealso [get_kaz_oblasts_map]
#'
#' [package vignette](../doc/making_maps.html#spatial_data) or `vignette("making_maps", package = "geokz")`
#'
#' @example inst/examples/kaz_cnt1_sf.R
#'
NULL

#' @title Administrative units level 2 of Kazakhstan by Zones according to the natural conditions
#'
#' @family datasets with Natural Zones
#'
#' @name natural_zones
#'
#' @description
#' A `data.frame` object including the list of Administrative units level 2 of Kazakhstan
#' by Zones according to the natural conditions.
#'
#' @docType data
#'
#' @keywords datasets
#'
#' @source
#' [The list of administrative-territorial regions according to the natural conditions of the Republic of Kazakhstan](https://adilet.zan.kz/rus/docs/V2000021691#z70).
#'
#' @usage data(natural_zones)
#'
#' @format
#' A data frame object with `r prettyNum(nrow(geokz::natural_zones), big.mark=",")` rows and fields:
#'   * KATO: Classifier of Administrative Territorial Objects (rus.
#'       [KATO](https://data.egov.kz/datasets/view?index=kato))
#'   * ZONE_EN: Name of Zone on English (Latin) characters
#'   * ZONE_KK: Name of Zone on Kazakh (Cyrillic) characters
#'   * ZONE_RU: Name of Zone on Russian (Cyrillic) characters
#'   * ADM1_RU: Name of Administrative units level 1 on Russian (Cyrillic) characters
#'   * ADM2_RU: Name of Administrative units level 2 on Russian (Cyrillic) characters
#'   * ADM2_PCODE: Two first characters of code according ISO 3166-2 ("KZ") + (__AB__ characters of _KATO_ + __CD__ characters of _KATO_ + __EF__ characters of _KATO_) or six first characters from _TE_
#'
#' @seealso [get_kaz_rayons_map]
#'
#' [package vignette](/doc/making_maps.html#natural_conditions) or `vignette("making_maps", package = "geokz")`
#'
#' @example inst/examples/natural_zones.R
NULL
