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
#include crafted3_cells.mk

#   ----------------------------------------------------------------
#               CELL TARGETS
#   ----------------------------------------------------------------

ifdef BUFFERED

#   --------    already buffered    --------------------------------

CELLS +=        AAAO222 \
                AAAO322 \
                AAAO332 \
                AAAO333 \
                AAAOA2221 \
                AAAOOA2222 \
                AAAOOA2223 \
                AAO221 \
                AAO32 \
                AAO321 \
                AAO33 \
                AAO331 \
                AAOA221 \
                AAOA2211 \
                AAOAAO2212 \
                AAOAAO2213 \
                AAOAO2211 \
                AAOOA222 \
                AAOOA223 \
                AAOOA2212 \
                AAOOA2213 \
                AAOOAAO2222 \
                AAOOAAO2223 \
                AAOOAO2221 \
                AAOOAO2222 \
                AND3 \
                AO22 \
                AO31 \
                AO32 \
                AOA211 \
                AOA221 \
                AOAAO2112 \
                AOAAO2113 \
                AOAO2111 \
                AOOA212 \
                AOOA213 \
                AOOAAO2122 \
                AOOAAO2123 \
                AOOAO2121 \
                OA22 \
                OA31 \
                OA32 \
                OAAO212 \
                OAAO213 \
                OAAO222 \
                OAAO223 \
                OAAOA2121 \
                OAAOOA2122 \
                OAAOOA2123 \
                OAO211 \
                OAO221 \
                OAOA2111 \
                OAOOA2112 \
                OAOOA2113 \
                OOA221 \
                OOA32 \
                OOA321 \
                OOA33 \
                OOA331 \
                OOAAO222 \
                OOAAO223 \
                OOAAO2212 \
                OOAAO2213 \
                OOAAOA2221 \
                OOAAOOA2222 \
                OOAAOOA2223 \
                OOAO221 \
                OOAO2211 \
                OOAO2212 \
                OOAO2213 \
                OOAOA2211 \
                OOAOOA2212 \
                OOAOOA2213 \
                OOOA222 \
                OOOA322 \
                OOOA332 \
                OOOA333 \
                OOOAAO2222 \
                OOOAAO2223 \
                OOOAO2221 \
                OOOAO2222 \
                OOOAO2223 \
                OR3

AAAO222:        DESCR = "2-2-2-input AND-AND-AND-OR gate"
AAAO222:        AAO221
	$(POPCORN) -m nand -c $@ $< > $@
	$(BLUE)

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

AAAOA2221:      DESCR = "2-2-2-1-input AND-AND-AND-OR-AND gate"
AAAOA2221:      AAAO222
	$(POPCORN) -m pu -c $@ $< > $@
	$(BLUE)

AAAOOA2222:     DESCR = "2-2-2-2-input AND-AND-AND-OR-OR-AND gate"
AAAOOA2222:     AAAOA2221
	$(POPCORN) -m nor -c $@ $< > $@
	$(BLUE)

AAAOOA2223:     DESCR = "2-2-2-3-input AND-AND-AND-OR-OR-AND gate"
AAAOOA2223:     AAAOOA2222
	$(POPCORN) -m nor -c $@ $< > $@
	$(BLUE)

AAO221:         DESCR = "2-2-1-input AND-AND-OR gate"
AAO221:         AAO22
	$(POPCORN) -m pd -c $@ $< > $@
	$(BLUE)

AAO32:          DESCR = "3-2-input AND-AND-OR gate"
AAO32:          AO31
	$(POPCORN) -m nand -c $@ $< > $@
	$(BLUE)

AAO321:         DESCR = "3-2-1-input AND-AND-OR gate"
AAO321:         AAO32
	$(POPCORN) -m pd -c $@ $< > $@
	$(BLUE)

AAO33:          DESCR = "3-3-input AND-AND-OR gate"
AAO33:          AAO32
	$(POPCORN) -m nand -c $@ $< > $@
	$(BLUE)

AAO331:         DESCR = "3-3-1-input AND-AND-OR gate"
AAO331:         AAO33
	$(POPCORN) -m pd -c $@ $< > $@
	$(BLUE)

AAOA221:        DESCR = "2-2-1-input AND-AND-OR-AND gate"
AAOA221:        AAO22
	$(POPCORN) -m pu -c $@ $< > $@
	$(BLUE)

AAOA2211:       DESCR = "2-2-1-1-input AND-AND-OR-AND gate"
AAOA2211:       AAO221
	$(POPCORN) -m pu -c $@ $< > $@
	$(BLUE)

AAOAAO2212:     DESCR = "2-2-1-2-input AND-AND-OR-AND-AND-OR gate"
AAOAAO2212:     AAOAO2211
	$(POPCORN) -m nand -c $@ $< > $@
	$(BLUE)

AAOAAO2213:     DESCR = "2-2-1-3-input AND-AND-OR-AND-AND-OR gate"
AAOAAO2213:     AAOAAO2212
	$(POPCORN) -m nand -c $@ $< > $@
	$(BLUE)

AAOAO2211:      DESCR = "2-2-1-1-input AND-AND-OR-AND-OR gate"
AAOAO2211:      AAOA221
	$(POPCORN) -m pd -c $@ $< > $@
	$(BLUE)

AAOOA222:       DESCR = "2-2-2-input AND-AND-OR-OR-AND gate"
AAOOA222:       AAOA221
	$(POPCORN) -m nor -c $@ $< > $@
	$(BLUE)

AAOOA223:       DESCR = "2-2-3-input AND-AND-OR-OR-AND gate"
AAOOA223:       AAOOA222
	$(POPCORN) -m nor -c $@ $< > $@
	$(BLUE)

AAOOA2212:      DESCR = "2-2-1-2-input AND-AND-OR-OR-AND gate"
AAOOA2212:      AAOA2211
	$(POPCORN) -m nor -c $@ $< > $@
	$(BLUE)

AAOOA2213:      DESCR = "2-2-1-3-input AND-AND-OR-OR-AND gate"
AAOOA2213:      AAOOA2212
	$(POPCORN) -m nor -c $@ $< > $@
	$(BLUE)

AAOOAAO2222:    DESCR = "2-2-2-2-input AND-AND-OR-OR-AND-AND-OR gate"
AAOOAAO2222:    AAOOAO2221
	$(POPCORN) -m nand -c $@ $< > $@
	$(BLUE)

AAOOAAO2223:    DESCR = "2-2-2-3-input AND-AND-OR-OR-AND-AND-OR gate"
AAOOAAO2223:    AAOOAAO2222
	$(POPCORN) -m nand -c $@ $< > $@
	$(BLUE)

