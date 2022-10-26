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
#   File:           StdCellLib/Catalog/stacked3_aphase_unbuf_cells.mk
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

#   Dependencies for cells with 3 stacked transistors,
#   which are still unbuffered.

#   ----------------------------------------------------------------
#               CELL TARGETS - still unbuffered
#   ----------------------------------------------------------------

#   --------    2x3T one phase      --------------------------------

CELLS +=        NAND3 NOR3

NAND3:          DESCR = "3-input Not-AND (or NAND) gate"
NAND3:          NAND2
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED3)

NOR3:           DESCR = "3-input Not-OR (or NOR) gate"
NOR3:           NOR2
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED3)

#   --------    2x4T two phases     --------------------------------

CELLS +=        AOI22 OAI22 \
                AOI31 OAI31

AOI22:          DESCR = "2-2-input AND-OR-Invert gate"
AOI22:          AOI21
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED3)

OAI22:          DESCR = "2-2-input OR-AND-Invert gate"
OAI22:          OAI21
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED3)

AOI31:          DESCR = "3-1-input AND-OR-Invert gate"
AOI31:          NAND3
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED3)

OAI31:          DESCR = "3-1-input OR-AND-Invert gate"
OAI31:          NOR3
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED3)

#   --------    2x4T three phases   --------------------------------

CELLS +=        AOAI211 OAOI211

AOAI211:        DESCR = "2-1-1-input AND-OR-AND-Invert gate"
AOAI211:        AOI21
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED3)

OAOI211:        DESCR = "2-1-1-input OR-AND-OR-Invert gate"
OAOI211:        OAI21
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED3)

#   --------    2x5T two phases     --------------------------------

CELLS +=        AOI32 OAI32 \
                AAOI32 OOAI32 \
                AAOI221 OOAI221

AOI32:          DESCR = "3-2-input AND-OR-Invert gate"
AOI32:          AOI31
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED3)

OAI32:          DESCR = "3-2-input OR-AND-Invert gate"
OAI32:          OAI31
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED3)

AAOI32:         DESCR = "3-2-input AND-AND-OR-Invert gate"
AAOI32:         AOI31
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED3)

OOAI32:         DESCR = "3-2-input OR-OR-AND-Invert gate"
OOAI32:         OAI31
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED3)

AAOI221:        DESCR = "2-2-1-input AND-AND-OR-Invert gate"
AAOI221:        AAOI22
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED3)

OOAI221:        DESCR = "2-2-1-input OR-OR-AND-Invert gate"
OOAI221:        OOAI22
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED3)

#   --------    2x5T three phases   --------------------------------

CELLS +=        AOAI221 OAOI221 \
                AOOAI212 OAAOI212 \
                AAOAI221 OOAOI221

AOAI221:        DESCR = "2-2-1-input AND-OR-AND-Invert gate"
AOAI221:        AOI22
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED3)

OAOI221:        DESCR = "2-2-1-input OR-AND-OR-Invert gate"
OAOI221:        OAI22
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED3)

AOOAI212:       DESCR = "2-1-2-input AND-OR-OR-AND-Invert gate"
AOOAI212:       AOAI211
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED3)

OAAOI212:       DESCR = "2-1-2-input OR-AND-AND-OR-Invert gate"
OAAOI212:       OAOI211
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED3)

AAOAI221:       DESCR = "2-2-1-input AND-AND-OR-AND-Invert gate"
AAOAI221:       AAOI22
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED3)

OOAOI221:       DESCR = "2-2-1-input OR-OR-AND-OR-Invert gate"
OOAOI221:       OOAI22
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED3)

#   --------    2x5T four phases    --------------------------------

CELLS +=        AOAOI2111 OAOAI2111

AOAOI2111:      DESCR = "2-1-1-1-input AND-OR-AND-OR-Invert gate"
AOAOI2111:      AOAI211
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED3)

OAOAI2111:      DESCR = "2-1-1-1-input OR-AND-OR-AND-Invert gate"
OAOAI2111:      OAOI211
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED3)

