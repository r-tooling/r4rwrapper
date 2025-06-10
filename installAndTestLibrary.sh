#!/bin/sh

# COMMAND="r4r_traceRmd"
# COMMAND="r4r_traceRmd"

set -e

FOLDER="r-hello-world"
#FOLDER="r-ggplot"
#FOLDER="r-kaggle"

cd ~/r4r
sudo make install


cd ~/r4rwrapper
sudo R -e "remove.packages('r4rwrapper')" || true
sudo R -e "devtools::install()"

cd tests-integration
cd ${FOLDER}
make

#cd ~/rmarkdownhelloworld/
#R -e "rmarkdown::render('helloworld.Rmd')" 
#R -e "library(r4rwrapper); r4r_traceRmd('helloworld.Rmd' , 'output' , 'r4rhellow' , 'r4rhellow' )" 


 
