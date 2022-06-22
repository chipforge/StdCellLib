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
                AOOA222 \
                AOOA223 \
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
                OR3

AAAO222:        DESCR = "2-2-2-input AND-AND-AND-OR gate"
AAAO222:        AAO221
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED3)

AAAO322:        DESCR = "3-2-2-input AND-AND-AND-OR gate"
AAAO322:        AAO321
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED3)

AAAO332:        DESCR = "3-3-2-input AND-AND-AND-OR gate"
AAAO332:        AAO331
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED3)

AAAO333:        DESCR = "3-3-3-input AND-AND-AND-OR gate"
AAAO333:        AAAO332
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED3)

AAAOA2221:      DESCR = "2-2-2-1-input AND-AND-AND-OR-AND gate"
AAAOA2221:      AAAO222
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED3)

AAAOOA2222:     DESCR = "2-2-2-2-input AND-AND-AND-OR-OR-AND gate"
AAAOOA2222:     AAAOA2221
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED3)

AAAOOA2223:     DESCR = "2-2-2-3-input AND-AND-AND-OR-OR-AND gate"
AAAOOA2223:     AAAOOA2222
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED3)

AAO221:         DESCR = "2-2-1-input AND-AND-OR gate"
AAO221:         AAO22
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED3)

AAO32:          DESCR = "3-2-input AND-AND-OR gate"
AAO32:          AO31
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED3)

AAO321:         DESCR = "3-2-1-input AND-AND-OR gate"
AAO321:         AAO32
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED3)

AAO33:          DESCR = "3-3-input AND-AND-OR gate"
AAO33:          AAO32
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED3)

AAO331:         DESCR = "3-3-1-input AND-AND-OR gate"
AAO331:         AAO33
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED3)

AAOA221:        DESCR = "2-2-1-input AND-AND-OR-AND gate"
AAOA221:        AAO22
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED3)

AAOA2211:       DESCR = "2-2-1-1-input AND-AND-OR-AND gate"
AAOA2211:       AAO221
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED3)

AAOAAO2212:     DESCR = "2-2-1-2-input AND-AND-OR-AND-AND-OR gate"
AAOAAO2212:     AAOAO2211
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED3)

AAOAAO2213:     DESCR = "2-2-1-3-input AND-AND-OR-AND-AND-OR gate"
AAOAAO2213:     AAOAAO2212
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED3)

AAOAO2211:      DESCR = "2-2-1-1-input AND-AND-OR-AND-OR gate"
AAOAO2211:      AAOA221
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED3)

AAOOA222:       DESCR = "2-2-2-input AND-AND-OR-OR-AND gate"
AAOOA222:       AAOA221
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED3)

AAOOA223:       DESCR = "2-2-3-input AND-AND-OR-OR-AND gate"
AAOOA223:       AAOOA222
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED3)

AAOOA2212:      DESCR = "2-2-1-2-input AND-AND-OR-OR-AND gate"
AAOOA2212:      AAOA2211
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED3)

AAOOA2213:      DESCR = "2-2-1-3-input AND-AND-OR-OR-AND gate"
AAOOA2213:      AAOOA2212
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED3)

AAOOAAO2222:    DESCR = "2-2-2-2-input AND-AND-OR-OR-AND-AND-OR gate"
AAOOAAO2222:    AAOOAO2221
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED3)

AAOOAAO2223:    DESCR = "2-2-2-3-input AND-AND-OR-OR-AND-AND-OR gate"
AAOOAAO2223:    AAOOAAO2222
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED3)

AAOOAO2221:     DESCR = "2-2-2-1-input AND-AND-OR-OR-AND-OR gate"
AAOOAO2221:     AAOOA222
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED3)

AND3:           DESCR = "3-input AND gate"
AND3:           AND2
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED3)

AO22:           DESCR = "2-2-input AND-OR gate"
AO22:           AO21
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED3)

AO31:           DESCR = "3-1-input AND-OR gate"
AO31:           AND3
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED3)

AO32:           DESCR = "3-2-input AND-OR gate"
AO32:           AO31
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED3)

AOA211:         DESCR = "2-1-1-input AND-OR-AND gate"
AOA211:         AO21
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED3)

AOA221:         DESCR = "2-2-1-input AND-OR-AND gate"
AOA221:         AO22
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED3)

AOAAO2112:      DESCR = "2-1-1-2-input AND-OR-AND-AND-OR gate"
AOAAO2112:      AOAO2111
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED3)