#   --------    2x6T two phases     --------------------------------

CELLS +=        AAAOI222 OOOAI222 \
                AAOI321 OOAI321 \
                AAOI33 OOAI33

AAAOI222:       DESCR = "2-2-2-input AND-AND-AND-OR-Invert gate"
AAAOI222:       AAOI221
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED3)

OOOAI222:       DESCR = "2-2-2-input OR-OR-OR-AND-Invert gate"
OOOAI222:       OOAI221
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED3)

AAOI321:        DESCR = "3-2-1-input AND-AND-OR-Invert gate"
AAOI321:        AAOI32
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED3)

OOAI321:        DESCR = "3-2-1-input OR-OR-AND-Invert gate"
OOAI321:        OOAI32
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED3)

AAOI33:         DESCR = "3-3-input AND-AND-OR-Invert gate"
AAOI33:         AAOI32
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED3)

OOAI33:         DESCR = "3-3-input OR-OR-AND-Invert gate"
OOAI33:         OOAI32
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED3)

#   --------    2x6T three phases   --------------------------------

CELLS +=        AOOAI213 OAAOI213 \
                AOOAI222 OAAOI222 \
                AAOAI2211 OOAOI2211 \
                AAOOAI222 OOAAOI222

AOOAI213:       DESCR = "2-1-3-input AND-OR-OR-AND-Invert gate"
AOOAI213:       AOOAI212
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED3)

OAAOI213:       DESCR = "2-1-3-input OR-AND-AND-OR-Invert gate"
OAAOI213:       OAAOI212
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED3)

AOOAI222:       DESCR = "2-2-2-input AND-OR-OR-AND-Invert gate"
AOOAI222:       AOAI221
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED3)

OAAOI222:       DESCR = "2-2-2-input OR-AND-AND-OR-Invert gate"
OAAOI222:       OAOI221
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED3)

AAOAI2211:      DESCR = "2-2-1-1-input AND-AND-OR-AND-Invert gate"
AAOAI2211:      AAOI221
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED3)

OOAOI2211:      DESCR = "2-2-1-1-input OR-OR-AND-OR-Invert gate"
OOAOI2211:      OOAI221
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED3)

AAOOAI222:      DESCR = "2-2-2-input AND-AND-OR-OR-AND-Invert gate"
AAOOAI222:      AAOAI221
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED3)

OOAAOI222:      DESCR = "2-2-2-input OR-OR-AND-AND-OR-Invert gate"
OOAAOI222:      OOAOI221
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED3)

#   --------    2x6T four phases    --------------------------------

CELLS +=        AOOAOI2121 OAAOAI2121 \
                AOAAOI2112 OAOOAI2112 \
                AAOAOI2211 OOAOAI2211

AOOAOI2121:     DESCR = "2-1-2-1-input AND-OR-OR-AND-OR-Invert gate"
AOOAOI2121:     AOOAI212
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED3)

OAAOAI2121:     DESCR = "2-1-2-1-input OR-AND-AND-OR-AND-Invert gate"
OAAOAI2121:     OAAOI212
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED3)

AOAAOI2112:     DESCR = "2-1-1-2-input AND-OR-AND-AND-OR-Invert gate"
AOAAOI2112:     AOAOI2111
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED3)

OAOOAI2112:     DESCR = "2-1-1-2-input OR-AND-OR-OR-AND-Invert gate"
OAOOAI2112:     OAOAI2111
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED3)

AAOAOI2211:     DESCR = "2-2-1-1-input AND-AND-OR-AND-OR-Invert gate"
AAOAOI2211:     AAOAI221
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED3)

OOAOAI2211:     DESCR = "2-2-1-1-input OR-OR-AND-OR-AND-Invert gate"
OOAOAI2211:     OOAOI221
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED3)

#   --------    2x7T two phases     --------------------------------

CELLS +=        AAOI331 OOAI331 \
                AAAOI322 OOOAI322

AAOI331:        DESCR = "3-3-1-input AND-AND-OR-Invert gate"
AAOI331:        AAOI33
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED3)

