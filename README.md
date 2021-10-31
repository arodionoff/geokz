# geokz    

This project downloads a set of shapefiles relevant to the Republic of Kazakhstan. 

![](man/figures/Kazakhstan.png)

`geokz`-package provides access to multiple dataset of different types and for different use. 

## Package installation

`geokz` can be installed from Github using:

`devtools::install_github("arodionoff/geokz")`

Vignette [*Making maps using {geokz}-package*](https://rpubs.com/A_Rodionoff/geokz) provides multiple real-world examples of their usage.

To use vignettes, you should use the installation with vignettes compilation: `devtools::install_github("arodionoff/geokz", build_vignettes = TRUE)`.

In these vignettes we introduce the different datasets and explain their use cases. 

## The following spatial objects are included:  

**administrative:**

* **kaz_adm0_sf**: Administrative units level 0 - the [boundary of Kazakhstan](inst/shape/kaz_admbnda_adm0_2018.shp).
* **kaz_adm1_sf**: Administrative units level 1 - the [boundaries of Regions](inst/shape/kaz_admbnda_adm1_2018.shp) (the Capital, Oblasts and Cities of Republican Significance).
* **kaz_adm2_sf**: Administrative units level 2 - the [boundaries of Districts](inst/shape/kaz_admbnda_adm2_2018.shp) (Oblast Rayons, City of Oblast Significance and Rayons of Cities of Republican Significance)
* **kaz_cnt1_sf**: All Administrative [Centers](inst/shape/kaz_admbnda_cnt1_2019.shp) level 1 of Kazakhstan including the Capital, Cities of Republican Significance and all center of Oblasts.

**natural:**

* **natural_zones**: the list of Administrative units level 2 of Kazakhstan by Zones according to the natural conditions.

You can use ESRI ArcGIS shapefiles (\*.cpg, \*.dbf, \*.prj, \*.shp, \*.shx) load as [`shape`](inst/shape) subdirectory.

## A call for action

The project is actively maintained, and ideas & suggestions to improve the package are greatly welcome. Should you feel more at ease with old fashioned email than the GitHub ticketing system - do drop me a line.
