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

#   list all dependencies for cells with 4 stacked transistors
#
include stacked3_cells.mk
#include crafted4_cells.mk

#   ----------------------------------------------------------------
#               CELL TARGETS
#   ----------------------------------------------------------------

ifdef BUFFERED

#   --------    already buffered    --------------------------------

CELLS +=        AAAO2221 \
                AAO42 \
                AAO43 \
                AAO44 \
                AAO222 \
                AAO322 \
                AAOA222 \
                AAOA321 \
                AAOA331 \
                AAOA2212 \
                AAOA2221 \
                AAOA3211 \
                AAOAO2212 \
                AAOAO2221 \
                AAOAO3211 \
                AAOAO22111 \
                AAOAOA22111 \
                AAOOA322 \
                AAOOA2221 \
                AND4 \
                AO23 \
                AO33 \
                AO41 \
                AO42 \
                AO43 \
                AOA212 \
                AOA231 \
                AOA232 \
                AOA311 \
                AOA321 \
                AOAAO2122 \
                AOAAO3112 \
                AOAAO21112 \
                AOAAOA21121 \
                AOAO2112 \
                AOAO2121 \
                AOAO2122 \
                AOAO3111 \
                AOAO3112 \
                AOAO3211 \
                AOAOA21111 \
                AOAOA21121 \
                AOAOAO211111 \
                AOAOOA21112 \
                AOOA214 \
                AOOA232 \
                AOOA312 \
                AOOA313 \
                AOOA2121 \
                AOOA2131 \
                AOOAO2122 \
                AOOAO2131 \
                AOOAO3121 \
                AOOAO21211 \
                AOOAOA21211 \
                AOOOA2122 \
                OA23 \
                OA33 \
                OA41 \
                OA42 \
                OA43 \
                OAAO312 \
                OAAO2121 \
                OAO212 \
                OAO222 \
                OAO231 \
                OAO311 \
                OAO321 \
                OAOA2112 \
                OAOA2121 \
                OAOA2211 \
                OAOA3111 \
                OAOAO21111 \
                OOA42 \
                OOA43 \
                OOA44 \
                OOA222 \
                OOAO222 \
                OOAO321 \
                OR4

AAAO2221:       DESCR = "2-2-2-1-input AND-AND-AND-OR gate"
AAAO2221:       AAAO222
	$(POPCORN) -m pd -c $@ $< > $@
	$(RED)

AAO42:          DESCR = "4-2-input AND-AND-OR gate"
AAO42:          AO41
	$(POPCORN) -m nand -c $@ $< > $@
	$(RED)

AAO43:          DESCR = "4-3-input AND-AND-OR gate"
AAO43:          AAO42
	$(POPCORN) -m nand -c $@ $< > $@
	$(RED)

AAO44:          DESCR = "4-4-input AND-AND-OR gate"
AAO44:          AAO43
	$(POPCORN) -m nand -c $@ $< > $@
	$(RED)

AAO222:         DESCR = "2-2-2-input AND-AND-OR gate"
AAO222:         AAO221
	$(POPCORN) -m nor -c $@ $< > $@
	$(RED)

AAO322:         DESCR = "3-2-2-input AND-AND-OR gate"
AAO322:         AAO321
	$(POPCORN) -m nor -c $@ $< > $@
	$(RED)

AAOA222:        DESCR = "2-2-2-input AND-AND-OR-AND gate"
AAOA222:        AAOA221
	$(POPCORN) -m nand -c $@ $< > $@
	$(RED)

AAOA321:        DESCR = "3-2-1-input AND-AND-OR-AND gate"
AAOA321:        AAO32
	$(POPCORN) -m pu -c $@ $< > $@
	$(RED)

AAOA331:        DESCR = "3-3-1-input AND-AND-OR-AND gate"
AAOA331:        AAO33
	$(POPCORN) -m pu -c $@ $< > $@
	$(RED)

AAOA2212:       DESCR = "2-2-1-2-input AND-AND-OR-AND gate"
AAOA2212:       AAOA2211
	$(POPCORN) -m nand -c $@ $< > $@
	$(RED)

AAOA2221:       DESCR = "2-2-2-1-input AND-AND-OR-AND gate"
AAOA2221:       AAO222
	$(POPCORN) -m pu -c $@ $< > $@
	$(RED)

AAOA3211:       DESCR = "3-2-1-1-input AND-AND-OR-AND gate"
AAOA3211:       AAO321
	$(POPCORN) -m pu -c $@ $< > $@
	$(RED)

AAOAO2212:      DESCR = "2-2-1-2-input AND-AND-OR-AND-OR gate"
AAOAO2212:      AAOAO2211
	$(POPCORN) -m nor -c $@ $< > $@
	$(RED)

AAOAO2221:      DESCR = "2-2-2-1-input AND-AND-OR-AND-OR gate"
AAOAO2221:      AAOA222
	$(POPCORN) -m pd -c $@ $< > $@
	$(RED)

AAOAO3211:      DESCR = "3-2-1-1-input AND-AND-OR-AND-OR gate"
AAOAO3211:      AAOA321
	$(POPCORN) -m pd -c $@ $< > $@
	$(RED)

AAOAO22111:     DESCR = "2-2-1-1-1-input AND-AND-OR-AND-OR gate"
AAOAO22111:     AAOA2211
	$(POPCORN) -m pd -c $@ $< > $@
	$(RED)

AAOAOA22111:    DESCR = "2-2-1-1-1-input AND-AND-OR-AND-OR-AND gate"
AAOAOA22111:    AAOAO2211
	$(POPCORN) -m pu -c $@ $< > $@
	$(RED)

AAOOA322:       DESCR = "3-2-2-input AND-AND-OR-OR-AND gate"
AAOOA322:       AAOA321
	$(POPCORN) -m nor -c $@ $< > $@
	$(RED)

AAOOA2221:      DESCR = "2-2-2-1-input AND-AND-OR-OR-AND gate"
AAOOA2221:      AAOOA222
	$(POPCORN) -m pu -c $@ $< > $@
	$(RED)

AND4:           DESCR = "4-input AND gate"
AND4:           AND3
	$(POPCORN) -m nand -c $@ $< > $@
	$(RED)

AO23:           DESCR = "2-3-input AND-OR gate"
AO23:           AO22
	$(POPCORN) -m nor -c $@ $< > $@
	$(RED)

AO33:           DESCR = "3-3-input AND-OR gate"
AO33:           AO32
	$(POPCORN) -m nor -c $@ $< > $@
	$(RED)

AO41:           DESCR = "4-1-input AND-OR gate"
AO41:           AND4
	$(POPCORN) -m pd -c $@ $< > $@
	$(RED)

AO42:           DESCR = "4-2-input AND-OR gate"
AO42:           AO41
	$(POPCORN) -m nor -c $@ $< > $@
	$(RED)

