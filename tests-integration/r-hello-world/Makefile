NAME := r-hello-world
FILE := hello-world.R
TEST_COMMAND := R -f $(FILE)
TRACE_FUNCTION := r4r_traceRFile
ARTIFACTS := hello-world.txt

include ../test.mk

setup:
	$(call install_r_packages,stringr)

