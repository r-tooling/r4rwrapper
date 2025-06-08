#' Run My Code Addin
#'
#' This function is triggered by the RStudio Addin.
#'
#' @export
run_my_code <- function() {

  ADDIN_NAME = "R4R"

   # Ensure RStudio API is available
  if (!rstudioapi::isAvailable()) {
    stop("This function requires RStudio.")
  }

  

  rstudioapi::showDialog("R4R", "You pressed the button!")
  

  # Get the contents of the active document
  doc <- rstudioapi::getActiveDocumentContext()


  # Print it or do something else
  print(contents)


  if (doc$path == "") {
    rstudioapi::showDialog(ADDIN_NAME, "Save file before running")
    return()
  }


  
  # Save the current document
  rstudioapi::documentSave(id = doc$id)

  output <- dirname(doc$path)

  name <- "helloworldplugin"
  r4r_traceRmd(doc$path, output, paste0("r4r/", name) , paste0("r4r-", name ))

  rstudioapi::showDialog(ADDIN_NAME, "Done!")



#   list(
#   id = "#5",                  # internal doc ID
#   path = "/path/to/script.R",# file path ("" if unsaved)
#   contents = c("line 1", "line 2", ...), # lines of the file
#   selection = list(...)      # selected text, etc.
# )
# You can join it into a full string if needed:

# r
# Copy
# Edit
# code <- paste(doc$contents, collapse = "\n")

#### ---------------




}
