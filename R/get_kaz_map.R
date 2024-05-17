#' @title Get Oblasts & Cities of Republican Significance of Kazakhstan as `sf` polygons
#'
#' @family general polygon functions
#'
#' @description
#' Returns Geographical features of
#' [Oblasts & Cities of Republican Significance of Kazakhstan](https://en.wikipedia.org/wiki/Regions_of_Kazakhstan) -
#' Map of All Administrative units level 1 (the principal units of a country)
#' as polygons by specified codes or names or all of them in 2022 (default) or 2018 year.
#'
#' @name get_kaz_oblasts_map
#'
#' @usage get_kaz_oblasts_map(
#'                     KATO = NULL,       # Number
#'                     ADM1_EN = NULL,    # Character
#'                     ADM1_KK = NULL,    # Character
#'                     ADM1_RU = NULL,    # Character
#'                     ADM1_PCODE = NULL, # Character
#'                     ISO_3166_2 = NULL, # Character
#'                     crs = "+proj=lcc +lon_0=67 +lat_1=45 +lat_2=51 +ellps=krass",
#'                     Year = 2024L       # Integer
#'                     )
#'
#' @param KATO **A vector** of Codes of **Classifier of Administrative Territorial Objects** (rus.
#' [KATO](https://data.egov.kz/datasets/view?index=kato)) for the required Oblasts &
#'  Cities of Republican Significance of Kazakhstan or `NULL` to get all of them.
#'
#' @param ADM1_EN **A vector** of Names of Administrative units level 1 on English for the
#' required Oblasts & Cities of Republican Significance of Kazakhstan or `NULL` to get all of them.
#'
#' @param ADM1_KK **A vector** of Names of Administrative units level 1 on Kazakh (Cyrillic)
#' characters for the required Oblasts & Cities of Republican Significance of Kazakhstan or
#' `NULL` to get all of them.
#'
#' @param ADM1_RU **A vector** of Names of Administrative units level 1 on Russian (Cyrillic)
#' characters for the required Oblasts & Cities of Republican Significance of Kazakhstan or
#' `NULL` to get all of them.
#'
#' @param ADM1_PCODE **A vector** of _modified_ Codes of **Classifier of Administrative Territorial Objects** (rus.
#' [KATO](https://data.egov.kz/datasets/view?index=kato)) for the required Oblasts &
#' Cities of Republican Significance of Kazakhstan with `'KZ-'` prefix or
#' `NULL` to get all of them.
#'
#' @param ISO_3166_2 **A vector** of Codes for the principal subdivisions coded in
#' [ISO 3166-2](https://en.wikipedia.org/wiki/ISO_3166-2:KZ) or `NULL` to get all of them.
#'
#' @param crs **A value** of Coordinate Reference System as [EPSG (SRID)](https://en.wikipedia.org/wiki/EPSG_Geodetic_Parameter_Dataset)
#' number (for example, 2502) or `proj4string` from the [PROJ.4](https://proj.org/about.html) library
#' (for example, "+proj=longlat +datum=WGS84" as a projection specifier or
#' "+init=epsg:4326" as EPSG number) or `NULL` to get projection for A
#' **Lambert Conformal Conic (LCC)** with [Krasovsky 1940 ellipsoid](https://en.wikipedia.org/wiki/SK-42_reference_system).  See **Details**.
#'
#' @param Year **An integer** of Year for Administrative-Territorial divisions of the Country: 2018 or 2024 (default).
#'
#' @importFrom sf st_crs st_transform
#'
#' @return A `sf` object with the requested geographic geometries.
#'
#' @export
#'
#' @details
#'
#' When filter Geographical features you can use some names of Oblasts &
#' Cities of Republican Significance in English, Kazakh or Russian or National codes
#' (`ADM1_PCODE` or [KATO](https://data.egov.kz/datasets/view?index=kato) corresponding to level 1) or
#' ISO International codes ([ISO 3166-2](https://en.wikipedia.org/wiki/ISO_3166-2:KZ) corresponding to level 1)
#' (see [kaz_adm1_sf]).
#'
#' Astana, Almaty and Shymkent are considered as region on this dataset.
#'
#' Baykonyr (a city near the World's First Spaceport) are not considered on this dataset.
#'
#' Simultaneous use of several types of geographic features codes or
#' names in different languages **is not allowed**.
#'
#' For use non-latin characters in filters you need run `cat(stringi::stri_escape_unicode(x))` code R,
#' for example, `cat(stringi::stri_escape_unicode("\u0428\u044B\u043C\u043A\u0435\u043D\u0442 (\u049B\u0430\u043B\u0430)"))`
#' that is "`r "\u0428\u044B\u043C\u043A\u0435\u043D\u0442 (\u049B\u0430\u043B\u0430)"`" or
#' "\emph{Shymkent (city)}" in Kazakh language. See \code{stringi::\link[stringi]{stri_escape_unicode}} for details.
#'
#' The **Default Projection** uses [A Lambert Conformal Conic (LCC)](https://proj.org/operations/projections/lcc.html)
#'  with \emph{Krasovsky 1940 ellipsoid} and \emph{First standard parallel} - 45 N,
#'  \emph{Second standard parallel} - 51 N, \emph{Longitude of projection center} - 67 E,
#'  \emph{Latitude of projection center} - 48 N.
#'
#' @author
#'
#' Alexander Rodionov \email{a.rodionoff@@gmail.com}, **ORCID** = "0000-0003-2028-5421".