AO43:           DESCR = "4-2-input AND-OR gate"
AO43:           AO42
	$(POPCORN) -m nor -c $@ $< > $@
	$(RED)

AOA212:         DESCR = "2-1-2-input AND-OR-AND gate"
AOA212:         AOA211
	$(POPCORN) -m nand -c $@ $< > $@
	$(RED)

AOA231:         DESCR = "2-3-1-input AND-OR-AND gate"
AOA231:         AO23
	$(POPCORN) -m pu -c $@ $< > $@
	$(RED)

AOA232:         DESCR = "2-3-2-input AND-OR-AND gate"
AOA232:         AOA231
	$(POPCORN) -m nand -c $@ $< > $@
	$(RED)

AOA311:         DESCR = "3-1-1-input AND-OR-AND gate"
AOA311:         AO31
	$(POPCORN) -m pu -c $@ $< > $@
	$(RED)

AOA321:         DESCR = "3-2-1-input AND-OR-AND gate"
AOA321:         AO32
	$(POPCORN) -m pu -c $@ $< > $@
	$(RED)

AOAAO2122:      DESCR = "2-1-2-2-input AND-OR-AND-AND-OR gate"
AOAAO2122:      AOAO2121
	$(POPCORN) -m nand -c $@ $< > $@
	$(RED)

AOAAO3112:      DESCR = "3-1-1-2-input AND-OR-AND-AND-OR gate"
AOAAO3112:      AOAO3111
	$(POPCORN) -m nand -c $@ $< > $@
	$(RED)

AOAAO21112:     DESCR = "2-1-1-1-2-input AND-OR-AND-AND-OR gate"
AOAAO21112:     AOAAO2112
	$(POPCORN) -m pd -c $@ $< > $@
	$(RED)

AOAAOA21121:    DESCR = "2-1-1-2-1-input AND-OR-AND-AND-OR-AND gate"
AOAAOA21121:    AOAAO2112
	$(POPCORN) -m pu -c $@ $< > $@
	$(RED)

AOAO2112:       DESCR = "2-1-1-2-input AND-OR-AND-OR gate"
AOAO2112:       AOAO2111
	$(POPCORN) -m nor -c $@ $< > $@
	$(RED)

AOAO2121:       DESCR = "2-1-2-1-input AND-OR-AND-OR gate"
AOAO2121:       AOA212
	$(POPCORN) -m pd -c $@ $< > $@
	$(RED)

AOAO2122:       DESCR = "2-1-2-2-input AND-OR-AND-OR gate"
AOAO2122:       AOAO2121
	$(POPCORN) -m nor -c $@ $< > $@
	$(RED)

AOAO3111:       DESCR = "3-1-1-1-input AND-OR-AND-OR gate"
AOAO3111:       AOA311
	$(POPCORN) -m pd -c $@ $< > $@
	$(RED)

AOAO3112:       DESCR = "3-1-1-2-input AND-OR-AND-OR gate"
AOAO3112:       AOAO3111
	$(POPCORN) -m nor -c $@ $< > $@
	$(RED)

AOAO3211:       DESCR = "3-2-1-1-input AND-OR-AND-OR gate"
AOAO3211:       AOA321
	$(POPCORN) -m pd -c $@ $< > $@
	$(RED)

AOAOA21111:     DESCR = "2-1-1-1-1-input AND-OR-AND-OR-AND gate"
AOAOA21111:     AOAO2111
	$(POPCORN) -m pu -c $@ $< > $@
	$(RED)

AOAOA21121:     DESCR = "2-1-1-2-1-input AND-OR-AND-OR-AND gate"
AOAOA21121:     AOAO2112
	$(POPCORN) -m pu -c $@ $< > $@
	$(RED)

AOAOAO211111:   DESCR = "2-1-1-1-1-1-input AND-OR-AND-OR-AND-OR gate"
AOAOAO211111:   AOAOA21111
	$(POPCORN) -m pd -c $@ $< > $@
	$(RED)

AOAOOA21112:    DESCR = "2-1-1-1-2-input AND-OR-AND-OR-OR-AND gate"
AOAOOA21112:    AOAOA21111
	$(POPCORN) -m nor -c $@ $< > $@
	$(RED)

AOOA214:        DESCR = "2-1-4-input AND-OR-OR-AND gate"
AOOA214:        AOA213
	$(POPCORN) -m nor -c $@ $< > $@
	$(RED)

AOOA232:        DESCR = "2-3-2-input AND-OR-OR-AND gate"
AOOA232:        AOA231
	$(POPCORN) -m nor -c $@ $< > $@
	$(RED)

AOOA312:        DESCR = "3-1-2-input AND-OR-OR-AND gate"
AOOA312:        AOA311
	$(POPCORN) -m nor -c $@ $< > $@
	$(RED)

AOOA313:        DESCR = "3-1-3-input AND-OR-OR-AND gate"
AOOA313:        AOOA312
	$(POPCORN) -m nor -c $@ $< > $@
	$(RED)

AOOA2121:       DESCR = "2-1-2-1-input AND-OR-OR-AND gate"
AOOA2121:       AOOA212
	$(POPCORN) -m pu -c $@ $< > $@
	$(RED)

AOOA2131:       DESCR = "2-1-3-1-input AND-OR-OR-AND gate"
AOOA2131:       AOOA213
	$(POPCORN) -m pu -c $@ $< > $@
	$(RED)

AOOAO2122:      DESCR = "2-1-2-2-input AND-OR-OR-AND-OR gate"
AOOAO2122:      AOOAO2121
	$(POPCORN) -m nor -c $@ $< > $@
	$(RED)

AOOAO2131:      DESCR = "2-1-3-1-input AND-OR-OR-AND-OR gate"
AOOAO2131:      AOOA213
	$(POPCORN) -m pd -c $@ $< > $@
	$(RED)

AOOAO3121:      DESCR = "3-1-2-1-input AND-OR-OR-AND-OR gate"
AOOAO3121:      AOOA312
	$(POPCORN) -m pd -c $@ $< > $@
	$(RED)

AOOAO21211:     DESCR = "2-1-2-1-1-input AND-OR-OR-AND-OR gate"
AOOAO21211:     AOOA2121
	$(POPCORN) -m pd -c $@ $< > $@
	$(RED)

AOOAOA21211:    DESCR = "2-1-2-1-1-input AND-OR-OR-AND-OR-AND gate"
AOOAOA21211:    AOOAO2121
	$(POPCORN) -m pu -c $@ $< > $@
	$(RED)

AOOOA2122:      DESCR = "2-1-2-2-input AND-OR-OR-OR-AND gate"
AOOOA2122:      AOOA2121
	$(POPCORN) -m nor -c $@ $< > $@
	$(RED)

OA23:           DESCR = "2-3-input OR-AND gate"
OA23:           OA22
	$(POPCORN) -m nand -c $@ $< > $@
	$(RED)

