# This is a basic Makefile for compiling LaTeX documents
# Included is basic support for BibTeX bibliographies
# as well as support for multiple output formats.
#
# Current supported output types:
# html pdf
#
# Invoke the makefile in the following manners:
# make             -- Run LaTeX and BibTeX
# make pdf         -- Make PDF output using pdfTeX
# make finalpdf    -- Make PDF output with embedded fonts, etc...
# make index       -- Runs indexing (if you do indexing that is)
# make html        -- Makes HTML output
# make clean       -- Removes temp files and cleans up output
# make proper      -- More exhaustive clean
#-------------------------------------------------------

TEXSRC = $(wildcard *.tex)
MAINDOC = LL_6_main

.PHONY: all pdf latex xetex html clean cleanhtml proper sync html_nopic

#all: $(MAINDOC).pdf $(TEXSRC)
all: xetex $(TEXSRC)

html: $(MAINDOC).html $(TEXSRC)

html_nopic:
	htlatex  $(MAINDOC).tex "html,charset=utf-8,index=2,3,fn-in" "-cunihtf -utf8" "-p -dhtml/"
	@mv *.html ./html/ -v


LL_6_main.pdf: LL_6_main.tex FORCE
	pdflatex LL_6_main.tex

xetex: $(MAINDOC).tex $(TEXSRC)
	@echo "\\\boxed{\\\tt{hash:`hg id -i`""\ " "rev:`hg id -n`}}" > revision.tex
	xelatex -output-driver='xdvipdfmx -V 5 -v' $(MAINDOC).tex

$(MAINDOC).html: $(MAINDOC).tex
	htlatex  $(MAINDOC).tex "html,charset=utf-8,index=2,3,fn-in" "-cunihtf -utf8" " -dhtml/"
	@mv *.html ./html/ -v

clean:
	@rm -f $(MAINDOC).pdf *.aux *.html *.log *.toc *.tmp \
		*.4tc *.4ct *.lg *.out *.xref *.dvi

proper :
	@rm -f *.aux *.bbl *.blg *.log *.dvi \
	*.idx *.ilg *.ind *.toc *.lot *.lof

cleanhtml:
	@rm -f ./html/*.* *~

sync:
	@rsync -av --stats  ~/Documents/landaulifshitz/html/* wiki:/var/www/wiki4ka/Volume_06 --delete-after --human-readable

#
# Dependencies
# DO NOT DELETE
#$(MAINDOC).tex : $(TEXSRC)
#$(MAINDOC).pdf : $(TEXSRC)

# vim: set tabstop=4 shiftwidth=4 noexpandtab:
