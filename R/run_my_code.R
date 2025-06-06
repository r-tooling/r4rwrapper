#' Run My Code Addin
#'
#' This function is triggered by the RStudio Addin.
#'
#' @export
run_my_code <- function() {
  rstudioapi::showDialog("My Addin", "You pressed the button!")
  print("Hello from the addin!")


#  # Make sure we're in an RStudio session
#   if (!rstudioapi::isAvailable()) {
#     stop("This function requires RStudio.")
#   }

#   # Get the contents of the active document
#   doc <- rstudioapi::getActiveDocumentContext()

#   # Access the text as a character vector (one element per line)
#   contents <- doc$contents

#   # Print it or do something else
#   print(contents)

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

#  # Ensure RStudio API is available
#   if (!rstudioapi::isAvailable()) {
#     stop("This function requires RStudio.")
#   }

#   # Get active document context
#   doc <- rstudioapi::getActiveDocumentContext()
  
#   # Save the current document
#   rstudioapi::documentSave(id = doc$id)

#   # Feedback
#   rstudioapi::showDialog("Saved", paste("File saved:", doc$path))

}