OA33:           DESCR = "3-3-input OR-AND gate"
OA33:           OA32
	$(POPCORN) -m nand -c $@ $< > $@
	$(RED)

OA41:           DESCR = "4-1-input OR-AND gate"
OA41:           OR4
	$(POPCORN) -m pu -c $@ $< > $@
	$(RED)

OA42:           DESCR = "4-2-input OR-AND gate"
OA42:           OA41
	$(POPCORN) -m nand -c $@ $< > $@
	$(RED)

OA43:           DESCR = "4-3-input OR-AND gate"
OA43:           OA42
	$(POPCORN) -m nand -c $@ $< > $@
	$(RED)

OAAO312:        DESCR = "3-1-2-input OR-AND-AND-OR gate"
OAAO312:        OAO311
	$(POPCORN) -m nand -c $@ $< > $@
	$(RED)

OAAO2121:       DESCR = "2-1-2-1-input OR-AND-AND-OR gate"
OAAO2121:       OAAO212
	$(POPCORN) -m pd -c $@ $< > $@
	$(RED)

OAO212:         DESCR = "2-1-2-input OR-AND-OR gate"
OAO212:         OAO211
	$(POPCORN) -m nor -c $@ $< > $@
	$(RED)

OAO222:         DESCR = "2-2-2-input OR-AND-OR gate"
OAO222:         OAO221
	$(POPCORN) -m nor -c $@ $< > $@
	$(RED)

OAO231:         DESCR = "2-3-1-input OR-AND-OR gate"
OAO231:         OA23
	$(POPCORN) -m pd -c $@ $< > $@
	$(RED)

OAO311:         DESCR = "3-1-1-input OR-AND-OR gate"
OAO311:         OA31
	$(POPCORN) -m pd -c $@ $< > $@
	$(RED)

OAO321:         DESCR = "3-2-1-input OR-AND-OR gate"
OAO321:         OA32
	$(POPCORN) -m pd -c $@ $< > $@
	$(RED)

OAOA2112:       DESCR = "2-1-1-2-input OR-AND-OR-AND gate"
OAOA2112:       OAOA2111
	$(POPCORN) -m nand -c $@ $< > $@
	$(RED)

OAOA2121:       DESCR = "2-1-2-1-input OR-AND-OR-AND gate"
OAOA2121:       OAO212
	$(POPCORN) -m pu -c $@ $< > $@
	$(RED)

OAOA2211:       DESCR = "2-2-1-1-input OR-AND-OR-AND gate"
OAOA2211:       OAO221
	$(POPCORN) -m pu -c $@ $< > $@
	$(RED)

OAOA3111:       DESCR = "3-1-1-1-input OR-AND-OR-AND gate"
OAOA3111:       OAO311
	$(POPCORN) -m pu -c $@ $< > $@
	$(RED)

OAOAO21111:     DESCR = "2-1-1-1-1-input OR-AND-OR-AND-OR gate"
OAOAO21111:     OAOA2111
	$(POPCORN) -m pd -c $@ $< > $@
	$(RED)

OOA42:          DESCR = "4-2-input OR-OR-AND gate"
OOA42:          OA41
	$(POPCORN) -m nor -c $@ $< > $@
	$(RED)

OOA43:          DESCR = "4-3-input OR-OR-AND gate"
OOA43:          OOA42
	$(POPCORN) -m nor -c $@ $< > $@
	$(RED)

OOA44:          DESCR = "4-4-input OR-OR-AND gate"
OOA44:          OOA43
	$(POPCORN) -m nor -c $@ $< > $@
	$(RED)

OOA222:         DESCR = "2-2-2-input OR-OR-AND gate"
OOA222:         OOA221
	$(POPCORN) -m nand -c $@ $< > $@
	$(RED)

OOAO222:        DESCR = "2-2-2-input OR-OR-AND-OR gate"
OOAO222:        OOAO221
	$(POPCORN) -m nor -c $@ $< > $@
	$(RED)

OOAO321:        DESCR = "3-2-1-input OR-OR-AND-OR gate"
OOAO321:        OOA32
	$(POPCORN) -m pd -c $@ $< > $@
	$(RED)

OR4:            DESCR = "4-input OR gate"
OR4:            OR3
	$(POPCORN) -m nor -c $@ $< > $@
	$(RED)

#   --------    now buffered    ------------------------------------

else
ifeq ($(BUFFER),4)

CELLS +=        AAAO2221 \
                AAO42 \
                AAO43 \
                AAO44 \
                AAO222 \
                AAO322 \
                AAOA222 \
                AAOA321 \
                AAOA331 \
                AAOA2212 \
                AAOA2221 \
                AAOA3211 \
                AAOAO2212 \
                AAOAO2221 \
                AAOAO3211 \
                AAOAO22111 \
                AAOAOA22111 \
                AAOOA322 \
                AAOOA2221 \
                AND4 \
                AO23 \
                AO33 \
                AO41 \
                AO42 \
                AO43 \
                AOA212 \
                AOA231 \
                AOA232 \
                AOA311 \
                AOA321 \
                AOAAO2122 \
                AOAAO3112 \
                AOAAO21112 \
                AOAAOA21121 \
                AOAO2112 \
                AOAO2121 \
                AOAO2122 \
                AOAO3111 \
                AOAO3112 \
                AOAO3211 \
                AOAOA21111 \
                AOAOA21121 \
                AOAOAO211111 \
                AOAOOA21112 \
                AOOA214 \
                AOOA232 \
                AOOA312 \
                AOOA313 \
                AOOA2121 \
                AOOA2131 \
                AOOAO2122 \
                AOOAO2131 \
                AOOAO3121 \
                AOOAO21211 \
                AOOAOA21211 \
                AOOOA2122 \
                OA23 \
                OA33 \
                OA41 \
                OA42 \
                OA43 \
                OAAO312 \
                OAAO2121 \
                OAO212 \
                OAO222 \
                OAO231 \
                OAO311 \
                OAO321 \
                OAOA2112 \
                OAOA2121 \
                OAOA2211 \
                OAOA3111 \
                OAOAO21111 \
                OOA42 \
                OOA43 \
                OOA44 \
                OOA222 \
                OOAO222 \
                OOAO321 \
                OR4

AAAO2221:       DESCR = "2-2-2-1-input AND-AND-AND-OR gate"
AAAO2221:       AAAOI222
	$(POPCORN) -m pd -c $@ $< > $@
	$(RED)

AAO42:          DESCR = "4-2-input AND-AND-OR gate"
AAO42:          AO41
	$(POPCORN) -m nand -c $@ $< > $@
	$(RED)

AAO43:          DESCR = "4-3-input AND-AND-OR gate"
AAO43:          AAO42
	$(POPCORN) -m nand -c $@ $< > $@
	$(RED)

AAO44:          DESCR = "4-4-input AND-AND-OR gate"
AAO44:          AAO43
	$(POPCORN) -m nand -c $@ $< > $@
	$(RED)

