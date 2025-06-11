
#' @export


r4r_traceRFile <- function(file, output, image_tag, container_name, base_image="", skip_manifest=TRUE) {
  
    if (!is_full_file_path_with_extension(file ,".R")) {
         stop(".R file not provided");
    }


    expr <- paste0("source('", file,  "')")
    .Call("traceExpression",  expr, output, image_tag, container_name, base_image , skip_manifest)
  
}

#' @export
r4r_traceRmd <- function(rmdFile, output, image_tag, container_name, base_image="", skip_manifest=TRUE) {
    
    if (!is_full_file_path_with_extension(rmdFile ,".Rmd")) {
         stop(".Rmd file not provided");
    }

    expr <- paste0("rmarkdown::render('", rmdFile,  "')")
    .Call("traceExpression", expr, output, image_tag, container_name, base_image, skip_manifest)
  
}


is_full_file_path_with_extension <- function(path, extension) {
  # Check inputs
  if (!is.character(path) || length(path) != 1 || !is.character(extension) || length(extension) != 1) {
    return(FALSE)
  }
  
  # Normalize the path
  normalized_path <- normalizePath(path, winslash = "/", mustWork = FALSE)
  
  # Ensure extension starts with a dot
  if (!grepl("^\\.", extension)) {
    extension <- paste0(".", extension)
  }
  
  # Escape for regex and build pattern
  ext_pattern <- paste0("\\", extension, "$")
  
  # Check extension match (case-insensitive)
  has_correct_extension <- grepl(ext_pattern, normalized_path, ignore.case = TRUE)
  
  # Check if it's an absolute path
  is_absolute <- grepl("^(/|[A-Za-z]:/)", normalized_path)
  
  # Combine conditions
  return(has_correct_extension && is_absolute)
}
