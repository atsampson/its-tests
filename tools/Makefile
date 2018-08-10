ITS = $(HOME)/src/its
FONTS = 13fg 16fg 18fg 20fg 22fg 25fg 30fg

all: fonts/fonts.dir

fonts/fonts.dir: $(patsubst %,fonts/%.pcf,$(FONTS))
	cd fonts && mkfontdir

fonts/%.pcf: $(ITS)/bin/fonts/%.kst
	./ksttobdf $< | bdftopcf -o $@ /dev/stdin