#' @seealso
#'
#' You can upload dataset [kaz_adm1_sf] for Oblasts & Cities of Republican Significance
#' of Kazakhstan directly, but you must manually filter the Geographic Features
#' you require and set the suitable [Cartographic Projection](https://en.wikipedia.org/wiki/List_of_map_projections).
#'
#' For maps of Oblast & City of Republican Significance in 2022 Version  please use function
#' [get_kaz_oblasts_map] () or dataset [geokz::kaz_adm1_sf].
#'
#' For maps of Oblast & City of Republican Significance in 2018 Version  please use function
#' [get_kaz_oblasts_map]`(Year = 2018L)` or dataset [geokz::kaz_adm1_2018_sf].
#'
#' [package vignette](../doc/making_maps.html) or `vignette("making_maps", package = "geokz")`
#'
#' @example inst/examples/get_kaz_oblasts_map.R
#'
get_kaz_oblasts_map <- function(KATO=NULL, ADM1_EN=NULL, ADM1_KK=NULL, ADM1_RU=NULL,
                                ADM1_PCODE=NULL, ISO_3166_2=NULL,
                                crs="+proj=lcc +lon_0=67 +lat_1=45 +lat_2=51 +ellps=krass",
                                Year=2024L) {

  df_sf <-
    if ( is.na(Year) | is.null(Year) | Year >= 2022 ) geokz::kaz_adm1_sf else geokz::kaz_adm1_2018_sf

  if (is.null(KATO) & is.null(ADM1_EN) & is.null(ADM1_KK) & is.null(ADM1_RU) &
      is.null(ADM1_PCODE) & is.null(ISO_3166_2)) {
    df_sf <- df_sf
  } else {
    if ( !is.null(KATO) ) {
      KATO_ <- KATO
      df_sf <- base::subset(df_sf, KATO %in% KATO_)
    } else {
      if ( !is.null(ADM1_EN) ) {
        ADM1_EN_ <- ADM1_EN
        df_sf <- base::subset(df_sf, ADM1_EN %in% ADM1_EN_)
      } else {
        if ( !is.null(ADM1_KK) ) {
          ADM1_KK_ <- ADM1_KK
          df_sf <- base::subset(df_sf, ADM1_KK %in% ADM1_KK_)
        } else {
          if ( !is.null(ADM1_RU) ) {
            ADM1_RU_ <- ADM1_RU
            df_sf <- base::subset(df_sf, ADM1_RU %in% ADM1_RU_)
          } else {
            if ( !is.null(ADM1_PCODE) ) {
              ADM1_PCODE_ <- ADM1_PCODE
              df_sf <- base::subset(df_sf, ADM1_PCODE %in% ADM1_PCODE_)
            } else {
              ISO_3166_2_ <- ISO_3166_2
              df_sf <- base::subset(df_sf, ISO_3166_2 %in% ISO_3166_2_)
            }  }   }   }     }      }

# If you save an sf-dataframe with a newer version of GDAL, and then try st_transform on a system with an older version
# of GDAL, the projection info cannot be read properly. The solution is to re-set the projection:
# EPSG:4326 or WGS84 - World Geodetic System 1984 - see https://github.com/r-spatial/sf/issues/1419
  sf::st_crs(x = df_sf) <- 4326L

# A Lambert Conformal Conic projection (LCC) with Krasovsky 1940 ellipsoid
# <https://proj.org/operations/projections/lcc.html>
# First standard parallel - 45 N, Second standard parallel = 51 N,
# Longitude of projection center - 67 E, Latitude of projection center = 48 N
  df_sf <-
    sf::st_transform(
      x = df_sf,
      crs = crs
      )

  if (nrow(df_sf) == 0) {
    warning("The Conditions you defined specified an empty dataset of geographic features",
            call. = TRUE)
  }

  return(df_sf)

}    # The end of `get_kaz_oblasts_map()`


