#' Run My Code Addin
#'
#' This function is triggered by the RStudio Addin.
#'
#' @export
trace_current_Rmd <- function() {

  ADDIN_NAME = "R4R"

   # Ensure RStudio API is available
  if (!rstudioapi::isAvailable()) {
    stop("This function requires RStudio.")
  }

  

  # Get the contents of the active document
  doc <- rstudioapi::getActiveDocumentContext()

  if (doc$path == "") {
    rstudioapi::showDialog(ADDIN_NAME, "Save file before running")
    return()
  }

  if (!is_full_file_path_with_extension(doc$path, ".Rmd")) {
    rstudioapi::showDialog(ADDIN_NAME, "File is not .Rmd")
    return()  
  }

  
  response <- rstudioapi::showQuestion(
    title = "Start tracing?",
    message = "Do you want to start the tracing?",
    ok = "Yes",
    cancel = "No"
  )

  if (!isTRUE(response))
    return()

  # Save the current document
  rstudioapi::documentSave(id = doc$id)


  filename <- basename(doc$path)              
  filename_no_ext <- tools::file_path_sans_ext(filename)

  output <- paste0(dirname(doc$path), "/actual")

  name <- make_docker_image_safe(filename_no_ext)
  image_tag <- paste0("r4r/", name)
  container_name <- paste0("r4r-", name )


  if (Sys.getenv("VISUAL") =="" )
    Sys.setenv(VISUAL = "gnome-text-editor")
  res <- r4r_traceRmd(doc$path, output, image_tag , container_name, skip_manifest=FALSE)

  if (res != 0) { 
    rstudioapi::showDialog(ADDIN_NAME, "Tracing finished with errors")
    return();
  }
  
  rstudioapi::showDialog(ADDIN_NAME, paste0("Done! Container: ", container_name))
 
  
}

make_docker_image_safe <- function(name) {
  # Convert to lowercase
  name <- tolower(name)
  
  # Replace disallowed characters with dashes
  name <- gsub("[^a-z0-9._-]", "-", name)
  
  # Remove leading invalid characters (like dash or dot)
  name <- gsub("^[^a-z0-9]+", "", name)
  
  # Trim trailing dashes or dots (optional)
  name <- gsub("[-.]+$", "", name)
  
  return(name)
}
