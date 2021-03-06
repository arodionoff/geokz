% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/get_kaz_map.R
\name{get_kaz_oblasts_map}
\alias{get_kaz_oblasts_map}
\title{Get Oblasts & Cities of Republican Significance of Kazakhstan as \code{sf} polygons}
\usage{
get_kaz_oblasts_map(
                    KATO = NULL,       # Number
                    ADM1_EN = NULL,    # Character
                    ADM1_KK = NULL,    # Character
                    ADM1_RU = NULL,    # Character
                    ADM1_PCODE = NULL, # Character
                    ISO_3166_2 = NULL, # Character
                    crs = "+proj=lcc +lon_0=67 +lat_1=45 +lat_2=51 +ellps=krass"
                    )
}
\arguments{
\item{KATO}{\strong{A vector} of Codes of \strong{Classifier of Administrative Territorial Objects} (rus.
\href{https://data.egov.kz/datasets/view?index=kato}{KATO}) for the required Oblasts &
Cities of Republican Significance of Kazakhstan or \code{NULL} to get all of them.}

\item{ADM1_EN}{\strong{A vector} of Names of Administrative units level 1 on English for the
required Oblasts & Cities of Republican Significance of Kazakhstan or \code{NULL} to get all of them.}

\item{ADM1_KK}{\strong{A vector} of Names of Administrative units level 1 on Kazakh (Cyrillic)
characters for the required Oblasts & Cities of Republican Significance of Kazakhstan or
\code{NULL} to get all of them.}

\item{ADM1_RU}{\strong{A vector} of Names of Administrative units level 1 on Russian (Cyrillic)
characters for the required Oblasts & Cities of Republican Significance of Kazakhstan or
\code{NULL} to get all of them.}

\item{ADM1_PCODE}{\strong{A vector} of \emph{modified} Codes of \strong{Classifier of Administrative Territorial Objects} (rus.
\href{https://data.egov.kz/datasets/view?index=kato}{KATO}) for the required Oblasts &
Cities of Republican Significance of Kazakhstan with \code{'KZ-'} prefix or
\code{NULL} to get all of them.}

\item{ISO_3166_2}{\strong{A vector} of Codes for the principal subdivisions coded in
\href{https://en.wikipedia.org/wiki/ISO_3166-2:KZ}{ISO 3166-2} or \code{NULL} to get all of them.}

\item{crs}{\strong{A value} of Coordinate Reference System as \href{https://en.wikipedia.org/wiki/EPSG_Geodetic_Parameter_Dataset}{EPSG (SRID)}
number (for example, 2502) or \code{proj4string} from the \href{https://proj.org/about.html}{PROJ.4} library
(for example, "+proj=longlat +datum=WGS84" as a projection specifier or
"+init=epsg:4326" as EPSG number) or \code{NULL} to get projection for A
\strong{Lambert Conformal Conic (LCC)} with \href{https://en.wikipedia.org/wiki/SK-42_reference_system}{Krasovsky 1940 ellipsoid}.  See \strong{Details}.}
}
\value{
A \code{sf} object with the requested geographic geometries.
}
\description{
Returns Geographical features of
\href{https://en.wikipedia.org/wiki/Regions_of_Kazakhstan}{Oblasts & Cities of Republican Significance of Kazakhstan} -
Map of All Administrative units level 1 (the principal units of a country)
as polygons by specified codes or names or all of them.
}
\details{
When filter Geographical features you can use some names of Oblasts &
Cities of Republican Significance in English, Kazakh or Russian or National codes
(\code{ADM1_PCODE} or \href{https://data.egov.kz/datasets/view?index=kato}{KATO} corresponding to level 1) or
ISO International codes (\href{https://en.wikipedia.org/wiki/ISO_3166-2:KZ}{ISO 3166-2} corresponding to level 1)
(see \link{kaz_adm1_sf}).

Nur-Sultan, Almaty and Shymkent are considered as region on this dataset.

Baykonyr (a city near the World's First Spaceport) are not considered on this dataset.

Simultaneous use of several types of geographic features codes or
names in different languages \strong{is not allowed}.

For use non-latin characters in filters you need run \code{cat(stringi::stri_escape_unicode(x))} code R,
for example, \code{cat(stringi::stri_escape_unicode("\\u0428\\u044B\\u043C\\u043A\\u0435\\u043D\\u0442 (\\u049B\\u0430\\u043B\\u0430)"))}
that is "Шымкент (қала)" or
"\emph{Shymkent (city)}" in Kazakh language. See \code{stringi::\link[stringi]{stri_escape_unicode}} for details.

The \strong{Default Projection} uses \href{https://proj.org/operations/projections/lcc.html}{A Lambert Conformal Conic (LCC)}
with \emph{Krasovsky 1940 ellipsoid} and \emph{First standard parallel} - 45 N,
\emph{Second standard parallel} - 51 N, \emph{Longitude of projection center} - 67 E,
\emph{Latitude of projection center} - 48 N.
}
\examples{

kaz <- get_kaz_oblasts_map()

plot(kaz["ADM1_EN"])

if (requireNamespace("dplyr","tmap", quietly = TRUE)) {

library(dplyr)
library(tmap)

# Western Regions

Western_Region <-
  get_kaz_oblasts_map(ADM1_EN = c(
    "Aktobe",
    "Atyrau",
    "Mangystau",
    "West Kazakhstan"
  ),
  crs = 2500) # Pulkovo 1942 / Gauss-Kruger CM 57E. See <https://epsg.io/2500>.

tmap::qtm(Western_Region,
          fill = "ADM1_EN",
          title = "Western Region of Kazakhstan")

# Simultaneous use of several types of International & National codes or
# names in different languages **is allowed** with binding geographic features

South_Region <-
  get_kaz_oblasts_map(ADM1_EN = c(
    "Almaty",
    "Almaty (city)")) \%>\%
  dplyr::bind_rows(
    get_kaz_oblasts_map(ADM1_KK = c(                                             # Kazakh Language
      "\u0422\u04AF\u0440\u043A\u0456\u0441\u0442\u0430\u043D",                  # Turkestan Region
      "\u0428\u044B\u043C\u043A\u0435\u043D\u0442 (\u049B\u0430\u043B\u0430)"))  # Shymkent City
  ) \%>\%                                                     # cat(stringi::stri_escape_unicode(x))
  dplyr::bind_rows(
    get_kaz_oblasts_map(ISO_3166_2 = c(
      "KZ-ZHA",
      "KZ-KZY"))
  )

tmap::qtm(
  South_Region,
  fill = "ADM1_KK",
  text = "ADM1_EN",
  title = "South Region of Kazakhstan",
  fill.title = "\u041e\u0431\u043b\u044b\u0441 / \u049a\u0430\u043b\u0430",
  projection = 2502
  )

}    # The end for {dplyr}, {magrittr} & {tmap} package
}
\seealso{
You can upload dataset \link{kaz_adm1_sf} for Oblasts & Cities of Republican Significance
of Kazakhstan directly, but you must manually filter the Geographic Features
you require and set the suitable \href{https://en.wikipedia.org/wiki/List_of_map_projections}{Cartographic Projection}.

For maps of Rayons of Oblast & City of Oblast Significance please use function
\link{get_kaz_rayons_map}\verb{()} or dataset \link{kaz_adm2_sf}.

\href{../doc/making_maps.html}{package vignette} or \code{vignette("making_maps", package = "geokz")}

Other general polygon functions: 
\code{\link{get_kaz_rayons_map}()}
}
\author{
Alexander Rodionov \email{a.rodionoff@gmail.com}, \strong{ORCID} = "0000-0003-2028-5421".
}
\concept{general polygon functions}