AOAAO2113:      DESCR = "2-1-1-3-input AND-OR-AND-AND-OR gate"
AOAAO2113:      AOAAO2112
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED3)

AOAO2111:       DESCR = "2-1-1-1-input AND-OR-AND-OR gate"
AOAO2111:       AOA211
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED3)

AOOA212:        DESCR = "2-1-2-input AND-OR-OR-AND gate"
AOOA212:        AOA211
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED3)

AOOA213:        DESCR = "2-1-3-input AND-OR-OR-AND gate"
AOOA213:        AOOA212
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED3)

AOOA222:        DESCR = "2-2-2-input AND-OR-OR-AND gate"
AOOA222:        AOA221
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED3)

AOOA223:        DESCR = "2-2-3-input AND-OR-OR-AND gate"
AOOA223:        AOOA222
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED3)

AOOAAO2122:     DESCR = "2-1-2-2-input AND-OR-OR-AND-AND-OR gate"
AOOAAO2122:     AOOAO2121
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED3)

AOOAAO2123:     DESCR = "2-1-2-3-input AND-OR-OR-AND-AND-OR gate"
AOOAAO2123:     AOOAOI2121
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED3)

AOOAO2121:      DESCR = "2-1-2-1-input AND-OR-OR-AND-OR gate"
AOOAO2121:      AOOA212
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED3)

OA22:           DESCR = "2-2-input OR-AND gate"
OA22:           OA21
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED3)

OA31:           DESCR = "3-1-input OR-AND gate"
OA31:           OR3
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED3)

OA32:           DESCR = "3-2-input OR-AND gate"
OA32:           OA31
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED3)

OAAO212:        DESCR = "2-1-2-input OR-AND-AND-OR gate"
OAAO212:        OAO211
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED3)

OAAO213:        DESCR = "2-1-3-input OR-AND-AND-OR gate"
OAAO213:        OAAO212
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED3)

OAAO222:        DESCR = "2-2-2-input OR-AND-AND-OR gate"
OAAO222:        OAOI221
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED3)

OAAO223:        DESCR = "2-2-3-input OR-AND-AND-OR gate"
OAAO223:        OAAO222
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED3)

OAAOA2121:      DESCR = "2-1-2-1-input OR-AND-AND-OR-AND gate"
OAAOA2121:      OAAO212
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED3)

OAAOOA2122:     DESCR = "2-1-2-2-input OR-AND-AND-OR-AND-AND gate"
OAAOOA2122:     OAAOA2121
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED3)

OAAOOA2123:     DESCR = "2-1-2-3-input OR-AND-AND-OR-AND-AND gate"
OAAOOA2123:     OAAOOA2122
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED3)

OAO211:         DESCR = "2-1-1-input OR-AND-OR gate"
OAO211:         OA21
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED3)

OAO221:         DESCR = "2-2-1-input OR-AND-OR gate"
OAO221:         OA22
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED3)

OAOA2111:       DESCR = "2-1-1-1-input OR-AND-OR-AND gate"
OAOA2111:       OAO211
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED3)

OAOOA2112:      DESCR = "2-1-1-2-input OR-AND-OR-OR-AND gate"
OAOOA2112:      OAOA2111
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED3)

OAOOA2113:      DESCR = "2-1-1-3-input OR-AND-OR-OR-AND gate"
OAOOA2113:      OAOOA2112
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED3)

OOA221:         DESCR = "2-2-1-input OR-OR-AND gate"
OOA221:         OOA22
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED3)

OOA32:          DESCR = "3-2-input OR-OR-AND gate"
OOA32:          OA31
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED3)

OOA321:         DESCR = "3-2-1-input OR-OR-AND gate"
OOA321:         OOA32
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED3)

OOA33:          DESCR = "3-3-input OR-OR-AND gate"
OOA33:          OOA32
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED3)

OOA331:         DESCR = "3-3-1-input OR-OR-AND gate"
OOA331:         OOA33
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED3)

OOAAO222:       DESCR = "2-2-2-input OR-OR-AND-AND-OR gate"
OOAAO222:       OOAO221
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED3)

OOAAO223:       DESCR = "2-2-3-input OR-OR-AND-AND-OR gate"
OOAAO223:       OOAAO222
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED3)

OOAAO2212:      DESCR = "2-2-1-2-input OR-OR-AND-AND-OR gate"
OOAAO2212:      OOAO2211
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED3)

OOAAO2213:      DESCR = "2-2-1-3-input OR-OR-AND-AND-OR gate"
OOAAO2213:      OOAAO2212
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED3)

