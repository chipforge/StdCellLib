#   ************    LibreSilicon's StdCellLibrary   *******************
#
#   Organisation:   Chipforge
#                   Germany / European Union
#
#   Profile:        Chipforge focus on fine System-on-Chip Cores in
#                   Verilog HDL Code which are easy understandable and
#                   adjustable. For further information see
#                           www.chipforge.org
#                   there are projects from small cores up to PCBs, too.
#
#   File:           StdCellLib/Documents/LaTeX/GNUmakefile
#
#   Purpose:        Makefile for Document Generation in LaTeX
#
#   ************    GNU Make 3.80 Source Code       ****************
#
#   ////////////////////////////////////////////////////////////////
#
#   Copyright (c) 2018, 2019 by chipforge <stdcelllib@nospam.chipforge.org>
#   All rights reserved.
#
#       This Standard Cell Library is licensed under the Libre Silicon
#       public license; you can redistribute it and/or modify it under
#       the terms of the Libre Silicon public license as published by
#       the Libre Silicon alliance, either version 1 of the License, or
#       (at your option) any later version.
#
#       This design is distributed in the hope that it will be useful,
#       but WITHOUT ANY WARRANTY; without even the implied warranty of
#       MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
#       See the Libre Silicon Public License for more details.
#
#   ////////////////////////////////////////////////////////////////////

#   common definitions

include ../../include.mk

#   directory pathes

OUTPUTDIR =     ../../$(RELEASEDIR)

#   project tools

LATEX ?=        pdflatex # -output-directory $(OUTPUTDIR)

#   ----------------------------------------------------------------
#               DEFAULT TARGETS
#   ----------------------------------------------------------------

#   display help screen if no target is specified

.PHONY: help
help:
	#   ----------------------------------------------------------
	#       available targets:
	#   ----------------------------------------------------------
	#
	#   help       - print this help screen
	#   clean      - clean up all intermediate files
	#
	#   doc        - compile documentation"
	#


.PHONY: clean
clean:
	$(RM) *.aux *.idx *.log *.toc *.out

#   ----------------------------------------------------------------
#               DOCUMENTATION TARGETS
#   ----------------------------------------------------------------

.PHONY: doc
doc:    pdf clean

#   grep all hierarchical LaTeX files and build the up-to-date PDF

.PHONY: pdf
pdf:    $(PROJECT).tex
	$(LATEX) $<
	$(LATEX) $<
	$(MV) $(PROJECT).pdf $(OUTPUTDIR)

%:
	# generate datasheet / manual page