OOAI331:        DESCR = "3-3-1-input OR-OR-AND-Invert gate"
OOAI331:        OOAI33
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED3)

AAAOI322:       DESCR = "3-2-2-input AND-AND-AND-OR-Invert gate"
AAAOI322:       AAOI321
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED3)

OOOAI322:       DESCR = "3-2-2-input OR-OR-OR-AND-Invert gate"
OOOAI322:       OOAI321
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED3)

#   --------    2x7T three phases   --------------------------------

CELLS +=        AOOAI223 OAAOI223 \
                AAOOAI223 OOAAOI223 \
                AAOOAI2212 OOAAOI2212 \
                AAAOAI2221 OOOAOI2221

AOOAI223:       DESCR = "2-2-3-input AND-OR-OR-AND-Invert gate"
AOOAI223:       AOOAI222
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED3)

OAAOI223:       DESCR = "2-2-3-input OR-AND-AND-OR-Invert gate"
OAAOI223:       OAAOI222
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED3)

AAOOAI223:      DESCR = "2-2-3-input AND-AND-OR-OR-AND-Invert gate"
AAOOAI223:      AAOOAI222
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED3)

OOAAOI223:      DESCR = "2-2-3-input OR-OR-AND-AND-OR-Invert gate"
OOAAOI223:      OOAAOI222
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED3)

AAOOAI2212:     DESCR = "2-2-1-2-input AND-AND-OR-OR-AND-Invert gate"
AAOOAI2212:     AAOAI2211
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED3)

OOAAOI2212:     DESCR = "2-2-1-2-input OR-OR-AND-AND-OR-Invert gate"
OOAAOI2212:     OOAOI2211
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED3)

AAAOAI2221:     DESCR = "2-2-2-1-input AND-AND-OR-AND-Invert gate"
AAAOAI2221:     AAAOI222
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED3)

OOOAOI2221:     DESCR = "2-2-2-1-input OR-OR-OR-AND-OR-Invert gate"
OOOAOI2221:     OOOAI222
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED3)

#   --------    2x7T four phases    --------------------------------

CELLS +=        AOAAOI2113 OAOOAI2113 \
                AOOAAOI2122 OAAOOAI2122 \
                AAOAAOI2212 OOAOOAI2212 \
                AAOOAOI2221 OOAAOAI2221

AOAAOI2113:     DESCR = "2-1-1-3-input AND-OR-AND-AND-OR-Invert gate"
AOAAOI2113:     AOAAOI2112
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED3)

OAOOAI2113:     DESCR = "2-1-1-3-input OR-AND-OR-OR-AND-Invert gate"
OAOOAI2113:     OAOOAI2112
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED3)

AOOAAOI2122:    DESCR = "2-1-2-2-input AND-OR-OR-AND-AND-OR-Invert gate"
AOOAAOI2122:    AOOAOI2121
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED3)

OAAOOAI2122:    DESCR = "2-1-2-2-input OR-AND-AND-OR-AND-AND-Invert gate"
OAAOOAI2122:    OAAOAI2121
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED3)

AAOAAOI2212:    DESCR = "2-2-1-2-input AND-AND-OR-AND-AND-OR-Invert gate"
AAOAAOI2212:    AAOAOI2211
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED3)

OOAOOAI2212:    DESCR = "2-2-1-2-input OR-OR-AND-OR-OR-AND-Invert gate"
OOAOOAI2212:    OOAOAI2211
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED3)

AAOOAOI2221:    DESCR = "2-2-2-1-input AND-AND-OR-OR-AND-OR-Invert gate"
AAOOAOI2221:    AAOOAI222
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED3)

OOAAOAI2221:    DESCR = "2-2-2-1-input OR-OR-AND-AND-OR-AND-Invert gate"
OOAAOAI2221:    OOAAOI222
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED3)

#   --------    2x8T two phases     --------------------------------

CELLS +=        AAAOI332 OOOAI332 \

AAAOI332:       DESCR = "3-3-2-input AND-AND-AND-OR-Invert gate"
AAAOI332:       AAOI331
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED3)

