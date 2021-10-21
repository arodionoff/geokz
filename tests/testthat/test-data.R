# context("Testing dataframes with georaphic coverages") `context()` was deprecated in the 3rd edition.

testthat::test_that("geokz::kaz_adm0_sf dataset for Administrative units level 0
                     (country) can be loaded", {

  # load(paste0("data/", "kaz_adm0_sf.rda"))
  x <- geokz::kaz_adm0_sf

  testthat::expect_true(is.data.frame(x))
  testthat::expect_s3_class(x, "sf")

  testthat::expect_equal(nrow(x), 1L)
  testthat::expect_equal(sf::st_crs(x)$input, "WGS 84")
  testthat::expect_true(all(sf::st_is_valid(x)))

  # structure of datasets...
  testthat::expect_equal(ncol(x), 6L)
  testthat::expect_equal(colnames(x), c("KATO", "ADM0_EN", "ADM0_KK", "ADM0_RU", "ADM0_PCODE",
                                        "geometry"))
  testthat::expect_type(x$KATO,    "character")
  testthat::expect_type(x$ADM0_EN, "character")
  testthat::expect_type(x$ADM0_KK, "character")
  testthat::expect_type(x$ADM0_RU, "character")
  testthat::expect_type(x$ADM0_PCODE, "character")
  testthat::expect_s3_class(x$geometry, c("sfc_MULTIPOLYGON", "sfc"))

})

testthat::test_that("geokz::kaz_adm1_sf dataset for Administrative units level 1
                     (Oblasts) can be loaded", {

  # load(paste0("data/", "kaz_adm1_sf.rda"))
  x <- geokz::kaz_adm1_sf

  testthat::expect_true(is.data.frame(x))
  testthat::expect_s3_class(x, "sf")

  testthat::expect_equal(nrow(x), 17L)
  testthat::expect_equal(sf::st_crs(x)$input, "WGS 84")
  testthat::expect_true(all(sf::st_is_valid(x)))

  # structure of datasets...
  testthat::expect_equal(ncol(x), 11L)
  testthat::expect_equal(colnames(x), c("KATO",
                                        "ADM0_EN", "ADM0_KK", "ADM0_RU", "ADM0_PCODE",
                                        "ADM1_EN", "ADM1_KK", "ADM1_RU", "ADM1_PCODE",
                                        "ISO_3166_2", "geometry"))
  testthat::expect_type(x$KATO,       "character")
  testthat::expect_type(x$ADM0_EN,    "character")
  testthat::expect_type(x$ADM0_KK,    "character")
  testthat::expect_type(x$ADM0_RU,    "character")
  testthat::expect_type(x$ADM0_PCODE, "character")
  testthat::expect_type(x$ADM1_EN,    "character")
  testthat::expect_type(x$ADM1_KK,    "character")
  testthat::expect_type(x$ADM1_RU,    "character")
  testthat::expect_type(x$ADM1_PCODE, "character")
  testthat::expect_type(x$ISO_3166_2, "character")
  testthat::expect_s3_class(x$geometry, c("sfc_MULTIPOLYGON", "sfc"))

})

testthat::test_that("geokz::kaz_adm2_sf dataset for Administrative units level 2
                    (Rayons & Cities of Oblast Significance) can be loaded", {

  # load(paste0("data/", "kaz_adm2_sf.rda"))
  x <- geokz::kaz_adm2_sf

  testthat::expect_true(is.data.frame(x))
  testthat::expect_s3_class(x, "sf")

  testthat::expect_equal(nrow(x), 216L)
  testthat::expect_equal(sf::st_crs(x)$input, "WGS 84")
  testthat::expect_true(all(sf::st_is_valid(x)))

  # structure of datasets...
  testthat::expect_equal(ncol(x), 15L)
  testthat::expect_equal(colnames(x), c("KATO",
                                        "ADM0_EN", "ADM0_KK", "ADM0_RU", "ADM0_PCODE",
                                        "ADM1_EN", "ADM1_KK", "ADM1_RU", "ADM1_PCODE",
                                        "ADM2_EN", "ADM2_KK", "ADM2_RU", "ADM2_PCODE",
                                        "ISO_3166_2", "geometry"))
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
  testthat::expect_s3_class(x$geometry, c("sfc_MULTIPOLYGON", "sfc"))

})

testthat::test_that("geokz::kaz_cnt1_sf dataset for Centers of Administrative units level 1
                    (Oblasts) can be loaded", {

  # load(paste0("data/", "kaz_cnt1_sf.rda"))
  x <- geokz::kaz_cnt1_sf

  testthat::expect_true(is.data.frame(x))
  testthat::expect_s3_class(x, "sf")

  testthat::expect_equal(nrow(x), 18L)
  testthat::expect_equal(sf::st_crs(x)$input, "WGS 84")
  testthat::expect_true(all(sf::st_is_valid(x)))

  # structure of datasets...
  testthat::expect_equal(ncol(x), 15L)
  testthat::expect_equal(colnames(x), c("KATO",
                                        "ADM0_EN", "ADM0_KK", "ADM0_RU", "ADM0_PCODE",
                                        "ADM1_EN", "ADM1_KK", "ADM1_RU", "ADM1_PCODE",
                                        "TYPE_CNT1", "ISO_3166_2",
                                        "NAME_EN", "NAME_KK", "NAME_RU","geometry"))
  testthat::expect_type(x$KATO,       "character")
  testthat::expect_type(x$ADM0_EN,    "character")
  testthat::expect_type(x$ADM0_KK,    "character")
  testthat::expect_type(x$ADM0_RU,    "character")
  testthat::expect_type(x$ADM0_PCODE, "character")
  testthat::expect_type(x$ADM1_EN,    "character")
  testthat::expect_type(x$ADM1_KK,    "character")
  testthat::expect_type(x$ADM1_RU,    "character")
  testthat::expect_type(x$ADM1_PCODE, "character")
  testthat::expect_type(x$TYPE_CNT1,  "integer")
  testthat::expect_type(x$ISO_3166_2, "character")
  testthat::expect_type(x$NAME_EN,    "character")
  testthat::expect_type(x$NAME_KK,    "character")
  testthat::expect_type(x$NAME_RU,    "character")
  testthat::expect_s3_class(x$geometry, c("sfc_MULTIPOLYGON", "sfc"))

})

testthat::test_that("geokz::natural_zones dataset for Zone of Administrative units level 2
                    according to natural conditions can be loaded", {

  # load(paste0("data/", "natural_zones.rda"))
  x <- geokz::natural_zones

  testthat::expect_true(is.data.frame(x))

  testthat::expect_equal(nrow(x), 216L)

  # structure of datasets...
  testthat::expect_equal(ncol(x), 7L)
  testthat::expect_equal(colnames(x),  c("KATO", "ZONE_EN", "ZONE_KK", "ZONE_RU",
                                         "ADM1_RU", "ADM2_RU", "ADM2_PCODE"))
  testthat::expect_type(x$KATO,        "character")
  testthat::expect_s3_class(x$ZONE_EN, "factor")
  testthat::expect_s3_class(x$ZONE_KK, "factor")
  testthat::expect_s3_class(x$ZONE_RU, "factor")
  testthat::expect_type(x$ADM1_RU,     "character")
  testthat::expect_type(x$ADM2_RU,     "character")
  testthat::expect_type(x$ADM2_PCODE,  "character")

})
