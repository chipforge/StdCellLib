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

CELLS +=        AAOA321 \
                AAOA331 \
                AND4 \
                AO23 \
                AO33 \
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
                OOAO321 \
                OR4

AAOA321:        DESCR = "3-2-1-input AND-AND-OR-AND gate"
AAOA321:        AAOA221
	$(POPCORN) -m nand -c $@ $< > $@
	$(TRACING)

AAOA331:        DESCR = "3-3-1-input AND-AND-OR-AND gate"
AAOA331:        LIMIT = 4
AAOA331:        AAOA321
	$(POPCORN) -m nand -c $@ $< > $@
	$(TRACING)

AND4:           DESCR = "4-input AND gate"
AND4:           AND3
	$(POPCORN) -m nand -c $@ $< > $@
	$(TRACING)

AO23:           DESCR = "2-3-input AND-OR gate"
AO23:           OR4
	$(POPCORN) -m aoi -c $@ $< > $@
	$(TRACING)

AO33:           DESCR = "3-3-input AND-OR gate"
AO33:           AO23
	$(POPCORN) -m nand -c $@ $< > $@
	$(TRACING)

AO41:           DESCR = "4-1-input AND-OR gate"
AO41:           AO31
	$(POPCORN) -m nand -c $@ $< > $@
	$(TRACING)

AOA212:         DESCR = "2-1-2-input AND-OR-AND gate"
AOA212:         OA22
	$(POPCORN) -m nand -c $@ $< > $@
	$(TRACING)

AOA311:         DESCR = "3-1-1-input AND-OR-AND gate"
AOA311:         AOA211
	$(POPCORN) -m aoi -c $@ $< > $@
	$(TRACING)

OA22:           DESCR = "2-2-input OR-AND gate"
OA22:           AND3
	$(POPCORN) -m oai -c $@ $< > $@
	$(TRACING)

OA23:           DESCR = "2-3-input OR-AND gate"
OA23:           AND4
	$(POPCORN) -m oai -c $@ $< > $@
	$(TRACING)

OA33:           DESCR = "3-3-input OR-AND gate"
OA33:           OA23
	$(POPCORN) -m oai -c $@ $< > $@
	$(TRACING)

OA41:           DESCR = "4-1-input OR-AND gate"
OA41:           OA31
	$(POPCORN) -m oai -c $@ $< > $@
	$(TRACING)

OA43:           DESCR = "4-3-input OR-AND gate"
OA43:           OA33
	$(POPCORN) -m oai -c $@ $< > $@
	$(TRACING)

OAO311:         DESCR = "3-1-1-input OR-AND-OR gate"
OAO311:         OAO211
	$(POPCORN) -m oai -c $@ $< > $@
	$(TRACING)

OAOA2211:       DESCR = "2-2-1-1-input OR-AND-OR-AND gate"
OAOA2211:       AOA311
	$(POPCORN) -m nor -c $@ $< > $@
	$(TRACING)

OAOA3211:       DESCR = "3-2-1-1-input OR-AND-OR-AND gate"
OAOA3211:       OAOA2211
	$(POPCORN) -m oai -c $@ $< > $@
	$(TRACING)

OOAO321:        DESCR = "3-2-1-input OR-OR-AND-OR gate"
OOAO321:        OOAO221
	$(POPCORN) -m oai -c $@ $< > $@
	$(TRACING)

OR4:            DESCR = "4-input OR gate"
OR4:            OR3
	$(POPCORN) -m nor -c $@ $< > $@
	$(TRACING)

#   --------    now buffered    ------------------------------------

else
ifeq ($(BUFFER),4)

CELLS +=        AAOA321 \
                AAOA331 \
                AND4 \
                AO23 \
                AO33 \
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
                OOAO321 \
                OR4

AAOA321:        DESCR = "3-2-1-input AND-AND-OR-AND gate"
AAOA321:        AAOAI221
	$(POPCORN) -m nand -c $@ $< > $@
	$(TRACING)

AAOA331:        DESCR = "3-3-1-input AND-AND-OR-AND gate"
AAOA331:        LIMIT = 4
AAOA331:        AAOA321
	$(POPCORN) -m nand -c $@ $< > $@
	$(TRACING)

AND4:           DESCR = "4-input AND gate"
AND4:           NAND3
	$(POPCORN) -m nand -c $@ $< > $@
	$(TRACING)

AO23:           DESCR = "2-3-input AND-OR gate"
AO23:           OR4
	$(POPCORN) -m aoi -c $@ $< > $@
	$(TRACING)

AO33:           DESCR = "3-3-input AND-OR gate"
AO33:           AO23
	$(POPCORN) -m nand -c $@ $< > $@
	$(TRACING)

AO41:           DESCR = "4-1-input AND-OR gate"
AO41:           AOI31
	$(POPCORN) -m nand -c $@ $< > $@
	$(TRACING)

AOA212:         DESCR = "2-1-2-input AND-OR-AND gate"
AOA212:         OAI22
	$(POPCORN) -m nand -c $@ $< > $@
	$(TRACING)

AOA311:         DESCR = "3-1-1-input AND-OR-AND gate"
AOA311:         AOAI211
	$(POPCORN) -m aoi -c $@ $< > $@
	$(TRACING)

OA22:           DESCR = "2-2-input OR-AND gate"
OA22:           AND3
	$(POPCORN) -m oai -c $@ $< > $@
	$(TRACING)

OA23:           DESCR = "2-3-input OR-AND gate"
OA23:           AND4
	$(POPCORN) -m oai -c $@ $< > $@
	$(TRACING)

