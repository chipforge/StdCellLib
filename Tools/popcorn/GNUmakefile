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
#   File:           StdCellLib/Tools/popcorn/GNUmakefile
#
#   Purpose:        Makefile for Popcorn Tool Dependencies
#
#   ************    GNU Make 3.80 Source Code       ****************
#
#   ////////////////////////////////////////////////////////////////
#
#   Copyright (c) 2019 by chipforge <hsank@nospam.chipforge.org>
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

#   project name

PROJECT =       Popcorn

#   tool variables

CAT ?=          @cat
ECHO ?=         @echo # -e
MV ?=           mv
RM ?=           rm -f
TAR ?=          tar -zh
DATE :=         $(shell date +%Y%m%d)

#   project tools

#TROFF ?=        groff -m mandoc -T ps
TROFF ?=        groff -t -mdoc

#   ----------------------------------------------------------------
#               DEFAULT TARGETS
#   ----------------------------------------------------------------

#   display help screen if no target is specified

.PHONY: help
help:
	$(ECHO) "-------------------------------------------------------------------"
	$(ECHO) "    available targets:"
	$(ECHO) "-------------------------------------------------------------------"
	$(ECHO) ""
	$(ECHO) "    help       - print this help screen"
	$(ECHO) "    clean      - clean up all intermediate files"
	$(ECHO) ""
	$(ECHO) "    manpages   - generate Manual Page for Popcorn"
	$(ECHO) "    popcorn    - generate all dependencies"
	$(ECHO) ""


.PHONY: clean
clean:
	$(RM) *.ps

#   ----------------------------------------------------------------
#               MANUAL PAGES
#   ----------------------------------------------------------------

.PHONY: cell.5.ps
cell.5.ps: cell.5
	$(TROFF) $< > $@

.PHONY: popcorn.1.ps
popcorn.1.ps: popcorn.1
	$(TROFF) $< > $@

manual: cell.5.ps popcorn.1.ps

popcorn: manual
