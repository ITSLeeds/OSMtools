#' Convert file format of osm files
#' 
#'  @param file path to file
#'  @param format format to convert to
#' 
#' 
osmt_convert <- function(file, format_out = "o5m"){
  checkmate::assert_os("windows")
  checkmate::assert_choice(format_out, 
                           choice = c("osm","osc",
                                      "osc.gz","osh",
                                      "o5m","o5c","pbf"))
  checkmate::assert_file_exists(file)
  path.package("OSMTools")
  
  
  
}