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
#   File:           StdCellLib/Catalog/stacked2_cells.mk
#
#   Purpose:        Makefile for Cell Generation with popcorn
#
#   ************    GNU Make 3.80 Source Code       ****************
#
#   ////////////////////////////////////////////////////////////////
#
#   Copyright (c)   2018, 2019 by
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

#   list all dependencies for cells with up to 2 stacked transistors

#   ----------------------------------------------------------------
#               CELL TARGETS
#   ----------------------------------------------------------------

ifeq ($(BUFFER),2)

#   --------    now buffered    ------------------------------------

CELLS +=        AND2.cell \
                AO21.cell \
                OA21.cell \
                OR2.cell

AND2.cell:      INV.cell
	$(POPCORN) -m nand $< > $@

AO21.cell:      OR2.cell
	$(POPCORN) -m aoi $< > $@

OA21.cell:      AND2.cell
	$(POPCORN) -m oai $< > $@

OR2.cell:       INV.cell
	$(POPCORN) -m nor $< > $@

BUFFERED = true

else

#   --------    not buffered    ------------------------------------

CELLS +=        AOI21.cell \
                NAND2.cell \
                NOR2.cell \
                OAI21.cell

AOI21.cell:     NOR2.cell
	$(POPCORN) -m aoi $< > $@

NAND2.cell:     INV.cell
	$(POPCORN) -m nand $< > $@

NOR2.cell:      INV.cell
	$(POPCORN) -m nor $< > $@

OAI21.cell:     NAND2.cell
	$(POPCORN) -m oai $< > $@

endif
