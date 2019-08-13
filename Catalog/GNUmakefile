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
#   Copyright (c) 2018 by chipforge <hsank@nospam.chipforge.org>
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
#   Attention! limit/buffer changes will impact cell catalog

LIMIT =         4
BUFFER =        $(LIMIT)
CELLS =         AOI21.cell \
                NAND2.cell NAND3.cell AND4.cell \
                NOR2.cell NOR3.cell OR4.cell \
                OAI21.cell

POPCORN ?=      ../Tools/popcorn/popcorn -l $(LIMIT) -b $(BUFFER)

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
	$(ECHO) "    catalog    - compile catalog cells"
	$(ECHO) ""


.PHONY: clean
clean:
	$(RM) $(CELLS)

#   ----------------------------------------------------------------
#               CELL TARGETS
#   ----------------------------------------------------------------

.PHONY: catalog
catalog:    $(CELLS)

AND4.cell: NAND3.cell
	$(POPCORN) -m nand $< > $@

AOI21.cell: NOR2.cell
	$(POPCORN) -m aoi $< > $@

NAND2.cell: INV.cell
	$(POPCORN) -m nand $< > $@

NAND3.cell: NAND2.cell
	$(POPCORN) -m nand $< > $@

NOR2.cell: INV.cell
	$(POPCORN) -m nor $< > $@

NOR3.cell: NOR2.cell
	$(POPCORN) -m nor $< > $@

OAI21.cell: NAND2.cell
	$(POPCORN) -m oai $< > $@

OR4.cell: NOR3.cell
	$(POPCORN) -m nor $< > $@

