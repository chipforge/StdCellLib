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
#   File:           StdCellLib/GNUmakefile
#
#   Purpose:        Root Makefile
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

CATALOGDIR =    Catalog
DOCUMENTSDIR =  Documents
SIMULATIONDIR = Simulation
SOURCESDIR =    Sources
SYNTHESISDIR =  Synthesis
TBENCHDIR =     TBench
TOOLSDIR =      Tools

#   tool variables

CAT ?=          @cat
ECHO ?=         @echo # -e
MV ?=           mv
TAR ?=          tar -zh
DATE :=         $(shell date +%Y%m%d)

#   project tools

POPCORN ?=      $(TOOLSDIR)/tcl/popcorn -o $(CATALOGDIR)
SCHEMATIC ?=    $(TOOLSDIR)/tcl/cell2schematic -o $(DOCUMENTSDIR)/LaTeX -g LaTeX

#   default

DISTRIBUTION =  ./GNUmakefile \
                $(CATALOGDIR) \
                $(DOCUMENTSDIR) \
                $(SIMULATIONDIR) \
                $(SOURCESDIR) \
                $(SYNTHESISDIR) \
                $(TBENCHDIR)

#   ----------------------------------------------------------------
#               DEFINITIONS
#   ----------------------------------------------------------------

CELLS =         $(patsubst %.func,%,$(notdir $(wildcard $(CATALOGDIR)/*.cell)))

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
	$(ECHO) "    dist       - build a tarball with all important files"
	$(ECHO) "    clean      - clean up all intermediate files"
	$(ECHO) ""
	$(ECHO) "    alf        - generate generate ALF export"
	$(ECHO) "    catalog    - re-generate combinatoral catalog (DON'T DO THAT!!)"
	$(ECHO) "    doc        - generate complete documentation"
	$(ECHO) "    spice      - generate SPICE models"
	$(ECHO) "    verilog    - generate VERILOG models"
	$(ECHO) ""
	$(ECHO) "    cells      - generate almost all cell files (cell list below)"
	$(ECHO) ""
	$(ECHO) "-------------------------------------------------------------------"
	$(ECHO) "    available cells:"
	$(ECHO) "-------------------------------------------------------------------"
	$(ECHO) ""
	$(ECHO) "$(CELLS)"
	$(ECHO) ""

#   make archiv by building a tarball with all important files

.PHONY: dist
dist: clean
	$(ECHO) "---- build a tarball with all important files ----"
	$(TAR) -cvf $(PROJECT)_$(DATE).tgz $(DISTRIBUTION)

#   well, 'clean' directories before distributing

.PHONY: clean
clean:
	$(ECHO) "---- clean up all intermediate files ----"
	$(MAKE) -C $(DOCUMENTSDIR)/LaTeX -f build.mk $@

#   ----------------------------------------------------------------
#               DETAILED TARGETS
#   ----------------------------------------------------------------

#.PHONY: cells
#cells: $(CELLS)

#   re-generates 'functional, switch-level based' descriptions for
#   almost all combinatorial cells - ATTENTION! USE this with CAUTION
#   while following steps might overwrite your manual efforts

.PHONY: catalog
catalog:
	$(POPCORN) -t $(T)

#   grep all hierarchichal LaTeX files and build the up-to-date PDF

.PHONY: doc
doc:
	$(MAKE) -C $(DOCUMENTSDIR)/LaTeX -f build.mk $@

%_schematic.tex: $(CATALOGDIR)/%.cell
	$(SCHEMATIC) $<
