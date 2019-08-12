#' Filter osm by tags
#' 
#' @param file path to file
#' @param path_out path to file to save result
#' @param keep object to keep arguments
#' @param drop object to drop arguments
#' @param keep_tags tags to keep arguments
#' @param drop_tags togs to drop arguments
#' @export
#' 

osmt_filter <- function(file, path_out,
                                keep = NULL, drop = NULL,
                                keep_tags = NULL,
                                drop_tags = NULL){
  checkmate::assert_os("windows")
  file <- normalizePath(file)
  checkmate::assert_file_exists(file)
  path_osmfilter <- file.path(path.package("OSMtools"),"osmfilter.exe")
  path_osmfilter <- normalizePath(path_osmfilter)
  
  request <- paste0(path_osmfilter," ",file)
  if(!is.null(keep)){
    add <- paste0(' --keep="',
                  keep,
                  '"')
    request <- paste0(request,add)
  }
  if(!is.null(drop)){
    request <- paste0(request,
                      ' --drop="',
                      drop,
                      '"'
                      )
  }
  if(!is.null(keep_tags)){
    request <- paste0(request,
                      ' --keep-tags="',
                      keep_tags,
                      '"')
  }
  if(!is.null(drop_tags)){
    request <- paste0(request,
                      ' --drop-tags="',
                      drop_tags,
                      '"')
  }
  
  path_out <- normalizePath(path_out, mustWork = FALSE)
  request <- paste0(request," -o=",path_out)
  
  system(request, intern = TRUE)
  
}
