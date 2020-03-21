.PHONY: clean
clean:
	@rm -f dai.cabal

.PHONY: install
install: clean
	@stack update
	@stack install --dependencies-only

.PHONY: lint
lint: clean
	@stack exec hlint src test

.PHONY: watch
watch: clean
	@stack build --file-watch

.PHONY: coverage
coverage: clean
	@stack test --coverage
