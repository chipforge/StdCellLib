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
#   File:           StdCellLib/Catalog/stacked3_cells.mk
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

#   list all dependencies for cells with 3 stacked transistors
#
include stacked2_cells.mk

#   ----------------------------------------------------------------
#               CELL TARGETS
#   ----------------------------------------------------------------

ifdef BUFFERED

#   --------    already buffered    --------------------------------

CELLS +=        AND3.cell \
                AO211.cell \
                AO31.cell \
                AO311.cell \
                AOA211.cell \
                AOA221.cell \
                OA211.cell \
                OA31.cell \
                OA311.cell \
                OAO211.cell \
                OR3.cell

AND3.cell:      AND2.cell
	$(POPCORN) -m nand $< > $@

AO211.cell:     OR3.cell
	$(POPCORN) -m aoi $< > $@

AO31.cell:      AO21.cell
	$(POPCORN) -m aoi $< > $@

AO311.cell:     AO211.cell
	$(POPCORN) -m aoi $< > $@

AOA211.cell:    OA21.cell
	$(POPCORN) -m nand $< > $@

AOA221.cell:    OA31.cell
	$(POPCORN) -m nand $< > $@

OA211.cell:     AND3.cell
	$(POPCORN) -m oai $< > $@

OA31.cell:      OA21.cell
	$(POPCORN) -m oai $< > $@

OA311.cell:     OA211.cell
	$(POPCORN) -m oai $< > $@

OAO211.cell:    AO21.cell
	$(POPCORN) -m nor $< > $@

OR3.cell:       OR2.cell
	$(POPCORN) -m nor $< > $@

else
ifeq ($(BUFFER),3)

#   --------    now buffered    ------------------------------------

CELLS +=        AND3.cell \
                AO211.cell \
                AO31.cell \
                AO311.cell \
                AOA211.cell \
                AOA221.cell \
                OA211.cell \
                OA31.cell \
                OA311.cell \
                OAO211.cell \
                OR3.cell

AND3.cell:      NAND2.cell
	$(POPCORN) -m nand $< > $@

AO211.cell:     OR3.cell
	$(POPCORN) -m aoi $< > $@

AO31.cell:      AOI21.cell
	$(POPCORN) -m aoi $< > $@

AO311.cell:     AO211.cell
	$(POPCORN) -m aoi $< > $@

AOA211.cell:    OAI21.cell
	$(POPCORN) -m nand $< > $@

AOA221.cell:    OA31.cell
	$(POPCORN) -m nand $< > $@

OA211.cell:     AND3.cell
	$(POPCORN) -m oai $< > $@

OA31.cell:      OAI21.cell
	$(POPCORN) -m oai $< > $@

OA311.cell:     OA211.cell
	$(POPCORN) -m oai $< > $@

OAO211.cell:    AOI21.cell
	$(POPCORN) -m nor $< > $@

OR3.cell:       NOR2.cell
	$(POPCORN) -m nor $< > $@

BUFFERED = true

else

#   --------    not buffered    ------------------------------------

CELLS +=        AOAI211.cell \
                AOAI221.cell \
                AOI211.cell \
                AOI31.cell \
                AOI311.cell \
                NAND3.cell \
                NOR3.cell \
                OAI211.cell \
                OAI31.cell \
                OAI311.cell \
                OAOI211.cell \

AOAI211.cell:   OAI21.cell
	$(POPCORN) -m nand $< > $@

AOAI221.cell:   OAI31.cell
	$(POPCORN) -m nand $< > $@

AOI211.cell:    NOR3.cell
	$(POPCORN) -m aoi $< > $@

AOI31.cell:     AOI21.cell
	$(POPCORN) -m aoi $< > $@

AOI311.cell:    AOI211.cell
	$(POPCORN) -m aoi $< > $@

NAND3.cell:     NAND2.cell
	$(POPCORN) -m nand $< > $@

NOR3.cell:      NOR2.cell
	$(POPCORN) -m nor $< > $@

OAI211.cell:    NAND3.cell
	$(POPCORN) -m oai $< > $@

OAI31.cell:     OAI21.cell
	$(POPCORN) -m oai $< > $@

OAI311.cell:    OAI211.cell
	$(POPCORN) -m oai $< > $@

OAOI211.cell:   AOI21.cell
	$(POPCORN) -m nor $< > $@

endif
endif
