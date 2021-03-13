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

#   list all dependencies for cells with 3 stacked transistors
#
include stacked2_cells.mk

#   ----------------------------------------------------------------
#               CELL TARGETS
#   ----------------------------------------------------------------

ifdef BUFFERED

#   --------    already buffered    --------------------------------

CELLS +=        AAAO322 \
                AAAO332 \
                AAAO333 \
                AAO32 \
                AAO33 \
                AAO321 \
                AAO331 \
                AND3 \
                AO22 \
                AO31 \
                AO32 \
                OA22 \
                OA31 \
                OA32 \
                OR3 \
                OOA32 \
                OOA33 \
                OOA321 \
                OOA331 \
                OOOA322 \
                OOOA332 \
                OOOA333

AAAO322:        DESCR = "3-2-2-input AND-AND-AND-OR gate"
AAAO322:        AAO321
	$(POPCORN) -m nand -c $@ $< > $@
	$(BLUE)

AAAO332:        DESCR = "3-3-2-input AND-AND-AND-OR gate"
AAAO332:        AAO331
	$(POPCORN) -m nand -c $@ $< > $@
	$(BLUE)

AAAO333:        DESCR = "3-3-3-input AND-AND-AND-OR gate"
AAAO333:        AAAO332
	$(POPCORN) -m nand -c $@ $< > $@
	$(BLUE)

AAOA221:        DESCR = "2-2-1-input AND-AND-OR-AND gate"
AAOA221:        AOA211
	$(POPCORN) -m aoi -c $@ $< > $@
	$(BLUE)

AAO321:         DESCR = "3-2-1-input AND-AND-OR gate"
AAO321:         AAO32
	$(POPCORN) -m pd -c $@ $< > $@
	$(BLUE)

AAO331:         DESCR = "3-3-1-input AND-AND-OR gate"
AAO331:         AAO33
	$(POPCORN) -m pd -c $@ $< > $@
	$(BLUE)

AND3:           DESCR = "3-input AND gate"
AND3:           AND2
	$(POPCORN) -m nand -c $(*F) -c $@ $< > $@
	$(BLUE)

AO22:           DESCR = "2-2-input AND-OR gate"
AO22:           AO21
	$(POPCORN) -m nor -c $@ $< > $@
	$(BLUE)

AO31:           DESCR = "3-1-input AND-OR gate"
AO31:           AND3
	$(POPCORN) -m pd -c $@ $< > $@
	$(BLUE)

AO32:           DESCR = "3-2-input AND-OR gate"
AO32:           AO31
	$(POPCORN) -m nor -c $@ $< > $@
	$(BLUE)

AAO32:          DESCR = "3-2-input AND-AND-OR gate"
AAO32:          AO31
	$(POPCORN) -m nand -c $@ $< > $@
	$(BLUE)

AO321:          DESCR = "3-2-1-input AND-OR gate"
AO321:          AO221
	$(POPCORN) -m aoi -c $@ $< > $@
	$(BLUE)

AAO33:          DESCR = "3-3-input AND-AND-OR gate"
AAO33:          AAO32
	$(POPCORN) -m nand -c $@ $< > $@
	$(BLUE)

AOA211:         DESCR = "2-1-1-input AND-OR-AND gate"
AOA211:         OA21
	$(POPCORN) -m nand -c $@ $< > $@
	$(BLUE)

AOA221:         DESCR = "2-2-1-input AND-OR-AND gate"
AOA221:         OA31
	$(POPCORN) -m nand -c $@ $< > $@
	$(BLUE)

AOAO2111:       DESCR = "2-1-1-1-input AND-OR-AND-OR gate"
AOAO2111:       OAO211
	$(POPCORN) -m nand -c $@ $< > $@
	$(BLUE)

AOOA212:        DESCR = "2-1-2-input AND-OR-OR-AND gate"
AOOA212:        OOA22
	$(POPCORN) -m nand -c $@ $< > $@
	$(BLUE)

OA22:           DESCR = "2-2-input OR-AND gate"
OA22:           OA21
	$(POPCORN) -m nand -c $@ $< > $@
	$(BLUE)

