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
#   File:           StdCellLib/Tools/popcorn/GNUmakefile
#
#   Purpose:        Makefile for Popcorn Tool Dependencies
#
#   ************    GNU Make 3.80 Source Code       ****************
#
#   ////////////////////////////////////////////////////////////////
#
#   Copyright (c)   2019 by
#                   chipforge - <popcorn@nospam.chipforge.org>
#
#   This source file may be used and distributed without restriction
#   provided that this copyright statement is not removed from the
#   file and that any derivative work contains the original copyright
#   notice and the associated disclaimer.
#
#   This source is free software; you can redistribute it and/or modify
#   it under the terms of the GNU General Public License as published by
#   the Free Software Foundation; either version 3 of the License, or
#   (at your option) any later version.
#
#   This source is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
#   GNU General Public License for more details.
#
#    (__)  You should have received a copy of the GNU General Public
#    oo )  License along with this program; if not, write to the
#    /_/|  Free Software Foundation Inc., 51 Franklin St., 5th Floor,
#          Boston, MA 02110-1301, USA
#
#   GNU General Public License v3.0 - http://www.gnu.org/licenses/gpl-3.0.html
#   ////////////////////////////////////////////////////////////////////

#   project name

PROJECT =       Popcorn

#   tool variables

CAT ?=          @cat
ECHO ?=         @echo # -e
MV ?=           mv
RM ?=           rm -f
TAR ?=          tar -zh
DATE :=         $(shell date +%Y%m%d)

#   project tools

TROFF ?=        groff -t -mdoc

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
	$(ECHO) "    manual     - generate Manual Pages for Popcorn"
	$(ECHO) "    tools      - generate all dependencies"
	$(ECHO) ""


.PHONY: clean
clean:
	-$(RM) ../*.ps

#   ----------------------------------------------------------------
#               MANUAL PAGES
#   ----------------------------------------------------------------

#   man 5 cell

.PHONY: ../cell.5.ps
../cell.5.ps: ../cell.5
	$(TROFF) $< > $@

#   man 5 table

.PHONY: ../table.5.ps
../table.5.ps: ../table.5
	$(TROFF) $< > $@

#   man 1 popcorn

.PHONY: ../popcorn.1.ps
../popcorn.1.ps: ../popcorn.1
	$(TROFF) $< > $@

manual: ../cell.5.ps ../table.5.ps ../popcorn.1.ps

#   ----------------------------------------------------------------
#               TOOLING
#   ----------------------------------------------------------------

tools: manual