#' @title Get Rayons Oblasts & Cities of Oblast Significance of Kazakhstan as `sf` polygons
#'
#' @family general polygon functions
#'
#' @description
#' Returns Geographical features of [Rayons of Oblasts & Cities of Oblast Significance of Kazakhstan](https://en.wikipedia.org/wiki/Regions_of_Kazakhstan) -
#' Map of All Administrative units level 2 (the district units of principal units)
#' as polygons by specified codes or names or all of them in 2024 (default) or 2018 year.
#'
#' @name get_kaz_rayons_map
#'
#' @usage get_kaz_rayons_map(
#'                    KATO = NULL,        # Number
#'                    ADM1_EN = NULL,     # Character
#'                    ADM1_KK = NULL,     # Character
#'                    ADM1_RU = NULL,     # Character
#'                    ADM1_PCODE = NULL,  # Character
#'                    ADM2_EN = NULL,     # Character
#'                    ADM2_KK = NULL,     # Character
#'                    ADM2_RU = NULL,     # Character
#'                    ADM2_PCODE = NULL,  # Character
#'                    ISO_3166_2 = NULL,  # Character
#'                    crs = "+proj=lcc +lon_0=67 +lat_1=45 +lat_2=51 +ellps=krass",
#'                    Year = 2024L        # Integer
#'                    )
#'
#' @param KATO **A vector** of Codes of **Classifier of Administrative Territorial Objects** (rus.
#' [KATO](https://data.egov.kz/datasets/view?index=kato)) for the required Oblasts &
#'  Cities of Republican Significance of Kazakhstan or `NULL` to get all of them.
#'
#' @param ADM1_EN **A vector** of Names of Administrative units level 1 on English for the
#' required Oblasts & Cities of Republican Significance of Kazakhstan or `NULL` to get all of them.
#'
#' @param ADM1_KK **A vector** of Names of Administrative units level 1 on Kazakh (Cyrillic)
#' characters for the required Oblasts & Cities of Republican Significance of Kazakhstan or
#' `NULL` to get all of them.
#'
#' @param ADM1_RU **A vector** of Names of Administrative units level 1 on Russian (Cyrillic)
#' characters for the required Oblasts & Cities of Republican Significance of Kazakhstan or
#' `NULL` to get all of them.
#'
#' @param ADM1_PCODE **A vector** of _modified_ Codes of **Classifier of Administrative Territorial Objects** (rus.
#' [KATO](https://data.egov.kz/datasets/view?index=kato)) for the required Oblasts &
#' Cities of Republican Significance of Kazakhstan with `'KZ-'` prefix or
#' `NULL` to get all of them.
#'
#' @param ADM2_EN **A vector** of Names of Administrative units level 2 on English for the
#' required Rayons of Oblasts & Cities of Oblast Significance of Kazakhstan or `NULL` to get all of them.
#'
#' @param ADM2_KK **A vector** of Names of Administrative units level 2 on Kazakh (Cyrillic)
#' characters for the required Rayons of Oblasts & Cities of Oblast Significance of Kazakhstan or
#' `NULL` to get all of them.
#'
#' @param ADM2_RU **A vector** of Names of Administrative units level 2 on Russian (Cyrillic)
#' characters for the required Rayons of Oblasts & Cities of Oblast Significance of Kazakhstan
#' or `NULL` to get all of them.
#'
#' @param ADM2_PCODE **A vector** of _modified_ Codes of **Classifier of Administrative Territorial Objects** (rus.
#' [KATO](https://data.egov.kz/datasets/view?index=kato)) for the required Rayons of Oblasts &
#' Cities of Oblast Significance of Kazakhstan with `'KZ-'` prefix or
#' `NULL` to get all of them.
#'
#' @param ISO_3166_2 **A vector** of Codes for the principal subdivisions coded in
#' [ISO 3166-2](https://en.wikipedia.org/wiki/ISO_3166-2:KZ) or `NULL` to get all of them.
#'
#' @param crs **A value** of Coordinate Reference System as [EPSG (SRID)](https://en.wikipedia.org/wiki/EPSG_Geodetic_Parameter_Dataset)
#' number (for example, 2502) or `proj4string` from the [PROJ.4](https://proj.org/about.html) library
#' (for example, "+proj=longlat +datum=WGS84" as a projection specifier or
#' "+init=epsg:4326" as EPSG number) or `NULL` to get projection for A
#' **Lambert Conformal Conic (LCC)** with [Krasovsky 1940 ellipsoid](https://en.wikipedia.org/wiki/SK-42_reference_system).  See **Details**.
#'
#' @param Year **An integer** of Year for Administrative-Territorial divisions of the Country: 2018 or 2024 (default).
#'
#' @importFrom sf st_crs st_transform
#'
#' @return A `sf` object with the requested geographic geometries.
#'
#' @export
#'
#' @details
#'
#' When filter Geographical features you can use some names of Oblasts &
#' Cities of Republican Significance, Rayons of Oblasts & Cities of Oblast Significance
#' in English, Kazakh or Russian or National codes (`ADM1_PCODE` corresponding to level 1,
#' `ADM2_PCODE` or [KATO](https://data.egov.kz/datasets/view?index=kato) corresponding to level 2)
#' or ISO International codes ([ISO 3166-2](https://en.wikipedia.org/wiki/ISO_3166-2:KZ)
#' corresponding to level 1) (see [kaz_adm2_sf]).
#'
#' Nur-Sultan, Almaty and Shymkent are considered as a set of regions on this dataset.
#'
#' Baykonyr (a city near the World's First Spaceport) are not considered on this dataset.
#'
#' Simultaneous use of several types of geographic features codes or
#' names in different languages **is not allowed**.
#'
#' For use non-latin characters in filters you need run `cat(stringi::stri_escape_unicode(x))` code R,
#' for example, `cat(stringi::stri_escape_unicode("\u0428\u044B\u043C\u043A\u0435\u043D\u0442 (\u049B\u0430\u043B\u0430)"))`
#' that is "`r "\u0428\u044B\u043C\u043A\u0435\u043D\u0442 (\u049B\u0430\u043B\u0430)"`" or
#' "\emph{Shymkent (city)}" in Kazakh language. See \code{stringi::\link[stringi]{stri_escape_unicode}} for details.
#'
#' The **Default Projection** uses [A Lambert Conformal Conic (LCC)](https://proj.org/operations/projections/lcc.html)
#' with \emph{Krasovsky 1940 ellipsoid} and \emph{First standard parallel} - 45 N,
#' \emph{Second standard parallel} - 51 N, \emph{Longitude of projection center} - 67 E,
#' \emph{Latitude of projection center} - 48 N.
#'
#' @author
#'
#' Alexander Rodionov \email{a.rodionoff@@gmail.com}, **ORCID** = "0000-0003-2028-5421".

