
.PHONY: all clean view

all:
	cd help; make
	cd tutorial; make

clean:
	@rm -rf ./tmp

view:
	firefox ./tmp/docs/help/index.html &
	firefox ./tmp/docs/tutorial/index.html &
	# evince ../tmp/help/docs/pdf/guide-resinfo-wapt.pdf &
