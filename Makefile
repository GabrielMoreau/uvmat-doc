DATE:=$(shell date '+%Y-%m-%d')

# Host IP for WSL2 under Windows
IP:=$(shell (echo 127.0.0.1 ; uname -a | grep -q 'microsoft' && hostname -I | cut -f 1 -d ' ') | tail -1)


.PHONY: all clean docs env view serve-start serve-stop

all: env docs
	#d help; make
	#cd tutorial; make

clean:
	@rm -rf ./tmp

tmp/src/README.md: README.md Makefile
	mkdir -p tmp/src
	(cd tmp/src; \
		ln -sf ../../README.md README.md; \
		ln -sf ../../img-uvmat.png img-uvmat; \
		[ -e bib ] || ln -sf ../../bib bib; \
		[ -e help ] || ln -sf ../../help help; \
		[ -e tutorial ] || ln -sf ../../tutorial tutorial; \
		)

tmp/mkdocs.yml: ./mkdocs.yml Makefile
	mkdir -p ../tmp
	sed -e "s/__DATE__/$(DATE)/;" $< > $@

docs: Makefile tmp/mkdocs.yml tmp/src/README.md
	mkdir -p ../tmp/docs/help
	. ./tmp/cache/venv/bin/activate; cd tmp; mkdocs build -f ./mkdocs.yml

env:
	mkdir -p tmp/cache
	python3 -m venv ./tmp/cache/venv
	. ./tmp/cache/venv/bin/activate; pip install mkdocs-macros-plugin mkdocs-material mkdocs-material-extensions mkdocs-with-pdf # mkdocs-git-revision-date-localized-plugin

view:
	firefox http://$(IP):8008 &

serve-start:
	. ./tmp/cache/venv/bin/activate; mkdocs serve --dev-addr $(IP):8008 -f ./tmp/mkdocs.yml &

serve-stop:
	pgrep -f 'mkdocs serve --dev-addr $(IP):8008 ' | xargs -r kill
