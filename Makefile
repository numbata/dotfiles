.PHONY: play

all: install_deps play

install_deps: .deps_installed

play:
	./bin/play

.deps_installed:
	./bin/install_deps
	touch ./.deps_installed