AAOOAO2221:     DESCR = "2-2-2-1-input AND-AND-OR-OR-AND-OR gate"
AAOOAO2221:     AAOOA222
	$(POPCORN) -m pd -c $@ $< > $@
	$(BLUE)

AAOOAO2222:     DESCR = "2-2-2-2-input AND-AND-OR-OR-AND-OR gate"
AAOOAO2222:     AAOOAO2221
	$(POPCORN) -m nor -c $@ $< > $@
	$(BLUE)

AND3:           DESCR = "3-input AND gate"
AND3:           AND2
	$(POPCORN) -m nand -c $@ $< > $@
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

AOA211:         DESCR = "2-1-1-input AND-OR-AND gate"
AOA211:         AO21
	$(POPCORN) -m pu -c $@ $< > $@
	$(BLUE)

AOA221:         DESCR = "2-2-1-input AND-OR-AND gate"
AOA221:         AO22
	$(POPCORN) -m pu -c $@ $< > $@
	$(BLUE)

AOAAO2112:      DESCR = "2-1-1-2-input AND-OR-AND-AND-OR gate"
AOAAO2112:      AOAO2111
	$(POPCORN) -m nand -c $@ $< > $@
	$(BLUE)

AOAAO2113:      DESCR = "2-1-1-3-input AND-OR-AND-AND-OR gate"
AOAAO2113:      AOAAO2112
	$(POPCORN) -m nand -c $@ $< > $@
	$(BLUE)

AOAO2111:       DESCR = "2-1-1-1-input AND-OR-AND-OR gate"
AOAO2111:       AOA211
	$(POPCORN) -m pd -c $@ $< > $@
	$(BLUE)

AOOA212:        DESCR = "2-1-2-input AND-OR-OR-AND gate"
AOOA212:        AOA211
	$(POPCORN) -m nor -c $@ $< > $@
	$(BLUE)

AOOA213:        DESCR = "2-1-3-input AND-OR-OR-AND gate"
AOOA213:        AOOA212
	$(POPCORN) -m nor -c $@ $< > $@
	$(BLUE)

AOOAAO2122:     DESCR = "2-1-2-2-input AND-OR-OR-AND-AND-OR gate"
AOOAAO2122:     AOOAO2121
	$(POPCORN) -m nand -c $@ $< > $@
	$(BLUE)

AOOAAO2123:     DESCR = "2-1-2-3-input AND-OR-OR-AND-AND-OR gate"
AOOAAO2123:     AOOAOI2121
	$(POPCORN) -m nand -c $@ $< > $@
	$(BLUE)

AOOAO2121:      DESCR = "2-1-2-1-input AND-OR-OR-AND-OR gate"
AOOAO2121:      AOOA212
	$(POPCORN) -m pd -c $@ $< > $@
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

OAAO212:        DESCR = "2-1-2-input OR-AND-AND-OR gate"
OAAO212:        OAO211
	$(POPCORN) -m nand -c $@ $< > $@
	$(BLUE)

OAAO213:        DESCR = "2-1-3-input OR-AND-AND-OR gate"
OAAO213:        OAAO212
	$(POPCORN) -m nand -c $@ $< > $@
	$(BLUE)

OAAO222:        DESCR = "2-2-2-input OR-AND-AND-OR gate"
OAAO222:        OAOI221
	$(POPCORN) -m nand -c $@ $< > $@
	$(BLUE)

OAAO223:        DESCR = "2-2-3-input OR-AND-AND-OR gate"
OAAO223:        OAAO222
	$(POPCORN) -m nand -c $@ $< > $@
	$(BLUE)

OAAOA2121:      DESCR = "2-1-2-1-input OR-AND-AND-OR-AND gate"
OAAOA2121:      OAAO212
	$(POPCORN) -m pu -c $@ $< > $@
	$(BLUE)

OAAOOA2122:     DESCR = "2-1-2-2-input OR-AND-AND-OR-AND-AND gate"
OAAOOA2122:     OAAOA2121
	$(POPCORN) -m nor -c $@ $< > $@
	$(BLUE)

OAAOOA2123:     DESCR = "2-1-2-3-input OR-AND-AND-OR-AND-AND gate"
OAAOOA2123:     OAAOOA2122
	$(POPCORN) -m nor -c $@ $< > $@
	$(BLUE)

OAO211:         DESCR = "2-1-1-input OR-AND-OR gate"
OAO211:         OA21
	$(POPCORN) -m pd -c $@ $< > $@
	$(BLUE)

OAO221:         DESCR = "2-2-1-input OR-AND-OR gate"
OAO221:         OA22
	$(POPCORN) -m pd -c $@ $< > $@
	$(BLUE)

OAOA2111:       DESCR = "2-1-1-1-input OR-AND-OR-AND gate"
OAOA2111:       OAO211
	$(POPCORN) -m pu -c $@ $< > $@
	$(BLUE)

OAOOA2112:      DESCR = "2-1-1-2-input OR-AND-OR-OR-AND gate"
OAOOA2112:      OAOA2111
	$(POPCORN) -m nor -c $@ $< > $@
	$(BLUE)

OAOOA2113:      DESCR = "2-1-1-3-input OR-AND-OR-OR-AND gate"
OAOOA2113:      OAOOA2112
	$(POPCORN) -m nor -c $@ $< > $@
	$(BLUE)

OOA221:         DESCR = "2-2-1-input OR-OR-AND gate"
OOA221:         OOA22
	$(POPCORN) -m pu -c $@ $< > $@
	$(BLUE)

OOA32:          DESCR = "3-2-input OR-OR-AND gate"
OOA32:          OA31
	$(POPCORN) -m nor -c $@ $< > $@
	$(BLUE)

OOA321:         DESCR = "3-2-1-input OR-OR-AND gate"
OOA321:         OOA32
	$(POPCORN) -m pu -c $@ $< > $@
	$(BLUE)

OOA33:          DESCR = "3-3-input OR-OR-AND gate"
OOA33:          OOA32
	$(POPCORN) -m nor -c $@ $< > $@
	$(BLUE)

OOA331:         DESCR = "3-3-1-input OR-OR-AND gate"
OOA331:         OOA33
	$(POPCORN) -m pu -c $@ $< > $@
	$(BLUE)

OOAAO222:       DESCR = "2-2-2-input OR-OR-AND-AND-OR gate"
OOAAO222:       OOAO221
	$(POPCORN) -m nand -c $@ $< > $@
	$(BLUE)

OOAAO223:       DESCR = "2-2-3-input OR-OR-AND-AND-OR gate"
OOAAO223:       OOAAO222
	$(POPCORN) -m nand -c $@ $< > $@
	$(BLUE)

