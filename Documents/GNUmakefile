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

TRUTHTABLEDIR ?= $(DOCUMENTSDIR)/Truthtables
SCHEMATICDIR ?= $(DOCUMENTSDIR)/Schematics
DATASHEETDIR ?= $(DOCUMENTSDIR)/Datasheets
BOOKDIR ?= $(DOCUMENTSDIR)/Book

#   project tools

LATEX ?= pdflatex # -output-directory $(RELEASEDIR)
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
	#   truthtables - generate truth tables for every cell
	#   schematics  - generate schematics for every cell
	#   datasheets  - generate datasheets for every cell
	#   reference   - generate complete reference book
	#


.PHONY: clean
clean:
	$(MAKE) -C $(TRUTHTABLEDIR) $@
	$(MAKE) -C $(SCHEMATICDIR) $@
	$(MAKE) -C $(DATASHEETDIR) $@
	-$(RM) *.aux *.bcf *.idx *.log *.toc *.out

#   ----------------------------------------------------------------
#               DOCUMENTATION TARGETS
#   ----------------------------------------------------------------

#   generate en detail

.PHONY: truthtables
truthtables:
	$(MAKE) -C $(TRUTHTABLEDIR) $@

.PHONY: schematics
schematics:
	$(MAKE) -C $(SCHEMATICDIR) $@

.PHONY: datasheets
datasheets:
	$(MAKE) -C $(DATASHEETDIR) $@

#   grep all hierarchical LaTeX files and build the up-to-date PDF

.PHONY: reference
reference: truthtables schematics datasheets #$(PROJECT).tex
	$(LATEX) $(PROJECT).tex
	$(BIBER) $(PROJECT)
	$(GLOSSARY) $(PROJECT).glo
	$(LATEX) $(PROJECT).tex
	$(MV) $(PROJECT).pdf $(RELEASEDIR)

