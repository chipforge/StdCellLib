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
#   File:           StdCellLib/Tools/GNUmakefile
#
#   Purpose:        Makefile for Standard Cell Library Tool Dependencies
#
#   ************    GNU Make 3.80 Source Code       ****************
#
#   ////////////////////////////////////////////////////////////////
#
#   Copyright (c) 2019 - 2021 by
#                 chipforge <popcorn@nospam.chipforge.org>
#   All rights reserved.
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

#   project root directory, relative, used inside include.mk file
PRD =               ..

#   common definitions

include $(PRD)/include.mk

#   usefull tools

TROFF ?=        groff -t -mdoc

#   ----------------------------------------------------------------
#               DEFAULT TARGETS
#   ----------------------------------------------------------------

#   display help screen if no target is specified

.PHONY: help
help:
	#   ----------------------------------------------------------
	#    available targets:
	#   ----------------------------------------------------------
	#
	#    help       - print this help screen
	#    clean      - clean up all intermediate files
	#
	#    manual     - generate Manual Pages
	#    tools      - generate all dependencies
	#


.PHONY: clean
clean:
	-$(RM) *.ps

#   ----------------------------------------------------------------
#               MANUAL PAGES
#   ----------------------------------------------------------------

MANPAGES    = cell.5.ps \
              table.5.ps \
              cobblestone.1.ps \
              datasheet.1.ps \
              konstruktivist.1.ps \
              scarbata.1.ps \
              popcorn.1.ps

%.ps: %
	$(TROFF) $< > $@

#   ----------------------------------------------------------------
#               TOOLING
#   ----------------------------------------------------------------

.PHONY: tools
tools: $(MANPAGES)