OA31:           DESCR = "3-1-input OR-AND gate"
OA31:           OR3
	$(POPCORN) -m pu -c $@ $< > $@
	$(BLUE)

OA32:           DESCR = "3-2-input OR-AND gate"
OA32:           OA31
	$(POPCORN) -m nand -c $@ $< > $@
	$(BLUE)

OOA32:          DESCR = "3-2-input OR-OR-AND gate"
OOA32:          OA31
	$(POPCORN) -m nor -c $@ $< > $@
	$(BLUE)

OAO211:         DESCR = "2-1-1-input OR-AND-OR gate"
OAO211:         AO21
	$(POPCORN) -m oai -c $@ $< > $@
	$(BLUE)

OAO212:         DESCR = "2-1-2-input OR-AND-OR gate"
OAO212:         AO22
	$(POPCORN) -m nor -c $@ $< > $@
	$(BLUE)

OAO221:         DESCR = "2-2-1-input OR-AND-OR gate"
OAO221:         AO31
	$(POPCORN) -m nor -c $@ $< > $@
	$(BLUE)

OAOA2111:       DESCR = "2-1-1-1-input OR-AND-OR-AND gate"
OAOA2111:       AOA211
	$(POPCORN) -m nor -c $@ $< > $@
	$(BLUE)

OR3:            DESCR = "3-input OR gate"
OR3:            OR2
	$(POPCORN) -m nor -c $@ $< > $@
	$(BLUE)

OOA33:          DESCR = "3-3-input OR-OR-AND gate"
OOA33:          OOA32
	$(POPCORN) -m nor -c $@ $< > $@
	$(BLUE)

OOA321:         DESCR = "3-2-1-input OR-OR-AND gate"
OOA321:         OOA32
	$(POPCORN) -m pu -c $@ $< > $@
	$(BLUE)

OOA331:         DESCR = "3-3-1-input OR-OR-AND gate"
OOA331:         OOA33
	$(POPCORN) -m pu -c $@ $< > $@
	$(BLUE)

OOAO221:        DESCR = "2-2-1-input OR-OR-AND-OR gate"
OOAO221:        OAO211
	$(POPCORN) -m oai -c $@ $< > $@
	$(BLUE)

OOOA322:        DESCR = "3-2-2-input OR-OR-OR-AND gate"
OOOA322:        OOA321
	$(POPCORN) -m nor -c $@ $< > $@
	$(BLUE)

OOOA332:        DESCR = "3-3-2-input OR-OR-OR-AND gate"
OOOA332:        OOA331
	$(POPCORN) -m nor -c $@ $< > $@
	$(BLUE)

OOOA333:        DESCR = "3-3-3-input OR-OR-OR-AND gate"
OOOA333:        OOOA332
	$(POPCORN) -m nor -c $@ $< > $@
	$(BLUE)

else
ifeq ($(BUFFER),3)

#   --------    now buffered    ------------------------------------

CELLS +=        AAAO322 \
                AAAO332 \
                AAAO333 \
                AAO32 \
                AAO33 \
                AAO321 \
                AAO331 \
                AND3 \
                AO22 \
                AO31 \
                AO32 \
                OA22 \
                OA31 \
                OA32 \
                OR3 \
                OOA32 \
                OOA33 \
                OOA321 \
                OOA331 \
                OOOA322 \
                OOOA332 \
                OOOA333

AAAO322:        DESCR = "3-2-2-input AND-AND-AND-OR gate"
AAAO322:        AAO321
	$(POPCORN) -m nand -c $@ $< > $@
	$(BLUE)

AAAO332:        DESCR = "3-3-2-input AND-AND-AND-OR gate"
AAAO332:        AAO331
	$(POPCORN) -m nand -c $@ $< > $@
	$(BLUE)

AAAO333:        DESCR = "3-3-3-input AND-AND-AND-OR gate"
AAAO333:        AAAO332
	$(POPCORN) -m nand -c $@ $< > $@
	$(BLUE)

AAOA221:        DESCR = "2-2-1-input AND-AND-OR-AND gate"
AAOA221:        AOA211
	$(POPCORN) -m aoi -c $@ $< > $@
	$(BLUE)

