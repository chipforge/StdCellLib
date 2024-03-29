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
#   File:           StdCellLib/Documents/Datasheets/GNUmakefile
#
#   Purpose:        Makefile for Document Generation
#
#   ************    GNU Make 3.80 Source Code       ****************
#
#   ////////////////////////////////////////////////////////////////
#
#   Copyright (c) 2018 - 2022 by
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
PRD =               ../..

#   common definitions

include $(PRD)/include.mk

#   virtuell search pathes

VPATH = $(CATALOGDIR)

#   auxiliary stuff for targets

DATASHEETS := $(foreach i,$(CELLS),$(i).tex)

#   directory pathes

CIRCUITRYDIR ?= ./Circuitry
TRUTHTABLEDIR ?= ./Truthtables
SCHEMATICDIR ?= ./Schematics
LAYOUTDIR ?= ./Layouts
LOADINGDIR ?= ./Loading

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
	#   datasheets - generate data sheet for every cell
	#

#   'clean' current directory

.PHONY: clean
clean:
	#-$(MAKE) -C $(CIRCUITRYDIR) $@
	-$(MAKE) -C $(TRUTHTABLEDIR) $@
	-$(MAKE) -C $(SCHEMATICDIR) $@
	-$(MAKE) -C $(LAYOUTDIR) $@
	-$(MAKE) -C $(LOADINGDIR) $@
	-$(RM) *.tex *.aux

#   ----------------------------------------------------------------
#               CIRCUITRY
#   ----------------------------------------------------------------

#   Go down into directory, collect information and beautify them
#   for LaTeX.

.PHONY: circuitry
circuitry:
	$(MAKE) -C $(CIRCUITRYDIR) $@

#   ----------------------------------------------------------------
#               TRUTH TABLES
#   ----------------------------------------------------------------

#   Go down into directory, collect information and beautify them
#   for LaTeX.

.PHONY: truthtables
truthtables:
	$(MAKE) -C $(TRUTHTABLEDIR) $@

#   ----------------------------------------------------------------
#               SCHEMATICS
#   ----------------------------------------------------------------

#   Go down into directory, collect information and beautify them
#   for LaTeX.

.PHONY: schematics
schematics:
	$(MAKE) -C $(SCHEMATICDIR) $@

#   ----------------------------------------------------------------
#               LAYOUTS
#   ----------------------------------------------------------------

#   Go down into directory, collect information and beautify them
#   for LaTeX.

.PHONY: layouts
layouts:
	$(MAKE) -C $(LAYOUTDIR) $@

#   ----------------------------------------------------------------
#               LOADING
#   ----------------------------------------------------------------

#   Go down into directory, collect information and beautify them
#   for LaTeX.

.PHONY: loading
loading:
	$(MAKE) -C $(LOADINGDIR) $@

#   ----------------------------------------------------------------
#               DATASHEETS TARGET
#   ----------------------------------------------------------------

#   Present all usefull informations for the Datasheets, e.g. Truth
#   Tables, Schematics etc in one Datasheet per Cell.
#   This information has to be collected.

.PHONY: datasheets
datasheets: truthtables schematics layouts loading $(DATASHEETS)

%.tex: %
	$(DATASHEET) $< > $@