OOAAOA2221:     DESCR = "2-2-2-1-input OR-OR-AND-AND-OR-AND gate"
OOAAOA2221:     OOAAO222
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED3)

OOAAOOA2222:    DESCR = "2-2-2-2-input OR-OR-AND-AND-OR-OR-AND gate"
OOAAOOA2222:    OOAAOA2221
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED3)

OOAAOOA2223:    DESCR = "2-2-2-3-input OR-OR-AND-AND-OR-OR-AND gate"
OOAAOOA2223:    OOAAOOA2222
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED3)

OAAO223:        DESCR = "2-2-3-input OR-AND-AND-OR gate"
OAAO223:        OAAO222
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED3)

OOAO221:        DESCR = "2-2-1-input OR-OR-AND-OR gate"
OOAO221:        OOA22
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED3)

OOAO2211:       DESCR = "2-2-1-1-input OR-OR-AND-OR gate"
OOAO2211:       OOA221
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED3)

OOAOA2211:      DESCR = "2-2-1-1-input OR-OR-AND-OR-AND gate"
OOAOA2211:      OOAO221
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED3)

OOAOOA2212:     DESCR = "2-2-1-2-input OR-OR-AND-OR-OR-AND gate"
OOAOOA2212:     OOAOA2211
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED3)

OOAOOA2213:     DESCR = "2-2-1-3-input OR-OR-AND-OR-OR-AND gate"
OOAOOA2213:     OOAOOA2212
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED3)

OOOA222:        DESCR = "2-2-2-input OR-OR-OR-AND gate"
OOOA222:        OOA221
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED3)

OOOA322:        DESCR = "3-2-2-input OR-OR-OR-AND gate"
OOOA322:        OOA321
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED3)

OOOA332:        DESCR = "3-3-2-input OR-OR-OR-AND gate"
OOOA332:        OOA331
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED3)

OOOA333:        DESCR = "3-3-3-input OR-OR-OR-AND gate"
OOOA333:        OOOA332
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED3)

OOOAAO2222:     DESCR = "2-2-2-2-input OR-OR-OR-AND-AND-OR gate"
OOOAAO2222:     OOOAO2221
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED3)

OOOAAO2223:     DESCR = "2-2-2-3-input OR-OR-OR-AND-AND-OR gate"
OOOAAO2223:     OOOAAO2222
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED3)

OOOAO2221:      DESCR = "2-2-2-1-input OR-OR-OR-AND-OR gate"
OOOAO2221:      OOOA222
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED3)

OR3:            DESCR = "3-input OR gate"
OR3:            OR2
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED3)

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
                AOOA222 \
                AOOA223 \
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
                OR3

AAAO222:        DESCR = "2-2-2-input AND-AND-AND-OR gate"
AAAO222:        AAO221
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED3)

AAAO322:        DESCR = "3-2-2-input AND-AND-AND-OR gate"
AAAO322:        AAO321
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED3)

AAAO332:        DESCR = "3-3-2-input AND-AND-AND-OR gate"
AAAO332:        AAO331
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED3)

AAAO333:        DESCR = "3-3-3-input AND-AND-AND-OR gate"
AAAO333:        AAAO332
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED3)

AAAOA2221:      DESCR = "2-2-2-1-input AND-AND-AND-OR-AND gate"
AAAOA2221:      AAAO222
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED3)

AAAOOA2222:     DESCR = "2-2-2-2-input AND-AND-AND-OR-OR-AND gate"
AAAOOA2222:     AAAOA2221
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED3)

AAAOOA2223:     DESCR = "2-2-2-3-input AND-AND-AND-OR-OR-AND gate"
AAAOOA2223:     AAAOOA2222
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED3)

AAO221:         DESCR = "2-2-1-input AND-AND-OR gate"
AAO221:         AAOI22
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED3)

AAO32:          DESCR = "3-2-input AND-AND-OR gate"
AAO32:          AO31
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED3)

AAO321:         DESCR = "3-2-1-input AND-AND-OR gate"
AAO321:         AAO32
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED3)

AAO33:          DESCR = "3-3-input AND-AND-OR gate"
AAO33:          AAO32
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED3)

AAO331:         DESCR = "3-3-1-input AND-AND-OR gate"
AAO331:         AAO33
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED3)

AAOA221:        DESCR = "2-2-1-input AND-AND-OR-AND gate"
AAOA221:        AAOI22
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED3)

AAOA2211:       DESCR = "2-2-1-1-input AND-AND-OR-AND gate"
AAOA2211:       AAO221
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED3)