OOAAO2212:      DESCR = "2-2-1-2-input OR-OR-AND-AND-OR gate"
OOAAO2212:      OOAO2211
	$(POPCORN) -m nand -c $@ $< > $@
	$(BLUE)

OOAAO2213:      DESCR = "2-2-1-3-input OR-OR-AND-AND-OR gate"
OOAAO2213:      OOAAO2212
	$(POPCORN) -m nand -c $@ $< > $@
	$(BLUE)

OOAAOA2221:     DESCR = "2-2-2-1-input OR-OR-AND-AND-OR-AND gate"
OOAAOA2221:     OOAAO222
	$(POPCORN) -m pu -c $@ $< > $@
	$(BLUE)

OOAAOOA2222:    DESCR = "2-2-2-2-input OR-OR-AND-AND-OR-OR-AND gate"
OOAAOOA2222:    OOAAOA2221
	$(POPCORN) -m nor -c $@ $< > $@
	$(BLUE)

OOAAOOA2223:    DESCR = "2-2-2-3-input OR-OR-AND-AND-OR-OR-AND gate"
OOAAOOA2223:    OOAAOOA2222
	$(POPCORN) -m nor -c $@ $< > $@
	$(BLUE)

OAAO223:        DESCR = "2-2-3-input OR-AND-AND-OR gate"
OAAO223:        OAAO222
	$(POPCORN) -m nand -c $@ $< > $@
	$(BLUE)

OOAO221:        DESCR = "2-2-1-input OR-OR-AND-OR gate"
OOAO221:        OOA22
	$(POPCORN) -m pd -c $@ $< > $@
	$(BLUE)

OOAO2211:       DESCR = "2-2-1-1-input OR-OR-AND-OR gate"
OOAO2211:       OOA221
	$(POPCORN) -m pd -c $@ $< > $@
	$(BLUE)

OOAO2212:       DESCR = "2-2-1-2-input OR-OR-AND-OR gate"
OOAO2212:       OOAO2211
	$(POPCORN) -m nand -c $@ $< > $@
	$(BLUE)

OOAO2213:       DESCR = "2-2-1-3-input OR-OR-AND-OR gate"
OOAO2213:       OOAO2212
	$(POPCORN) -m nand -c $@ $< > $@
	$(BLUE)

OOAOA2211:      DESCR = "2-2-1-1-input OR-OR-AND-OR-AND gate"
OOAOA2211:      OOAO221
	$(POPCORN) -m pu -c $@ $< > $@
	$(BLUE)

OOAOOA2212:     DESCR = "2-2-1-2-input OR-OR-AND-OR-OR-AND gate"
OOAOOA2212:     OOAOA2211
	$(POPCORN) -m nor -c $@ $< > $@
	$(BLUE)

OOAOOA2213:     DESCR = "2-2-1-3-input OR-OR-AND-OR-OR-AND gate"
OOAOOA2213:     OOAOOA2212
	$(POPCORN) -m nor -c $@ $< > $@
	$(BLUE)

OOOA222:        DESCR = "2-2-2-input OR-OR-OR-AND gate"
OOOA222:        OOA221
	$(POPCORN) -m nor -c $@ $< > $@
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

OOOAAO2222:     DESCR = "2-2-2-2-input OR-OR-OR-AND-AND-OR gate"
OOOAAO2222:     OOOAO2221
	$(POPCORN) -m nand -c $@ $< > $@
	$(BLUE)

OOOAAO2223:     DESCR = "2-2-2-3-input OR-OR-OR-AND-AND-OR gate"
OOOAAO2223:     OOOAAO2222
	$(POPCORN) -m nand -c $@ $< > $@
	$(BLUE)

OOOAO2221:      DESCR = "2-2-2-1-input OR-OR-OR-AND-OR gate"
OOOAO2221:      OOOA222
	$(POPCORN) -m pd -c $@ $< > $@
	$(BLUE)

OOOAO2222:      DESCR = "2-2-2-2-input OR-OR-OR-AND-OR gate"
OOOAO2222:      OOOAO2221
	$(POPCORN) -m nand -c $@ $< > $@
	$(BLUE)

OOOAO2223:      DESCR = "2-2-2-3-input OR-OR-OR-AND-OR gate"
OOOAO2223:      OOOAO2222
	$(POPCORN) -m nand -c $@ $< > $@
	$(BLUE)

OR3:            DESCR = "3-input OR gate"
OR3:            OR2
	$(POPCORN) -m nor -c $@ $< > $@
	$(BLUE)

else
ifeq ($(BUFFER),3)

#   --------    now buffered    ------------------------------------

CELLS +=        AAAO222 \
                AAAO322 \
                AAAO332 \
                AAAO333 \
                AAAOA2221 \
                AAAOOA2222 \
                AAAOOA2223 \
                AAO221 \
                AAO32 \
                AAO321 \
                AAO33 \
                AAO331 \
                AAOA221 \
                AAOA2211 \
                AAOAAO2212 \
                AAOAAO2213 \
                AAOAO2211 \
                AAOOA222 \
                AAOOA223 \
                AAOOA2212 \
                AAOOA2213 \
                AAOOAAO2222 \
                AAOOAAO2223 \
                AAOOAO2221 \
                AAOOAO2222 \
                AND3 \
                AO22 \
                AO31 \
                AO32 \
                AOA211 \
                AOA221 \
                AOAAO2112 \
                AOAAO2113 \
                AOAO2111 \
                AOOA212 \
                AOOA213 \
                AOOAAO2122 \
                AOOAAO2123 \
                AOOAO2121 \
                OA22 \
                OA31 \
                OA32 \
                OAAO212 \
                OAAO213 \
                OAAO222 \
                OAAO223 \
                OAAOA2121 \
                OAAOOA2122 \
                OAAOOA2123 \
                OAO211 \
                OAO221 \
                OAOA2111 \
                OAOOA2112 \
                OAOOA2113 \
                OOA221 \
                OOA32 \
                OOA321 \
                OOA33 \
                OOA331 \
                OOAAO222 \
                OOAAO223 \
                OOAAO2212 \
                OOAAO2213 \
                OOAAOA2221 \
                OOAAOOA2222 \
                OOAAOOA2223 \
                OOAO221 \
                OOAO2211 \
                OOAO2212 \
                OOAO2213 \
                OOAOA2211 \
                OOAOOA2212 \
                OOAOOA2213 \
                OOOA222 \
                OOOA322 \
                OOOA332 \
                OOOA333 \
                OOOAAO2222 \
                OOOAAO2223 \
                OOOAO2221 \
                OOOAO2222 \
                OOOAO2223 \
                OR3

