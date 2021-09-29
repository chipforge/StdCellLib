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
#   Copyright (c) 2018, 2019, 2020 by
#                 chipforge <stdcelllib@nospam.chipforge.org>
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
PRD =               .

#   common definitions

include $(PRD)/include.mk

DISTRIBUTION =  $(RELEASEDIR)/*.pdf \
                $(RELEASEDIR)/magic \
                $(RELEASEDIR)/spice \
                # still incomplete

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
	#   dist       - build a tarball with all important files
	#   clean      - clean up all intermediate files
	#
	#   tools      - generate POPCORN tool
	#   catalog    - (re-)generate combinatorial catalog (DON'T DO THAT!!)
	#   layout     - generate physical layouts
	#   datasheet  - generate cell data sheet
	#   doc        - generate complete data book
	#

#   'clean' directories

.PHONY: clean
clean:
	# ---- clean up all intermediate files ----
	$(MAKE) -C $(TOOLSDIR) $@
	$(MAKE) -C $(DOCUMENTSDIR)/LaTeX $@
	# ---- clean generated catalog files ----
	$(MAKE) -C $(CATALOGDIR) $@

#   ----------------------------------------------------------------
#               TOOLS
#   ----------------------------------------------------------------

#   prepare Popcorn before usage

.PHONY: tools
tools:
	$(MAKE) -C $(TOOLSDIR) $@

#   ----------------------------------------------------------------
#               CATATLOG TARGETS
#   ----------------------------------------------------------------

#   re-generates 'functional, switch-level based' descriptions for
#   almost all combinatorial cells - ATTENTION! USE this with CAUTION
#   while following steps might overwrite your manual efforts

.PHONY: catalog
catalog:
	$(MAKE) -C $(CATALOGDIR) $@

#   ----------------------------------------------------------------
#               LAYOUT TARGETS
#   ----------------------------------------------------------------

#   generate layout for all known cells

.PHONY: layout
layout:
	$(MAKE) -f layout.mk magic

#   ----------------------------------------------------------------
#               DOCUMENTATION TARGETS
#   ----------------------------------------------------------------

#   grep all hierarchical LaTeX files and build the up-to-date PDF

.PHONY: doc
doc:
	$(MAKE) -C $(DOCUMENTSDIR)/LaTeX $@

#   ----------------------------------------------------------------
#               DISTRIBUTION
#   ----------------------------------------------------------------

#   make archive by building a tarball with all important files

.PHONY: dist
dist: clean doc
	# ---- build a tarball with all important files ----"
	$(TAR) -cvf $(PROJECT)_$(DATE).tgz $(DISTRIBUTION)

