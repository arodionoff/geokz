# geokz    

This project downloads a set of shapefiles relevant to the Republic of Kazakhstan. 

![](images/Kazakhstan.png)

`geokz`-package provides access to multiple dataset of different types and for different use. In this vignette we introduce the different datas and explain their use cases. 

## Package installation {#package_installation}

`geokz` can be installed from Github using:

`remotes::install_github("arodionoff/geokz")`

Vignette [*Making maps using {geokz}-package*](vignettes/making_maps.Rmd) provides multiple real-world examples of their usage.

## The following spatial objects are included:  

administrative:

* **kaz_adm0_sf**: Administrative units level 0 - the boundary of Kazakhstan.
* **kaz_adm1_sf**: Administrative units level 1 - the boundaries of Regions (the Capital, Oblasts and Cities of Republican Significance).
* **kaz_adm2_sf**: Administrative units level 2 - the boundaries of Districts (Oblast Rayons, City of Oblast Significance and Rayons of Cities of Republican Significance)
* **kaz_cnt1_sf**: All Administrative centers level 1 of Kazakhstan including the Capital, Cities of Republican Significance and all center of Oblasts.

natural:

* **natural_zones**: the list of Administrative units level 2 of Kazakhstan by Zones according to the natural conditions.

## A call for action

The project is actively maintained, and ideas & suggestions to improve the package are greatly welcome. Should you feel more at ease with old fashioned email than the GitHub ticketing system - do drop me a line.