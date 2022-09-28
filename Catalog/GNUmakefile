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

VPATH = $(SOURCESDIR)/geda:$(CATALOGDIR)

#   project settings

CELLS =

#   !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
#       ATTENTION! Limit/Buffer changes will impact cell catalog.
#       Hence, strongly recommended, that you know what you're doing.
#   !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

# global; max number of stacked mosfets - reasonable less or equal 5
LIMIT ?=            4
# buffering recommended, but free to reduce - usually $(LIMIT)
BUFFER ?=           5
# textual description for cell functionality
DESCR ?=            '?'

POPCORN +=          -b $(BUFFER) \
                    -D $(DESCR)
NETLIST ?=          lepton-netlist -g geda # FIXME!! backend target still does not exist

#   tool variables

TRACE.DOT ?=        trace.dot
TRACE.SVG ?=        trace.svg
DOT ?=              dot -Tsvg $(TRACE.DOT) -o $(TRACE.SVG)

STACKED2 ?=         -@echo "    $< -> $@ [color=blueviolet]" >> $(TRACE.DOT)
STACKED3 ?=         -@echo "    $< -> $@ [color=dodgerblue]" >> $(TRACE.DOT)
STACKED4 ?=         -@echo "    $< -> $@ [color=lime]" >> $(TRACE.DOT)
STACKED5 ?=         -@echo "    $< -> $@ [color=yellow]" >> $(TRACE.DOT)
STACKED6 ?=         -@echo "    $< -> $@ [color=orange]" >> $(TRACE.DOT)
STACKED7 ?=         -@echo "    $< -> $@ [color=red]" >> $(TRACE.DOT)

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
	#   trace      - generate cell derivative tree (as SVG)
	#
	#   ----------------------------------------------------------
	#       available cells [LIMIT=$(LIMIT) + BUFFER=$(BUFFER)]:
	#   ----------------------------------------------------------
	#   $(CELLS)
	#

.PHONY: clean
clean:
	-$(RM) $(CELLS)
	-$(RM) $(TRACE.DOT) $(TRACE.SVG)

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
#               SETS
#   ----------------------------------------------------------------

#   include makefiles, regarding
#   - number of (allowed) stacked transistors, and
#   - minimum limit for output buffering

ifeq ($(LIMIT),2)
    #include crafted2_cells.mk
    ifeq ($(BUFFER),2)
        include stacked2_aphase_bufnow_cells.mk
    else
        include stacked2_aphase_unbuf_cells.mk
    endif
else
ifeq ($(LIMIT),3)
    #include crafted2_cells.mk
    #include crafted3_cells.mk
    ifeq ($(BUFFER),2)
        include stacked2_aphase_bufnow_cells.mk
        include stacked3_aphase_allbuf_cells.mk
    else
    ifeq ($(BUFFER),3)
        include stacked2_aphase_unbuf_cells.mk
        include stacked3_aphase_bufnow_cells.mk
    else
        include stacked2_aphase_unbuf_cells.mk
        include stacked3_aphase_unbuf_cells.mk
    endif
    endif
else
ifeq ($(LIMIT),4)
    #include crafted2_cells.mk
    #include crafted3_cells.mk
    #include crafted4_cells.mk
    ifeq ($(BUFFER),2)
        include stacked2_aphase_bufnow_cells.mk
        include stacked3_aphase_allbuf_cells.mk
        include stacked4_phase2_allbuf_cells.mk
        include stacked4_phase3_allbuf_cells.mk
        include stacked4_phase4_allbuf_cells.mk
        include stacked4_phase5_allbuf_cells.mk
        include stacked4_phase6_allbuf_cells.mk
    else
    ifeq ($(BUFFER),3)
        include stacked2_aphase_unbuf_cells.mk
        include stacked3_aphase_bufnow_cells.mk
        include stacked4_phase2_allbuf_cells.mk
        include stacked4_phase3_allbuf_cells.mk
        include stacked4_phase4_allbuf_cells.mk
        include stacked4_phase5_allbuf_cells.mk
        include stacked4_phase6_allbuf_cells.mk
    else
    ifeq ($(BUFFER),4)
        include stacked2_aphase_unbuf_cells.mk
        include stacked3_aphase_unbuf_cells.mk
        include stacked4_phase2_bufnow_cells.mk
        include stacked4_phase3_bufnow_cells.mk
        include stacked4_phase4_bufnow_cells.mk
        include stacked4_phase5_bufnow_cells.mk
        include stacked4_phase6_bufnow_cells.mk
    else
        include stacked2_aphase_unbuf_cells.mk
        include stacked3_aphase_unbuf_cells.mk
        include stacked4_phase2_unbuf_cells.mk
        include stacked4_phase3_unbuf_cells.mk
        include stacked4_phase4_unbuf_cells.mk
        include stacked4_phase5_unbuf_cells.mk
        include stacked4_phase6_unbuf_cells.mk
    endif
    endif
    endif
