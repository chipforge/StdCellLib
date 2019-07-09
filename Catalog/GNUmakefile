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

#   project tools

POPCORN ?=      ../Tools/tcl/popcorn
CELLS =         INV.cell NAND2.cell NAND3.cell AND4.cell NOR2.cell NOR3.cell OR4.cell AOI21.cell OAI21.cell
LIMIT =         4

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
#	$(RM) *.aux *.idx *.log *.toc *.out
	$(RM) AND4.cell NAND2.cell NAND3.cell NOR2.cell NOR3.cell OR4.cell

#   ----------------------------------------------------------------
#               DOCUMENTATION TARGETS
#   ----------------------------------------------------------------

.PHONY: catalog
catalog:    $(CELLS) libresilicon.sp libresilicon.lef libresilicon.lib qflow demoboard.mag doc/StdCellLib.pdf

libresilicon.sp: *.cell
	../Tools/perl/cell2spice.pl
	../Tools/perl/librecells.pl

demoboard.mag: *.cell libresilicon.sp
	perl ../Tools/perl/demoboard.pl >demoboard.mag

libresilicon.lef: *.cell libresilicon.sp
	../Tools/perl/lefgen.pl outputlib/*.lef >libresilicon.lef

libresilicon.lib: *.cell libresilicon.sp
	../Tools/perl/libgen.pl >libresilicon.lib

.PHONY: qflow
qflow:	libresilicon.lef libresilicon.lib
	mkdir -p /usr/local/share/qflow/tech/ls050
	cp libresilicon.lef /usr/local/share/qflow/tech/ls050/ls050_stdcells.lef
	cp libresilicon.lib /usr/local/share/qflow/tech/ls050/ls05_stdcells.lib

AND4.cell: NAND3.cell
	$(POPCORN) -l $(LIMIT) -n nand -c $@ -b $(LIMIT) $< 

NAND2.cell: INV.cell
	$(POPCORN) -l $(LIMIT) -n nand -c $@ $<

NAND3.cell: NAND2.cell
	$(POPCORN) -l $(LIMIT) -n nand -c $@ $<

AOI21.cell: INV.cell
	$(POPCORN) -l $(LIMIT) -n aoi -c $@ $<

OAI21.cell: INV.cell
	$(POPCORN) -l $(LIMIT) -n oai -c $@ $<

NOR2.cell: INV.cell
	$(POPCORN) -l $(LIMIT) -n nor -c $@ $<

NOR3.cell: NOR2.cell
	$(POPCORN) -l $(LIMIT) -n nor -c $@ $< 

OR4.cell: NOR3.cell
	$(POPCORN) -l $(LIMIT) -n nor -c $@ -b $(LIMIT) $<

doc/StdCellLib.pdf: *.cell libresilicon.sp
	doc/docu.sh

.PHONY: importQflow
importQflow:
	../Tools/perl/spice2cell.pl /usr/local/share/qflow/tech/gscl45nm/gscl45nm.sp
	../Tools/perl/spice2cell.pl /usr/local/share/qflow/tech/ls050/libresilicon.sp
	../Tools/perl/spice2cell.pl /usr/local/share/qflow/tech/ls050/ls050_stdcells.sp
	../Tools/perl/spice2cell.pl /usr/local/share/qflow/tech/osu018/osu018_stdcells.sp
	../Tools/perl/spice2cell.pl /usr/local/share/qflow/tech/osu035/osu035_stdcells.sp
	../Tools/perl/spice2cell.pl /usr/local/share/qflow/tech/osu050/osu050_stdcells.sp

