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
#   File:           StdCellLib/Catalog/stacked3_aphase_allbuf_cells.mk
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
#   ////////////////////////////////////////////////////////////////

#   ----------------------------------------------------------------
#               DESCRIPTION
#   ----------------------------------------------------------------

#   Dependencies for cells with 3 stacked transistors,
#   which are all well buffered.

#   ----------------------------------------------------------------
#               CELL TARGETS - already buffered
#   ----------------------------------------------------------------

#   --------    2x3T one phase      --------------------------------

CELLS +=        AND3 OR3

AND3:           DESCR = "3-input AND gate"
AND3:           AND2
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED3)

OR3:            DESCR = "3-input OR gate"
OR3:            OR2
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED3)

#   --------    2x4T two phases     --------------------------------

CELLS +=        AO22 OA22 \
                AO31 OA31

AO22:           DESCR = "2-2-input AND-OR gate"
AO22:           AO21
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED3)

OA22:           DESCR = "2-2-input OR-AND gate"
OA22:           OA21
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED3)

AO31:           DESCR = "3-1-input AND-OR gate"
AO31:           AND3
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED3)

OA31:           DESCR = "3-1-input OR-AND gate"
OA31:           OR3
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED3)

#   --------    2x4T three phases   --------------------------------

CELLS +=        AOA211 OAO211

AOA211:         DESCR = "2-1-1-input AND-OR-AND gate"
AOA211:         AO21
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED3)

OAO211:         DESCR = "2-1-1-input OR-AND-OR gate"
OAO211:         OA21
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED3)

#   --------    2x5T two phases     --------------------------------

CELLS +=        AO32 OA32 \
                AAO32 OOA32 \
                AAO221 OOA221

AO32:           DESCR = "3-2-input AND-OR gate"
AO32:           AO31
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED3)

OA32:           DESCR = "3-2-input OR-AND gate"
OA32:           OA31
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED3)

AAO32:          DESCR = "3-2-input AND-AND-OR gate"
AAO32:          AO31
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED3)

OOA32:          DESCR = "3-2-input OR-OR-AND gate"
OOA32:          OA31
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED3)

AAO221:         DESCR = "2-2-1-input AND-AND-OR gate"
AAO221:         AAO22
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED3)

OOA221:         DESCR = "2-2-1-input OR-OR-AND gate"
OOA221:         OOA22
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED3)

#   --------    2x5T three phases   --------------------------------

CELLS +=        AOA221 OAO221 \
                AOOA212 OAAO212 \
                AAOA221 OOAO221

AOA221:         DESCR = "2-2-1-input AND-OR-AND gate"
AOA221:         AO22
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED3)

OAO221:         DESCR = "2-2-1-input OR-AND-OR gate"
OAO221:         OA22
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED3)

AOOA212:        DESCR = "2-1-2-input AND-OR-OR-AND gate"
AOOA212:        AOA211
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED3)

OAAO212:        DESCR = "2-1-2-input OR-AND-AND-OR gate"
OAAO212:        OAO211
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED3)

AAOA221:        DESCR = "2-2-1-input AND-AND-OR-AND gate"
AAOA221:        AAO22
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED3)

OOAO221:        DESCR = "2-2-1-input OR-OR-AND-OR gate"
OOAO221:        OOA22
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED3)

#   --------    2x5T four phases    --------------------------------

CELLS +=        AOAO2111 OAOA2111

AOAO2111:       DESCR = "2-1-1-1-input AND-OR-AND-OR gate"
AOAO2111:       AOA211
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED3)

OAOA2111:       DESCR = "2-1-1-1-input OR-AND-OR-AND gate"
OAOA2111:       OAO211
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED3)

#   --------    2x6T two phases     --------------------------------

CELLS +=        AAAO222 OOOA222 \
                AAO321 OOA321 \
                AAO33 OOA33

AAAO222:        DESCR = "2-2-2-input AND-AND-AND-OR gate"
AAAO222:        AAO221
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED3)

OOOA222:        DESCR = "2-2-2-input OR-OR-OR-AND gate"
OOOA222:        OOA221
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED3)

AAO321:         DESCR = "3-2-1-input AND-AND-OR gate"
AAO321:         AAO32
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED3)

OOA321:         DESCR = "3-2-1-input OR-OR-AND gate"
OOA321:         OOA32
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED3)

AAO33:          DESCR = "3-3-input AND-AND-OR gate"
AAO33:          AAO32
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED3)

OOA33:          DESCR = "3-3-input OR-OR-AND gate"
OOA33:          OOA32
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED3)

#   --------    2x6T three phases   --------------------------------

CELLS +=        AOOA213 OAAO213 \
                AOOA222 OAAO222 \
                AAOA2211 OOAO2211 \
                AAOOA222 OOAAO222

AOOA213:        DESCR = "2-1-3-input AND-OR-OR-AND gate"
AOOA213:        AOOA212
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED3)

