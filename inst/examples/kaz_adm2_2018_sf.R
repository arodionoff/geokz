data("kaz_adm2_2018_sf")

library(sf)

# Plotting with dataset
plot(kaz_adm2_2018_sf[, 'ADM2_KK'])

# Plotting with function
plot(geokz::get_kaz_rayons_map(Year = 2018L)[, 'ADM2_KK'])