AAAO222:        DESCR = "2-2-2-input AND-AND-AND-OR gate"
AAAO222:        AAO221
	$(POPCORN) -m nand -c $@ $< > $@
	$(BLUE)

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

AAAOA2221:      DESCR = "2-2-2-1-input AND-AND-AND-OR-AND gate"
AAAOA2221:      AAAO222
	$(POPCORN) -m pu -c $@ $< > $@
	$(BLUE)

AAAOOA2222:     DESCR = "2-2-2-2-input AND-AND-AND-OR-OR-AND gate"
AAAOOA2222:     AAAOA2221
	$(POPCORN) -m nor -c $@ $< > $@
	$(BLUE)

AAAOOA2223:     DESCR = "2-2-2-3-input AND-AND-AND-OR-OR-AND gate"
AAAOOA2223:     AAAOOA2222
	$(POPCORN) -m nor -c $@ $< > $@
	$(BLUE)

AAO221:         DESCR = "2-2-1-input AND-AND-OR gate"
AAO221:         AAOI22
	$(POPCORN) -m pd -c $@ $< > $@
	$(BLUE)

AAO32:          DESCR = "3-2-input AND-AND-OR gate"
AAO32:          AO31
	$(POPCORN) -m nand -c $@ $< > $@
	$(BLUE)

AAO321:         DESCR = "3-2-1-input AND-AND-OR gate"
AAO321:         AAO32
	$(POPCORN) -m pd -c $@ $< > $@
	$(BLUE)

AAO33:          DESCR = "3-3-input AND-AND-OR gate"
AAO33:          AAO32
	$(POPCORN) -m nand -c $@ $< > $@
	$(BLUE)

AAO331:         DESCR = "3-3-1-input AND-AND-OR gate"
AAO331:         AAO33
	$(POPCORN) -m pd -c $@ $< > $@
	$(BLUE)

AAOA221:        DESCR = "2-2-1-input AND-AND-OR-AND gate"
AAOA221:        AAOI22
	$(POPCORN) -m pu -c $@ $< > $@
	$(BLUE)

AAOA2211:       DESCR = "2-2-1-1-input AND-AND-OR-AND gate"
AAOA2211:       AAO221
	$(POPCORN) -m pu -c $@ $< > $@
	$(BLUE)

AAOAAO2212:     DESCR = "2-2-1-2-input AND-AND-OR-AND-AND-OR gate"
AAOAAO2212:     AAOAO2211
	$(POPCORN) -m nand -c $@ $< > $@
	$(BLUE)

AAOAAO2213:     DESCR = "2-2-1-3-input AND-AND-OR-AND-AND-OR gate"
AAOAAO2213:     AAOAAO2212
	$(POPCORN) -m nand -c $@ $< > $@
	$(BLUE)

AAOAO2211:      DESCR = "2-2-1-1-input AND-AND-OR-AND-OR gate"
AAOAO2211:      AAOA221
	$(POPCORN) -m pd -c $@ $< > $@
	$(BLUE)

AAOOA222:       DESCR = "2-2-2-input AND-AND-OR-OR-AND gate"
AAOOA222:       AAOA221
	$(POPCORN) -m nor -c $@ $< > $@
	$(BLUE)

AAOOA223:       DESCR = "2-2-3-input AND-AND-OR-OR-AND gate"
AAOOA223:       AAOOA222
	$(POPCORN) -m nor -c $@ $< > $@
	$(BLUE)

AAOOA2212:      DESCR = "2-2-1-2-input AND-AND-OR-OR-AND gate"
AAOOA2212:      AAOA2211
	$(POPCORN) -m nor -c $@ $< > $@
	$(BLUE)

AAOOA2213:      DESCR = "2-2-1-3-input AND-AND-OR-OR-AND gate"
AAOOA2213:      AAOOA2212
	$(POPCORN) -m nor -c $@ $< > $@
	$(BLUE)

AAOOAAO2222:    DESCR = "2-2-2-2-input AND-AND-OR-OR-AND-AND-OR gate"
AAOOAAO2222:    AAOOAO2221
	$(POPCORN) -m nand -c $@ $< > $@
	$(BLUE)

AAOOAAO2223:    DESCR = "2-2-2-3-input AND-AND-OR-OR-AND-AND-OR gate"
AAOOAAO2223:    AAOOAAO2222
	$(POPCORN) -m nand -c $@ $< > $@
	$(BLUE)

AAOOAO2221:     DESCR = "2-2-2-1-input AND-AND-OR-OR-AND-OR gate"
AAOOAO2221:     AAOOA222
	$(POPCORN) -m pd -c $@ $< > $@
	$(BLUE)

AAOOAO2222:     DESCR = "2-2-2-2-input AND-AND-OR-OR-AND-OR gate"
AAOOAO2222:     AAOOAO2221
	$(POPCORN) -m nor -c $@ $< > $@
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

OAO211:         DESCR = "2-1-1-input OR-AND-OR gate"
OAO211:         OAI21
	$(POPCORN) -m pd -c $@ $< > $@
	$(BLUE)

OAO221:         DESCR = "2-2-1-input OR-AND-OR gate"
OAO221:         OA22
	$(POPCORN) -m pd -c $@ $< > $@
	$(BLUE)

OAOA2111:       DESCR = "2-1-1-1-input OR-AND-OR-AND gate"
OAOA2111:       OAO211
	$(POPCORN) -m pu -c $@ $< > $@
	$(BLUE)

OAOOA2112:      DESCR = "2-1-1-2-input OR-AND-OR-OR-AND gate"
OAOOA2112:      OAOA2111
	$(POPCORN) -m nor -c $@ $< > $@
	$(BLUE)

OAOOA2113:      DESCR = "2-1-1-3-input OR-AND-OR-OR-AND gate"
OAOOA2113:      OAOOA2112
	$(POPCORN) -m nor -c $@ $< > $@
	$(BLUE)

AOA211:         DESCR = "2-1-1-input AND-OR-AND gate"
AOA211:         AOI21
	$(POPCORN) -m pu -c $@ $< > $@
	$(BLUE)

AOA221:         DESCR = "2-2-1-input AND-OR-AND gate"
AOA221:         AO22
	$(POPCORN) -m pu -c $@ $< > $@
	$(BLUE)

AOAAO2112:      DESCR = "2-1-1-2-input AND-OR-AND-AND-OR gate"
AOAAO2112:      AOAO2111
	$(POPCORN) -m nand -c $@ $< > $@
	$(BLUE)

AOAAO2113:      DESCR = "2-1-1-3-input AND-OR-AND-AND-OR gate"
AOAAO2113:      AOAAO2112
	$(POPCORN) -m nand -c $@ $< > $@
	$(BLUE)

