## ADM2: Assigning polygons to correct multipolygons

# Преобразование некорретно разнесенных участков MULTIPOLYGON к корректным адм.-терр. единицам 2 уровня И
# Удаление Z and/or M измерений в этих покрытиях

# See Kazakhstan from United Nations Office for the Coordination of Humanitarian Affairs -
# Subnational Administrative Boundaries from  -
# https://data.humdata.org/dataset/cod-ab-kaz into '/maps'

library('sf')               # Simple Features for R
# library('data.table')       # Extension of `data.frame`
library('tidyverse')        # Easily Install and Load the 'Tidyverse'
library('magrittr')         # A Forward-Pipe Operator for R


# shp1_sf <- sf::st_read('maps/kaz_admbnda_adm1_2019.shp')

shp2_sf <- sf::st_read('maps/kaz_admbnda_adm2_2019.shp') |> # Create 'sf' class from package 'sf'
  # "+proj=tmerc +lat_0=0 +lon_0=69 +k=1 +x_0=500000 +y_0=0 +ellps=krass +towgs84=23.92,-141.27,-80.9,0,0.35,0.82,-0.12 +units=m +no_defs"
  sf::st_transform(crs = '+init=epsg:2598') |>  # Kazakhstan, Kyrgyzstan, Russian Federation onshore
  sf::st_zm(geometry) #  	Drop or add Z and/or M dimensions from feature geometries for get centroids

# Review of ADM2 objects
shp2_sf |>
  sf::st_cast(from = geometry, to = 'POLYGON') |>
  dplyr::mutate( Area = sf::st_area(geometry) ) |>
  dplyr::arrange( ADM2_PCODE, dplyr::desc(Area)) |>
  dplyr::group_by(ADM2_PCODE) |>
  dplyr::mutate(row_no = row_number())
#       sf::st_centroid(geometry) |>
#         dplyr::group_by(ADM2_PCODE) |>
# dplyr::mutate( lag = geometry[ ifelse(dplyr::row_number() == 1, 1, dplyr::row_number() - 1) ],
#                dist = sf::st_distance(geometry, lag, by_element = TRUE) ) |>
#   # dplyr::arrange( ADM2_PCODE, dist) |>
#     magrittr::set_class(value = c('grouped_df', 'tbl_df', 'tbl', 'data.frame')) |>
#       dplyr::mutate( lag = NULL ) |>
#         magrittr::set_class(value = c('sf', 'grouped_df', 'tbl_df', 'tbl', 'data.frame')) |>

# janitor::tabyl(ADM2_PCODE) # |> View

# Набор площадных MULTIPOLYGON объектов с некорретного отнесенными отдельными частями В ПОРЯДКЕ КАК В shp2_sf
corrected_tbl <-
  tibble::tribble( ~ADM2_PCODE, ~Action, ~ADM2_PCODE2,
                   # Целиноградский (Акмолинская обл.)
                   'KZ116600', 'соединить близлежащие к cтолице',  list('KZ116600', 'KZ116600', 'KZ616400', 'KZ196800'),
                   # Талгарский (Алматинская обл.)
                   'KZ196200', 'объединять в Кегенский р-он',      list('KZ196200', 'KZ194400'),
                   # Жамбылский (Жамбылская обл.)
                   'KZ314000', 'объединять в Байзакский р-он',     list('KZ314000', 'KZ313600'),
                   # Жуалынский (Жамбылская обл.)
                   'KZ314200', 'объединять в Байзакский р-он',     list('KZ314200','KZ313600'),
                   # г. Актау (Мангистауская обл.)
                   'KZ471000', 'объединять в Мунайлинский р-он',   list('KZ471000', 'KZ475000'),
                   # Тупкараганский (Мангистауская обл.)
                   'KZ475200', 'два отдавать в Мунайлинский р-он', list(rep('KZ475200', 6), 'KZ475000', 'KZ475200', 'KZ475000' ),
                   # Сайрамский (Туркестанская обл.)
                   'KZ615200', 'объединять в Казыгуртский р-он',   list('KZ615200', 'KZ614000', 'KZ614000')
  )

shp2_sf$ID <- c( 1:nrow(shp2_sf) )

shp2_sf <-
  # Разделение ряда MULTIPOLYGON на POLYGON и присвоение им верных `ADM2_PCODE`
  shp2_sf |>
  dplyr::filter(ADM2_PCODE %in% corrected_tbl$ADM2_PCODE) |>
  sf::st_cast(from = geometry, to = 'POLYGON') |>
  dplyr::mutate( Area = sf::st_area(geometry) ) |>
  dplyr::arrange( ADM2_PCODE, dplyr::desc(Area)) |>
  dplyr::inner_join(y = corrected_tbl, by = c('ADM2_PCODE' = 'ADM2_PCODE')) |>
  dplyr::mutate( ADM2_PCODE = unlist(corrected_tbl$ADM2_PCODE2), ADM2_PCODE2 = NULL, Area = NULL, Action=NULL ) |>
  dplyr::ungroup() |>
  # Присоединение к ним только ДРУГИХ районов, к которым будут присоединяться потерянные участки типа POLYGON
  ( \(d) dplyr::bind_rows( shp2_sf |>
                      dplyr::filter(ADM2_PCODE %in%
                                      setdiff(unlist(corrected_tbl$ADM2_PCODE2), corrected_tbl$ADM2_PCODE) ), d) )() |>
  # Объединение площадных объектов в корректные MULTIPOLYGON
  dplyr::group_by(ADM2_PCODE) |> # group by the character vector `ADM2_PCODE2`
  dplyr::summarise( geometry = sf::st_union(geometry, do_union = TRUE, is_coverage = FALSE)) |>
  dplyr::ungroup() |>
  # magrittr::set_class(value = c('tbl_df', 'tbl', 'data.frame')) |>
  # Перенос корректных MULTIPOLYGON объектов в основной массив с правильныи MULTIPOLYGON объектами
  dplyr::inner_join( x = ., y = sf::st_drop_geometry(shp2_sf), by = c('ADM2_PCODE' = 'ADM2_PCODE')) |>
  .[, names(shp2_sf)] |>
  dplyr::bind_rows( shp2_sf |> dplyr::filter( !ADM2_PCODE %in% c(corrected_tbl$ADM2_PCODE,
                                                                  unlist(corrected_tbl$ADM2_PCODE2)) ) ) |>
  dplyr::arrange(ID) |>
  dplyr::mutate( ID = NULL) |>
  # df_shp2 |> dplyr::relocate(geometry, .after = KATO)
  # Восстановления изначальной проекции WGS84 - World Geodetic System 1984, used in GPS
  sf::st_transform(., crs = '+init=epsg:4326' )

attr(shp2_sf, 'agr') <- NULL   # Remove attributes of Agreggate function

# For Example
tmap::tm_shape( shp2_sf, bbox = dplyr::filter(shp2_sf, ADM2_PCODE == 'KZ475200') |> sf::st_bbox() ) +
  tmap::tm_fill('ADM2_PCODE') +
  tmap::tm_text('ADM1_PCODE') +
  tmap::tmap_options(check.and.fix = TRUE)

# Теперь можно вручную в QGIS исправить конфигурацию измененных объектов и удалить лишние вершины полигонов (vertex)
# Вокруг Актау, южнее Шымкента, севернее Тараза, Бостандыкский р-он Алматы, Талгарский  р-он, Алматинской области
sf::st_write(shp2_sf, 'maps/kaz_admbnda_adm2_2021.shp', layer_options = 'ENCODING=UTF-8', delete_layer = TRUE)