#' @seealso
#'
#' You can upload dataset [kaz_adm2_sf] for Rayons of Oblasts & Cities of Oblast Significance
#' of Kazakhstan directly, but you must manually filter the Geographic Features
#' you require and set the suitable [Cartographic Projection](https://en.wikipedia.org/wiki/List_of_map_projections).
#'
#' For maps of Rayons of Oblast & City of Oblast Significance in 2024 Version please use function
#' [get_kaz_rayons_map]`()` or dataset [geokz::kaz_adm2_sf].
#'
#' For maps of Rayons of Oblast & City of Oblast Significance in 2018 Version please use function
#' [get_kaz_rayons_map]`(Year = 2018L)` or dataset [geokz::kaz_adm2_2018_sf].
#'
#' [package vignette](../doc/making_maps.html) or `vignette("making_maps", package = "geokz")`
#'
#' @example inst/examples/get_kaz_rayons_map.R
#'
get_kaz_rayons_map <- function(KATO=NULL, ADM1_EN=NULL, ADM1_KK=NULL, ADM1_RU=NULL,
                               ADM1_PCODE=NULL, ADM2_EN=NULL, ADM2_KK=NULL, ADM2_RU=NULL,
                               ADM2_PCODE=NULL, ISO_3166_2=NULL,
                               crs="+proj=lcc +lon_0=67 +lat_1=45 +lat_2=51 +ellps=krass",
                               Year=2024L) {

  df_sf <-
    if ( is.na(Year) | is.null(Year) | Year >= 2024 ) geokz::kaz_adm2_sf else geokz::kaz_adm2_2018_sf

  if (is.null(KATO) & is.null(ADM1_EN) & is.null(ADM1_KK) & is.null(ADM1_RU) &
      is.null(ADM1_PCODE) & is.null(ADM2_EN) & is.null(ADM2_KK) & is.null(ADM2_RU) &
      is.null(ADM2_PCODE) & is.null(ISO_3166_2)) {
    df_sf <- df_sf
  } else {
    if ( !is.null(KATO) ) {
      KATO_ <- KATO
      df_sf <- base::subset(df_sf, KATO %in% KATO_)
    } else {
      if ( !is.null(ADM1_EN) ) {
        ADM1_EN_ <- ADM1_EN
        df_sf <- base::subset(df_sf, ADM1_EN %in% ADM1_EN_)
      } else {
        if ( !is.null(ADM1_KK) ) {
          ADM1_KK_ <- ADM1_KK
          df_sf <- base::subset(df_sf, ADM1_KK %in% ADM1_KK_)
        } else {
          if ( !is.null(ADM1_RU) ) {
            ADM1_RU_ <- ADM1_RU
            df_sf <- base::subset(df_sf, ADM1_RU %in% ADM1_RU_)
          } else {
            if ( !is.null(ADM1_PCODE) ) {
              ADM1_PCODE_ <- ADM1_PCODE
              df_sf <- base::subset(df_sf, ADM1_PCODE %in% ADM1_PCODE_)
            } else {
              if ( !is.null(ADM2_EN) ) {
                ADM2_EN_ <- ADM2_EN
                df_sf <- base::subset(df_sf, ADM2_EN %in% ADM2_EN_)
              } else {
                if ( !is.null(ADM2_KK) ) {
                  ADM2_KK_ <- ADM2_KK
                  df_sf <- base::subset(df_sf, ADM2_KK %in% ADM2_KK_)
                } else {
                  if ( !is.null(ADM2_RU) ) {
                    ADM2_RU_ <- ADM2_RU
                    df_sf <- base::subset(df_sf, ADM2_RU %in% ADM2_RU_)
                  } else {
                    if ( !is.null(ADM2_PCODE) ) {
                      ADM2_PCODE_ <- ADM2_PCODE
                      df_sf <- base::subset(df_sf, ADM2_PCODE %in% ADM2_PCODE_)
                    } else {
                      ISO_3166_2_ <- ISO_3166_2
                      df_sf <- base::subset(df_sf, ISO_3166_2 %in% ISO_3166_2_)
                    }  }   }    }   }  }   }   }     }      }

  # If you save an sf-dataframe with a newer version of GDAL, and then try st_transform on a system with an older version
  # of GDAL, the projection info cannot be read properly. The solution is to re-set the projection:
  # EPSG:4326 or WGS84 - World Geodetic System 1984 - see https://github.com/r-spatial/sf/issues/1419
  sf::st_crs(x = df_sf) <- 4326L

  # A Lambert Conformal Conic projection (LCC) with Krasovsky 1940 ellipsoid
  # <https://proj.org/operations/projections/lcc.html>
  # First standard parallel - 45 N, Second standard parallel = 51 N,
  # Longitude of projection center - 67 E, Latitude of projection center = 48 N
  df_sf <-
    sf::st_transform(
      x = df_sf,
      crs = crs
    )

  if (nrow(df_sf) == 0) {
    warning("The Conditions you defined specified an empty dataset of geographic features",
            call. = TRUE)
  }

  return(df_sf)

}    # The end of `get_kaz_rayons_map()`