AAO321:         DESCR = "3-2-1-input AND-AND-OR gate"
AAO321:         AAO32
	$(POPCORN) -m pd -c $@ $< > $@
	$(BLUE)

AAO331:         DESCR = "3-3-1-input AND-AND-OR gate"
AAO331:         AAO33
	$(POPCORN) -m pd -c $@ $< > $@
	$(BLUE)

AND3:           DESCR = "3-input AND gate"
AND3:           NAND2
	$(POPCORN) -m nand -c $@ $< > $@
	$(BLUE)

AO22:           DESCR = "2-2-input AND-OR gate"
AO22:           AOI21
	$(POPCORN) -m nor -c $@ $< > $@
	$(BLUE)

AO31:           DESCR = "3-1-input AND-OR gate"
AO31:           AND3
	$(POPCORN) -m pd -c $@ $< > $@
	$(BLUE)

AO32:           DESCR = "3-2-input AND-OR gate"
AO32:           AO31
	$(POPCORN) -m nor -c $@ $< > $@
	$(BLUE)

AAO32:          DESCR = "3-2-input AND-AND-OR gate"
AAO32:          AO31
	$(POPCORN) -m nand -c $@ $< > $@
	$(BLUE)

AO321:          DESCR = "3-2-1-input AND-OR gate"
AO321:          AO221
	$(POPCORN) -m aoi -c $@ $< > $@
	$(BLUE)

AAO33:          DESCR = "3-3-input AND-AND-OR gate"
AAO33:          AAO32
	$(POPCORN) -m nand -c $@ $< > $@
	$(BLUE)

AOA211:         DESCR = "2-1-1-input AND-OR-AND gate"
AOA211:         OAI21
	$(POPCORN) -m nand -c $@ $< > $@
	$(BLUE)

AOA221:         DESCR = "2-2-1-input AND-OR-AND gate"
AOA221:         OA31
	$(POPCORN) -m nand -c $@ $< > $@
	$(BLUE)

AOAO2111:       DESCR = "2-1-1-1-input AND-OR-AND-OR gate"
AOAO2111:       OAO211
	$(POPCORN) -m nand -c $@ $< > $@
	$(BLUE)

AOOA212:        DESCR = "2-1-2-input AND-OR-OR-AND gate"
AOOA212:        OOAI22
	$(POPCORN) -m nand -c $@ $< > $@
	$(BLUE)

OA22:           DESCR = "2-2-input OR-AND gate"
OA22:           OAI21
	$(POPCORN) -m nand -c $@ $< > $@
	$(BLUE)

OA31:           DESCR = "3-1-input OR-AND gate"
OA31:           OR3
	$(POPCORN) -m pu -c $@ $< > $@
	$(BLUE)

OA32:           DESCR = "3-2-input OR-AND gate"
OA32:           OA31
	$(POPCORN) -m nand -c $@ $< > $@
	$(BLUE)

OOA32:          DESCR = "3-2-input OR-OR-AND gate"
OOA32:          OA31
	$(POPCORN) -m nor -c $@ $< > $@
	$(BLUE)

OAO211:         DESCR = "2-1-1-input OR-AND-OR gate"
OAO211:         AOI21
	$(POPCORN) -m oai -c $@ $< > $@
	$(BLUE)

OAO212:         DESCR = "2-1-2-input OR-AND-OR gate"
OAO212:         AOI22
	$(POPCORN) -m nor -c $@ $< > $@
	$(BLUE)

OAO221:         DESCR = "2-2-1-input OR-AND-OR gate"
OAO221:         AO31
	$(POPCORN) -m nor -c $@ $< > $@
	$(BLUE)

OAOA2111:       DESCR = "2-1-1-1-input OR-AND-OR-AND gate"
OAOA2111:       AOA211
	$(POPCORN) -m nor -c $@ $< > $@
	$(BLUE)

OR3:            DESCR = "3-input OR gate"
OR3:            NOR2
	$(POPCORN) -m nor -c $@ $< > $@
	$(BLUE)

OOA33:          DESCR = "3-3-input OR-OR-AND gate"
OOA33:          OOA32
	$(POPCORN) -m nor -c $@ $< > $@
	$(BLUE)

