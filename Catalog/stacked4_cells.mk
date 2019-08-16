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
#   File:           StdCellLib/Catalog/stacked4_cells.mk
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

#   list all dependencies for cells with 4 stacked transistors
#
include stacked3_cells.mk

#   ----------------------------------------------------------------
#               CELL TARGETS
#   ----------------------------------------------------------------

#   --------    already buffered    --------------------------------

ifdef BUFFERED

CELLS +=        AND4.cell \
                AO2111.cell \
                AOA2111.cell \
                AOA311.cell \
                OA211.cell \
                OA2111.cell \
                OA41.cell \
                OAO2111.cell \
                OR4.cell

AND4.cell:      AND3.cell
	$(POPCORN) -m nand $< > $@

AO2111.cell:    OR4.cell
	$(POPCORN) -m aoi $< > $@

AOA2111.cell:   OA211.cell
	$(POPCORN) -m nand $< > $@

AOA311.cell:    AOA211.cell
	$(POPCORN) -m aoi $< > $@

OA211.cell:     AND3.cell
	$(POPCORN) -m oai $< > $@

OA2111.cell:    AND4.cell
	$(POPCORN) -m oai $< > $@

OA41.cell:      OA31.cell
	$(POPCORN) -m oai $< > $@

OAO2111.cell:   AO211.cell
	$(POPCORN) -m nor $< > $@

OR4.cell:       OR3.cell
	$(POPCORN) -m nor $< > $@

#   --------    now buffered    ------------------------------------

else
ifeq ($(BUFFER),4)

CELLS +=        AND4.cell \
                AO2111.cell \
                AOA2111.cell \
                AOA311.cell \
                OA211.cell \
                OA2111.cell \
                OA41.cell \
                OAO2111.cell \
                OR4.cell

AND4.cell:      NAND3.cell
	$(POPCORN) -m nand $< > $@

AO2111.cell:    OR4.cell
	$(POPCORN) -m aoi $< > $@

AOA2111.cell:   OAI211.cell
	$(POPCORN) -m nand $< > $@

AOA311.cell:    AOAI211.cell
	$(POPCORN) -m aoi $< > $@

OA211.cell:     AND3.cell
	$(POPCORN) -m oai $< > $@

OA2111.cell:    AND4.cell
	$(POPCORN) -m oai $< > $@

OA41.cell:      OAI31.cell
	$(POPCORN) -m oai $< > $@

OAO2111.cell:   AOI211.cell
	$(POPCORN) -m nor $< > $@

OR4.cell:       NOR3.cell
	$(POPCORN) -m nor $< > $@

BUFFERED = true

#   --------    not buffered    ------------------------------------

else

CELLS +=        AOAI2111.cell \
                AOAI311.cell \
                AOI2111.cell \
                NAND4.cell \
                NOR4.cell \
                OAI211.cell \
                OAI2111.cell \
                OAI41.cell \
                OAOI2111.cell

AOAI2111.cell:  OAI211.cell
	$(POPCORN) -m nand $< > $@

AOAI311.cell:   AOAI211.cell
	$(POPCORN) -m aoi $< > $@

AOI2111.cell:   NOR4.cell
	$(POPCORN) -m aoi $< > $@

NAND4.cell:     NAND3.cell
	$(POPCORN) -m nand $< > $@

NOR4.cell:      NOR3.cell
	$(POPCORN) -m nor $< > $@

OAI2111.cell:   NAND4.cell
	$(POPCORN) -m oai $< > $@

OAI41.cell:     OAI31.cell
	$(POPCORN) -m oai $< > $@

OAOI2111.cell:  AOI211.cell
	$(POPCORN) -m nor $< > $@

endif
endif