AAOAAO2212:     DESCR = "2-2-1-2-input AND-AND-OR-AND-AND-OR gate"
AAOAAO2212:     AAOAO2211
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED3)

AAOAAO2213:     DESCR = "2-2-1-3-input AND-AND-OR-AND-AND-OR gate"
AAOAAO2213:     AAOAAO2212
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED3)

AAOAO2211:      DESCR = "2-2-1-1-input AND-AND-OR-AND-OR gate"
AAOAO2211:      AAOA221
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED3)

AAOOA222:       DESCR = "2-2-2-input AND-AND-OR-OR-AND gate"
AAOOA222:       AAOA221
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED3)

AAOOA223:       DESCR = "2-2-3-input AND-AND-OR-OR-AND gate"
AAOOA223:       AAOOA222
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED3)

AAOOA2212:      DESCR = "2-2-1-2-input AND-AND-OR-OR-AND gate"
AAOOA2212:      AAOA2211
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED3)

AAOOA2213:      DESCR = "2-2-1-3-input AND-AND-OR-OR-AND gate"
AAOOA2213:      AAOOA2212
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED3)

AAOOAAO2222:    DESCR = "2-2-2-2-input AND-AND-OR-OR-AND-AND-OR gate"
AAOOAAO2222:    AAOOAO2221
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED3)

AAOOAAO2223:    DESCR = "2-2-2-3-input AND-AND-OR-OR-AND-AND-OR gate"
AAOOAAO2223:    AAOOAAO2222
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED3)

AAOOAO2221:     DESCR = "2-2-2-1-input AND-AND-OR-OR-AND-OR gate"
AAOOAO2221:     AAOOA222
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED3)

AND3:           DESCR = "3-input AND gate"
AND3:           NAND2
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED3)

AO22:           DESCR = "2-2-input AND-OR gate"
AO22:           AOI21
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED3)

AO31:           DESCR = "3-1-input AND-OR gate"
AO31:           AND3
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED3)

AO32:           DESCR = "3-2-input AND-OR gate"
AO32:           AO31
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED3)

OAO211:         DESCR = "2-1-1-input OR-AND-OR gate"
OAO211:         OAI21
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED3)

OAO221:         DESCR = "2-2-1-input OR-AND-OR gate"
OAO221:         OA22
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED3)

OAOA2111:       DESCR = "2-1-1-1-input OR-AND-OR-AND gate"
OAOA2111:       OAO211
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED3)

OAOOA2112:      DESCR = "2-1-1-2-input OR-AND-OR-OR-AND gate"
OAOOA2112:      OAOA2111
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED3)

OAOOA2113:      DESCR = "2-1-1-3-input OR-AND-OR-OR-AND gate"
OAOOA2113:      OAOOA2112
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED3)

AOA211:         DESCR = "2-1-1-input AND-OR-AND gate"
AOA211:         AOI21
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED3)

AOA221:         DESCR = "2-2-1-input AND-OR-AND gate"
AOA221:         AO22
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED3)

AOAAO2112:      DESCR = "2-1-1-2-input AND-OR-AND-AND-OR gate"
AOAAO2112:      AOAO2111
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED3)

AOAAO2113:      DESCR = "2-1-1-3-input AND-OR-AND-AND-OR gate"
AOAAO2113:      AOAAO2112
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED3)

AOAO2111:       DESCR = "2-1-1-1-input AND-OR-AND-OR gate"
AOAO2111:       AOA211
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED3)

AOOA212:        DESCR = "2-1-2-input AND-OR-OR-AND gate"
AOOA212:        AOA211
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED3)

AOOA213:        DESCR = "2-1-3-input AND-OR-OR-AND gate"
AOOA213:        AOA212
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED3)

AOOA222:        DESCR = "2-2-2-input AND-OR-OR-AND gate"
AOOA222:        AOA221
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED3)

AOOA223:        DESCR = "2-2-3-input AND-OR-OR-AND gate"
AOOA223:        AOOA222
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED3)

AOOAAO2122:     DESCR = "2-1-2-2-input AND-OR-OR-AND-AND-OR gate"
AOOAAO2122:     AOOAO2121
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED3)

AOOAAO2123:     DESCR = "2-1-2-3-input AND-OR-OR-AND-AND-OR gate"
AOOAAO2123:     AOOAO2121
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED3)

AOOAO2121:      DESCR = "2-1-2-1-input AND-OR-OR-AND-OR gate"
AOOAO2121:      AOOA212
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED3)

