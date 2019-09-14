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
                AO23 \
                AO41 \
                AOA212 \
                AOA311 \
                OA22 \
                OA23 \
                OA3111 \
                OA41 \
                OA4111 \
                OAO2111 \
                OAO311 \
                OAOA2211 \
                OAOA3211 \
                OR4

AND4:           DESCR = "4-input AND gate"
AND4:           AND3
	$(POPCORN) -m nand -c $@ $< > $@

AO23:           DESCR = "2-3-input AND-OR gate"
AO23:           OR4
	$(POPCORN) -m aoi -c $@ $< > $@

AO41:           DESCR = "4-1-input AND-OR gate"
AO41:           AO31
	$(POPCORN) -m aoi -c $@ $< > $@

AOA212:         DESCR = "2-1-2-input AND-OR-AND gate"
AOA212:         OA22
	$(POPCORN) -m nand -c $@ $< > $@

AOA311:         DESCR = "3-1-1-input AND-OR-AND gate"
AOA311:         AOA211
	$(POPCORN) -m aoi -c $@ $< > $@

OA22:           DESCR = "2-2-input OR-AND gate"
OA22:           AND3
	$(POPCORN) -m oai -c $@ $< > $@

OA23:           DESCR = "2-3-input OR-AND gate"
OA23:           AND4
	$(POPCORN) -m oai -c $@ $< > $@

OA33:           DESCR = "3-3-input OR-AND gate"
OA33:           OA23
	$(POPCORN) -m oai -c $@ $< > $@

OA41:           DESCR = "4-1-input OR-AND gate"
OA41:           OA31
	$(POPCORN) -m oai -c $@ $< > $@

OA43:           DESCR = "4-3-input OR-AND gate"
OA43:           OA33
	$(POPCORN) -m oai -c $@ $< > $@

OAO311:         DESCR = "3-1-1-input OR-AND-OR gate"
OAO311:         OAO211
	$(POPCORN) -m oai -c $@ $< > $@

OAOA2211:       DESCR = "2-2-1-1-input OR-AND-OR-AND gate"
OAOA2211:       AOA311
	$(POPCORN) -m nor -c $@ $< > $@

OAOA3211:       DESCR = "3-2-1-1-input OR-AND-OR-AND gate"
OAOA3211:       OAOA2211
	$(POPCORN) -m oai -c $@ $< > $@

OR4:            DESCR = "4-input OR gate"
OR4:            OR3
	$(POPCORN) -m nor -c $@ $< > $@

#   --------    now buffered    ------------------------------------

else
ifeq ($(BUFFER),4)

CELLS +=        AND4 \
                AO23 \
                AO41 \
                AOA212 \
                AOA311 \
                OA22 \
                OA23 \
                OA3111 \
                OA41 \
                OA4111 \
                OAO2111 \
                OAO311 \
                OAOA2211 \
                OAOA3211 \
                OR4

AND4:           DESCR = "4-input AND gate"
AND4:           NAND3
	$(POPCORN) -m nand -c $@ $< > $@

AO23:           DESCR = "2-3-input AND-OR gate"
AO23:           OR4
	$(POPCORN) -m aoi -c $@ $< > $@

AO41:           DESCR = "4-1-input AND-OR gate"
AO41:           AOI31
	$(POPCORN) -m aoi -c $@ $< > $@

AOA212:         DESCR = "2-1-2-input AND-OR-AND gate"
AOA212:         OAI22
	$(POPCORN) -m nand -c $@ $< > $@

AOA311:         DESCR = "3-1-1-input AND-OR-AND gate"
AOA311:         AOAI211
	$(POPCORN) -m aoi -c $@ $< > $@

OA22:           DESCR = "2-2-input OR-AND gate"
OA22:           AND3
	$(POPCORN) -m oai -c $@ $< > $@

OA23:           DESCR = "2-3-input OR-AND gate"
OA23:           AND4
	$(POPCORN) -m oai -c $@ $< > $@