else
    #include crafted2_cells.mk
    #include crafted3_cells.mk
    #include crafted4_cells.mk
    #include crafted5_cells.mk
    ifeq ($(BUFFER),2)
        include stacked2_aphase_bufnow_cells.mk
        include stacked3_aphase_allbuf_cells.mk
        include stacked4_phase2_allbuf_cells.mk
        include stacked4_phase3_allbuf_cells.mk
        include stacked4_phase4_allbuf_cells.mk
        include stacked4_phase5_allbuf_cells.mk
        include stacked4_phase6_allbuf_cells.mk
        include stacked5_phase2_allbuf_cells.mk
        include stacked5_phase3_allbuf_cells.mk
    else
    ifeq ($(BUFFER),3)
        include stacked2_aphase_unbuf_cells.mk
        include stacked3_aphase_bufnow_cells.mk
        include stacked4_phase2_allbuf_cells.mk
        include stacked4_phase3_allbuf_cells.mk
        include stacked4_phase4_allbuf_cells.mk
        include stacked4_phase5_allbuf_cells.mk
        include stacked4_phase6_allbuf_cells.mk
        include stacked5_phase2_allbuf_cells.mk
        include stacked5_phase3_allbuf_cells.mk
    else
    ifeq ($(BUFFER),4)
        include stacked2_aphase_unbuf_cells.mk
        include stacked3_aphase_unbuf_cells.mk
        include stacked4_phase2_bufnow_cells.mk
        include stacked4_phase3_bufnow_cells.mk
        include stacked4_phase4_bufnow_cells.mk
        include stacked4_phase5_bufnow_cells.mk
        include stacked4_phase6_bufnow_cells.mk
        include stacked5_phase2_allbuf_cells.mk
        include stacked5_phase3_allbuf_cells.mk
    else
    ifeq ($(BUFFER),5)
        include stacked2_aphase_unbuf_cells.mk
        include stacked3_aphase_unbuf_cells.mk
        include stacked4_phase2_unbuf_cells.mk
        include stacked4_phase3_unbuf_cells.mk
        include stacked4_phase4_unbuf_cells.mk
        include stacked4_phase5_unbuf_cells.mk
        include stacked4_phase6_unbuf_cells.mk
        include stacked5_phase2_bufnow_cells.mk
        include stacked5_phase3_bufnow_cells.mk
    else
        include stacked2_aphase_unbuf_cells.mk
        include stacked3_aphase_unbuf_cells.mk
        include stacked4_phase2_unbuf_cells.mk
        include stacked4_phase3_unbuf_cells.mk
        include stacked4_phase4_unbuf_cells.mk
        include stacked4_phase5_unbuf_cells.mk
        include stacked4_phase6_unbuf_cells.mk
        include stacked5_phase2_unbuf_cells.mk
        include stacked5_phase3_unbuf_cells.mk
    endif
    endif
    endif
    endif
endif
endif
endif

#   ----------------------------------------------------------------
#               CELL TARGETS
#   ----------------------------------------------------------------

#   generate cell file from schematic, while no popcorn-based target exist

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