OA22:           DESCR = "2-2-input OR-AND gate"
OA22:           OAI21
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED3)

OA31:           DESCR = "3-1-input OR-AND gate"
OA31:           OR3
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED3)

OA32:           DESCR = "3-2-input OR-AND gate"
OA32:           OA31
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED3)

OAAO212:        DESCR = "2-1-2-input OR-AND-AND-OR gate"
OAAO212:        OAO211
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED3)

OAAO213:        DESCR = "2-1-3-input OR-AND-AND-OR gate"
OAAO213:        OAAO212
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED3)

OAAO222:        DESCR = "2-2-2-input OR-AND-AND-OR gate"
OAAO222:        OAOI221
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED3)

OAAOA2121:      DESCR = "2-1-2-1-input OR-AND-AND-OR-AND gate"
OAAOA2121:      OAAO212
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED3)

OAAOOA2122:     DESCR = "2-1-2-2-input OR-AND-AND-OR-AND-AND gate"
OAAOOA2122:     OAAOA2121
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED3)

OAAOOA2123:     DESCR = "2-1-2-3-input OR-AND-AND-OR-AND-AND gate"
OAAOOA2123:     OAAOOA2122
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED3)

OOA221:         DESCR = "2-2-1-input OR-OR-AND gate"
OOA221:         OOAI22
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED3)

OOA32:          DESCR = "3-2-input OR-OR-AND gate"
OOA32:          OA31
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED3)

OOA321:         DESCR = "3-2-1-input OR-OR-AND gate"
OOA321:         OOA32
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED3)

OOA33:          DESCR = "3-3-input OR-OR-AND gate"
OOA33:          OOA32
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED3)

OOA331:         DESCR = "3-3-1-input OR-OR-AND gate"
OOA331:         OOA33
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED3)

OOAAO222:       DESCR = "2-2-2-input OR-OR-AND-AND-OR gate"
OOAAO222:       OOAO221
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED3)

OOAAO223:       DESCR = "2-2-3-input OR-OR-AND-AND-OR gate"
OOAAO223:       OOAAO222
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED3)

OOAAO2212:      DESCR = "2-2-1-2-input OR-OR-AND-AND-OR gate"
OOAAO2212:      OOAO2211
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED3)

OOAAO2213:      DESCR = "2-2-1-3-input OR-OR-AND-AND-OR gate"
OOAAO2213:      OOAAO2212
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED3)

OOAAOA2221:     DESCR = "2-2-2-1-input OR-OR-AND-AND-OR-AND gate"
OOAAOA2221:     OOAAO222
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED3)

OOAAOOA2222:    DESCR = "2-2-2-2-input OR-OR-AND-AND-OR-OR-AND gate"
OOAAOOA2222:    OOAAOA2221
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED3)

OOAAOOA2223:    DESCR = "2-2-2-3-input OR-OR-AND-AND-OR-OR-AND gate"
OOAAOOA2223:    OOAAOOA2222
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED3)

OOAO221:        DESCR = "2-2-1-input OR-OR-AND-OR gate"
OOAO221:        OOAI22
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED3)

OOAO2211:       DESCR = "2-2-1-1-input OR-OR-AND-OR gate"
OOAO2211:       OOA221
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED3)

OOAOA2211:      DESCR = "2-2-1-1-input OR-OR-AND-OR-AND gate"
OOAOA2211:      OOAO221
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED3)

OOAOOA2212:     DESCR = "2-2-1-2-input OR-OR-AND-OR-OR-AND gate"
OOAOOA2212:     OOAOA2211
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED3)

OOAOOA2213:     DESCR = "2-2-1-3-input OR-OR-AND-OR-OR-AND gate"
OOAOOA2213:     OOAOOA2212
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED3)

OOOA222:        DESCR = "2-2-2-input OR-OR-OR-AND gate"
OOOA222:        OOA221
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED3)

OOOA322:        DESCR = "3-2-2-input OR-OR-OR-AND gate"
OOOA322:        OOA321
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED3)

OOOA332:        DESCR = "3-3-2-input OR-OR-OR-AND gate"
OOOA332:        OOA331
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED3)

OOOA333:        DESCR = "3-3-3-input OR-OR-OR-AND gate"
OOOA333:        OOOA332
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED3)

OOOAAO2222:     DESCR = "2-2-2-2-input OR-OR-OR-AND-AND-OR gate"
OOOAAO2222:     OOOAO2221
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED3)