OA33:           DESCR = "3-3-input OR-AND gate"
OA33:           OA23
	$(POPCORN) -m oai -c $@ $< > $@

OA41:           DESCR = "4-1-input OR-AND gate"
OA41:           OAI31
	$(POPCORN) -m oai -c $@ $< > $@

OA43:           DESCR = "4-3-input OR-AND gate"
OA43:           OA33
	$(POPCORN) -m oai -c $@ $< > $@

OAO311:         DESCR = "3-1-1-input OR-AND-OR gate"
OAO311:         OAOI211
	$(POPCORN) -m oai -c $@ $< > $@

OAOA2211:       DESCR = "2-2-1-1-input OR-AND-OR-AND gate"
OAOA2211:       AOA311
	$(POPCORN) -m nor -c $@ $< > $@

OAOA3211:       DESCR = "3-2-1-1-input OR-AND-OR-AND gate"
OAOA3211:       OAOA2211
	$(POPCORN) -m oai -c $@ $< > $@

OR4:            DESCR = "4-input OR gate"
OR4:            NOR3
	$(POPCORN) -m nor -c $@ $< > $@

BUFFERED = true

#   --------    not buffered    ------------------------------------

else

CELLS +=        AOAI212 \
                AOAI311 \
                AOI23 \
                AOI41 \
                NAND4 \
                NOR4 \
                OAI23 \
                OAI3111 \
                OAI41 \
                OAI4111 \
                OAOAI2211 \
                OAOAI3211 \
                OAOI311

AOAI212:        DESCR = "2-1-2-input AND-OR-AND-Invert gate"
AOAI212:        OAI22
	$(POPCORN) -m nand -c $@ $< > $@

AOAI311:        DESCR = "3-1-1-input AND-OR-AND-Invert gate"
AOAI311:        AOAI211
	$(POPCORN) -m aoi -c $@ $< > $@

AOI23:          DESCR = "2-3-input AND-OR-Invert gate"
AOI23:          NOR4
	$(POPCORN) -m aoi -c $@ $< > $@

AOI41:          DESCR = "4-1-input AND-OR-Invert gate"
AOI41:          AOI31
	$(POPCORN) -m aoi -c $@ $< > $@

NAND4:          DESCR = "4-input Not-AND (or NAND) gate"
NAND4:          NAND3
	$(POPCORN) -m nand -c $@ $< > $@

NOR4:           DESCR = "4-input Not-OR (or NOR) gate"
NOR4:           NOR3
	$(POPCORN) -m nor -c $@ $< > $@

OAI23:          DESCR = "2-3-input OR-AND-Invert gate"
OAI23:          NAND4
	$(POPCORN) -m oai -c $@ $< > $@

OAI41:          DESCR = "4-1-input OR-AND-Invert gate"
OAI41:          OAI31
	$(POPCORN) -m oai -c $@ $< > $@

OAI33:          DESCR = "3-1-input OR-AND-Invert gate"
OAI33:          OAI23
	$(POPCORN) -m oai -c $@ $< > $@

OAI43:          DESCR = "4-3-input OR-AND-Invert gate"
OAI43:          OAI33
	$(POPCORN) -m oai -c $@ $< > $@

OAOAI2211:      DESCR = "2-2-1-1-input OR-AND-OR-AND-Invert gate"
OAOAI2211:      AOAI311
	$(POPCORN) -m nor -c $@ $< > $@

OAOAI3211:      DESCR = "3-2-1-1-input OR-AND-OR-AND-Invert gate"
OAOAI3211:      OAOAI2211
	$(POPCORN) -m oai -c $@ $< > $@

OAOI311:        DESCR = "3-1-1-input OR-AND-OR-Invert gate"
OAOI311:        OAOI211
	$(POPCORN) -m oai -c $@ $< > $@

endif
endif