OOOAI332:       DESCR = "3-3-2-input OR-OR-OR-AND-Invert gate"
OOOAI332:       OOAI331
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED3)

#   --------    2x8T three phases   --------------------------------

CELLS +=        AAOOAI2213 OOAAOI2213 \
                AAAOOAI2222 OOOAAOI2222 \

AAOOAI2213:     DESCR = "2-2-1-3-input AND-AND-OR-OR-AND-Invert gate"
AAOOAI2213:     AAOOAI2212
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED3)

OOAAOI2213:     DESCR = "2-2-1-3-input OR-OR-AND-AND-OR-Invert gate"
OOAAOI2213:     OOAAOI2212
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED3)

AAAOOAI2222:    DESCR = "2-2-2-2-input AND-AND-AND-OR-OR-AND-Invert gate"
AAAOOAI2222:    AAAOAI2221
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED3)

OOOAAOI2222:    DESCR = "2-2-2-2-input OR-OR-OR-AND-AND-OR-Invert gate"
OOOAAOI2222:    OOOAOI2221
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED3)

#   --------    2x8T four phases    --------------------------------

CELLS +=        AOOAAOI2123 OAAOOAI2123 \
                AAOAAOI2213 OOAOOAI2213 \
                AAOOAAOI2222 OOAAOOAI2222 \

AOOAAOI2123:    DESCR = "2-1-2-3-input AND-OR-OR-AND-AND-OR-Invert gate"
AOOAAOI2123:    AOOAAOI2122
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED3)

OAAOOAI2123:    DESCR = "2-1-2-3-input OR-AND-AND-OR-AND-AND-Invert gate"
OAAOOAI2123:    OAAOOAI2122
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED3)

AAOAAOI2213:    DESCR = "2-2-1-3-input AND-AND-OR-AND-AND-OR-Invert gate"
AAOAAOI2213:    AAOAAOI2212
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED3)

OOAOOAI2213:    DESCR = "2-2-1-3-input OR-OR-AND-OR-OR-AND-Invert gate"
OOAOOAI2213:    OOAOOAI2212
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED3)

AAOOAAOI2222:   DESCR = "2-2-2-2-input AND-AND-OR-OR-AND-AND-OR-Invert gate"
AAOOAAOI2222:   AAOOAOI2221
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED3)

OOAAOOAI2222:   DESCR = "2-2-2-2-input OR-OR-AND-AND-OR-OR-AND-Invert gate"
OOAAOOAI2222:   OOAAOAI2221
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED3)

#   --------    2x9T two phases     --------------------------------

CELLS +=        AAAOI333 OOOAI333

AAAOI333:       DESCR = "3-3-3-input AND-AND-AND-OR-Invert gate"
AAAOI333:       AAAOI332
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED3)

OOOAI333:       DESCR = "3-3-3-input OR-OR-OR-AND-Invert gate"
OOOAI333:       OOOAI332
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED3)

#   --------    2x9T three phases   --------------------------------

CELLS +=        AAAOOAI2223 OOOAAOI2223

AAAOOAI2223:    DESCR = "2-2-2-3-input AND-AND-AND-OR-OR-AND-Invert gate"
AAAOOAI2223:    AAAOOAI2222
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED3)

OOOAAOI2223:    DESCR = "2-2-2-3-input OR-OR-OR-AND-AND-OR-Invert gate"
OOOAAOI2223:    OOOAAOI2222
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED3)

#   --------    2x9T four phases    --------------------------------

CELLS +=        AAOOAAOI2223 OOAAOOAI2223

AAOOAAOI2223:   DESCR = "2-2-2-3-input AND-AND-OR-OR-AND-AND-OR-Invert gate"
AAOOAAOI2223:   AAOOAAOI2222
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED3)

OOAAOOAI2223:   DESCR = "2-2-2-3-input OR-OR-AND-AND-OR-OR-AND-Invert gate"
OOAAOOAI2223:   OOAAOOAI2222
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED3)