OOOAAO2223:     DESCR = "2-2-2-3-input OR-OR-OR-AND-AND-OR gate"
OOOAAO2223:     OOOAAO2222
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED3)

OOOAO2221:      DESCR = "2-2-2-1-input OR-OR-OR-AND-OR gate"
OOOAO2221:      OOOA222
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED3)

OR3:            DESCR = "3-input OR gate"
OR3:            NOR2
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED3)

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
                AOOAI222 \
                AOOAI223 \
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
                OOAOAI2211 \
                OOAOOAI2212 \
                OOAOOAI2213 \
                OOOAI222 \
                OOOAI322 \
                OOOAI332 \
                OOOAI333 \
                OOOAAOI2222 \
                OOOAAOI2223 \
                OOOAOI2221

AAAOI222:       DESCR = "2-2-2-input AND-AND-AND-OR-Invert gate"
AAAOI222:       AAOI221
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED3)

AAAOI322:       DESCR = "3-2-2-input AND-AND-AND-OR-Invert gate"
AAAOI322:       AAOI321
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED3)

AAAOI332:       DESCR = "3-3-2-input AND-AND-AND-OR-Invert gate"
AAAOI332:       AAOI331
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED3)

AAAOI333:       DESCR = "3-3-3-input AND-AND-AND-OR-Invert gate"
AAAOI333:       AAAOI332
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED3)

AAAOAI2221:     DESCR = "2-2-2-1-input AND-AND-OR-AND-Invert gate"
AAAOAI2221:     AAAOI222
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED3)

AAAOOAI2222:    DESCR = "2-2-2-2-input AND-AND-AND-OR-OR-AND-Invert gate"
AAAOOAI2222:    AAAOAI2221
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED3)

AAAOOAI2223:    DESCR = "2-2-2-3-input AND-AND-AND-OR-OR-AND-Invert gate"
AAAOOAI2223:    AAAOOAI2222
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED3)

AAOI221:        DESCR = "2-2-1-input AND-AND-OR-Invert gate"
AAOI221:        AAOI22
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED3)

AAOI32:         DESCR = "3-2-input AND-AND-OR-Invert gate"
AAOI32:         AOI31
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED3)

AAOI321:        DESCR = "3-2-1-input AND-AND-OR-Invert gate"
AAOI321:        AAOI32
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED3)

AAOI33:         DESCR = "3-3-input AND-AND-OR-Invert gate"
AAOI33:         AAOI32
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED3)

AAOI331:        DESCR = "3-3-1-input AND-AND-OR-Invert gate"
AAOI331:        AAOI33
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED3)

AAOAI221:       DESCR = "2-2-1-input AND-AND-OR-AND gate"
AAOAI221:       AAOI22
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED3)

AAOAI2211:      DESCR = "2-2-1-1-input AND-AND-OR-AND-Invert gate"
AAOAI2211:      AAOI221
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED3)

AAOAAOI2212:    DESCR = "2-2-1-2-input AND-AND-OR-AND-AND-OR-Invert gate"
AAOAAOI2212:    AAOAOI2211
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED3)

AAOAAOI2213:    DESCR = "2-2-1-3-input AND-AND-OR-AND-AND-OR-Invert gate"
AAOAAOI2213:    AAOAAOI2212
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED3)

AAOAOI2211:     DESCR = "2-2-1-1-input AND-AND-OR-AND-OR-Invert gate"
AAOAOI2211:     AAOAI221
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED3)

AAOOAAOI2222:   DESCR = "2-2-2-2-input AND-AND-OR-OR-AND-AND-OR-Invert gate"
AAOOAAOI2222:   AAOOAOI2221
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED3)

AAOOAAOI2223:   DESCR = "2-2-2-3-input AND-AND-OR-OR-AND-AND-OR-Invert gate"
AAOOAAOI2223:   AAOOAAOI2222
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED3)

AAOOAI222:      DESCR = "2-2-2-input AND-AND-OR-OR-AND-Invert gate"
AAOOAI222:      AAOAI221
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED3)

AAOOAI223:      DESCR = "2-2-3-input AND-AND-OR-OR-AND-Invert gate"
AAOOAI223:      AAOOAI222
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED3)

AAOOAI2212:     DESCR = "2-2-1-2-input AND-AND-OR-OR-AND-Invert gate"
AAOOAI2212:     AAOAI2211
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED3)

AAOOAI2213:     DESCR = "2-2-1-3-input AND-AND-OR-OR-AND-Invert gate"
AAOOAI2213:     AAOOAI2212
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED3)