AOAO2111:       DESCR = "2-1-1-1-input AND-OR-AND-OR gate"
AOAO2111:       AOA211
	$(POPCORN) -m pd -c $@ $< > $@
	$(BLUE)

AOOA212:        DESCR = "2-1-2-input AND-OR-OR-AND gate"
AOOA212:        AOA211
	$(POPCORN) -m nor -c $@ $< > $@
	$(BLUE)

AOOA213:        DESCR = "2-1-3-input AND-OR-OR-AND gate"
AOOA213:        AOA212
	$(POPCORN) -m nor -c $@ $< > $@
	$(BLUE)

AOOAAO2122:     DESCR = "2-1-2-2-input AND-OR-OR-AND-AND-OR gate"
AOOAAO2122:     AOOAO2121
	$(POPCORN) -m nand -c $@ $< > $@
	$(BLUE)

AOOAAO2123:     DESCR = "2-1-2-3-input AND-OR-OR-AND-AND-OR gate"
AOOAAO2123:     AOOAO2121
	$(POPCORN) -m nand -c $@ $< > $@
	$(BLUE)

AOOAO2121:      DESCR = "2-1-2-1-input AND-OR-OR-AND-OR gate"
AOOAO2121:      AOOA212
	$(POPCORN) -m pd -c $@ $< > $@
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

OAAO212:        DESCR = "2-1-2-input OR-AND-AND-OR gate"
OAAO212:        OAO211
	$(POPCORN) -m nand -c $@ $< > $@
	$(BLUE)

OAAO213:        DESCR = "2-1-3-input OR-AND-AND-OR gate"
OAAO213:        OAAO212
	$(POPCORN) -m nand -c $@ $< > $@
	$(BLUE)

OAAO222:        DESCR = "2-2-2-input OR-AND-AND-OR gate"
OAAO222:        OAOI221
	$(POPCORN) -m nand -c $@ $< > $@
	$(BLUE)

OAAOA2121:      DESCR = "2-1-2-1-input OR-AND-AND-OR-AND gate"
OAAOA2121:      OAAO212
	$(POPCORN) -m pu -c $@ $< > $@
	$(BLUE)

OAAOOA2122:     DESCR = "2-1-2-2-input OR-AND-AND-OR-AND-AND gate"
OAAOOA2122:     OAAOA2121
	$(POPCORN) -m nor -c $@ $< > $@
	$(BLUE)

OAAOOA2123:     DESCR = "2-1-2-3-input OR-AND-AND-OR-AND-AND gate"
OAAOOA2123:     OAAOOA2122
	$(POPCORN) -m nor -c $@ $< > $@
	$(BLUE)

OOA221:         DESCR = "2-2-1-input OR-OR-AND gate"
OOA221:         OOAI22
	$(POPCORN) -m pu -c $@ $< > $@
	$(BLUE)

OOA32:          DESCR = "3-2-input OR-OR-AND gate"
OOA32:          OA31
	$(POPCORN) -m nor -c $@ $< > $@
	$(BLUE)

OOA321:         DESCR = "3-2-1-input OR-OR-AND gate"
OOA321:         OOA32
	$(POPCORN) -m pu -c $@ $< > $@
	$(BLUE)

OOA33:          DESCR = "3-3-input OR-OR-AND gate"
OOA33:          OOA32
	$(POPCORN) -m nor -c $@ $< > $@
	$(BLUE)

OOA331:         DESCR = "3-3-1-input OR-OR-AND gate"
OOA331:         OOA33
	$(POPCORN) -m pu -c $@ $< > $@
	$(BLUE)

OOAAO222:       DESCR = "2-2-2-input OR-OR-AND-AND-OR gate"
OOAAO222:       OOAO221
	$(POPCORN) -m nand -c $@ $< > $@
	$(BLUE)

OOAAO223:       DESCR = "2-2-3-input OR-OR-AND-AND-OR gate"
OOAAO223:       OOAAO222
	$(POPCORN) -m nand -c $@ $< > $@
	$(BLUE)

OOAAO2212:      DESCR = "2-2-1-2-input OR-OR-AND-AND-OR gate"
OOAAO2212:      OOAO2211
	$(POPCORN) -m nand -c $@ $< > $@
	$(BLUE)

OOAAO2213:      DESCR = "2-2-1-3-input OR-OR-AND-AND-OR gate"
OOAAO2213:      OOAAO2212
	$(POPCORN) -m nand -c $@ $< > $@
	$(BLUE)

OOAAOA2221:     DESCR = "2-2-2-1-input OR-OR-AND-AND-OR-AND gate"
OOAAOA2221:     OOAAO222
	$(POPCORN) -m pu -c $@ $< > $@
	$(BLUE)

OOAAOOA2222:    DESCR = "2-2-2-2-input OR-OR-AND-AND-OR-OR-AND gate"
OOAAOOA2222:    OOAAOA2221
	$(POPCORN) -m nor -c $@ $< > $@
	$(BLUE)

OOAAOOA2223:    DESCR = "2-2-2-3-input OR-OR-AND-AND-OR-OR-AND gate"
OOAAOOA2223:    OOAAOOA2222
	$(POPCORN) -m nor -c $@ $< > $@
	$(BLUE)

OOAO221:        DESCR = "2-2-1-input OR-OR-AND-OR gate"
OOAO221:        OOAI22
	$(POPCORN) -m pd -c $@ $< > $@
	$(BLUE)

OOAO2211:       DESCR = "2-2-1-1-input OR-OR-AND-OR gate"
OOAO2211:       OOA221
	$(POPCORN) -m pd -c $@ $< > $@
	$(BLUE)

OOAO2212:       DESCR = "2-2-1-2-input OR-OR-AND-OR gate"
OOAO2212:       OOAO2211
	$(POPCORN) -m nand -c $@ $< > $@
	$(BLUE)

OOAO2213:       DESCR = "2-2-1-3-input OR-OR-AND-OR gate"
OOAO2213:       OOAO2212
	$(POPCORN) -m nand -c $@ $< > $@
	$(BLUE)

OOAOA2211:      DESCR = "2-2-1-1-input OR-OR-AND-OR-AND gate"
OOAOA2211:      OOAO221
	$(POPCORN) -m pu -c $@ $< > $@
	$(BLUE)

OOAOOA2212:     DESCR = "2-2-1-2-input OR-OR-AND-OR-OR-AND gate"
OOAOOA2212:     OOAOA2211
	$(POPCORN) -m nor -c $@ $< > $@
	$(BLUE)

OOAOOA2213:     DESCR = "2-2-1-3-input OR-OR-AND-OR-OR-AND gate"
OOAOOA2213:     OOAOOA2212
	$(POPCORN) -m nor -c $@ $< > $@
	$(BLUE)

