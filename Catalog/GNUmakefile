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
#   File:           StdCellLib/Catalog/GNUmakefile
#
#   Purpose:        Makefile for Cell Generation with popcorn
#
#   ************    GNU Make 3.80 Source Code       ****************
#
#   ////////////////////////////////////////////////////////////////
#
#   Copyright (c)   2018, 2019 by
#                   chipforge - <popcorn@nospam.chipforge.org>
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

PROJECT =       StdCellLib

#   directory pathes

DOCUMENTSDIR =  .
OUTPUTDIR =     ..

#   tool variables

CAT ?=          @cat
ECHO ?=         @echo # -e
MV ?=           mv
RM ?=           rm -f
TAR ?=          tar -zh
DATE :=         $(shell date +%Y%m%d)

#   project settings

CELLS =

#   Attention! limit/buffer changes will impact cell catalog

LIMIT ?=        5
BUFFER ?=       $(LIMIT)    # recommended, but free to reduce
LELVEL ?=       $(LIMIT)    # hack for fencing expand algorithmen

POPCORN ?=      ../Tools/popcorn/popcorn -l $(LEVEL) -b $(BUFFER)

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
	$(ECHO) "    catalog    - compile *all* catalog cells (see list below)"
	$(ECHO) ""
	$(ECHO) "-------------------------------------------------------------------"
	$(ECHO) "    available cells [limit=" $(LIMIT) "+ buffer=" $(BUFFER)"]:"
	$(ECHO) "-------------------------------------------------------------------"
	$(ECHO) ""
	$(ECHO) $(CELLS)
	$(ECHO) ""

.PHONY: clean
clean:
	$(RM) $(CELLS)

#   ----------------------------------------------------------------
#               CELL TARGETS
#   ----------------------------------------------------------------

#   include makefile with highest number of (allowed) stacked transistors

ifeq ($(LIMIT),2)
    include stacked2_cells.mk
else
ifeq ($(LIMIT),3)
    include stacked3_cells.mk
else
ifeq ($(LIMIT),4)
    include stacked4_cells.mk
else
ifeq ($(LIMIT),5)
    include stacked5_cells.mk
endif
endif
endif
endif

.PHONY: catalog
catalog:    $(CELLS)