AAOOAOI2221:    DESCR = "2-2-2-1-input AND-AND-OR-OR-AND-OR-Invert gate"
AAOOAOI2221:    AAOOAI222
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED3)

AOI22:          DESCR = "2-2-input AND-OR-Invert gate"
AOI22:          AOI21
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED3)

AOI31:          DESCR = "3-1-input AND-OR-Invert gate"
AOI31:          NAND3
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED3)

AOI32:          DESCR = "3-2-input AND-OR-Invert gate"
AOI32:          AOI31
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED3)

AOAI211:        DESCR = "2-1-1-input AND-OR-AND-Invert gate"
AOAI211:        AOI21
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED3)

AOAI221:        DESCR = "2-2-1-input AND-OR-AND-Invert gate"
AOAI221:        AOI22
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED3)

AOAAOI2112:     DESCR = "2-1-1-2-input AND-OR-AND-AND-OR-Invert gate"
AOAAOI2112:     AOAOI2111
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED3)

AOAAOI2113:     DESCR = "2-1-1-3-input AND-OR-AND-AND-OR-Invert gate"
AOAAOI2113:     AOAAOI2112
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED3)

AOAOI2111:      DESCR = "2-1-1-1-input AND-OR-AND-OR-Invert gate"
AOAOI2111:      AOAI211
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED3)

AOOAI212:       DESCR = "2-1-2-input AND-OR-OR-AND-Invert gate"
AOOAI212:       AOAI211
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED3)

AOOAI213:       DESCR = "2-1-3-input AND-OR-OR-AND-Invert gate"
AOOAI213:       AOOAI212
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED3)

AOOAI222:       DESCR = "2-2-2-input AND-OR-OR-AND-Invert gate"
AOOAI222:       AOAI221
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED3)

AOOAI223:       DESCR = "2-2-3-input AND-OR-OR-AND-Invert gate"
AOOAI223:       AOOAI222
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED3)

AOOAAOI2122:    DESCR = "2-1-2-2-input AND-OR-OR-AND-AND-OR-Invert gate"
AOOAAOI2122:    AOOAOI2121
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED3)

AOOAAOI2123:    DESCR = "2-1-2-3-input AND-OR-OR-AND-AND-OR-Invert gate"
AOOAAOI2123:    AOOAOI2121
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED3)

AOOAOI2121:     DESCR = "2-1-2-1-input AND-OR-OR-AND-OR-Invert gate"
AOOAOI2121:     AOOAI212
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED3)

NAND3:          DESCR = "3-input Not-AND (or NAND) gate"
NAND3:          NAND2
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED3)

NOR3:           DESCR = "3-input Not-OR (or NOR) gate"
NOR3:           NOR2
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED3)

OAI22:          DESCR = "2-2-input OR-AND-Invert gate"
OAI22:          OAI21
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED3)

OAI31:          DESCR = "3-1-input OR-AND-Invert gate"
OAI31:          NOR3
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED3)

OAI32:          DESCR = "3-2-input OR-AND-Invert gate"
OAI32:          OAI31
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED3)

OAAOI212:       DESCR = "2-1-2-input OR-AND-AND-OR-Invert gate"
OAAOI212:       OAOI211
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED3)

OAAOI213:       DESCR = "2-1-3-input OR-AND-AND-OR-Invert gate"
OAAOI213:       OAAOI212
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED3)

OAAOI222:       DESCR = "2-2-2-input OR-AND-AND-OR-Invert gate"
OAAOI222:       OAOI221
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED3)

OAAOI223:       DESCR = "2-2-3-input OR-AND-AND-OR-Invert gate"
OAAOI223:       OAAOI222
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED3)

OAAOAI2121:     DESCR = "2-1-2-1-input OR-AND-AND-OR-AND-Invert gate"
OAAOAI2121:     OAAOI212
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED3)

OAAOOAI2122:    DESCR = "2-1-2-2-input OR-AND-AND-OR-AND-AND-Invert gate"
OAAOOAI2122:    OAAOAI2121
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED3)

OAAOOAI2123:    DESCR = "2-1-2-3-input OR-AND-AND-OR-AND-AND-Invert gate"
OAAOOAI2123:    OAAOOAI2122
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED3)

OAOI211:        DESCR = "2-1-1-input OR-AND-OR-Invert gate"
OAOI211:        OAI21
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED3)

OAOI221:        DESCR = "2-2-1-input OR-AND-OR-Invert gate"
OAOI221:        OAI22
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED3)

