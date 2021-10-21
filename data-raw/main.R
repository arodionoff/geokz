## Create a New package

library('devtools')         # Tools to Make Developing R Packages Easier
library('sf')               # Simple Features for R

options(
  usethis.description = list(
    `Authors@R` = 'person("Alexander", "Rodionov", email = "a.rodionoff@gmail.com",
                          role = c("aut", "cre"))',
  )
)

usethis::create_tidy_package(path = 'D:/Users/ARodionov/Documents/Projects/21.09_geokz/geokz')
usethis::use_ccby_license() # Creative commons licenses appropriate for data packages CC-BY: Free to share and adapt, must give appropriate credit.

backports::import(pkgname = c('sf', 'magrittr')) # Import backported functions into your package from {sf}, {magrittr}

# usethis::use_data_raw('correct_adm2')  # Скрипта R для корректировки kaz_admbnda_adm2_2019.shp в kaz_admbnda_adm2_2021.shp

# usethis::use_data_raw('kaz_adm0_1_2_sf')  # Формирование из kaz_admbnda_adm0_2019.shp, kaz_admbnda_adm1_2021.shp, kaz_admbnda_adm2_2019.shp, kaz_admcntr_adm1_2018.shp `sf` объекта

# usethis::use_citation()  # Create a CITATION template in `inst/CITATION`

usethis::use_r("geokz-package")    # Documenting Packages
usethis::use_r("get_kaz_map")      # Functions
usethis::use_r("data")             # Data (create data: data-raw/create_data_sf.R, data-raw/correct_adm2.R)

usethis::use_vignette("making_maps") # Create Vignettes in package {geokz}
