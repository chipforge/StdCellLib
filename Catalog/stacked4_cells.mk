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

CELLS +=        AND4 \
                AO2111 \
                AO41 \
                AOA2111 \
                AOA311 \
                OA211 \
                OA2111 \
                OA3111 \
                OA41 \
                OA4111 \
                OAO2111 \
                OAO311 \
                OAOA2211 \
                OAOA3211 \
                OR4

AND4:           AND3
	$(POPCORN) -m nand -c $@ $< > $@

AO2111:         OR4
	$(POPCORN) -m aoi -c $@ $< > $@

AO41:           AO31
	$(POPCORN) -m aoi -c $@ $< > $@

AOA2111:        OA211
	$(POPCORN) -m nand -c $@ $< > $@

AOA311:         AOA211
	$(POPCORN) -m aoi -c $@ $< > $@

OA211:          AND3
	$(POPCORN) -m oai -c $@ $< > $@

OA2111:         AND4
	$(POPCORN) -m oai -c $@ $< > $@

OA3111:         OA2111
	$(POPCORN) -m oai -c $@ $< > $@

OA41:           OA31
	$(POPCORN) -m oai -c $@ $< > $@

OA4111:         OA3111
	$(POPCORN) -m oai -c $@ $< > $@

OAO2111:        AO211
	$(POPCORN) -m nor -c $@ $< > $@

OAO311:         OAO211
	$(POPCORN) -m oai -c $@ $< > $@

OAOA2211:       AOA311
	$(POPCORN) -m nor -c $@ $< > $@

OAOA3211:       OAOA2211
	$(POPCORN) -m oai -c $@ $< > $@

OR4:            OR3
	$(POPCORN) -m nor -c $@ $< > $@

#   --------    now buffered    ------------------------------------

else
ifeq ($(BUFFER),4)

CELLS +=        AND4 \
                AO2111 \
                AO41 \
                AOA2111 \
                AOA311 \
                OA211 \
                OA2111 \
                OA3111 \
                OA41 \
                OA4111 \
                OAO2111 \
                OAO311 \
                OAOA2211 \
                OAOA3211 \
                OR4

AND4:           NAND3
	$(POPCORN) -m nand -c $@ $< > $@

AO2111:         OR4
	$(POPCORN) -m aoi -c $@ $< > $@

AO41:           AOI31
	$(POPCORN) -m aoi -c $@ $< > $@

AOA2111:        OAI211
	$(POPCORN) -m nand -c $@ $< > $@

AOA311:         AOAI211
	$(POPCORN) -m aoi -c $@ $< > $@

OA211:          AND3
	$(POPCORN) -m oai -c $@ $< > $@

OA2111:         AND4
	$(POPCORN) -m oai -c $@ $< > $@

OA3111:         OA2111
	$(POPCORN) -m oai -c $@ $< > $@

OA41:           OAI31
	$(POPCORN) -m oai -c $@ $< > $@

OA4111:         OA3111
	$(POPCORN) -m oai -c $@ $< > $@

OAO2111:        AOI211
	$(POPCORN) -m nor -c $@ $< > $@

OAO311:         OAOI211
	$(POPCORN) -m oai -c $@ $< > $@

OAOA2211:       AOA311
	$(POPCORN) -m nor -c $@ $< > $@

OAOA3211:       OAOA2211
	$(POPCORN) -m oai -c $@ $< > $@

OR4:            NOR3
	$(POPCORN) -m nor -c $@ $< > $@

BUFFERED = true

#   --------    not buffered    ------------------------------------

else

CELLS +=        AOAI2111 \
                AOAI311 \
                AOI2111 \
                AOI41 \
                NAND4 \
                NOR4 \
                OAI2111 \
                OAI3111 \
                OAI41 \
                OAI4111 \
                OAOAI2211 \
                OAOAI3211 \
                OAOI2111 \
                OAOI311

AOAI2111:       OAI211
	$(POPCORN) -m nand -c $@ $< > $@

AOAI311:        AOAI211
	$(POPCORN) -m aoi -c $@ $< > $@

AOI2111:        NOR4
	$(POPCORN) -m aoi -c $@ $< > $@

AOI41:          AOI31
	$(POPCORN) -m aoi -c $@ $< > $@

NAND4:          NAND3
	$(POPCORN) -m nand -c $@ $< > $@

NOR4:           NOR3
	$(POPCORN) -m nor -c $@ $< > $@

OAI2111:        NAND4
	$(POPCORN) -m oai -c $@ $< > $@

OAI41:          OAI31
	$(POPCORN) -m oai -c $@ $< > $@

OAI3111:        OAI2111
	$(POPCORN) -m oai -c $@ $< > $@

OAI4111:        OAI3111
	$(POPCORN) -m oai -c $@ $< > $@

OAOAI2211:      AOAI311
	$(POPCORN) -m nor -c $@ $< > $@

OAOAI3211:      OAOAI2211
	$(POPCORN) -m oai -c $@ $< > $@

OAOI2111:       AOI211
	$(POPCORN) -m nor -c $@ $< > $@

OAOI311:        OAOI211
	$(POPCORN) -m oai -c $@ $< > $@

endif
endif