OAAO213:        DESCR = "2-1-3-input OR-AND-AND-OR gate"
OAAO213:        OAAO212
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED3)

AOOA222:        DESCR = "2-2-2-input AND-OR-OR-AND gate"
AOOA222:        AOA221
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED3)

OAAO222:        DESCR = "2-2-2-input OR-AND-AND-OR gate"
OAAO222:        OAOI221
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED3)

AAOA2211:       DESCR = "2-2-1-1-input AND-AND-OR-AND gate"
AAOA2211:       AAO221
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED3)

OOAO2211:       DESCR = "2-2-1-1-input OR-OR-AND-OR gate"
OOAO2211:       OOA221
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED3)

AAOOA222:       DESCR = "2-2-2-input AND-AND-OR-OR-AND gate"
AAOOA222:       AAOA221
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED3)

OOAAO222:       DESCR = "2-2-2-input OR-OR-AND-AND-OR gate"
OOAAO222:       OOAO221
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED3)

#   --------    2x6T four phases    --------------------------------

CELLS +=        AOOAO2121 OAAOA2121 \
                AOAAO2112 OAOOA2112 \
                AAOAO2211 OOAOA2211

AOOAO2121:      DESCR = "2-1-2-1-input AND-OR-OR-AND-OR gate"
AOOAO2121:      AOOA212
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED3)

OAAOA2121:      DESCR = "2-1-2-1-input OR-AND-AND-OR-AND gate"
OAAOA2121:      OAAO212
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED3)

AOAAO2112:      DESCR = "2-1-1-2-input AND-OR-AND-AND-OR gate"
AOAAO2112:      AOAO2111
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED3)

OAOOA2112:      DESCR = "2-1-1-2-input OR-AND-OR-OR-AND gate"
OAOOA2112:      OAOA2111
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED3)

AAOAO2211:      DESCR = "2-2-1-1-input AND-AND-OR-AND-OR gate"
AAOAO2211:      AAOA221
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED3)

OOAOA2211:      DESCR = "2-2-1-1-input OR-OR-AND-OR-AND gate"
OOAOA2211:      OOAO221
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED3)

#   --------    2x7T two phases     --------------------------------

CELLS +=        AAO331 OOA331 \
                AAAO322 OOOA322

AAO331:         DESCR = "3-3-1-input AND-AND-OR gate"
AAO331:         AAO33
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED3)

OOA331:         DESCR = "3-3-1-input OR-OR-AND gate"
OOA331:         OOA33
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED3)

AAAO322:        DESCR = "3-2-2-input AND-AND-AND-OR gate"
AAAO322:        AAO321
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED3)

OOOA322:        DESCR = "3-2-2-input OR-OR-OR-AND gate"
OOOA322:        OOA321
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED3)

#   --------    2x7T three phases   --------------------------------

CELLS +=        AOOA223 OAAO223 \
                AAOOA223 OOAAO223 \
                AAOOA2212 OOAAO2212 \
                AAAOA2221 OOOAO2221

AOOA223:        DESCR = "2-2-3-input AND-OR-OR-AND gate"
AOOA223:        AOOA222
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED3)

OAAO223:        DESCR = "2-2-3-input OR-AND-AND-OR gate"
OAAO223:        OAAO222
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED3)

AAOOA223:       DESCR = "2-2-3-input AND-AND-OR-OR-AND gate"
AAOOA223:       AAOOA222
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED3)

OOAAO223:       DESCR = "2-2-3-input OR-OR-AND-AND-OR gate"
OOAAO223:       OOAAO222
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED3)

AAOOA2212:      DESCR = "2-2-1-2-input AND-AND-OR-OR-AND gate"
AAOOA2212:      AAOA2211
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED3)

OOAAO2212:      DESCR = "2-2-1-2-input OR-OR-AND-AND-OR gate"
OOAAO2212:      OOAO2211
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED3)

AAAOA2221:      DESCR = "2-2-2-1-input AND-AND-AND-OR-AND gate"
AAAOA2221:      AAAO222
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED3)

OOOAO2221:      DESCR = "2-2-2-1-input OR-OR-OR-AND-OR gate"
OOOAO2221:      OOOA222
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED3)

#   --------    2x7T four phases    --------------------------------

CELLS +=        AOAAO2113 OAOOA2113 \
                AOOAAO2122 OAAOOA2122 \
                AAOAAO2212 OOAOOA2212 \
                AAOOAO2221 OOAAOA2221

AOAAO2113:      DESCR = "2-1-1-3-input AND-OR-AND-AND-OR gate"
AOAAO2113:      AOAAO2112
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED3)

OAOOA2113:      DESCR = "2-1-1-3-input OR-AND-OR-OR-AND gate"
OAOOA2113:      OAOOA2112
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED3)

