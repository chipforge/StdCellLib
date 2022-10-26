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
#   File:           StdCellLib/Catalog/stacked2_2x_T_bufnow_cells.mk
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
#   which are buffered now.

#   ----------------------------------------------------------------
#               CELL TARGETS - now buffered
#   ----------------------------------------------------------------

#   --------    2x2T one phase      --------------------------------

CELLS +=        AND2 OR2

AND2:           DESCR = "2-input AND gate"
AND2:           INV
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED2)

OR2:            DESCR = "2-input OR gate"
OR2:            INV
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED2)

#   --------    2x3T two phases     --------------------------------

CELLS +=        AO21 OA21

AO21:           DESCR = "2-1-input AND-OR gate"
AO21:           AND2
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED2)

OA21:           DESCR = "2-1-input OR-AND gate"
OA21:           OR2
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED2)

#   --------    2x4T two phases     --------------------------------

CELLS +=        AAOI22 OOAI22

AAO22:          DESCR = "2-2-input AND-AND-OR gate"
AAO22:          AO21
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED2)

OOA22:          DESCR = "2-2-input OR-OR-AND gate"
OOA22:          OA21
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED2)