AAO222:         DESCR = "2-2-2-input AND-AND-OR gate"
AAO222:         AAOI221
	$(POPCORN) -m nor -c $@ $< > $@
	$(RED)

AAO322:         DESCR = "3-2-2-input AND-AND-OR gate"
AAO322:         AAOI321
	$(POPCORN) -m nor -c $@ $< > $@
	$(RED)

AAOA222:        DESCR = "2-2-2-input AND-AND-OR-AND gate"
AAOA222:        AAOAI221
	$(POPCORN) -m nand -c $@ $< > $@
	$(RED)

AAOA321:        DESCR = "3-2-1-input AND-AND-OR-AND gate"
AAOA321:        AAOI32
	$(POPCORN) -m pu -c $@ $< > $@
	$(RED)

AAOA331:        DESCR = "3-3-1-input AND-AND-OR-AND gate"
AAOA331:        AAOI33
	$(POPCORN) -m pu -c $@ $< > $@
	$(RED)

AAOA2212:       DESCR = "2-2-1-2-input AND-AND-OR-AND gate"
AAOA2212:       AAOAI2211
	$(POPCORN) -m nand -c $@ $< > $@
	$(RED)

AAOA2221:       DESCR = "2-2-2-1-input AND-AND-OR-AND gate"
AAOA2221:       AAO222
	$(POPCORN) -m pu -c $@ $< > $@
	$(RED)

AAOA3211:       DESCR = "3-2-1-1-input AND-AND-OR-AND gate"
AAOA3211:       AAOI321
	$(POPCORN) -m pu -c $@ $< > $@
	$(RED)

AAOAO2212:      DESCR = "2-2-1-2-input AND-AND-OR-AND-OR gate"
AAOAO2212:      AAOAOI2211
	$(POPCORN) -m nor -c $@ $< > $@
	$(RED)

AAOAO2221:      DESCR = "2-2-2-1-input AND-AND-OR-AND-OR gate"
AAOAO2221:      AAOA222
	$(POPCORN) -m pd -c $@ $< > $@
	$(RED)

AAOAO3211:      DESCR = "3-2-1-1-input AND-AND-OR-AND-OR gate"
AAOAO3211:      AAOA321
	$(POPCORN) -m pd -c $@ $< > $@
	$(RED)

AAOAO22111:     DESCR = "2-2-1-1-1-input AND-AND-OR-AND-OR gate"
AAOAO22111:     AAOAI2211
	$(POPCORN) -m pd -c $@ $< > $@
	$(RED)

AAOAOA22111:    DESCR = "2-2-1-1-1-input AND-AND-OR-AND-OR-AND gate"
AAOAOA22111:    AAOAOI2211
	$(POPCORN) -m pu -c $@ $< > $@
	$(RED)

AAOOA322:       DESCR = "3-2-2-input AND-AND-OR-OR-AND gate"
AAOOA322:       AAOA321
	$(POPCORN) -m nor -c $@ $< > $@
	$(RED)

AAOOA2221:      DESCR = "2-2-2-1-input AND-AND-OR-OR-AND gate"
AAOOA2221:      AAOOAI222
	$(POPCORN) -m pu -c $@ $< > $@
	$(RED)

AND4:           DESCR = "4-input AND gate"
AND4:           NAND3
	$(POPCORN) -m nand -c $@ $< > $@
	$(RED)

AO23:           DESCR = "2-3-input AND-OR gate"
AO23:           AOI22
	$(POPCORN) -m nor -c $@ $< > $@
	$(RED)

AO33:           DESCR = "3-3-input AND-OR gate"
AO33:           AOI32
	$(POPCORN) -m nor -c $@ $< > $@
	$(RED)

AO41:           DESCR = "4-1-input AND-OR gate"
AO41:           AND4
	$(POPCORN) -m pd -c $@ $< > $@
	$(RED)

AO42:           DESCR = "4-2-input AND-OR gate"
AO42:           AO41
	$(POPCORN) -m nor -c $@ $< > $@
	$(RED)

AO43:           DESCR = "4-2-input AND-OR gate"
AO43:           AO42
	$(POPCORN) -m nor -c $@ $< > $@
	$(RED)

AOA212:         DESCR = "2-1-2-input AND-OR-AND gate"
AOA212:         AOAI211
	$(POPCORN) -m nand -c $@ $< > $@
	$(RED)

AOA231:         DESCR = "2-3-1-input AND-OR-AND gate"
AOA231:         AO23
	$(POPCORN) -m pu -c $@ $< > $@
	$(RED)

AOA232:         DESCR = "2-3-2-input AND-OR-AND gate"
AOA232:         AOA231
	$(POPCORN) -m nand -c $@ $< > $@
	$(RED)

AOA311:         DESCR = "3-1-1-input AND-OR-AND gate"
AOA311:         AOI31
	$(POPCORN) -m pu -c $@ $< > $@
	$(RED)

AOA321:         DESCR = "3-2-1-input AND-OR-AND gate"
AOA321:         AOI32
	$(POPCORN) -m pu -c $@ $< > $@
	$(RED)

AOAAO2122:      DESCR = "2-1-2-2-input AND-OR-AND-AND-OR gate"
AOAAO2122:      AOAO2121
	$(POPCORN) -m nand -c $@ $< > $@
	$(RED)

AOAAO3112:      DESCR = "3-1-1-2-input AND-OR-AND-AND-OR gate"
AOAAO3112:      AOAO3111
	$(POPCORN) -m nand -c $@ $< > $@
	$(RED)

AOAAO21112:     DESCR = "2-1-1-1-2-input AND-OR-AND-AND-OR gate"
AOAAO21112:     AOAAOI2112
	$(POPCORN) -m pd -c $@ $< > $@
	$(RED)

AOAAOA21121:    DESCR = "2-1-1-2-1-input AND-OR-AND-AND-OR-AND gate"
AOAAOA21121:    AOAAOI2112
	$(POPCORN) -m pu -c $@ $< > $@
	$(RED)

AOAO2112:       DESCR = "2-1-1-2-input AND-OR-AND-OR gate"
AOAO2112:       AOAOI2111
	$(POPCORN) -m nor -c $@ $< > $@
	$(RED)

AOAO2121:       DESCR = "2-1-2-1-input AND-OR-AND-OR gate"
AOAO2121:       AOA212
	$(POPCORN) -m pd -c $@ $< > $@
	$(RED)

AOAO2122:       DESCR = "2-1-2-2-input AND-OR-AND-OR gate"
AOAO2122:       AOAO2121
	$(POPCORN) -m nor -c $@ $< > $@
	$(RED)

AOAO3111:       DESCR = "3-1-1-1-input AND-OR-AND-OR gate"
AOAO3111:       AOA311
	$(POPCORN) -m pd -c $@ $< > $@
	$(RED)

