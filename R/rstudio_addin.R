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

  output <- paste0(dirname(doc$path), "/actual")
  name <- "helloworldplugin"
  image_tag <- paste0("r4r/", name)
  container_name <- paste0("r4r-", name )

  print(doc$path)
  print(output)
  print(image_tag)
  print(container_name)

  # TODO prompt image name  ,promt run container
  
  res <- r4r_traceRmd(doc$path, output, image_tag , container_name)

  if (res == 0)
    rstudioapi::showDialog(ADDIN_NAME, paste0("Done! Container: ", container_name))
  else
    rstudioapi::showDialog(ADDIN_NAME, "Tracing finished with errors")




}
