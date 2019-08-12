#' Download OSM from Geofabrik
#' 
#'  @param region geogabrik path to file without start and end e.g. "europe/great-britain/england/west-yorkshire"
#'  @param destfile file path to save file to
#' 
#' 
osmt_geofabrik_dl <- function(region = "europe/great-britain/england/west-yorkshire",
                              destfile = "osm.pbf"){
  url <- paste0("http://download.geofabrik.de/",
                 region,
                 "-latest.osm.pbf")
  utils::download.file(url = url,
                       destfile = destfile,
                       mode = "wb")
  
}
