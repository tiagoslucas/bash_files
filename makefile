SHELL := /bin/bash
	
.ONESHELL:;

.PHONY: all clean install
all:
	@./make.sh
	@./setup.sh
clean:
	@echo "Cleaning up..."
	rm -f target/*
install:
	@echo "Installing without building:"
	@./setup.sh

%:
	@./make.sh $@
	@./setup.sh $@