AOOAAO2122:     DESCR = "2-1-2-2-input AND-OR-OR-AND-AND-OR gate"
AOOAAO2122:     AOOAO2121
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED3)

OAAOOA2122:     DESCR = "2-1-2-2-input OR-AND-AND-OR-AND-AND gate"
OAAOOA2122:     OAAOA2121
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED3)

AAOAAO2212:     DESCR = "2-2-1-2-input AND-AND-OR-AND-AND-OR gate"
AAOAAO2212:     AAOAO2211
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED3)

OOAOOA2212:     DESCR = "2-2-1-2-input OR-OR-AND-OR-OR-AND gate"
OOAOOA2212:     OOAOA2211
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED3)

AAOOAO2221:     DESCR = "2-2-2-1-input AND-AND-OR-OR-AND-OR gate"
AAOOAO2221:     AAOOA222
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED3)

OOAAOA2221:     DESCR = "2-2-2-1-input OR-OR-AND-AND-OR-AND gate"
OOAAOA2221:     OOAAO222
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED3)

#   --------    2x8T two phases     --------------------------------

CELLS +=        AAAO332 OOOA332 \

AAAO332:        DESCR = "3-3-2-input AND-AND-AND-OR gate"
AAAO332:        AAO331
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED3)

OOOA332:        DESCR = "3-3-2-input OR-OR-OR-AND gate"
OOOA332:        OOA331
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED3)

#   --------    2x8T three phases   --------------------------------

CELLS +=        AAOOA2213 OOAAO2213 \
                AAAOOA2222 OOOAAO2222 \

AAOOA2213:      DESCR = "2-2-1-3-input AND-AND-OR-OR-AND gate"
AAOOA2213:      AAOOA2212
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED3)

OOAAO2213:      DESCR = "2-2-1-3-input OR-OR-AND-AND-OR gate"
OOAAO2213:      OOAAO2212
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED3)

AAAOOA2222:     DESCR = "2-2-2-2-input AND-AND-AND-OR-OR-AND gate"
AAAOOA2222:     AAAOA2221
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED3)

OOOAAO2222:     DESCR = "2-2-2-2-input OR-OR-OR-AND-AND-OR gate"
OOOAAO2222:     OOOAO2221
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED3)

#   --------    2x8T four phases    --------------------------------

CELLS +=        AOOAAO2123 OAAOOA2123 \
                AAOAAO2213 OOAOOA2213 \
                AAOOAAO2222 OOAAOOA2222 \

AOOAAO2123:     DESCR = "2-1-2-3-input AND-OR-OR-AND-AND-OR gate"
AOOAAO2123:     AOOAAOI2122
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED3)

OAAOOA2123:     DESCR = "2-1-2-3-input OR-AND-AND-OR-AND-AND gate"
OAAOOA2123:     OAAOOA2122
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED3)

AAOAAO2213:     DESCR = "2-2-1-3-input AND-AND-OR-AND-AND-OR gate"
AAOAAO2213:     AAOAAO2212
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED3)

OOAOOA2213:     DESCR = "2-2-1-3-input OR-OR-AND-OR-OR-AND gate"
OOAOOA2213:     OOAOOA2212
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED3)

AAOOAAO2222:    DESCR = "2-2-2-2-input AND-AND-OR-OR-AND-AND-OR gate"
AAOOAAO2222:    AAOOAO2221
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED3)

OOAAOOA2222:    DESCR = "2-2-2-2-input OR-OR-AND-AND-OR-OR-AND gate"
OOAAOOA2222:    OOAAOA2221
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED3)

#   --------    2x9T two phases     --------------------------------

CELLS +=        AAAO333 OOOA333

AAAO333:        DESCR = "3-3-3-input AND-AND-AND-OR gate"
AAAO333:        AAAO332
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED3)

OOOA333:        DESCR = "3-3-3-input OR-OR-OR-AND gate"
OOOA333:        OOOA332
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED3)

#   --------    2x9T three phases   --------------------------------

CELLS +=        AAAOOA2223 OOOAAO2223

AAAOOA2223:     DESCR = "2-2-2-3-input AND-AND-AND-OR-OR-AND gate"
AAAOOA2223:     AAAOOA2222
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED3)

OOOAAO2223:     DESCR = "2-2-2-3-input OR-OR-OR-AND-AND-OR gate"
OOOAAO2223:     OOOAAO2222
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED3)

#   --------    2x9T four phases    --------------------------------

CELLS +=        AAOOAAO2223 OOAAOOA2223

AAOOAAO2223:    DESCR = "2-2-2-3-input AND-AND-OR-OR-AND-AND-OR gate"
AAOOAAO2223:    AAOOAAO2222
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED3)

OOAAOOA2223:    DESCR = "2-2-2-3-input OR-OR-AND-AND-OR-OR-AND gate"
OOAAOOA2223:    OOAAOOA2222
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED3)