OOA321:         DESCR = "3-2-1-input OR-OR-AND gate"
OOA321:         OOA32
	$(POPCORN) -m pu -c $@ $< > $@
	$(BLUE)

OOA331:         DESCR = "3-3-1-input OR-OR-AND gate"
OOA331:         OOA33
	$(POPCORN) -m pu -c $@ $< > $@
	$(BLUE)

OOAO221:        DESCR = "2-2-1-input OR-OR-AND-OR gate"
OOAO221:        OAO211
	$(POPCORN) -m oai -c $@ $< > $@
	$(BLUE)

OOOA322:        DESCR = "3-2-2-input OR-OR-OR-AND gate"
OOOA322:        OOA321
	$(POPCORN) -m or -c $@ $< > $@
	$(BLUE)

OOOA332:        DESCR = "3-3-2-input OR-OR-OR-AND gate"
OOOA332:        OOA331
	$(POPCORN) -m nor -c $@ $< > $@
	$(BLUE)

OOOA333:        DESCR = "3-3-3-input OR-OR-OR-AND gate"
OOOA333:        OOOA332
	$(POPCORN) -m nor -c $@ $< > $@
	$(BLUE)

BUFFERED = true

else

#   --------    not buffered    ------------------------------------

CELLS +=        AAAOI322 \
                AAAOI332 \
                AAAOI333 \
                AAOI32 \
                AAOI33 \
                AAOI321 \
                AAOI331 \
                AOI22 \
                AOI31 \
                AOI32 \
                NAND3 \
                NOR3 \
                OAI22 \
                OAI31 \
                OAI32 \
                OOAI32 \
                OOAI33 \
                OOAI321 \
                OOAI331 \
                OOOAI322 \
                OOOAI332 \
                OOOAI333

AAAOI322:       DESCR = "3-2-2-input AND-AND-AND-OR-Invert gate"
AAAOI322:       AAOI321
	$(POPCORN) -m nand -c $@ $< > $@
	$(BLUE)

AAAOI332:       DESCR = "3-3-2-input AND-AND-AND-OR-Invert gate"
AAAOI332:       AAOI331
	$(POPCORN) -m nand -c $@ $< > $@
	$(BLUE)

AAAOI333:       DESCR = "3-3-3-input AND-AND-AND-OR-Invert gate"
AAAOI333:       AAAOI332
	$(POPCORN) -m nand -c $@ $< > $@
	$(BLUE)

AAOAI221:       DESCR = "2-2-1-input AND-AND-OR-AND gate"
AAOAI221:       AOAI211
	$(POPCORN) -m aoi -c $@ $< > $@
	$(BLUE)

AAOI321:        DESCR = "3-2-1-input AND-AND-OR-Invert gate"
AAOI321:        AAOI32
	$(POPCORN) -m pd -c $@ $< > $@
	$(BLUE)

AAOI331:        DESCR = "3-3-1-input AND-AND-OR-Invert gate"
AAOI331:        AAOI33
	$(POPCORN) -m pd -c $@ $< > $@
	$(BLUE)

AOAI211:        DESCR = "2-1-1-input AND-OR-AND-Invert gate"
AOAI211:        OAI21
	$(POPCORN) -m nand -c $@ $< > $@
	$(BLUE)

AOAI221:        DESCR = "2-2-1-input AND-OR-AND-Invert gate"
AOAI221:        OAI31
	$(POPCORN) -m nand -c $@ $< > $@
	$(BLUE)

AOAOI2111:      DESCR = "2-1-1-1-input AND-OR-AND-OR-Invert gate"
AOAOI2111:      OAOI211
	$(POPCORN) -m nand -c $@ $< > $@
	$(BLUE)

AOI22:          DESCR = "2-2-input AND-OR-Invert gate"
AOI22:          AOI21
	$(POPCORN) -m nor -c $@ $< > $@
	$(BLUE)

AOI31:          DESCR = "3-1-input AND-OR-Invert gate"
AOI31:          NAND3
	$(POPCORN) -m pd -c $@ $< > $@
	$(BLUE)

AOI32:          DESCR = "3-2-input AND-OR-Invert gate"
AOI32:          AOI31
	$(POPCORN) -m nor -c $@ $< > $@
	$(BLUE)