AOAO3112:       DESCR = "3-1-1-2-input AND-OR-AND-OR gate"
AOAO3112:       AOAO3111
	$(POPCORN) -m nor -c $@ $< > $@
	$(RED)

AOAOA21111:     DESCR = "2-1-1-1-1-input AND-OR-AND-OR-AND gate"
AOAOA21111:     AOAOI2111
	$(POPCORN) -m pu -c $@ $< > $@
	$(RED)

AOAOA21121:     DESCR = "2-1-1-2-1-input AND-OR-AND-OR-AND gate"
AOAOA21121:     AOAO2112
	$(POPCORN) -m pu -c $@ $< > $@
	$(RED)

AOAOAO211111:   DESCR = "2-1-1-1-1-1-input AND-OR-AND-OR-AND-OR gate"
AOAOAO211111:   AOAOA21111
	$(POPCORN) -m pd -c $@ $< > $@
	$(RED)

AOAOOA21112:    DESCR = "2-1-1-1-2-input AND-OR-AND-OR-OR-AND gate"
AOAOOA21112:    AOAOA21111
	$(POPCORN) -m nor -c $@ $< > $@
	$(RED)

AOOA214:        DESCR = "2-1-4-input AND-OR-OR-AND gate"
AOOA214:        AOAI213
	$(POPCORN) -m nor -c $@ $< > $@
	$(RED)

AOOA232:        DESCR = "2-3-2-input AND-OR-OR-AND gate"
AOOA232:        AOA231
	$(POPCORN) -m nor -c $@ $< > $@
	$(RED)

AOOA312:        DESCR = "3-1-2-input AND-OR-OR-AND gate"
AOOA312:        AOA311
	$(POPCORN) -m nor -c $@ $< > $@
	$(RED)

AOOA313:        DESCR = "3-1-3-input AND-OR-OR-AND gate"
AOOA313:        AOOA312
	$(POPCORN) -m nor -c $@ $< > $@
	$(RED)

AOOA2121:       DESCR = "2-1-2-1-input AND-OR-OR-AND gate"
AOOA2121:       AOOAI212
	$(POPCORN) -m pu -c $@ $< > $@
	$(RED)

AOOA2131:       DESCR = "2-1-3-1-input AND-OR-OR-AND gate"
AOOA2131:       AOOAI213
	$(POPCORN) -m pu -c $@ $< > $@
	$(RED)

AOOAO2122:      DESCR = "2-1-2-2-input AND-OR-OR-AND-OR gate"
AOOAO2122:      AOOAOI2121
	$(POPCORN) -m nor -c $@ $< > $@
	$(RED)

AOOAO2131:      DESCR = "2-1-3-1-input AND-OR-OR-AND-OR gate"
AOOAO2131:      AOOAI213
	$(POPCORN) -m pd -c $@ $< > $@
	$(RED)

AOOAO3121:      DESCR = "3-1-2-1-input AND-OR-OR-AND-OR gate"
AOOAO3121:      AOOA312
	$(POPCORN) -m pd -c $@ $< > $@
	$(RED)

AOOAO21211:     DESCR = "2-1-2-1-1-input AND-OR-OR-AND-OR gate"
AOOAO21211:     AOOA2121
	$(POPCORN) -m pd -c $@ $< > $@
	$(RED)

AOOAOA21211:    DESCR = "2-1-2-1-1-input AND-OR-OR-AND-OR-AND gate"
AOOAOA21211:    AOOAOI2121
	$(POPCORN) -m pu -c $@ $< > $@
	$(RED)

AOOOA2122:      DESCR = "2-1-2-2-input AND-OR-OR-OR-AND gate"
AOOOA2122:      AOOA2121
	$(POPCORN) -m nor -c $@ $< > $@
	$(RED)

OA23:           DESCR = "2-3-input OR-AND gate"
OA23:           OAI22
	$(POPCORN) -m nand -c $@ $< > $@
	$(RED)

OA33:           DESCR = "3-3-input OR-AND gate"
OA33:           OAI32
	$(POPCORN) -m nand -c $@ $< > $@
	$(RED)

OA41:           DESCR = "4-1-input OR-AND gate"
OA41:           OR4
	$(POPCORN) -m pu -c $@ $< > $@
	$(RED)

OA42:           DESCR = "4-2-input OR-AND gate"
OA42:           OA41
	$(POPCORN) -m nand -c $@ $< > $@
	$(RED)

OA43:           DESCR = "4-3-input OR-AND gate"
OA43:           OA42
	$(POPCORN) -m nand -c $@ $< > $@
	$(RED)

OAAO312:        DESCR = "3-1-2-input OR-AND-AND-OR gate"
OAAO312:        OAO311
	$(POPCORN) -m nand -c $@ $< > $@
	$(RED)

OAAO2121:       DESCR = "2-1-2-1-input OR-AND-AND-OR gate"
OAAO2121:       OAAOI212
	$(POPCORN) -m pd -c $@ $< > $@
	$(RED)

OAO212:         DESCR = "2-1-2-input OR-AND-OR gate"
OAO212:         OAOI211
	$(POPCORN) -m nor -c $@ $< > $@
	$(RED)

OAO222:         DESCR = "2-2-2-input OR-AND-OR gate"
OAO222:         OAOI221
	$(POPCORN) -m nor -c $@ $< > $@
	$(RED)

OAO231:         DESCR = "2-3-1-input OR-AND-OR gate"
OAO231:         OA23
	$(POPCORN) -m pd -c $@ $< > $@
	$(RED)
OAO311:         DESCR = "3-1-1-input OR-AND-OR gate"
OAO311:         OAI31
	$(POPCORN) -m pd -c $@ $< > $@
	$(RED)

OAO321:         DESCR = "3-2-1-input OR-AND-OR gate"
OAO321:         OAI32
	$(POPCORN) -m pd -c $@ $< > $@
	$(RED)

OAOA2112:       DESCR = "2-1-1-2-input OR-AND-OR-AND gate"
OAOA2112:       OAOAI2111
	$(POPCORN) -m nand -c $@ $< > $@
	$(RED)

OAOA2121:       DESCR = "2-1-2-1-input OR-AND-OR-AND gate"
OAOA2121:       OAO212
	$(POPCORN) -m pu -c $@ $< > $@
	$(RED)

OAOA2211:       DESCR = "2-2-1-1-input OR-AND-OR-AND gate"
OAOA2211:       OAOI221
	$(POPCORN) -m pu -c $@ $< > $@
	$(RED)

OAOA3111:       DESCR = "3-1-1-1-input OR-AND-OR-AND gate"
OAOA3111:       OAO311
	$(POPCORN) -m pu -c $@ $< > $@
	$(RED)

OAOAO21111:     DESCR = "2-1-1-1-1-input OR-AND-OR-AND-OR gate"
OAOAO21111:     OAOAI2111
	$(POPCORN) -m pd -c $@ $< > $@
	$(RED)

