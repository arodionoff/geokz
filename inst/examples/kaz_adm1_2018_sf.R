data("kaz_adm1_2018_sf")

library(sf)

# Plotting with dataset
plot(kaz_adm1_2018_sf[, 'KATO'])

# Plotting with function
plot(geokz::get_kaz_oblasts_map(Year = 2018L)[, 'KATO'])
