# context("Testing function `get_kaz_rayons_map()` with geographic coverage") `context()` was deprecated in the 3rd edition.

testthat::test_that("Get Rayons of Oblasts & Cities of Oblast Significance of Kazakhstan
                    as `sf` polygons for Map of All Administrative units level 2
                    (the district units of principal units) can be loaded", {

  x <- get_kaz_rayons_map()

  testthat::expect_true(is.data.frame(x))
  testthat::expect_s3_class(x, "sf")

  testthat::expect_equal(nrow(x), 224L)
  testthat::expect_equal(sf::st_crs(x)$input, "+proj=lcc +lon_0=67 +lat_1=45 +lat_2=51 +ellps=krass")
  testthat::expect_true(all(sf::st_is_valid(x)))

  # structure of datasets...
  testthat::expect_equal(ncol(x), 16L)
  testthat::expect_equal(colnames(x), c("KATO",
                                        "ADM0_EN", "ADM0_KK", "ADM0_RU", "ADM0_PCODE",
                                        "ADM1_EN", "ADM1_KK", "ADM1_RU", "ADM1_PCODE",
                                        "ADM2_EN", "ADM2_KK", "ADM2_RU", "ADM2_PCODE",
                                        "ISO_3166_2", "Year", "geometry"))
  testthat::expect_type(x$KATO,       "character")
  testthat::expect_type(x$ADM0_EN,    "character")
  testthat::expect_type(x$ADM0_KK,    "character")
  testthat::expect_type(x$ADM0_RU,    "character")
  testthat::expect_type(x$ADM0_PCODE, "character")
  testthat::expect_type(x$ADM1_EN,    "character")
  testthat::expect_type(x$ADM1_KK,    "character")
  testthat::expect_type(x$ADM1_RU,    "character")
  testthat::expect_type(x$ADM1_PCODE, "character")
  testthat::expect_type(x$ADM2_EN,    "character")
  testthat::expect_type(x$ADM2_KK,    "character")
  testthat::expect_type(x$ADM2_RU,    "character")
  testthat::expect_type(x$ADM2_PCODE, "character")
  testthat::expect_type(x$ISO_3166_2, "character")
  testthat::expect_type(x$Year,       "integer")
  testthat::expect_s3_class(x$geometry, c("sfc_MULTIPOLYGON", "sfc"))

  # projection of dataset with geographic features
  testthat::expect_equal(
    sf::st_crs(get_kaz_rayons_map(crs = 2502)),
    sf::st_crs(x = 2502)
  )
  testthat::expect_equal(sf::st_crs(get_kaz_rayons_map(crs = "+proj=webmerc +datum=WGS84"))$input,
                         "+proj=webmerc +datum=WGS84")

  # subset of dataset with geographic features
  testthat::expect_equal(nrow(get_kaz_rayons_map(ADM1_EN = "Almaty (city)")), 8L)
  testthat::expect_silent(get_kaz_rayons_map(ADM1_EN = c(
    "Akmola",
    "Almaty",
    "Mangystau",
    "Jambyl",
    "Turkestan"
  )))
  testthat::expect_warning(get_kaz_rayons_map(KATO = "123456789"),
                  "The Conditions you defined specified an empty dataset of geographic features")

  testthat::expect_warning(plot(get_kaz_rayons_map()))

  testthat::expect_warning( get_kaz_rayons_map("a"))
  testthat::expect_error( get_kaz_rayons_map(crs = "a") )

})
