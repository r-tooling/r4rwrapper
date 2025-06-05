IMAGE_TAG := libr4r/test-$(NAME)
CONTAINER_NAME := libr4r-test-$(NAME)
OUTPUT := actual
TRACE_COMMAND := R -e "library(r4rwrapper); $(TRACE_FUNCTION)('$(FILE)','$(OUTPUT)','$(IMAGE_TAG)', '$(CONTAINER_NAME)') "
NCPUS ?= 8


define install_r_packages
	Rscript -e 'install.packages(setdiff(commandArgs(TRUE), rownames(installed.packages())), repos="https://cloud.r-project.org", Ncpus=$(NCPUS))' $(1)
endef

all: clean trace check

.PHONY: test-run
test-run:
	$(TEST_COMMAND)

.PHONY: trace
trace:
	$(TRACE_COMMAND)

.PHONY: check
check:
	pwd
	../snapshot.sh --fail expected $(OUTPUT)/result

.PHONY: clean
clean:
	-docker rm $(CONTAINER_NAME)
	-docker rmi -f $(IMAGE_TAG)
	rm -fr $(OUTPUT) $(ARTIFACTS)
