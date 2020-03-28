.PHONY: clean
clean:
	@rm -f dai.cabal

.PHONY: install
install: clean
	@stack update
	# install dev deps
	@stack build hlint --copy-compiler-tool

.PHONY: precommit
precommit:
	@mkdir -p .git/hooks
	@echo "make lint" > .git/hooks/pre-commit
	@chmod +x .git/hooks/pre-commit


.PHONY: setup
setup: install precommit
	@echo "Setup complete"


.PHONY: lint
lint: clean
	@stack exec hlint src test

.PHONY: watch
watch: clean
	@stack build --file-watch

.PHONY: coverage
coverage: clean
	@stack test --coverage

.PHONY: run
run: clean
	@stack build
	@stack exec dai-exe
