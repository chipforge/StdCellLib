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
#   Copyright (c) 2018 by chipforge <stdcelllib@nospam.chipforge.org>
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

#   common definitions

include include.mk

DISTRIBUTION =  $(CATALOGDIR)/ \
                $(DOCUMENTSDIR)/*.pdf \
		$(TECHDIR) \
#                $(RELEASEDIR) \
#               $(SIMULATIONDIR) \
                $(SOURCESDIR) \
                $(SYNTHESISDIR) \
                $(TBENCHDIR) \


#   collect available cells

IGNORE := $(wildcard $(CATALOGDIR)/*.mk $(CATALOGDIR)/GNUmakefile)
CELLS := $(notdir $(filter-out $(IGNORE), $(wildcard $(CATALOGDIR)/*)))

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
	$(ECHO) "    tools      - generate POPCORN tool"
	$(ECHO) "    catalog    - re-generate combinatorial catalog (DON'T DO THAT!!)"
	$(ECHO) "    doc        - generate data book"
	$(ECHO) ""
	$(ECHO) "    alf [CELL=<cell>]      - generate ALF export"
	$(ECHO) "    record [CELL=<cell>]   - measure / characterize cell"
	$(ECHO) "    magic [CELL=<cell>]    - generate MAGIC layout"
	$(ECHO) "    spice [CELL=<cell>]    - generate SPICE models"
	$(ECHO) "    svg [CELL=<cell>]      - generate SVG layout"
	$(ECHO) "    verilog [CELL=<cell>]  - generate VERILOG cell models"
	$(ECHO) ""
	$(ECHO) "-------------------------------------------------------------------"
	$(ECHO) "    available cells:"
	$(ECHO) "-------------------------------------------------------------------"
	$(ECHO) ""
	$(ECHO) "$(CELLS)"
	$(ECHO) ""

#   make archive by building a tarball with all important files

.PHONY: dist
dist: clean
	$(ECHO) "---- build a tarball with all important files ----"
	$(TAR) -cvf $(PROJECT)_$(DATE).tgz $(DISTRIBUTION)
	echo $(PROJECT)_$(DATE).tgz has been written.

#   well, 'clean' directories before distributing

.PHONY: clean
clean:
	$(ECHO) "---- clean up all intermediate files ----"
	$(MAKE) -f simulation.mk $@
	$(MAKE) -C $(TOOLSDIR)/popcorn -f GNUmakefile $@
	$(MAKE) -C $(DOCUMENTSDIR)/LaTeX -f GNUmakefile $@

#   ----------------------------------------------------------------
#               TOOLS
#   ----------------------------------------------------------------

#   prepare Popcorn before usage

.PHONY: tools
tools:
	$(MAKE) -C $(TOOLSDIR)/popcorn -f GNUmakefile $@

#   ----------------------------------------------------------------
#               CATATLOG TARGETS
#   ----------------------------------------------------------------

#   re-generates 'functional, switch-level based' descriptions for
#   almost all combinatorial cells - ATTENTION! USE this with CAUTION
#   while following steps might overwrite your manual efforts

.PHONY: catalog
catalog:   tools
	$(MAKE) -C $(CATALOGDIR) -f GNUmakefile $@

#   ----------------------------------------------------------------
#               CELL TARGETS
#   ----------------------------------------------------------------

#   generate truth table

.PHONY: table-file
table-file:
	$(MAKE) -f simulation.mk CELL=$(CELL) table-file

#   measure / characterize cells

.PHONY: record
record:
	$(MAKE) -f simulation.mk CELL=$(CELL) record

#   ----------------------------------------------------------------
#               DOCUMENTATION TARGETS
#   ----------------------------------------------------------------

#   grep all hierarchical LaTeX files and build the up-to-date PDF

.PHONY: doc
doc:
	$(MAKE) -C $(DOCUMENTSDIR)/LaTeX -f GNUmakefile $@