OOA42:          DESCR = "4-2-input OR-OR-AND gate"
OOA42:          OA41
	$(POPCORN) -m nor -c $@ $< > $@
	$(RED)

OOA43:          DESCR = "4-3-input OR-OR-AND gate"
OOA43:          OOA42
	$(POPCORN) -m nor -c $@ $< > $@
	$(RED)

OOA44:          DESCR = "4-4-input OR-OR-AND gate"
OOA44:          OOA43
	$(POPCORN) -m nor -c $@ $< > $@
	$(RED)

OOA222:         DESCR = "2-2-2-input OR-OR-AND gate"
OOA222:         OOAI221
	$(POPCORN) -m nand -c $@ $< > $@
	$(RED)

OOAO222:        DESCR = "2-2-2-input OR-OR-AND-OR gate"
OOAO222:        OOAOI221
	$(POPCORN) -m nor -c $@ $< > $@
	$(RED)

OOAO321:        DESCR = "3-2-1-input OR-OR-AND-OR gate"
OOAO321:        OOAI32
	$(POPCORN) -m pd -c $@ $< > $@
	$(RED)

OR4:            DESCR = "4-input OR gate"
OR4:            NOR3
	$(POPCORN) -m nor -c $@ $< > $@
	$(RED)

BUFFERED = true

#   --------    not buffered    ------------------------------------

else

CELLS +=        AAAOI2221 \
                AAOI42 \
                AAOI43 \
                AAOI44 \
                AAOI222 \
                AAOI322 \
                AAOAI222 \
                AAOAI321 \
                AAOAI331 \
                AAOAI2212 \
                AAOAI2221 \
                AAOAI3211 \
                AAOAOI2212 \
                AAOAOI2221 \
                AAOAOI3211 \
                AAOAOI22111 \
                AAOAOAI22111 \
                AAOOAI322 \
                AAOOAI2221 \
                AOI23 \
                AOI33 \
                AOI41 \
                AOI42 \
                AOI43 \
                AOAI212 \
                AOAI231 \
                AOAI232 \
                AOAI311 \
                AOAI321 \
                AOAAOI2122 \
                AOAAOI3112 \
                AOAAOI21112 \
                AOAAOAI21121 \
                AOAOI2112 \
                AOAOI2121 \
                AOAOI2122 \
                AOAOI3111 \
                AOAOI3112 \
                AOAOI3211 \
                AOAOAI21111 \
                AOAOAI21121 \
                AOAOAOI211111 \
                AOAOOAI21112 \
                AOOAI214 \
                AOOAI232 \
                AOOAI312 \
                AOOAI313 \
                AOOAI2121 \
                AOOAI2131 \
                AOOAOI2122 \
                AOOAOI2131 \
                AOOAOI3121 \
                AOOAOI21211 \
                AOOAOAI21211 \
                AOOOAI2122 \
                NAND4 \
                NOR4 \
                OAI23 \
                OAI33 \
                OAI41 \
                OAI42 \
                OAI43 \
                OAAOI312 \
                OAAOI2121 \
                OAOI212 \
                OAOI222 \
                OAOI231 \
                OAOI311 \
                OAOI321 \
                OAOAI2112 \
                OAOAI2121 \
                OAOAI2211 \
                OAOAI3111 \
                OAOAOI21111 \
                OOAI42 \
                OOAI43 \
                OOAI44 \
                OOAI222 \
                OOAOI222 \
                OOAOI321

AAAOI2221:      DESCR = "2-2-2-1-input AND-AND-AND-OR-Invert gate"
AAAOI2221:      AAAOI222
	$(POPCORN) -m pd -c $@ $< > $@
	$(RED)

AAOI42:         DESCR = "4-2-input AND-AND-OR-Invert gate"
AAOI42:         AOI41
	$(POPCORN) -m nand -c $@ $< > $@
	$(RED)

AAOI43:         DESCR = "4-3-input AND-AND-OR-Invert gate"
AAOI43:         AAOI42
	$(POPCORN) -m nand -c $@ $< > $@
	$(RED)

AAOI44:         DESCR = "4-4-input AND-AND-OR-Invert gate"
AAOI44:         AAOI43
	$(POPCORN) -m nand -c $@ $< > $@
	$(RED)

AAOI222:        DESCR = "2-2-2-input AND-AND-OR-Invert gate"
AAOI222:        AAOI221
	$(POPCORN) -m nor -c $@ $< > $@
	$(RED)

AAOI322:        DESCR = "3-2-2-input AND-AND-OR-Invert gate"
AAOI322:        AAOI321
	$(POPCORN) -m nor -c $@ $< > $@
	$(RED)

AAOAI222:       DESCR = "2-2-2-input AND-AND-OR-AND-Invert gate"
AAOAI222:       AAOAI221
	$(POPCORN) -m nand -c $@ $< > $@
	$(RED)

AAOAI321:       DESCR = "3-2-1-input AND-AND-OR-AND-Invert gate"
AAOAI321:       AAOI32
	$(POPCORN) -m pu -c $@ $< > $@
	$(RED)

AAOAI331:       DESCR = "3-3-1-input AND-AND-OR-AND-Invert gate"
AAOAI331:       AAOI33
	$(POPCORN) -m pu -c $@ $< > $@
	$(RED)

AAOAI2212:      DESCR = "2-2-1-2-input AND-AND-OR-AND-Invert gate"
AAOAI2212:      AAOAI2211
	$(POPCORN) -m nand -c $@ $< > $@
	$(RED)

AAOAI2221:      DESCR = "2-2-2-1-input AND-AND-OR-AND-Invert gate"
AAOAI2221:      AAOI222
	$(POPCORN) -m pu -c $@ $< > $@
	$(RED)

AAOAI3211:      DESCR = "3-2-1-1-input AND-AND-OR-AND-Invert gate"
AAOAI3211:      AAOI321
	$(POPCORN) -m pu -c $@ $< > $@
	$(RED)

AAOAOI2212:     DESCR = "2-2-1-2-input AND-AND-OR-AND-OR-Invert gate"
AAOAOI2212:     AAOAOI2211
	$(POPCORN) -m nor -c $@ $< > $@
	$(RED)

AAOAOI2221:     DESCR = "2-2-2-1-input AND-AND-OR-AND-OR-Invert gate"
AAOAOI2221:     AAOAI222
	$(POPCORN) -m pd -c $@ $< > $@
	$(RED)

AAOAOI3211:     DESCR = "3-2-1-1-input AND-AND-OR-AND-OR-Invert gate"
AAOAOI3211:     AAOAI321
	$(POPCORN) -m pd -c $@ $< > $@
	$(RED)

AAOAOI22111:    DESCR = "2-2-1-1-1-input AND-AND-OR-AND-OR-Invert gate"
AAOAOI22111:    AAOAI2211
	$(POPCORN) -m pd -c $@ $< > $@
	$(RED)

