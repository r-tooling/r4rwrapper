# r4rwrapper


r4rwrapper is an R package for tracing R code using r4r. It can trace the execution of an arbitrary R file, and also provides convenient support for rmarkdown notebooks. 
The package also provides an R Studio addin to start the tracing of the notebooks.


# Internals

The wrapper calls into the shared object provided within r4r, `libr4r.so`. 
The wrapper contains a `traceExpression`  native function which in turn 
calls into a `r4r_trace_expression` function provided by the r4r library. 
Tracing expressions allows for tracing arbitrary R code, from R files (using `source`) to 
specific notebooks (`rmarkdown::render(' myNotebook.Rmd' )`). 


## Usage

### From R

The package supports two functions to run r4r from R: 

```R
# file: R file
# output: output folder
# image_tag: name of docker image
# container_name: name of the container
# base_image: base image. By default ubuntu:24.10 is used if left empty 

r4r_traceRFile <- function(file, output, image_tag, container_name, base_image="", skip_manifest=TRUE) {}

r4r_traceRmd <- function(rmdFile, output, image_tag, container_name, base_image="", skip_manifest=TRUE) {}

```

### From R studio

The plugin is becomes avaiable once the package is intalled. Just open an Rmd file, and while file is on focus go to Tools -> Addins -> Browse addins -> select r4rwrapper . 
This will start the tracing for the current file. During the process, the user is prompted to edit the `manifest.conf` file before the Docker file is created. `gnome-text-editor` is used by default to edit the file, but it can be changed by setting the environment variable `VISUAL`. The process continues when the editor is closed.
The process also runs the newly created container and its name is reported at the end.
The output folder is located within Rmd file's parent folder.


## Install

To install the package from source code, standing on this repository folder  start R and then:

```R
devtools::install()
```

The library assumes r4r is already installed in the system (libr4r.so). At the moment, the shared objects needs to be localted at /usr/local/lib. Afer installing, the R studio add-in 
becomes available.

## Integration tests

Integration tests are located at `tests-instegration`. The integration tests from r4r
are replicated in this repository, only run using the wrapper. 
For example to run `r-helloworld` test :

```sh
cd tests-integration/r-hello-world
make
