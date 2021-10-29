# context("Testing ESRI ArcGIS shapefiles with geographic coverages") `context()` was deprecated in the 3rd edition.

testthat::test_that("kaz_admbnda_adm0_2018.shp ESRI ArcGIS for Administrative units level 0
                     (country) can be loaded", {

   x <- sf::st_read(system.file("shape/kaz_admbnda_adm0_2018.shp", package = "geokz"),
                    "kaz_admbnda_adm0_2018", crs = 4326L, quiet = TRUE)

   testthat::expect_true(is.data.frame(x))
   testthat::expect_s3_class(x, "sf")
   testthat::expect_true(all(sf::st_is_valid(x)))

   # Coordinate Reference System of object
   # EPSG:4326 or WGS84 - see https://github.com/r-spatial/sf/issues/1419
   testthat::expect_warning(sf::st_crs(x = x) <- 4326L, NA)
   testthat::expect_silent(x <-
                             sf::st_transform(x = x,
                                              crs = "+proj=lcc +lon_0=67 +lat_1=45 +lat_2=51 +ellps=krass"))
   testthat::expect_equal(sf::st_crs(x)$input, "+proj=lcc +lon_0=67 +lat_1=45 +lat_2=51 +ellps=krass")
   testthat::expect_silent(x <- sf::st_transform(x = x, crs = "EPSG:4326"))

   # structure of datasets...
   testthat::expect_equal(nrow(x), 1L)
   testthat::expect_equal(ncol(x), 6L)
   testthat::expect_equal(colnames(x), c("KATO", "ADM0_EN", "ADM0_KK", "ADM0_RU", "ADM0_PCODE",
                                         "geometry"))
   testthat::expect_type(x$KATO,       "character")
   testthat::expect_type(x$ADM0_EN,    "character")
   testthat::expect_type(x$ADM0_KK,    "character")
   testthat::expect_type(x$ADM0_RU,    "character")
   testthat::expect_type(x$ADM0_PCODE, "character")
   testthat::expect_s3_class(x$geometry, c("sfc_MULTIPOLYGON", "sfc"))

})
