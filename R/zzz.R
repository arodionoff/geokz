.onAttach <- function(libname, pkgname) {
  geokzVersion <- tryCatch(utils::packageDescription("geokz", fields = "Version"),
                            warning = function(w) return("alpha"),
                            error = function(e) return("alpha"))
  msg <- paste0("geokz ", geokzVersion,
                "\nGeographic coverages of Kazakhstan in ESRI ArcGIS Shapefiles",
                "\nType citation(\"geokz\") for citing this R package in publications")

  if (!interactive())
    msg[1] <- paste("Package 'geokz' version", packageVersion("geokz"))
  packageStartupMessage(msg)
  invisible()
}