AAOAOAI22111:   DESCR = "2-2-1-1-1-input AND-AND-OR-AND-OR-AND-Invert gate"
AAOAOAI22111:   AAOAOI2211
	$(POPCORN) -m pu -c $@ $< > $@
	$(RED)

AAOOAI322:      DESCR = "3-2-2-input AND-AND-OR-OR-AND-Invert gate"
AAOOAI322:      AAOAI321
	$(POPCORN) -m nor -c $@ $< > $@
	$(RED)

AAOOAI2221:     DESCR = "2-2-2-1-input AND-AND-OR-OR-AND-Invert gate"
AAOOAI2221:     AAOOAI222
	$(POPCORN) -m pu -c $@ $< > $@
	$(RED)

AOI23:          DESCR = "2-3-input AND-OR-Invert gate"
AOI23:          AOI22
	$(POPCORN) -m nor -c $@ $< > $@
	$(RED)

AOI33:          DESCR = "3-3-input AND-OR-Invert gate"
AOI33:          AOI32
	$(POPCORN) -m nor -c $@ $< > $@
	$(RED)

AOI41:          DESCR = "4-1-input AND-OR-Invert gate"
AOI41:          NAND4
	$(POPCORN) -m pd -c $@ $< > $@
	$(RED)

AOI42:          DESCR = "4-2-input AND-OR-Invert gate"
AOI42:          AOI41
	$(POPCORN) -m nor -c $@ $< > $@
	$(RED)

AOI43:          DESCR = "4-3-input AND-OR-Invert gate"
AOI43:          AOI42
	$(POPCORN) -m nor -c $@ $< > $@
	$(RED)

AOAI212:        DESCR = "2-1-2-input AND-OR-AND-Invert gate"
AOAI212:        AOAI211
	$(POPCORN) -m nand -c $@ $< > $@
	$(RED)

AOAI231:        DESCR = "2-3-1-input AND-OR-AND-Invert gate"
AOAI231:        AOI23
	$(POPCORN) -m pu -c $@ $< > $@
	$(RED)

AOAI232:        DESCR = "2-3-2-input AND-OR-AND-Invert gate"
AOAI232:        AOAI231
	$(POPCORN) -m nand -c $@ $< > $@
	$(RED)

AOAI311:        DESCR = "3-1-1-input AND-OR-AND-Invert gate"
AOAI311:        AOI31
	$(POPCORN) -m pu -c $@ $< > $@
	$(RED)

AOAI321:        DESCR = "3-2-1-input AND-OR-AND-Invert gate"
AOAI321:        AOI32
	$(POPCORN) -m pu -c $@ $< > $@
	$(RED)

AOAAOI2122:     DESCR = "2-1-2-2-input AND-OR-AND-AND-OR-Invert gate"
AOAAOI2122:     AOAOI2121
	$(POPCORN) -m nand -c $@ $< > $@
	$(RED)

AOAAOI3112:     DESCR = "3-1-1-2-input AND-OR-AND-AND-OR-Invert gate"
AOAAOI3112:     AOAOI3111
	$(POPCORN) -m nand -c $@ $< > $@
	$(RED)

AOAAOI21112:    DESCR = "2-1-1-1-2-input AND-OR-AND-AND-OR-Invert gate"
AOAAOI21112:    AOAAOI2112
	$(POPCORN) -m pd -c $@ $< > $@
	$(RED)

AOAAOAI21121:   DESCR = "2-1-1-2-1-input AND-OR-AND-AND-OR-AND-Invert gate"
AOAAOAI21121:   AOAAOI2112
	$(POPCORN) -m pu -c $@ $< > $@
	$(RED)

AOAOI2112:      DESCR = "2-1-1-2-input AND-OR-AND-OR-Invert gate"
AOAOI2112:      AOAOI2111
	$(POPCORN) -m nor -c $@ $< > $@
	$(RED)

AOAOI2121:      DESCR = "2-1-2-1-input AND-OR-AND-OR-Invert gate"
AOAOI2121:      AOAI212
	$(POPCORN) -m pd -c $@ $< > $@
	$(RED)

AOAOI2122:      DESCR = "2-1-2-2-input AND-OR-AND-OR-Invert gate"
AOAOI2122:      AOAOI2121
	$(POPCORN) -m nor -c $@ $< > $@
	$(RED)

AOAOI3111:      DESCR = "3-1-1-1-input AND-OR-AND-OR-Invert gate"
AOAOI3111:      AOAI311
	$(POPCORN) -m pd -c $@ $< > $@
	$(RED)

AOAOI3112:      DESCR = "3-1-1-2-input AND-OR-AND-OR-Invert gate"
AOAOI3112:      AOAOI3111
	$(POPCORN) -m nor -c $@ $< > $@
	$(RED)

AOAOI3211:      DESCR = "3-2-1-1-input AND-OR-AND-OR-Invert gate"
AOAOI3211:      AOAI321
	$(POPCORN) -m pd -c $@ $< > $@
	$(RED)

AOAOAI21111:    DESCR = "2-1-1-1-1-input AND-OR-AND-OR-AND-Invert gate"
AOAOAI21111:    AOAOI2111
	$(POPCORN) -m pu -c $@ $< > $@
	$(RED)

AOAOAI21121:    DESCR = "2-1-1-2-1-input AND-OR-AND-OR-AND-Invert gate"
AOAOAI21121:    AOAOI2112
	$(POPCORN) -m pu -c $@ $< > $@
	$(RED)

AOAOAOI211111:  DESCR = "2-1-1-1-1-1-input AND-OR-AND-OR-AND-OR-Invert gate"
AOAOAOI211111:  AOAOAI21111
	$(POPCORN) -m pd -c $@ $< > $@
	$(RED)

AOAOOAI21112:   DESCR = "2-1-1-1-2-input AND-OR-AND-OR-OR-AND-Invert gate"
AOAOOAI21112:   AOAOAI21111
	$(POPCORN) -m nor -c $@ $< > $@
	$(RED)

AOOAI214:       DESCR = "2-1-4-input AND-OR-OR-AND-Invert gate"
AOOAI214:       AOAI213
	$(POPCORN) -m nor -c $@ $< > $@
	$(RED)

AOOAI232:       DESCR = "2-3-2-input AND-OR-OR-AND-Invert gate"
AOOAI232:       AOAI231
	$(POPCORN) -m nor -c $@ $< > $@
	$(RED)

AOOAI312:       DESCR = "3-1-2-input AND-OR-OR-AND-Invert gate"
AOOAI312:       AOAI311
	$(POPCORN) -m nor -c $@ $< > $@
	$(RED)

AOOAI313:       DESCR = "3-1-3-input AND-OR-OR-AND-Invert gate"
AOOAI313:       AOOAI312
	$(POPCORN) -m nor -c $@ $< > $@
	$(RED)

