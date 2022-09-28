#   ************    LibreSilicon's StdCellLibrary   ****************
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
#   File:           StdCellLib/Catalog/stacked5_phase3_bufnow_cells.mk
#
#   Purpose:        Makefile for Cell Generation with popcorn
#
#   ************    GNU Make 3.80 Source Code       ****************
#
#   ////////////////////////////////////////////////////////////////
#
#   Copyright (c)   2018, 2019 - 2021 by
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
#   ////////////////////////////////////////////////////////////////

#   ----------------------------------------------------------------
#               DESCRIPTION
#   ----------------------------------------------------------------

#   Dependencies for cells with 5 stacked transistors and three phases,
#   which are buffered now.

#   ----------------------------------------------------------------
#               CELL TARGETS - now buffered
#   ----------------------------------------------------------------

#   --------    three phases    ------------------------------------

CELLS +=        AOA213 OAO213 \
                       OOAO2213 \
                       OOOAO2223

AOA213:         DESCR = "2-1-3-input AND-OR-AND gate"
AOA213:         AOAI212
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED5)

OAO213:        DESCR = "2-1-3-input OR-AND-OR gate"
OAO213:        OAOI212
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED5)

OOAO2213:       DESCR = "2-2-1-3-input OR-OR-AND-OR gate"
OOAO2213:       OOAO2212
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED5)

OOOAO2223:      DESCR = "2-2-2-3-input OR-OR-OR-AND-OR gate"
OOOAO2223:      OOOAO2222
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED5)
