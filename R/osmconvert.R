#' Convert file format of osm files
#' 
#' @param file path to file
#' @param format_out format to convert to
#' @param drop_author logical, reduce file size bu removing author info
#' @export 
#' 
osmt_convert <- function(file, format_out = "o5m", drop_author = TRUE){
  checkmate::assert_os("windows")
  checkmate::assert_choice(format_out, 
                           choice = c("osm","osc",
                                      "osc.gz","osh",
                                      "o5m","o5c","pbf"))
  file <- normalizePath(file)
  checkmate::assert_file_exists(file)
  path_out <- paste0(substr(file,1,nchar(file)-3),format_out)
  #checkmate::check_file_exists(path_out)
  path_osmconvert <- file.path(path.package("OSMtools"),"osmconvert.exe")
  path_osmconvert <- normalizePath(path_osmconvert)
  request <- paste0(path_osmconvert, 
                    " ",
                    file,
                    " --out-",
                    format_out)
  if(drop_author){
    request <- paste0(request," --drop-author")
  }
  request <- paste0(request," -o=",path_out)
  
  system(request, intern = TRUE)
  
  
}
