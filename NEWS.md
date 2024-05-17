# geokz 1.0.0

## Major improvements

This release focuses on four main areas:

1. The creation of three new Kazakhstani Oblasts (Abay Oblast - the administrative center - Semey, Zhetysu Oblast - Taldykorgan, Ulytau Oblast - Zhezkazgan), as well as the transformation of districts in them.

2. Recreation of districts in the Abay Oblast & the East Kazakhstan Oblast and the establishment of new cities of regional significance in the Akmola Oblast - Kosshy and in the Almaty Oblast - Alatau (old name - Zhetigen).

3. Transfer of the administrative center of the Almaty Oblast to the city of Konaiev (old name - Kapshagay), establishment of new urban districts in the capital Astana and the city of Republican Significance - Shymkent.

4. Add Argument of `Year` for some functions for different administrative-territorial divisions of the Country in 2018 and 2024 years.

## Minor improvements

* Clarification of the boundaries of some Rayons of the Oblasts of Kazakhstan.

* Fixed bugs and mistakes in texts.

# geokz 0.0.0.951

## Minor improvements

* Add attributes `agr` into geographic coverages for correct aggregation of spatial features.

# geokz 0.0.0.950

## Minor improvements and bug fixes

* Fixed bugs and mistakes in `kaz_adm2_sf` geographic coverage and `kaz_admbnda_adm2_2018.shp` shapefile.

# geokz 0.0.0.946

## New features

* Create a vignette on on direct loading ESRI ArcGIS shape files (*.shp) with R & Python scripts.

* Add this NEWS file.

## Minor improvements and bug fixes

* Fixed bugs and mistakes in texts.

# geokz 0.0.0.9037

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
