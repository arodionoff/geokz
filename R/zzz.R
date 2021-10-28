.onLoad <- function(libname, pkgname) {

  utils::data("kaz_adm0_sf", package = "geokz", envir = parent.env(environment()))
  # EPSG:4326 or WGS84 - see https://github.com/r-spatial/sf/issues/1419
  sf::st_crs(x = kaz_adm0_sf) <- 4326L

  utils::data("kaz_adm1_sf", package = "geokz", envir = parent.env(environment()))
  # EPSG:4326 or WGS84 - see https://github.com/r-spatial/sf/issues/1419
  sf::st_crs(x = kaz_adm1_sf) <- 4326L

  utils::data("kaz_adm2_sf", package = "geokz", envir = parent.env(environment()))
  # EPSG:4326 or WGS84 - see https://github.com/r-spatial/sf/issues/1419
  sf::st_crs(x = kaz_adm2_sf) <- 4326L

  utils::data("kaz_cnt1_sf", package = "geokz", envir = parent.env(environment()))
  # EPSG:4326 or WGS84 - see https://github.com/r-spatial/sf/issues/1419
  sf::st_crs(x = kaz_cnt1_sf) <- 4326L

  invisible()
}