OOOA222:        DESCR = "2-2-2-input OR-OR-OR-AND gate"
OOOA222:        OOA221
	$(POPCORN) -m nor -c $@ $< > $@
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

OOOAAO2222:     DESCR = "2-2-2-2-input OR-OR-OR-AND-AND-OR gate"
OOOAAO2222:     OOOAO2221
	$(POPCORN) -m nand -c $@ $< > $@
	$(BLUE)

OOOAAO2223:     DESCR = "2-2-2-3-input OR-OR-OR-AND-AND-OR gate"
OOOAAO2223:     OOOAAO2222
	$(POPCORN) -m nand -c $@ $< > $@
	$(BLUE)

OOOAO2221:      DESCR = "2-2-2-1-input OR-OR-OR-AND-OR gate"
OOOAO2221:      OOOA222
	$(POPCORN) -m pd -c $@ $< > $@
	$(BLUE)

OOOAO2222:      DESCR = "2-2-2-2-input OR-OR-OR-AND-OR gate"
OOOAO2222:      OOOAO2221
	$(POPCORN) -m nand -c $@ $< > $@
	$(BLUE)

OOOAO2223:      DESCR = "2-2-2-3-input OR-OR-OR-AND-OR gate"
OOOAO2223:      OOOAO2222
	$(POPCORN) -m nand -c $@ $< > $@
	$(BLUE)

OR3:            DESCR = "3-input OR gate"
OR3:            NOR2
	$(POPCORN) -m nor -c $@ $< > $@
	$(BLUE)

BUFFERED = true

else

#   --------    not buffered    ------------------------------------

CELLS +=        AAAOI222 \
                AAAOI322 \
                AAAOI332 \
                AAAOI333 \
                AAAOAI2221 \
                AAAOOAI2222 \
                AAAOOAI2223 \
                AAOI221 \
                AAOI32 \
                AAOI321 \
                AAOI33 \
                AAOI331 \
                AAOAI221 \
                AAOAI2211 \
                AAOAAOI2212 \
                AAOAAOI2213 \
                AAOAOI2211 \
                AAOOAI222 \
                AAOOAI223 \
                AAOOAI2212 \
                AAOOAI2213 \
                AAOOAAOI2222 \
                AAOOAAOI2223 \
                AAOOAOI2221 \
                AAOOAOI2222 \
                AOI22 \
                AOI31 \
                AOI32 \
                AOAI211 \
                AOAI221 \
                AOAAOI2112 \
                AOAAOI2113 \
                AOAOI2111 \
                AOOAI212 \
                AOOAI213 \
                AOOAAOI2122 \
                AOOAAOI2123 \
                AOOAOI2121 \
                NAND3 \
                NOR3 \
                OAI22 \
                OAI31 \
                OAI32 \
                OAAOI212 \
                OAAOI213 \
                OAAOI222 \
                OAAOI223 \
                OAAOAI2121 \
                OAAOOAI2122 \
                OAAOOAI2123 \
                OAOI211 \
                OAOI221 \
                OAOAI2111 \
                OAOOAI2112 \
                OAOOAI2113 \
                OOAI221 \
                OOAI32 \
                OOAI321 \
                OOAI33 \
                OOAI331 \
                OOAAOI222 \
                OOAAOI223 \
                OOAAOI2212 \
                OOAAOAI2221 \
                OOAAOOAI2222 \
                OOAAOOAI2223 \
                OOAOI221 \
                OOAOI2211 \
                OOAOI2212 \
                OOAOI2213 \
                OOAOAI2211 \
                OOAOOAI2212 \
                OOAOOAI2213 \
                OOOAI222 \
                OOOAI322 \
                OOOAI332 \
                OOOAI333 \
                OOOAAOI2222 \
                OOOAAOI2223 \
                OOOAOI2221 \
                OOOAOI2222 \
                OOOAOI2223

AAAOI222:       DESCR = "2-2-2-input AND-AND-AND-OR-Invert gate"
AAAOI222:       AAOI221
	$(POPCORN) -m nand -c $@ $< > $@
	$(BLUE)

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

AAAOAI2221:     DESCR = "2-2-2-1-input AND-AND-OR-AND-Invert gate"
AAAOAI2221:     AAAOI222
	$(POPCORN) -m pu -c $@ $< > $@
	$(BLUE)

AAAOOAI2222:    DESCR = "2-2-2-2-input AND-AND-AND-OR-OR-AND-Invert gate"
AAAOOAI2222:    AAAOAI2221
	$(POPCORN) -m nor -c $@ $< > $@
	$(BLUE)

AAAOOAI2223:    DESCR = "2-2-2-3-input AND-AND-AND-OR-OR-AND-Invert gate"
AAAOOAI2223:    AAAOOAI2222
	$(POPCORN) -m nor -c $@ $< > $@
	$(BLUE)

AAOI221:        DESCR = "2-2-1-input AND-AND-OR-Invert gate"
AAOI221:        AAOI22
	$(POPCORN) -m pd -c $@ $< > $@
	$(BLUE)

AAOI32:         DESCR = "3-2-input AND-AND-OR-Invert gate"
AAOI32:         AOI31
	$(POPCORN) -m nand -c $@ $< > $@
	$(BLUE)

AAOI321:        DESCR = "3-2-1-input AND-AND-OR-Invert gate"
AAOI321:        AAOI32
	$(POPCORN) -m pd -c $@ $< > $@
	$(BLUE)

AAOI33:         DESCR = "3-3-input AND-AND-OR-Invert gate"
AAOI33:         AAOI32
	$(POPCORN) -m nand -c $@ $< > $@
	$(BLUE)

AAOI331:        DESCR = "3-3-1-input AND-AND-OR-Invert gate"
AAOI331:        AAOI33
	$(POPCORN) -m pd -c $@ $< > $@
	$(BLUE)

AAOAI221:       DESCR = "2-2-1-input AND-AND-OR-AND gate"
AAOAI221:       AAOI22
	$(POPCORN) -m pu -c $@ $< > $@
	$(BLUE)

AAOAI2211:      DESCR = "2-2-1-1-input AND-AND-OR-AND-Invert gate"
AAOAI2211:      AAOI221
	$(POPCORN) -m pu -c $@ $< > $@
	$(BLUE)

AAOAAOI2212:    DESCR = "2-2-1-2-input AND-AND-OR-AND-AND-OR-Invert gate"
AAOAAOI2212:    AAOAOI2211
	$(POPCORN) -m nand -c $@ $< > $@
	$(BLUE)

AAOAAOI2213:    DESCR = "2-2-1-3-input AND-AND-OR-AND-AND-OR-Invert gate"
AAOAAOI2213:    AAOAAOI2212
	$(POPCORN) -m nand -c $@ $< > $@
	$(BLUE)

