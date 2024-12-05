DATE:=$(shell date '+%Y-%m-%d')
DEP:=README.md # $(shell find ./ -name *.md -a -name *.png)

.PHONY: all clean docs env view pad prez

all: env docs

clean:
	@rm -rf ../tmp/help

../tmp/mkdocs-help.yml: ./mkdocs.yml Makefile
	mkdir -p ../tmp
	sed -e "s/__DATE__/$(DATE)/;" ./mkdocs.yml > $@

docs: $(DEP) Makefile ../tmp/mkdocs-help.yml
	mkdir -p ../tmp/docs/help
	. ../tmp/venv/bin/activate; cd ..; mkdocs build -f ./tmp/mkdocs-help.yml

env:
	mkdir -p ../tmp
	python3 -m venv ../tmp/venv
	. ../tmp/venv/bin/activate; pip install mkdocs-macros-plugin mkdocs-material mkdocs-material-extensions mkdocs-with-pdf # mkdocs-git-revision-date-localized-plugin

view:
	cd ..; firefox ./tmp/docs/help/index.html &
	# evince ../tmp/help/docs/pdf/guide-resinfo-wapt.pdf &


pad:
	cd pad-report/; ./pad-backup.sh

help:
	@echo "docs    create doc for dev and mainteners"
