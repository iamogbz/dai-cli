.PHONY: clean
clean:
	@rm dai.cabal

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
