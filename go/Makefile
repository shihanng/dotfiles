export GOBIN=$(shell pwd)/bin

.PHONY: test install-tools clean all

install-tools:
	@echo Installing tools from tools.go
	@cat tools.go | grep _ | awk -F'"' '{print $$2}' | xargs -tI % go install %