AOOAI2121:      DESCR = "2-1-2-1-input AND-OR-OR-AND-Invert gate"
AOOAI2121:      AOOAI212
	$(POPCORN) -m pu -c $@ $< > $@
	$(RED)

AOOAI2131:      DESCR = "2-1-3-1-input AND-OR-OR-AND-Invert gate"
AOOAI2131:      AOOAI213
	$(POPCORN) -m pu -c $@ $< > $@
	$(RED)

AOOAOI2122:     DESCR = "2-1-2-2-input AND-OR-OR-AND-OR-Invert gate"
AOOAOI2122:     AOOAOI2121
	$(POPCORN) -m nor -c $@ $< > $@
	$(RED)

AOOAOI2131:     DESCR = "2-1-3-1-input AND-OR-OR-AND-OR-Invert gate"
AOOAOI2131:     AOOAI213
	$(POPCORN) -m pd -c $@ $< > $@
	$(RED)

AOOAOI3121:     DESCR = "3-1-2-1-input AND-OR-OR-AND-OR-Invert gate"
AOOAOI3121:     AOOAI312
	$(POPCORN) -m pd -c $@ $< > $@
	$(RED)

AOOAOI21211:    DESCR = "2-1-2-1-1-input AND-OR-OR-AND-OR-Invert gate"
AOOAOI21211:    AOOAI2121
	$(POPCORN) -m pd -c $@ $< > $@
	$(RED)

AOOAOAI21211:   DESCR = "2-1-2-1-1-input AND-OR-OR-AND-OR-AND-Invert gate"
AOOAOAI21211:   AOOAOI2121
	$(POPCORN) -m pu -c $@ $< > $@
	$(RED)

AOOOAI2122:     DESCR = "2-1-2-2-input AND-OR-OR-OR-AND-Invert gate"
AOOOAI2122:     AOOAI2121
	$(POPCORN) -m nor -c $@ $< > $@
	$(RED)

NAND4:          DESCR = "4-input Not-AND (or NAND) gate"
NAND4:          NAND3
	$(POPCORN) -m nand -c $@ $< > $@
	$(RED)

NOR4:           DESCR = "4-input Not-OR (or NOR) gate"
NOR4:           NOR3
	$(POPCORN) -m nor -c $@ $< > $@
	$(RED)

OAI23:          DESCR = "2-3-input OR-AND-Invert gate"
OAI23:          OAI22
	$(POPCORN) -m nand -c $@ $< > $@
	$(RED)

OAI33:          DESCR = "3-3-input OR-AND-Invert gate"
OAI33:          OAI32
	$(POPCORN) -m nand -c $@ $< > $@
	$(RED)

OAI41:          DESCR = "4-1-input OR-AND-Invert gate"
OAI41:          NOR4
	$(POPCORN) -m pu -c $@ $< > $@
	$(RED)

OAI42:          DESCR = "4-2-input OR-AND-Invert gate"
OAI42:          OAI41
	$(POPCORN) -m nand -c $@ $< > $@
	$(RED)

OAI43:          DESCR = "4-3-input OR-AND-Invert gate"
OAI43:          OAI42
	$(POPCORN) -m nand -c $@ $< > $@
	$(RED)

OAAOI312:       DESCR = "3-1-2-input OR-AND-AND-OR-Invert gate"
OAAOI312:       OAOI311
	$(POPCORN) -m nand -c $@ $< > $@
	$(RED)

OAAOI2121:      DESCR = "2-1-2-1-input OR-AND-AND-OR-Invert gate"
OAAOI2121:      OAAOI212
	$(POPCORN) -m pd -c $@ $< > $@
	$(RED)

OAOI212:        DESCR = "2-1-2-input OR-AND-OR-Invert gate"
OAOI212:        OAOI211
	$(POPCORN) -m nor -c $@ $< > $@
	$(RED)

OAOI222:        DESCR = "2-2-2-input OR-AND-OR-Invert gate"
OAOI222:        OAOI221
	$(POPCORN) -m nor -c $@ $< > $@
	$(RED)

OAOI231:        DESCR = "2-3-1-input OR-AND-OR-Invert gate"
OAOI231:        OAI23
	$(POPCORN) -m pd -c $@ $< > $@
	$(RED)

OAOI311:        DESCR = "3-1-1-input OR-AND-OR-Invert gate"
OAOI311:        OAI31
	$(POPCORN) -m pd -c $@ $< > $@
	$(RED)

OAOI321:        DESCR = "3-2-1-input OR-AND-OR-Invert gate"
OAOI321:        OAI32
	$(POPCORN) -m pd -c $@ $< > $@
	$(RED)

OAOAI2112:      DESCR = "2-1-1-2-input OR-AND-OR-AND-Invert gate"
OAOAI2112:      OAOAI2111
	$(POPCORN) -m nand -c $@ $< > $@
	$(RED)

OAOAI2121:      DESCR = "2-1-2-1-input OR-AND-OR-AND-Invert gate"
OAOAI2121:      OAOI212
	$(POPCORN) -m pu -c $@ $< > $@
	$(RED)

OAOAI2211:      DESCR = "2-2-1-1-input OR-AND-OR-AND-Invert gate"
OAOAI2211:      OAOI221
	$(POPCORN) -m pu -c $@ $< > $@
	$(RED)

OAOAI3111:      DESCR = "3-1-1-1-input OR-AND-OR-AND-Invert gate"
OAOAI3111:      OAOI311
	$(POPCORN) -m pu -c $@ $< > $@
	$(RED)

OAOAOI21111:    DESCR = "2-1-1-1-1-input OR-AND-OR-AND-OR-Invert gate"
OAOAOI21111:    OAOAI2111
	$(POPCORN) -m pd -c $@ $< > $@
	$(RED)

OOAI42:         DESCR = "4-2-input OR-OR-AND-Invert gate"
OOAI42:         OAI41
	$(POPCORN) -m nor -c $@ $< > $@
	$(RED)

OOAI43:         DESCR = "4-3-input OR-OR-AND-Invert gate"
OOAI43:         OOAI42
	$(POPCORN) -m nor -c $@ $< > $@
	$(RED)

OOAI44:         DESCR = "4-4-input OR-OR-AND-Invert gate"
OOAI44:         OOAI43
	$(POPCORN) -m nor -c $@ $< > $@
	$(RED)

OOAI222:        DESCR = "2-2-2-input OR-OR-AND-Invert gate"
OOAI222:        OOAI221
	$(POPCORN) -m nand -c $@ $< > $@
	$(RED)

OOAOI222:       DESCR = "2-2-2-input OR-OR-AND-OR-Invert gate"
OOAOI222:       OOAOI221
	$(POPCORN) -m nor -c $@ $< > $@
	$(RED)

OOAOI321:       DESCR = "3-2-1-input OR-OR-AND-OR-Invert gate"
OOAOI321:       OOAI32
	$(POPCORN) -m pd -c $@ $< > $@
	$(RED)

endif
endif