OA33:           DESCR = "3-3-input OR-AND gate"
OA33:           OA23
	$(POPCORN) -m oai -c $@ $< > $@
	$(TRACING)

OA41:           DESCR = "4-1-input OR-AND gate"
OA41:           OAI31
	$(POPCORN) -m oai -c $@ $< > $@
	$(TRACING)

OA43:           DESCR = "4-3-input OR-AND gate"
OA43:           OA33
	$(POPCORN) -m oai -c $@ $< > $@
	$(TRACING)

OAO311:         DESCR = "3-1-1-input OR-AND-OR gate"
OAO311:         OAOI211
	$(POPCORN) -m oai -c $@ $< > $@
	$(TRACING)

OAOA2211:       DESCR = "2-2-1-1-input OR-AND-OR-AND gate"
OAOA2211:       AOA311
	$(POPCORN) -m nor -c $@ $< > $@
	$(TRACING)

OAOA3211:       DESCR = "3-2-1-1-input OR-AND-OR-AND gate"
OAOA3211:       OAOA2211
	$(POPCORN) -m oai -c $@ $< > $@
	$(TRACING)

OOAO321:        DESCR = "3-2-1-input OR-OR-AND-OR gate"
OOAO321:        OOAOI221
	$(POPCORN) -m oai -c $@ $< > $@
	$(TRACING)

OR4:            DESCR = "4-input OR gate"
OR4:            NOR3
	$(POPCORN) -m nor -c $@ $< > $@
	$(TRACING)

BUFFERED = true

#   --------    not buffered    ------------------------------------

else

CELLS +=        AAOAI321 \
                AAOAI331 \
                AOAI212 \
                AOAI311 \
                AOI23 \
                AOI33 \
                AOI41 \
                NAND4 \
                NOR4 \
                OAI23 \
                OAI3111 \
                OAI41 \
                OAI4111 \
                OAOAI2211 \
                OAOAI3211 \
                OAOI311 \
                OOAOI321

AAOAI321:       DESCR = "3-2-1-input AND-AND-OR-AND-Invert gate"
AAOAI321:       AAOAI221
	$(POPCORN) -m nand -c $@ $< > $@
	$(TRACING)

AAOAI331:       DESCR = "3-3-1-input AND-AND-OR-AND-Invert gate"
AAOAI331:       LIMIT = 4
AAOAI331:       AAOAI321
	$(POPCORN) -m nand -c $@ $< > $@
	$(TRACING)

AOAI212:        DESCR = "2-1-2-input AND-OR-AND-Invert gate"
AOAI212:        OAI22
	$(POPCORN) -m nand -c $@ $< > $@
	$(TRACING)

AOAI311:        DESCR = "3-1-1-input AND-OR-AND-Invert gate"
AOAI311:        AOAI211
	$(POPCORN) -m aoi -c $@ $< > $@
	$(TRACING)

AOI23:          DESCR = "2-3-input AND-OR-Invert gate"
AOI23:          NOR4
	$(POPCORN) -m aoi -c $@ $< > $@
	$(TRACING)

AOI33:          DESCR = "3-3-input AND-OR-Invert gate"
AOI33:          AOI23
	$(POPCORN) -m nand -c $@ $< > $@
	$(TRACING)

AOI41:          DESCR = "4-1-input AND-OR-Invert gate"
AOI41:          AOI31
	$(POPCORN) -m nand -c $@ $< > $@
	$(TRACING)

NAND4:          DESCR = "4-input Not-AND (or NAND) gate"
NAND4:          NAND3
	$(POPCORN) -m nand -c $@ $< > $@
	$(TRACING)

NOR4:           DESCR = "4-input Not-OR (or NOR) gate"
NOR4:           NOR3
	$(POPCORN) -m nor -c $@ $< > $@
	$(TRACING)

OAI23:          DESCR = "2-3-input OR-AND-Invert gate"
OAI23:          NAND4
	$(POPCORN) -m oai -c $@ $< > $@
	$(TRACING)

OAI41:          DESCR = "4-1-input OR-AND-Invert gate"
OAI41:          OAI31
	$(POPCORN) -m oai -c $@ $< > $@
	$(TRACING)

OAI33:          DESCR = "3-1-input OR-AND-Invert gate"
OAI33:          OAI23
	$(POPCORN) -m oai -c $@ $< > $@
	$(TRACING)

OAI43:          DESCR = "4-3-input OR-AND-Invert gate"
OAI43:          OAI33
	$(POPCORN) -m oai -c $@ $< > $@
	$(TRACING)

OAOAI2211:      DESCR = "2-2-1-1-input OR-AND-OR-AND-Invert gate"
OAOAI2211:      AOAI311
	$(POPCORN) -m nor -c $@ $< > $@
	$(TRACING)

OAOAI3211:      DESCR = "3-2-1-1-input OR-AND-OR-AND-Invert gate"
OAOAI3211:      OAOAI2211
	$(POPCORN) -m oai -c $@ $< > $@
	$(TRACING)

OAOI311:        DESCR = "3-1-1-input OR-AND-OR-Invert gate"
OAOI311:        OAOI211
	$(POPCORN) -m oai -c $@ $< > $@
	$(TRACING)

OOAOI321:       DESCR = "3-2-1-input OR-OR-AND-OR-Invert gate"
OOAOI321:       OOAOI221
	$(POPCORN) -m oai -c $@ $< > $@
	$(TRACING)

endif
endif
