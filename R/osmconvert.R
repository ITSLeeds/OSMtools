#' Convert file format of osm files
#'
#' @param file path to file
#' @param format_out format to convert to
#' @param drop_author logical, reduce file size by removing author info
#' @param bbox sf bbox, from st_bbox(), or a 2x2 matrix lng/lat coordinates for bottom left and top right corners
#' @export 
#' 
osmt_convert <- function(file, format_out = "o5m", drop_author = TRUE, bbox = NULL){
  checkmate::assert_choice(format_out, 
                           choice = c("osm","osc",
                                      "osc.gz","osh",
                                      "o5m","o5c","pbf"))
  file <- normalizePath(file)
  checkmate::assert_file_exists(file)
  path_out <- paste0(substr(file,1,nchar(file)-3),format_out)
  checkmate::check_file_exists(path_out)

  if(checkmate::check_os("windows")){
    path_osmconvert <- file.path(path.package("OSMtools"),"osmconvert.exe")
  } else if(checkmate::check_os("linux")){
    path_osmconvert <- file.path(path.package("OSMtools"),"osmconvert64")
  } else {
    stop("OS not supported")
  }
  
  
  # Check bbox
  if(!is.null(bbox)){
    if(all(class(bbox) == "bbox")){
      bbox <- matrix(as.numeric(bbox), ncol = 2, byrow = 2)
    }
    checkmate::assert_matrix(bbox, min.rows = 2, max.rows = 2, min.cols = 2,
                             max.cols = 2)
    
    checkmate::assert_numeric(bbox[,1], lower = -180, upper = 180)
    checkmate::assert_numeric(bbox[,2], lower = -90, upper = 90)
    if(bbox[1,1] > bbox[2,1]){
      stop("BBox first point is not west of second point")
    }
    if(bbox[2,1] > bbox[2,2]){
      stop("BBox first point is not south of second point")
    }
    
  }
  
  request <- paste0(path_osmconvert, 
                    " ",
                    file,
                    " --out-",
                    format_out)
  
  if(drop_author){
    request <- paste0(request," --drop-author")
  }
  
  if(!is.null(bbox)){
    request <- paste0(request,
                      ' -b=',
                      paste(bbox[1],bbox[3],bbox[2],bbox[4], sep = ","))
  }
  
  request <- paste0(request," -o=",path_out)
  
  system(request, intern = TRUE)
  
  
}