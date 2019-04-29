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

#   project name

PROJECT =       StdCellLib

#   directory paths

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

SCHEMATIC ?=    $(TOOLSDIR)/tcl/_schematic -o $(DOCUMENTSDIR)/LaTeX -i $(CATALOGDIR) -g LaTeX
MANUAL ?=       $(TOOLSDIR)/tcl/_manpage -o $(DOCUMENTSDIR)/LaTeX -i $(CATALOGDIR) -g LaTeX
SWITCH ?=       $(TOOLSDIR)/tcl/_switch -o $(SOURCESDIR)/verilog -i $(CATALOGDIR) -f verilog

#   default

DISTRIBUTION =  $(CATALOGDIR)/*.cell \
                $(DOCUMENTSDIR)/*.pdf \
                $(SIMULATIONDIR) \
                $(SOURCESDIR) \
                $(SYNTHESISDIR) \
                $(TBENCHDIR)

.SUFFIXES:      # delete all default suffix rules
#   ----------------------------------------------------------------
#               DEFINITIONS
#   ----------------------------------------------------------------

CELLS =         $(patsubst %.cell,%,$(notdir $(wildcard $(CATALOGDIR)/*.cell)))
MANPAGES =      $(patsubst %,%_manpage.tex,$(CELLS))

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
	$(ECHO) "    alf        - generate ALF export"
	$(ECHO) "    catalog    - re-generate combinatorial catalog (DON'T DO THAT!!)"
	$(ECHO) "    doc        - generate complete documentation"
	$(ECHO) "    magic      - generate MAGIC layout"
	$(ECHO) "    popcorn    - generate POPCORN tool"
	$(ECHO) "    spice      - generate SPICE models"
	$(ECHO) "    svg        - generate SVG layout"
	$(ECHO) "    verilog    - generate VERILOG models"
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

#   well, 'clean' directories before distributing

.PHONY: clean
clean:
	$(ECHO) "---- clean up all intermediate files ----"
	$(MAKE) -C $(DOCUMENTSDIR)/LaTeX -f GNUmakefile $@
	$(MAKE) -C $(TOOLSDIR)/popcorn -f GNUmakefile $@

#   ----------------------------------------------------------------
#               CATATLOG TARGETS
#   ----------------------------------------------------------------

#   re-generates 'functional, switch-level based' descriptions for
#   almost all combinatorial cells - ATTENTION! USE this with CAUTION
#   while following steps might overwrite your manual efforts

.PHONY: catalog
catalog:
	$(MAKE) -C $(CATALOGDIR) -f GNUmakefile $@

#   ----------------------------------------------------------------
#               DOCUMENTATION TARGETS
#   ----------------------------------------------------------------

#   grep all hierarchical LaTeX files and build the up-to-date PDF

.PHONY: doc
doc:
	$(MAKE) -C $(DOCUMENTSDIR)/LaTeX -f GNUmakefile $@

.PHONY: _manpages
_manpages: $(MANPAGES)

%_circuits.tex: $(CATALOGDIR)/%.cell
	$(ECHO) "cell -> circuits still missing"

%_schematic.tex:
	$(ECHO) "---- generate $@ ----"
	$(SCHEMATIC) $(*F)

%_truthtable.tex: $(CATALOGDIR)/%.cell
	$(ECHO) "cell -> truthtable still missing"

%_files.tex:
	$(ECHO) "files still missing"

%_manpage.tex: $(DOCUMENTSDIR)/LaTeX/%_schematic.tex
	$(MANUAL) $(*F)
	$(ECHO) "---- includes for $@ done ----"

#%_manpage.tex: $(DOCUMENTSDIR)/LaTeX/%_schematic.tex $(DOCUMENTSDIR)/LaTeX/%_manpage.tex
#%_manpage.tex: $(CATALOGDIR)/%.cell $(DOCUMENTSDIR)/LaTeX/%_schematic.tex
#%_manpage.tex:  %_circuits.tex %_schematic.tex %_truthtable.tex    !!

#   ----------------------------------------------------------------
#               TOOLS
#   ----------------------------------------------------------------

.PHONY: popcorn
popcorn:
	$(MAKE) -C $(TOOLSDIR)/popcorn -f GNUmakefile $@
