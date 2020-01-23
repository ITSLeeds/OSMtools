#' Filter osm by tags
#'
#' https://wiki.openstreetmap.org/wiki/Osmfilter
#' 
#' @param file path to file
#' @param path_out path to file to save result
#' @param keep character, object to keep arguments
#' @param drop character, object to drop arguments
#' @param modify character, object tags paris to modify
#' @param keep_tags character, tags to keep arguments
#' @param drop_tags character, tags to drop arguments
#' @param modify_tags character, tags to modify
#' 
#' @details 
#' A wrapper around osmfilter, supports Windows, Mac, Linux versions
#' 
#' @return
#' FUnction returns NULL but a new file is saved to disk
#' 
#' @export
#' 

osmt_filter <- function(file, 
                        path_out,
                        keep = NULL, 
                        drop = NULL,
                        modify = NULL,
                        keep_tags = NULL,
                        drop_tags = NULL,
                        modify_tags = NULL
                        ){
  
  file <- normalizePath(file)
  checkmate::assert_file_exists(file)
  
  if(checkmate::check_os("windows")){
    path_osmconvert <- file.path(path.package("OSMtools"),"osmfilter.exe")
  } else if(checkmate::check_os("linux")){
    path_osmconvert <- file.path(path.package("OSMtools"),"osmfilter32")
  } else if(checkmate::check_os("mac")){
    path_osmconvert <- file.path(path.package("OSMtools"),"osmfilter.rb")
  } else {
    stop("OS not supported")
  }
  
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
  
  if(!is.null(modify)){
    request <- paste0(request,
                      ' --modify-node-tags="',
                      modify,
                      '"')
  }
  
  if(!is.null(modify_tags)){
    request <- paste0(request,
                      ' --modify-tags="',
                      modify_tags,
                      '"')
  }
  
  
  path_out <- normalizePath(path_out, mustWork = FALSE)
  request <- paste0(request," -o=",path_out)
  
  system(request, intern = TRUE)
  return(NULL)
  
}
