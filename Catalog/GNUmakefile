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
LEVEL ?=        $(LIMIT)    # hack for fencing expand algorithmen
DESCR ?=        '?'

#POPCORN ?=      ../Tools/tcl/popcorn
POPCORN ?=      ../Tools/popcorn/popcorn -l $(LEVEL) -b $(BUFFER) -D $(DESCR)

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
	$(ECHO) "    cell CELL=<cell> - compile up to dedicated catalog cell"
	$(ECHO) ""
	$(ECHO) "-------------------------------------------------------------------"
	$(ECHO) "    available cells [limit=" $(LIMIT) "+ buffer=" $(BUFFER)"]:"
	$(ECHO) "-------------------------------------------------------------------"
	$(ECHO) ""
	$(ECHO) $(CELLS)
	$(ECHO) ""

.PHONY: clean
clean:
#	$(RM) *.aux *.idx *.log *.toc *.out
	$(RM) $(CELLS)
	$(RM) AND4.cell NAND2.cell NAND3.cell NOR2.cell NOR3.cell OR4.cell
	$(RM) *.mag *.svg *.ext *.res.ext *.spice *.nodes *.sp *.sim *.al *.res.lump *.png *.err *.log *.libtemplate *.lib *.truthtable.html *.truthtable.v *.truthtable.txt outputlib/*.gds outputlib/*.lef outputlib/*.mag debuglib/* *.running *.mag.drc *.drc *.predrc

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
	
.PHONY: layout
layout: libresilicon.sp libresilicon.lef libresilicon.lib demoboard.mag doc/StdCellLib.pdf demoboard.svg


libresilicon.sp: *.cell ../Tech/librecell_tech.py ../Tools/perl/cell2spice.pl ../Tools/perl/librecells.pl ../Tech/nmos.sp
	../Tools/perl/cell2spice.pl
	../Tools/perl/librecells.pl
	rm -f libresilicon.lib
	../Tools/perl/libgen.pl >libresilicon.libtemplate
	libertymerge -b libresilicon.libtemplate -o libresilicon.lib -u *.lib

demoboard.mag: *.cell libresilicon.sp
	perl ../Tools/perl/demoboard.pl >demoboard.mag

.PHONY: buildreport
buildreport:
	bash ../Tools/reporter.sh

libresilicon.lef: *.cell libresilicon.sp
	../Tools/perl/lefgen.pl outputlib/*.lef >libresilicon.lef

libresilicon.lib: *.cell libresilicon.sp
	../Tools/perl/libgen.pl >libresilicon.libtemplate
	rm -f libresilicon.lib
	libertymerge -b libresilicon.libtemplate -o libresilicon.lib -u *.lib


.PHONY: qflow
qflow:	libresilicon.lef libresilicon.lib
	sudo mkdir -p /usr/local/share/qflow/tech/ls050
	sudo cp libresilicon.lef /usr/local/share/qflow/tech/ls050/ls050_stdcells.lef
	sudo cp libresilicon.lib /usr/local/share/qflow/tech/ls050/ls05_stdcells.lib

#AND4.cell: NAND3.cell
#	$(POPCORN) -l $(LIMIT) -n nand -c $@ -b $(LIMIT) $< 
#
#NAND2.cell: INV.cell
#	$(POPCORN) -l $(LIMIT) -n nand -c $@ $<
#
#NAND3.cell: NAND2.cell
#	$(POPCORN) -l $(LIMIT) -n nand -c $@ $<
#
#AOI21.cell: INV.cell
#	$(POPCORN) -l $(LIMIT) -n aoi -c $@ $<
#
#OAI21.cell: INV.cell
#	$(POPCORN) -l $(LIMIT) -n oai -c $@ $<
#
#NOR2.cell: INV.cell
#	$(POPCORN) -l $(LIMIT) -n nor -c $@ $<
#
#NOR3.cell: NOR2.cell
#	$(POPCORN) -l $(LIMIT) -n nor -c $@ $< 
#
#OR4.cell: NOR3.cell
#	$(POPCORN) -l $(LIMIT) -n nor -c $@ -b $(LIMIT) $<

doc/StdCellLib.pdf: *.cell libresilicon.sp
#	doc/docu.sh

.PHONY: importQflow
importQflow:
	../Tools/perl/spice2cell.pl /usr/local/share/qflow/tech/gscl45nm/gscl45nm.sp
	../Tools/perl/spice2cell.pl /usr/local/share/qflow/tech/osu018/osu018_stdcells.sp
	../Tools/perl/spice2cell.pl /usr/local/share/qflow/tech/osu035/osu035_stdcells.sp
	../Tools/perl/spice2cell.pl /usr/local/share/qflow/tech/osu050/osu050_stdcells.sp
	../Tools/perl/spice2cell.pl /usr/share/qflow/tech/osu018/osu018_stdcells.sp
	../Tools/perl/spice2cell.pl /usr/share/qflow/tech/osu035/osu035_stdcells.sp
	../Tools/perl/spice2cell.pl /usr/share/qflow/tech/osu050/osu050_stdcells.sp

mags=$(wildcard *.mag)
svgs=$(mags:.mag=.svg)

.PHONY: svg
svg: $(svgs)

test:
	echo For debugging run "export PySpiceLogLevel=DEBUG" before make
	lctime --debug --liberty libresilicon.lib \
	--include ../Tech/libresilicon.m \
	--spice INV.spice \
	--cell INV \
	--output INV.lib
	libertyviz -l INV.lib --cell INV --pin Y --related-pin A --table cell_rise
	libertymerge -b libresilicon.lib -o output_liberty.lib -u INV.lib AND2X1.lib

test2:
	/usr/local/bin/lctime --debug --liberty ~/FreePDK45/osu_soc/lib/files/gscl45nm.lib \
	--include ~/FreePDK45/osu_soc/lib/files/gpdk45nm.m \
	--spice ~/FreePDK45/osu_soc/lib/source/netlists/AND2X1.pex.netlist \
	--cell AND2X1 \
	--output /tmp/and2x1.lib
	libertyviz -l /tmp/and2x1.lib --cell AND2X1 --pin Y --related-pin A --table cell_rise &
	libertyviz -l /tmp/and2x1.lib --cell AND2X1 --pin Y --related-pin B --table rise_transition &
	libertyviz -l /tmp/and2x1.lib --cell AND2X1 --pin Y --related-pin A --table cell_fall &
	libertyviz -l /tmp/and2x1.lib --cell AND2X1 --pin Y --related-pin B --table fall_transition &


%.svg : %.mag
	perl ../Tools/perl/mag2svg.pl $@


.PHONY: cell
cell:       $(CELL)