AAOAOI2211:     DESCR = "2-2-1-1-input AND-AND-OR-AND-OR-Invert gate"
AAOAOI2211:     AAOAI221
	$(POPCORN) -m pd -c $@ $< > $@
	$(BLUE)

AAOOAAOI2222:   DESCR = "2-2-2-2-input AND-AND-OR-OR-AND-AND-OR-Invert gate"
AAOOAAOI2222:   AAOOAOI2221
	$(POPCORN) -m nand -c $@ $< > $@
	$(BLUE)

AAOOAAOI2223:   DESCR = "2-2-2-3-input AND-AND-OR-OR-AND-AND-OR-Invert gate"
AAOOAAOI2223:   AAOOAAOI2222
	$(POPCORN) -m nand -c $@ $< > $@
	$(BLUE)

AAOOAI222:      DESCR = "2-2-2-input AND-AND-OR-OR-AND-Invert gate"
AAOOAI222:      AAOAI221
	$(POPCORN) -m nor -c $@ $< > $@
	$(BLUE)

AAOOAI223:      DESCR = "2-2-3-input AND-AND-OR-OR-AND-Invert gate"
AAOOAI223:      AAOOAI222
	$(POPCORN) -m nor -c $@ $< > $@
	$(BLUE)

AAOOAI2212:     DESCR = "2-2-1-2-input AND-AND-OR-OR-AND-Invert gate"
AAOOAI2212:     AAOAI2211
	$(POPCORN) -m nor -c $@ $< > $@
	$(BLUE)

AAOOAI2213:     DESCR = "2-2-1-3-input AND-AND-OR-OR-AND-Invert gate"
AAOOAI2213:     AAOOAI2212
	$(POPCORN) -m nor -c $@ $< > $@
	$(BLUE)

AAOOAOI2221:    DESCR = "2-2-2-1-input AND-AND-OR-OR-AND-OR-Invert gate"
AAOOAOI2221:    AAOOAI222
	$(POPCORN) -m pd -c $@ $< > $@
	$(BLUE)

AAOOAOI2222:    DESCR = "2-2-2-2-input AND-AND-OR-OR-AND-OR-Invert gate"
AAOOAOI2222:    AAOOAOI2221
	$(POPCORN) -m nor -c $@ $< > $@
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

AOAI211:        DESCR = "2-1-1-input AND-OR-AND-Invert gate"
AOAI211:        AOI21
	$(POPCORN) -m pu -c $@ $< > $@
	$(BLUE)

AOAI221:        DESCR = "2-2-1-input AND-OR-AND-Invert gate"
AOAI221:        AOI22
	$(POPCORN) -m pu -c $@ $< > $@
	$(BLUE)

AOAAOI2112:     DESCR = "2-1-1-2-input AND-OR-AND-AND-OR-Invert gate"
AOAAOI2112:     AOAOI2111
	$(POPCORN) -m nand -c $@ $< > $@
	$(BLUE)

AOAAOI2113:     DESCR = "2-1-1-3-input AND-OR-AND-AND-OR-Invert gate"
AOAAOI2113:     AOAAOI2112
	$(POPCORN) -m nand -c $@ $< > $@
	$(BLUE)

AOAOI2111:      DESCR = "2-1-1-1-input AND-OR-AND-OR-Invert gate"
AOAOI2111:      AOAI211
	$(POPCORN) -m pd -c $@ $< > $@
	$(BLUE)

AOOAI212:       DESCR = "2-1-2-input AND-OR-OR-AND-Invert gate"
AOOAI212:       AOAI211
	$(POPCORN) -m nor -c $@ $< > $@
	$(BLUE)

AOOAI213:       DESCR = "2-1-3-input AND-OR-OR-AND-Invert gate"
AOOAI213:       AOOAI212
	$(POPCORN) -m nor -c $@ $< > $@
	$(BLUE)

AOOAAOI2122:    DESCR = "2-1-2-2-input AND-OR-OR-AND-AND-OR-Invert gate"
AOOAAOI2122:    AOOAOI2121
	$(POPCORN) -m nand -c $@ $< > $@
	$(BLUE)

AOOAAOI2123:    DESCR = "2-1-2-3-input AND-OR-OR-AND-AND-OR-Invert gate"
AOOAAOI2123:    AOOAOI2121
	$(POPCORN) -m nand -c $@ $< > $@
	$(BLUE)

AOOAOI2121:     DESCR = "2-1-2-1-input AND-OR-OR-AND-OR-Invert gate"
AOOAOI2121:     AOOAI212
	$(POPCORN) -m pd -c $@ $< > $@
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

OAAOI212:       DESCR = "2-1-2-input OR-AND-AND-OR-Invert gate"
OAAOI212:       OAOI211
	$(POPCORN) -m nand -c $@ $< > $@
	$(BLUE)

OAAOI213:       DESCR = "2-1-3-input OR-AND-AND-OR-Invert gate"
OAAOI213:       OAAOI212
	$(POPCORN) -m nand -c $@ $< > $@
	$(BLUE)

OAAOI222:       DESCR = "2-2-2-input OR-AND-AND-OR-Invert gate"
OAAOI222:       OAOI221
	$(POPCORN) -m nand -c $@ $< > $@
	$(BLUE)

OAAOI223:       DESCR = "2-2-3-input OR-AND-AND-OR-Invert gate"
OAAOI223:       OAAOI222
	$(POPCORN) -m nand -c $@ $< > $@
	$(BLUE)

OAAOAI2121:     DESCR = "2-1-2-1-input OR-AND-AND-OR-AND-Invert gate"
OAAOAI2121:     OAAOI212
	$(POPCORN) -m pu -c $@ $< > $@
	$(BLUE)

OAAOOAI2122:    DESCR = "2-1-2-2-input OR-AND-AND-OR-AND-AND-Invert gate"
OAAOOAI2122:    OAAOAI2121
	$(POPCORN) -m nor -c $@ $< > $@
	$(BLUE)

OAAOOAI2123:    DESCR = "2-1-2-3-input OR-AND-AND-OR-AND-AND-Invert gate"
OAAOOAI2123:    OAAOOAI2122
	$(POPCORN) -m nor -c $@ $< > $@
	$(BLUE)

OAOI211:        DESCR = "2-1-1-input OR-AND-OR-Invert gate"
OAOI211:        OAI21
	$(POPCORN) -m pd -c $@ $< > $@
	$(BLUE)

OAOI221:        DESCR = "2-2-1-input OR-AND-OR-Invert gate"
OAOI221:        OAI22
	$(POPCORN) -m pd -c $@ $< > $@
	$(BLUE)

