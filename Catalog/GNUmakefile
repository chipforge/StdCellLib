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
#   Copyright (c) 2018 - 2021 by
#                 chipforge <popcorn@nospam.chipforge.org>
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

#   virtuell search pathes

vpath   %.sym   $(SOURCESDIR)/geda
vpath   %.sch   $(SOURCESDIR)/geda
vpath   $(CATALOGDIR)

#   project settings

CELLS =

#   !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
#       ATTENTION! Limit/Buffer changes will impact cell catalog.
#       Hence, strongly recommended, that you know what you're doing.
#   !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

# global; max number of stacked mosfets
LIMIT ?=            5
# buffering recommended, but free to reduce
BUFFER ?=           $(LIMIT)
# textual description for cell functionality
DESCR ?=            '?'

POPCORN +=          -b $(BUFFER) \
                    -D $(DESCR)
NETLIST ?=          gnetlist -g geda # FIXME!! backend target still does not exist

#   tool variables

TRACE.DOT ?=        trace.dot
TRACE.PDF ?=        trace.pdf
DOT ?=              dot -Tpdf $(TRACE.DOT) -o $(TRACE.PDF)

GREEN ?=            -@echo "    $< -> $@ [color=green]" >> $(TRACE.DOT)
BLUE ?=             -@echo "    $< -> $@ [color=blue]" >> $(TRACE.DOT)
RED ?=              -@echo "    $< -> $@ [color=red]" >> $(TRACE.DOT)
PINK ?=             -@echo "    $< -> $@ [color=pink]" >> $(TRACE.DOT)

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
	#   catalog    - compile *all* catalog cells (see list below)
	#   cell CELL=<cell> - compile up to dedicated catalog cell
	#   trace      - generate catalog's cell generation tree
	#
	#   ----------------------------------------------------------
	#       available cells [limit=$(LIMIT) + buffer=$(BUFFER)]:
	#   ----------------------------------------------------------
	#   $(CELLS)
	#

.PHONY: clean
clean:
	-$(RM) $(CELLS)
	-$(RM) $(TRACE.DOT) $(TRACE.PDF)

.PHONY: header
header:
	#    _ __   ___  _ __   ___ ___  _ __ _ __
	#   | '_ \ / _ \| '_ \ / __/ _ \| '__| '_ \\
	#   | |_) | (_) | |_) | (_| (_) | |  | | | |
	#   | .__/ \___/| .__/ \___\___/|_|  |_| |_|
	#   |_|launched:|_| $(DATE)
	-@echo "digraph catalog {" > $(TRACE.DOT)
	-@echo "    node[shape=box]" >> $(TRACE.DOT)

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

#   generate cell file from gEDA schematic, while no popcorn-based target exist

%:  %.sym %.sch
	$(NETLIST) $^ -o $@ > /dev/null

#   common generating targets

.PHONY: catalog
catalog:    header $(CELLS)

.PHONY: cell
cell:   $(CELL)

#   ----------------------------------------------------------------
#               POST PROCESSING
#   ----------------------------------------------------------------

.PHONY: trace
trace:
	-@echo "}" >> $(TRACE.DOT)
	$(DOT)