OAOAI2111:      DESCR = "2-1-1-1-input OR-AND-OR-AND-Invert gate"
OAOAI2111:      OAOI211
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED3)

OAOOAI2112:     DESCR = "2-1-1-2-input OR-AND-OR-OR-AND-Invert gate"
OAOOAI2112:     OAOAI2111
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED3)

OAOOAI2113:     DESCR = "2-1-1-3-input OR-AND-OR-OR-AND-Invert gate"
OAOOAI2113:     OAOOAI2112
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED3)

OOAI221:        DESCR = "2-2-1-input OR-OR-AND-Invert gate"
OOAI221:        OOAI22
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED3)

OOAI32:         DESCR = "3-2-input OR-OR-AND-Invert gate"
OOAI32:         OAI31
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED3)

OOAI321:        DESCR = "3-2-1-input OR-OR-AND-Invert gate"
OOAI321:        OOAI32
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED3)

OOAI33:         DESCR = "3-3-input OR-OR-AND-Invert gate"
OOAI33:         OOAI32
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED3)

OOAI331:        DESCR = "3-3-1-input OR-OR-AND-Invert gate"
OOAI331:        OOAI33
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED3)

OOAAOI222:      DESCR = "2-2-2-input OR-OR-AND-AND-OR-Invert gate"
OOAAOI222:      OOAOI221
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED3)

OOAAOI223:      DESCR = "2-2-3-input OR-OR-AND-AND-OR-Invert gate"
OOAAOI223:      OOAAOI222
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED3)

OOAAOI2212:     DESCR = "2-2-1-2-input OR-OR-AND-AND-OR-Invert gate"
OOAAOI2212:     OOAOI2211
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED3)

OOAAOI2213:     DESCR = "2-2-1-3-input OR-OR-AND-AND-OR-Invert gate"
OOAAOI2213:     OOAAOI2212
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED3)

OOAAOAI2221:    DESCR = "2-2-2-1-input OR-OR-AND-AND-OR-AND-Invert gate"
OOAAOAI2221:    OOAAOI222
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED3)

OOAAOOAI2222:   DESCR = "2-2-2-2-input OR-OR-AND-AND-OR-OR-AND-Invert gate"
OOAAOOAI2222:   OOAAOAI2221
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED3)

OOAAOOAI2223:   DESCR = "2-2-2-3-input OR-OR-AND-AND-OR-OR-AND-Invert gate"
OOAAOOAI2223:   OOAAOOAI2222
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED3)

OOAOI221:       DESCR = "2-2-1-input OR-OR-AND-OR-Invert gate"
OOAOI221:       OOAI22
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED3)

OOAOI2211:      DESCR = "2-2-1-1-input OR-OR-AND-OR-Invert gate"
OOAOI2211:      OOAI221
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED3)

OOAOAI2211:     DESCR = "2-2-1-1-input OR-OR-AND-OR-AND-Invert gate"
OOAOAI2211:     OOAOI221
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED3)

OOAOOAI2212:    DESCR = "2-2-1-2-input OR-OR-AND-OR-OR-AND-Invert gate"
OOAOOAI2212:    OOAOAI2211
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED3)

OOAOOAI2213:    DESCR = "2-2-1-3-input OR-OR-AND-OR-OR-AND-Invert gate"
OOAOOAI2213:    OOAOOAI2212
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED3)

OOOAI222:       DESCR = "2-2-2-input OR-OR-OR-AND-Invert gate"
OOOAI222:       OOAI221
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED3)

OOOAI322:       DESCR = "3-2-2-input OR-OR-OR-AND-Invert gate"
OOOAI322:       OOAI321
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED3)

OOOAI332:       DESCR = "3-3-2-input OR-OR-OR-AND-Invert gate"
OOOAI332:       OOAI331
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED3)

OOOAI333:       DESCR = "3-3-3-input OR-OR-OR-AND-Invert gate"
OOOAI333:       OOOAI332
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED3)

OOOAAOI2222:    DESCR = "2-2-2-2-input OR-OR-OR-AND-AND-OR-Invert gate"
OOOAAOI2222:    OOOAOI2221
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED3)

OOOAAOI2223:    DESCR = "2-2-2-3-input OR-OR-OR-AND-AND-OR-Invert gate"
OOOAAOI2223:    OOOAAOI2222
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED3)

OOOAOI2221:     DESCR = "2-2-2-1-input OR-OR-OR-AND-OR-Invert gate"
OOOAOI2221:     OOOAI222
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED3)

endif
endif
