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

CELLS +=        AND2 \
                AO21 \
                AO22 \
                OA21 \
                OA22 \
                OR2

AND2:           INV
	$(POPCORN) -m nand -c $@ $< > $@

AO21:           OR2
	$(POPCORN) -m aoi -c $@ $< > $@

AO22:           LEVEL = 2
AO22:           AO21
	$(POPCORN) -m oai -c $@ $< > $@

OA21:           AND2
	$(POPCORN) -m oai -c $@ $< > $@

OA22:           LEVEL = 2
OA22:           OA21
	$(POPCORN) -m oai -c $@ $< > $@

OR2:            INV
	$(POPCORN) -m nor -c $@ $< > $@

BUFFERED = true

else

#   --------    not buffered    ------------------------------------

CELLS +=        AOI21 \
                AOI22 \
                NAND2 \
                NOR2 \
                OAI21 \
                OAI22

AOI21:          NOR2
	$(POPCORN) -m aoi -c $@ $< > $@

AOI22:          LEVEL = 2
AOI22:          AOI21
	$(POPCORN) -m oai -c $@ $< > $@

NAND2:          INV
	$(POPCORN) -m nand -c $@ $< > $@

NOR2:           INV
	$(POPCORN) -m nor -c $@ $< > $@

OAI21:          NAND2
	$(POPCORN) -m oai -c $@ $< > $@

OAI22:          LEVEL = 2
OAI22:          OAI21
	$(POPCORN) -m oai -c $@ $< > $@

endif