AAOI32:         DESCR = "3-2-input AND-AND-OR-Invert gate"
AAOI32:         AOI31
	$(POPCORN) -m nand -c $@ $< > $@
	$(BLUE)

AAOI33:         DESCR = "3-3-input AND-AND-OR-Invert gate"
AAOI33:         AAOI32
	$(POPCORN) -m nand -c $@ $< > $@
	$(BLUE)

AOOAI212:       DESCR = "2-1-2-input AND-OR-OR-AND-Invert gate"
AOOAI212:       OOAI22
	$(POPCORN) -m nand -c $@ $< > $@
	$(BLUE)

NAND3:          DESCR = "3-input Not-AND (or NAND) gate"
NAND3:          NAND2
	$(POPCORN) -m nand -c $@ $< > $@
	$(BLUE)

NOR3:           DESCR = "3-input Not-OR (or NOR) gate"
NOR3:           NOR2
	$(POPCORN) -m nor -c $@ $< > $@
	$(BLUE)

OAI22:          DESCR = "2-2-input OR-AND-Invert gate"
OAI22:          OAI21
	$(POPCORN) -m nand -c $@ $< > $@
	$(BLUE)

OAI31:          DESCR = "3-1-input OR-AND-Invert gate"
OAI31:          NOR3
	$(POPCORN) -m pu -c $@ $< > $@
	$(BLUE)

OAI32:          DESCR = "3-2-input OR-AND-Invert gate"
OAI32:          OAI31
	$(POPCORN) -m nand -c $@ $< > $@
	$(BLUE)

OOAI321:         DESCR = "3-2-1-input OR-OR-AND-Invert gate"
OOAI321:         OOAI32
	$(POPCORN) -m pu -c $@ $< > $@
	$(BLUE)

OOAI32:         DESCR = "3-2-input OR-OR-AND-Invert gate"
OOAI32:         OAI31
	$(POPCORN) -m nor -c $@ $< > $@
	$(BLUE)

OAOAI2111:      DESCR = "2-1-1-1-input OR-AND-OR-AND-Invert gate"
OAOAI2111:      AOAI211
	$(POPCORN) -m nor -c $@ $< > $@
	$(BLUE)

OAOI211:        DESCR = "2-1-1-input OR-AND-OR-Invert gate"
OAOI211:        AOI21
	$(POPCORN) -m oai -c $@ $< > $@
	$(BLUE)

OAOI212:        DESCR = "2-1-2-input OR-AND-OR-Invert gate"
OAOI212:        AOI22
	$(POPCORN) -m nor -c $@ $< > $@
	$(BLUE)

OAOI221:        DESCR = "2-2-1-input OR-AND-OR-Invert gate"
OAOI221:        AOI31
	$(POPCORN) -m nor -c $@ $< > $@
	$(BLUE)

OOAI33:         DESCR = "3-3-input OR-OR-AND-Invert gate"
OOAI33:         OOAI32
	$(POPCORN) -m nor -c $@ $< > $@
	$(BLUE)

OOAI331:        DESCR = "3-3-1-input OR-OR-AND-Invert gate"
OOAI331:        OOAI33
	$(POPCORN) -m pu -c $@ $< > $@
	$(BLUE)

OOAOI221:       DESCR = "2-2-1-input OR-OR-AND-OR-Invert gate"
OOAOI221:       OAOI211
	$(POPCORN) -m oai -c $@ $< > $@
	$(BLUE)

OOOAI322:       DESCR = "3-2-2-input OR-OR-OR-AND-Invert gate"
OOOAI322:       OOAI321
	$(POPCORN) -m nor -c $@ $< > $@
	$(BLUE)

OOOAI332:       DESCR = "3-3-2-input OR-OR-OR-AND-Invert gate"
OOOAI332:       OOAI331
	$(POPCORN) -m nor -c $@ $< > $@
	$(BLUE)

OOOAI333:       DESCR = "3-3-3-input OR-OR-OR-AND-Invert gate"
OOOAI333:       OOOAI332
	$(POPCORN) -m nor -c $@ $< > $@
	$(BLUE)

endif
endif
