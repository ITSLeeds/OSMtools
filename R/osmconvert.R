#' Convert file format of osm files
#'
#' @param file path to file
#' @param format_out format to convert to
#' @param drop_author logical, reduce file size bu removing author info
#' @param overwrite logical, should existing file be overwritten, default = FALSE
#' @export
#'
osmt_convert <- function(file,
                        format_out = "pbf",
                        drop_author = TRUE,
                        overwrite = FALSE){
  
  # Check Inputs
  checkmate::assert_choice(format_out,
                           choice = c("osm","osc",
                                      "osc.gz","osh",
                                      "o5m","o5c","pbf"))
  file <- normalizePath(file)
  checkmate::assert_file_exists(file)
  path_out <- paste0(substr(file,1,nchar(file)-3),format_out)
  if(checkmate::check_file_exists(path_out)){
    if(!overwrite){
      stop(paste0(path_out," already exists"))
    }
  }
  
  if(checkmate::check_os("windows")){
    path_osmconvert <- file.path(path.package("geofabric"),"inst","osmconvert.exe")
  } else if(checkmate::check_os("linux")){
    path_osmconvert <- file.path(path.package("geofabric"),"inst","osmconvert64")
  } else {
    stop("OS is not supported")
  }
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