OAOAI2111:      DESCR = "2-1-1-1-input OR-AND-OR-AND-Invert gate"
OAOAI2111:      OAOI211
	$(POPCORN) -m pu -c $@ $< > $@
	$(BLUE)

OAOOAI2112:     DESCR = "2-1-1-2-input OR-AND-OR-OR-AND-Invert gate"
OAOOAI2112:     OAOAI2111
	$(POPCORN) -m nor -c $@ $< > $@
	$(BLUE)

OAOOAI2113:     DESCR = "2-1-1-3-input OR-AND-OR-OR-AND-Invert gate"
OAOOAI2113:     OAOOAI2112
	$(POPCORN) -m nor -c $@ $< > $@
	$(BLUE)

OOAI221:        DESCR = "2-2-1-input OR-OR-AND-Invert gate"
OOAI221:        OOAI22
	$(POPCORN) -m pu -c $@ $< > $@
	$(BLUE)

OOAI32:         DESCR = "3-2-input OR-OR-AND-Invert gate"
OOAI32:         OAI31
	$(POPCORN) -m nor -c $@ $< > $@
	$(BLUE)

OOAI321:        DESCR = "3-2-1-input OR-OR-AND-Invert gate"
OOAI321:        OOAI32
	$(POPCORN) -m pu -c $@ $< > $@
	$(BLUE)

OOAI33:         DESCR = "3-3-input OR-OR-AND-Invert gate"
OOAI33:         OOAI32
	$(POPCORN) -m nor -c $@ $< > $@
	$(BLUE)

OOAI331:        DESCR = "3-3-1-input OR-OR-AND-Invert gate"
OOAI331:        OOAI33
	$(POPCORN) -m pu -c $@ $< > $@
	$(BLUE)

OOAAOI222:      DESCR = "2-2-2-input OR-OR-AND-AND-OR-Invert gate"
OOAAOI222:      OOAOI221
	$(POPCORN) -m nand -c $@ $< > $@
	$(BLUE)

OOAAOI223:      DESCR = "2-2-3-input OR-OR-AND-AND-OR-Invert gate"
OOAAOI223:      OOAAOI222
	$(POPCORN) -m nand -c $@ $< > $@
	$(BLUE)

OOAAOI2212:     DESCR = "2-2-1-2-input OR-OR-AND-AND-OR-Invert gate"
OOAAOI2212:     OOAOI2211
	$(POPCORN) -m nand -c $@ $< > $@
	$(BLUE)

OOAAOI2213:     DESCR = "2-2-1-3-input OR-OR-AND-AND-OR-Invert gate"
OOAAOI2213:     OOAAOI2212
	$(POPCORN) -m nand -c $@ $< > $@
	$(BLUE)

OOAAOAI2221:    DESCR = "2-2-2-1-input OR-OR-AND-AND-OR-AND-Invert gate"
OOAAOAI2221:    OOAAOI222
	$(POPCORN) -m pu -c $@ $< > $@
	$(BLUE)

OOAAOOAI2222:   DESCR = "2-2-2-2-input OR-OR-AND-AND-OR-OR-AND-Invert gate"
OOAAOOAI2222:   OOAAOAI2221
	$(POPCORN) -m nor -c $@ $< > $@
	$(BLUE)

OOAAOOAI2223:   DESCR = "2-2-2-3-input OR-OR-AND-AND-OR-OR-AND-Invert gate"
OOAAOOAI2223:   OOAAOOAI2222
	$(POPCORN) -m nor -c $@ $< > $@
	$(BLUE)

OOAOI221:       DESCR = "2-2-1-input OR-OR-AND-OR-Invert gate"
OOAOI221:       OOAI22
	$(POPCORN) -m pd -c $@ $< > $@
	$(BLUE)

OOAOI2211:      DESCR = "2-2-1-1-input OR-OR-AND-OR-Invert gate"
OOAOI2211:      OOAI221
	$(POPCORN) -m pd -c $@ $< > $@
	$(BLUE)

OOAOI2212:      DESCR = "2-2-1-2-input OR-OR-AND-OR-Invert gate"
OOAOI2212:      OOAOI2211
	$(POPCORN) -m nand -c $@ $< > $@
	$(BLUE)

OOAOI2213:      DESCR = "2-2-1-3-input OR-OR-AND-OR-Invert gate"
OOAOI2213:      OOAOI2212
	$(POPCORN) -m nand -c $@ $< > $@
	$(BLUE)

OOAOAI2211:     DESCR = "2-2-1-1-input OR-OR-AND-OR-AND-Invert gate"
OOAOAI2211:     OOAOI221
	$(POPCORN) -m pu -c $@ $< > $@
	$(BLUE)

OOAOOAI2212:    DESCR = "2-2-1-2-input OR-OR-AND-OR-OR-AND-Invert gate"
OOAOOAI2212:    OOAOAI2211
	$(POPCORN) -m nor -c $@ $< > $@
	$(BLUE)

OOAOOAI2213:    DESCR = "2-2-1-3-input OR-OR-AND-OR-OR-AND-Invert gate"
OOAOOAI2213:    OOAOOAI2212
	$(POPCORN) -m nor -c $@ $< > $@
	$(BLUE)

OOOAI222:       DESCR = "2-2-2-input OR-OR-OR-AND-Invert gate"
OOOAI222:       OOAI221
	$(POPCORN) -m nor -c $@ $< > $@
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

OOOAAOI2222:    DESCR = "2-2-2-2-input OR-OR-OR-AND-AND-OR-Invert gate"
OOOAAOI2222:    OOOAOI2221
	$(POPCORN) -m nand -c $@ $< > $@
	$(BLUE)

OOOAAOI2223:    DESCR = "2-2-2-3-input OR-OR-OR-AND-AND-OR-Invert gate"
OOOAAOI2223:    OOOAAOI2222
	$(POPCORN) -m nand -c $@ $< > $@
	$(BLUE)

OOOAOI2221:     DESCR = "2-2-2-1-input OR-OR-OR-AND-OR-Invert gate"
OOOAOI2221:     OOOAI222
	$(POPCORN) -m pd -c $@ $< > $@
	$(BLUE)

OOOAOI2222:     DESCR = "2-2-2-2-input OR-OR-OR-AND-OR-Invert gate"
OOOAOI2222:     OOOAOI2221
	$(POPCORN) -m nand -c $@ $< > $@
	$(BLUE)

OOOAOI2223:     DESCR = "2-2-2-3-input OR-OR-OR-AND-OR-Invert gate"
OOOAOI2223:     OOOAOI2222
	$(POPCORN) -m nand -c $@ $< > $@
	$(BLUE)

endif
endif
