NAME := vcrate
VERSION := v0.0.1
REVISION := $(shell git rev-parse --short HEAD)

SRCS := $(shell find . -type f -name '*.go')
LDFLAGS := -ldflags="-s -w -X \"main.Version=$(VERSION)\" -X \"main.Revision=$(REVISION)\" -extldflags \"-static\""

## Setup
setup:
	go get github.com/golang/dep/cmd/dep
	go get github.com/golang/lint/golint
	go get golang.org/x/tools/cmd/goimports
	go get github.com/Songmu/make2help/cmd/make2help

## Install dependencies
deps: setup
	dep ensure

## Run tests
test: deps
	go test -cover -v

## Lint
lint: setup
	go vet $(SRCS)
	golint $(SRCS)

## Format source codes
fmt: setup
	goimports -w $(SRCS)

## build binaries ex. make bin/vcrate
bin/$(NAME):
	go build -a -tags netgo -installsuffix netgo $(LDFLAGS) -o $@ $<

## Clean
clean:
	rm -rf bin/*
	rm -rf dist/*
	rm -rf vendor/*

## Show help
help:
	@make2help $(MAXEFILE_LIST)

.PHONY: setup deps test lint fmt clean help
