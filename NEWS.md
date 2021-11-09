# geokz 0.0.0.944

## New features

* Create a vignette on on direct loading ESRI ArcGIS shape files (*.shp) with R & Python scripts.

* Add this NEWS file.

## Minor improvements and bug fixes

* Fixed bugs and mistakes in texts.

# gt 0.0.0.9037

This release focuses on two main areas:

1. Provide reliable Kazakhstani geographic coverages:
* **kaz_adm0_sf**: Administrative units level 0 - the [boundary of Kazakhstan](../inst/shape/kaz_admbnda_adm0_2018.shp).
* **kaz_adm1_sf**: Administrative units level 1 - the [boundaries of Regions](../inst/shape/kaz_admbnda_adm1_2018.shp) (the Capital, Oblasts and Cities of Republican Significance).
* **kaz_adm2_sf**: Administrative units level 2 - the [boundaries of Districts](../inst/shape/kaz_admbnda_adm2_2018.shp) (Oblast Rayons, City of Oblast Significance and Rayons of Cities of Republican Significance)
* **kaz_cnt1_sf**: All Administrative [Centers](../inst/shape/kaz_admbnda_cnt1_2019.shp) level 1 of Kazakhstan including the Capital, Cities of Republican Significance and all center of Oblasts.
* **natural_zones**: the list of Administrative units level 2 of Kazakhstan by Zones according to the natural conditions.

2. Demonstrate the semantics of using functions `get_kaz_oblasts_map()` & `get_kaz_rayons_map()` and datasets of class `sf` in real examples, both help and vignette:
    * Basic **{graphics}** package;
    * Thematic maps **{tmap}** package;
    * Advanced data visualization **{ggplot2}** package;
    * Interactive map widget using **{leaflet}** package.
