DATE:=$(shell date '+%Y-%m-%d')

.PHONY: all clean docs env view

all: env docs
	#d help; make
	#cd tutorial; make

clean:
	@rm -rf ./tmp

view:
	firefox ./tmp/docs/help/index.html &
	firefox ./tmp/docs/tutorial/index.html &
	# evince ../tmp/help/docs/pdf/guide-resinfo-wapt.pdf &

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
	. ./tmp/venv/bin/activate; cd tmp; mkdocs build -f ./mkdocs.yml

env:
	mkdir -p tmp
	python3 -m venv ./tmp/venv
	. ./tmp/venv/bin/activate; pip install mkdocs-macros-plugin mkdocs-material mkdocs-material-extensions mkdocs-with-pdf # mkdocs-git-revision-date-localized-plugin

view:
	firefox ./tmp/docs/index.html &
