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
#   File:           StdCellLib/Catalog/stacked5_cells.mk
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

#   list all dependencies for cells with 5 stacked transistors
#
include stacked4_cells.mk

#   ----------------------------------------------------------------
#               CELL TARGETS
#   ----------------------------------------------------------------

ifdef BUFFERED

#   --------    already buffered    --------------------------------

CELLS +=        AND5 \
                OR5

AND5:           DESCR = "5-input AND gate"
AND5:           AND4
	$(POPCORN) -m nand -c $@ $< > $@
	$(PINK)

OR5:            DESCR = "5-input OR gate"
OR5:            OR4
	$(POPCORN) -m nor -c $@ $< > $@
	$(PINK)

#   --------    now buffered    ------------------------------------

else
ifeq ($(BUFFER),5)

CELLS +=        AND5 \
                OR5

AND5:           DESCR = "5-input AND gate"
AND5:           NAND4
	$(POPCORN) -m nand -c $@ $< > $@
	$(PINK)

OR5:            DESCR = "5-input OR gate"
OR5:            NOR4
	$(POPCORN) -m nor -c $@ $< > $@
	$(PINK)

BUFFERED = true

#   --------    not buffered    ------------------------------------

else

CELLS +=        NAND5 \
                NOR5

NAND5:          DESCR = "5-input Not-AND (or NAND) gate"
NAND5:          NAND4
	$(POPCORN) -m nand -c $@ $< > $@
	$(PINK)

NOR5:           DESCR = "5-input Not-OR (or NOR) gate"
NOR5:           NOR4
	$(POPCORN) -m nor -c $@ $< > $@
	$(PINK)

endif
endif
