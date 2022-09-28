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
#   File:           StdCellLib/Catalog/stacked2_aphase_unbuf_cells.mk
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
#   ////////////////////////////////////////////////////////////////////

#   ----------------------------------------------------------------
#               DESCRIPTION
#   ----------------------------------------------------------------

#   Dependencies for cells with up to 2 stacked transistors,
#   which are still unbuffered.

#   ----------------------------------------------------------------
#               CELL TARGETS - still unbuffered
#   ----------------------------------------------------------------

#   --------    one phase   ----------------------------------------

CELLS +=        NAND2 NOR2

NAND2:          DESCR = "2-input Not-AND (or NAND) gate"
NAND2:          INV
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED2)

NOR2:           DESCR = "2-input Not-OR (or NOR) gate"
NOR2:           INV
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED2)

#   --------    two phases  ----------------------------------------

CELLS +=        AOI21 OAI21 \
                AAOI22 OOAI22

AOI21:          DESCR = "2-1-input AND-OR-Invert gate"
AOI21:          NAND2
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED2)

OAI21:          DESCR = "2-1-input OR-AND-Invert gate"
OAI21:          NOR2
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED2)

AAOI22:         DESCR = "2-2-input AND-AND-OR-Invert gate"
AAOI22:         AOI21
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED2)

OOAI22:         DESCR = "2-2-input OR-OR-AND-Invert gate"
OOAI22:         OAI21
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED2)
