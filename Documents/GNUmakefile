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
#   File:           StdCellLib/Documents/GNUmakefile
#
#   Purpose:        Makefile for Document Generation
#
#   ************    GNU Make 3.80 Source Code       ****************
#
#   ////////////////////////////////////////////////////////////////
#
#   Copyright (c) 2018 - 2022 by
#                 chipforge <stdcelllib@nospam.chipforge.org>
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

#   project root directory, relative, used inside include.mk file
PRD =               ..

#   common definitions

include $(PRD)/include.mk

#   directory pathes

DATASHEETDIR ?= ./Datasheets

#   project tools

LATEX ?= lualatex --shell-escape
BIBER ?= biber
GLOSSARY ?= makeglossaries

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
	#   help        - print this help screen
	#   clean       - clean up all intermediate files
	#
	#   datasheets  - generate datasheets for every cell
	#   reference   - generate complete reference book
	#

#   'clean' current directory

.PHONY: clean
clean:
	$(MAKE) -C $(DATASHEETDIR) $@
	-$(RM) *.aux *.bcf *.idx *.log *.toc *.out *.acr *.alg
	-$(RM) *.acn *.bbl *.blg *.glo *.ist *.xml *.xdy *.gls *.glg

#   ----------------------------------------------------------------
#               DATASHEETS TARGET
#   ----------------------------------------------------------------

#   Generate Datasheets en detail as part of the Reference Manual.
#   All stuff inside datasheets is organizied hierarchical.

.PHONY: datasheets
datasheets:
	$(MAKE) -C $(DATASHEETDIR) $@

#   ----------------------------------------------------------------
#               REFERENCE MANUAL
#   ----------------------------------------------------------------

#   Main target for the essential Reference Manual generation.
#   Grep all hierarchical LaTeX files and build the up-to-date PDF.

.PHONY: reference
reference: datasheets #$(PROJECT).tex
	$(LATEX) $(PROJECT).tex
	$(BIBER) $(PROJECT)
	$(GLOSSARY) $(PROJECT)
	$(LATEX) $(PROJECT).tex
	$(LATEX) $(PROJECT).tex
	$(MV) $(PROJECT).pdf $(RELEASEDIR)

