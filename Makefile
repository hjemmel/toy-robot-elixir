.PHONY: dev test help
.DEFAULT_GOAL: help

default: help

help: ## Output available commands
	@echo "Available commands:"
	@echo
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/##//'

dev:  ## Run a development environment
	@docker build -t elixir-dev .
	@docker run --rm -it elixir-dev iex -S mix


test: ## Run the current test suite
	@docker build -t elixir-dev .
	@docker run --rm -it elixir-dev mix test --trace
