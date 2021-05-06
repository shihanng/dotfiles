.PHONY: install-nodejs install-ruby install install-go

install-nodejs:
	npm ci

install-ruby:
	bundle install

install-go: export GOBIN = $(shell pwd)/bin
install-go:
	@go mod download
	@go list -f '{{range .Imports}}{{.}} {{end}}' tools.go | xargs go install

install: install-nodejs install-ruby
