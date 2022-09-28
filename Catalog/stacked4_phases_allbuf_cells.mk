#   ************    LibreSilicon's StdCellLibrary   ****************
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
#   File:           StdCellLib/Catalog/stacked4_phases_allbuf_cells.mk
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

#   Dependencies for cells with 4 stacked transistors and X phases,
#   which are all well buffered.

#   ----------------------------------------------------------------
#               CELL TARGETS - already buffered
#   ----------------------------------------------------------------

#   --------    one phase   ----------------------------------------

CELLS +=        AND4 OR4

AND4:           DESCR = "4-input AND gate"
AND4:           AND3
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

OR4:            DESCR = "4-input OR gate"
OR4:            OR3
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

#   --------    two phases  ----------------------------------------

CELLS +=        AO23 OA23 \
                AO33 OA33 \
                AO41 OA41 \
                AO42 OA42 \
                AO43 OA43 \
                AAO42 OOA42 \
                AAO43 OOA43 \
                AAO44 OOA44 \
                AAO222 OOA222 \
                AAO322 OOA322 \
                AAO332 OOA332 \
                AAO421 OOA421 \
                       OOA422 \
                       OOA431 \
                       OOOA422 \
                AAAO2221 OOOA2221 \
                AAAO3221 OOOA3221 \
                AAAO3222 \
                AAAO3321 OOOA3321 \
                AAAO3331 OOOA3331 \
                AAAAO2222 OOOOA2222

AO23:           DESCR = "2-3-input AND-OR gate"
AO23:           AO22
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

OA23:           DESCR = "2-3-input OR-AND gate"
OA23:           OA22
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

AO33:           DESCR = "3-3-input AND-OR gate"
AO33:           AO32
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

OA33:           DESCR = "3-3-input OR-AND gate"
OA33:           OA32
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

AO41:           DESCR = "4-1-input AND-OR gate"
AO41:           AND4
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

OA41:           DESCR = "4-1-input OR-AND gate"
OA41:           OR4
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

AO42:           DESCR = "4-2-input AND-OR gate"
AO42:           AO41
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

OA42:           DESCR = "4-2-input OR-AND gate"
OA42:           OA41
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

AO43:           DESCR = "4-2-input AND-OR gate"
AO43:           AO42
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

OA43:           DESCR = "4-3-input OR-AND gate"
OA43:           OA42
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

AAO42:          DESCR = "4-2-input AND-AND-OR gate"
AAO42:          AO41
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

OOA42:          DESCR = "4-2-input OR-OR-AND gate"
OOA42:          OA41
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

AAO43:          DESCR = "4-3-input AND-AND-OR gate"
AAO43:          AAO42
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

OOA43:          DESCR = "4-3-input OR-OR-AND gate"
OOA43:          OOA42
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

AAO44:          DESCR = "4-4-input AND-AND-OR gate"
AAO44:          AAO43
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

OOA44:          DESCR = "4-4-input OR-OR-AND gate"
OOA44:          OOA43
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

AAO222:         DESCR = "2-2-2-input AND-AND-OR gate"
AAO222:         AAO221
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

OOA222:         DESCR = "2-2-2-input OR-OR-AND gate"
OOA222:         OOA221
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

AAO322:         DESCR = "3-2-2-input AND-AND-OR gate"
AAO322:         AAO321
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

OOA322:         DESCR = "3-2-2-input OR-OR-AND gate"
OOA322:         OOA321
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

AAO332:         DESCR = "3-3-2-input AND-AND-OR gate"
AAO332:         AAO331
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

OOA332:         DESCR = "3-3-2-input OR-OR-AND gate"
OOA332:         OOA331
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

AAO421:         DESCR = "4-2-1-input AND-AND-OR gate"
AAO421:         AAO42
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

OOA421:         DESCR = "4-2-1-input OR-OR-AND gate"
OOA421:         OOA42
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

OOA422:         DESCR = "4-2-2-input OR-OR-AND gate"
OOA422:         OOA421
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

OOA431:         DESCR = "4-3-1-input OR-OR-AND gate"
OOA431:         OOA43
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

OOOA422:        DESCR = "4-2-2-input OR-OR-OR-AND gate"
OOOA422:        OOA421
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

AAAO2221:       DESCR = "2-2-2-1-input AND-AND-AND-OR gate"
AAAO2221:       AAAO222
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

OOOA2221:       DESCR = "2-2-2-1-input OR-OR-OR-AND gate"
OOOA2221:       OOOA222
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

AAAO3221:       DESCR = "3-2-2-1-input AND-AND-AND-OR gate"
AAAO3221:       AAAO322
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

OOOA3221:       DESCR = "3-2-2-1-input OR-OR-OR-AND gate"
OOOA3221:       OOOA322
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

AAAO3222:       DESCR = "3-2-2-2-input AND-AND-AND-OR gate"
AAAO3222:       AAAO3221
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

AAAO3321:       DESCR = "3-3-2-1-input AND-AND-AND-OR gate"
AAAO3321:       AAAO332
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

OOOA3321:       DESCR = "3-3-2-1-input OR-OR-OR-AND gate"
OOOA3321:       OOOA332
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

AAAO3331:       DESCR = "3-3-3-1-input AND-AND-AND-OR gate"
AAAO3331:       AAAO333
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

OOOA3331:       DESCR = "3-3-3-1-input OR-OR-OR-AND gate"
OOOA3331:       OOOA333
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

AAAAO2222:       DESCR = "2-2-2-2-input AND-AND-AND-AND-OR gate"
AAAAO2222:       AAAO2221
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

OOOOA2222:       DESCR = "2-2-2-2-input OR-OR-OR-OR-AND gate"
OOOOA2222:       OOOA2221
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

#   --------    three phases    ------------------------------------

CELLS +=        AOA212 OAO212 \
                AOA222 OAO222 \
                AOA231 OAO231 \
                AOA232 OAO232 \
                AOA311 OAO311 \
                AOA321 OAO321 \
                AOA331 \
                AAOA222 OOAO222 \
                AAOA321 OOAO321 \
                AAOA331 OOAO331 \
                AOOA214 OAAO214 \
                        OAAO224 \
                AOOA232 OAAO232 \
                AOOA233 OAAO233 \
                AOOA312 OAAO312 \
                AOOA313 OAAO313 \
                AOOA314 OAAO314 \
                AOOA322 OAAO322 \
                AOOA323 OAAO323 \
                AOOA332 \
                AAOA2212 OOAO2212 \
                AAOA2221 OOAO2221 \
                AAOA2222 OOAO2222 \
                AAOA3211 OOAO3211 \
                AAOA3221 OOAO3221 \
                AAOA3311 OOAO3311 \
                AAOA3321 \
                AOOA2121 OAAO2121 \
                AOOA2131 OAAO2131 \
                AOOA2141 OAAO2141 \
                AOOA2221 OAAO2221 \
                         OAAO2231 \
                AOOA2321 \
                AAOOA224 OOAAO224 \
                AAOOA322 OOAAO322 \
                AAOOA323 OOAAO323 \
                AAOOA332 OOAAO332 \
                AAAOA2222 OOOAO2222 \
                AAAOA3221 OOOAO3221 \
                AAAOA3321 OOOAO3321 \
                AAAOA3331 OOOAO3331 \
                AAOOA2214 OOAAO2214 \
                AAOOA2221 OOAAO2221 \
                AAOOA2222 OOAAO2222 \
                AAOOA2231 OOAAO2231 \
                AAOOA2241 \
                AAOOA3212 OOAAO3212 \
                AAOOA3312 \
                AOOOA2122 OAAAO2122 \
                AOOOA2132 OAAAO2132 \
                          OAAAO2222 \
                           OOOAAO2224 \
                AAAOA22211 \
                AAAOA32211 \
                AAOOA22121 OOAAO22121 \
                AAOOA22131 OOAAO22131 \
                AAOOOA2222 OOAAAO2222 \
                AAOOOA2232 \
                AAAOOA2224 \
                AAAOOA3222 \
                AAAOOA22221 OOOAAO22221 \
                AAAOOA22231 OOOAAO22231 \
                AAOOOA22122

AOA212:         DESCR = "2-1-2-input AND-OR-AND gate"
AOA212:         AOA211
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

OAO212:         DESCR = "2-1-2-input OR-AND-OR gate"
OAO212:         OAO211
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

AOA222:         DESCR = "2-2-2-input AND-OR-AND gate"
AOA222:         AOA221
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

OAO222:         DESCR = "2-2-2-input OR-AND-OR gate"
OAO222:         OAO221
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

AOA231:         DESCR = "2-3-1-input AND-OR-AND gate"
AOA231:         AO23
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

OAO231:         DESCR = "2-3-1-input OR-AND-OR gate"
OAO231:         OA23
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

AOA232:         DESCR = "2-3-2-input AND-OR-AND gate"
AOA232:         AOA231
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

OAO232:         DESCR = "2-3-2-input OR-AND-OR gate"
OAO232:         OAO231
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

AOA311:         DESCR = "3-1-1-input AND-OR-AND gate"
AOA311:         AO31
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

OAO311:         DESCR = "3-1-1-input OR-AND-OR gate"
OAO311:         OA31
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

AOA321:         DESCR = "3-2-1-input AND-OR-AND gate"
AOA321:         AO32
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

OAO321:         DESCR = "3-2-1-input OR-AND-OR gate"
OAO321:         OA32
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

AOA331:         DESCR = "3-3-1-input AND-OR-AND gate"
AOA331:         AO33
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

AAOA222:        DESCR = "2-2-2-input AND-AND-OR-AND gate"
AAOA222:        AAOA221
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

OOAO222:        DESCR = "2-2-2-input OR-OR-AND-OR gate"
OOAO222:        OOAO221
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

AAOA321:        DESCR = "3-2-1-input AND-AND-OR-AND gate"
AAOA321:        AAO32
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

OOAO321:        DESCR = "3-2-1-input OR-OR-AND-OR gate"
OOAO321:        OOA32
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

AAOA331:        DESCR = "3-3-1-input AND-AND-OR-AND gate"
AAOA331:        AAO33
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

OOAO331:        DESCR = "3-3-1-input OR-OR-AND-OR gate"
OOAO331:        OOA33
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

AOOA214:        DESCR = "2-1-4-input AND-OR-OR-AND gate"
AOOA214:        AOOA213
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

OAAO214:        DESCR = "2-1-4-input OR-AND-AND-OR gate"
OAAO214:        OAAO213
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

OAAO224:        DESCR = "2-2-4-input OR-AND-AND-OR gate"
OAAO224:        OAAO223
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

AOOA232:        DESCR = "2-3-2-input AND-OR-OR-AND gate"
AOOA232:        AOA231
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

OAAO232:        DESCR = "2-3-2-input OR-AND-AND-OR gate"
OAAO232:        OAO231
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

AOOA233:        DESCR = "2-3-3-input AND-OR-OR-AND gate"
AOOA233:        AOOA232
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

OAAO233:        DESCR = "2-3-3-input OR-AND-AND-OR gate"
OAAO233:        OAAO232
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

AOOA312:        DESCR = "3-1-2-input AND-OR-OR-AND gate"
AOOA312:        AOA311
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

OAAO312:        DESCR = "3-1-2-input OR-AND-AND-OR gate"
OAAO312:        OAO311
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

AOOA313:        DESCR = "3-1-3-input AND-OR-OR-AND gate"
AOOA313:        AOOA312
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

OAAO313:        DESCR = "3-1-3-input OR-AND-AND-OR gate"
OAAO313:        OAAO312
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

AOOA314:        DESCR = "3-1-4-input AND-OR-OR-AND gate"
AOOA314:        AOOA313
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

OAAO314:        DESCR = "3-1-4-input OR-AND-AND-OR gate"
OAAO314:        OAAO313
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

AOOA322:        DESCR = "3-2-2-input AND-OR-OR-AND gate"
AOOA322:        AOA321
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

OAAO322:        DESCR = "3-2-2-input OR-AND-AND-OR gate"
OAAO322:        OAO321
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

AOOA323:        DESCR = "3-2-3-input AND-OR-OR-AND gate"
AOOA323:        AOOA322
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

OAAO323:        DESCR = "3-2-3-input OR-AND-AND-OR gate"
OAAO323:        OAAO322
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

AOOA332:        DESCR = "3-2-3-input AND-OR-OR-AND gate"
AOOA332:        AOA331
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

AAOA2212:       DESCR = "2-2-1-2-input AND-AND-OR-AND gate"
AAOA2212:       AAOA2211
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

OOAO2212:       DESCR = "2-2-1-2-input OR-OR-AND-OR gate"
OOAO2212:       OOAO2211
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

AAOA2221:       DESCR = "2-2-2-1-input AND-AND-OR-AND gate"
AAOA2221:       AAO222
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

OOAO2221:       DESCR = "2-2-2-1-input OR-OR-AND-OR gate"
OOAO2221:       OOA222
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

AAOA2222:       DESCR = "2-2-2-2-input AND-AND-OR-AND gate"
AAOA2222:       AAOA2221
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

OOAO2222:       DESCR = "2-2-2-2-input OR-OR-AND-OR gate"
OOAO2222:       OOAO2221
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

AAOA3211:       DESCR = "3-2-1-1-input AND-AND-OR-AND gate"
AAOA3211:       AAO321
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

OOAO3211:       DESCR = "3-2-1-1-input OR-OR-AND-OR gate"
OOAO3211:       OOA321
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

AAOA3221:       DESCR = "3-2-2-1-input AND-AND-OR-AND gate"
AAOA3221:       AAO322
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

OOAO3221:       DESCR = "3-2-2-1-input OR-OR-AND-OR gate"
OOAO3221:       OOA322
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

AAOA3311:       DESCR = "3-3-1-1-input AND-AND-OR-AND gate"
AAOA3311:       AAO331
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

OOAO3311:       DESCR = "3-3-1-1-input OR-OR-AND-OR gate"
OOAO3311:       OOA331
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

AAOA3321:       DESCR = "3-3-2-1-input AND-AND-OR-AND gate"
AAOA3321:       AAO332
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

AOOA2121:       DESCR = "2-1-2-1-input AND-OR-OR-AND gate"
AOOA2121:       AOOA212
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

OAAO2121:       DESCR = "2-1-2-1-input OR-AND-AND-OR gate"
OAAO2121:       OAAO212
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

AOOA2131:       DESCR = "2-1-3-1-input AND-OR-OR-AND gate"
AOOA2131:       AOOA213
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

OAAO2131:       DESCR = "2-1-3-1-input OR-AND-AND-OR gate"
OAAO2131:       OAAO213
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

AOOA2141:       DESCR = "2-1-4-1-input AND-OR-OR-AND gate"
AOOA2141:       AOOA214
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

OAAO2141:       DESCR = "2-1-4-1-input OR-AND-AND-OR gate"
OAAO2141:       OAAO214
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

AOOA2221:       DESCR = "2-2-2-1-input AND-OR-OR-AND gate"
AOOA2221:       AOOA222
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

OAAO2221:       DESCR = "2-2-2-1-input OR-AND-AND-OR gate"
OAAO2221:       OAAO222
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

OAAO2231:       DESCR = "2-2-3-1-input OR-AND-AND-OR gate"
OAAO2231:       OAAO223
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

AOOA2321:       DESCR = "2-3-2-1-input AND-OR-OR-AND gate"
AOOA2321:       AOOA232
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

AAOOA224:       DESCR = "2-2-4-input AND-AND-OR-OR-AND gate"
AAOOA224:       AAOOA223
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

OOAAO224:       DESCR = "2-2-4-input OR-OR-AND-AND-OR gate"
OOAAO224:       OOAAO223
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

AAOOA322:       DESCR = "3-2-2-input AND-AND-OR-OR-AND gate"
AAOOA322:       AAOA321
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

OOAAO322:       DESCR = "3-2-2-input OR-OR-AND-AND-OR gate"
OOAAO322:       OOAO321
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

AAOOA323:       DESCR = "3-2-3-input AND-AND-OR-OR-AND gate"
AAOOA323:       AAOOA322
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

OOAAO323:       DESCR = "3-2-3-input OR-OR-AND-AND-OR gate"
OOAAO323:       OOAAO322
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

AAOOA332:       DESCR = "3-3-2-input AND-AND-OR-OR-AND gate"
AAOOA332:       AAOA331
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

OOAAO332:       DESCR = "3-3-2-input OR-OR-AND-AND-OR gate"
OOAAO332:       OOAO331
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

AAAOA2222:      DESCR = "2-2-2-2-input AND-AND-AND-OR-AND gate"
AAAOA2222:      AAAOA2221
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

OOOAO2222:      DESCR = "2-2-2-2-input OR-OR-OR-AND-OR gate"
OOOAO2222:      OOOAO2221
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

AAAOA3221:      DESCR = "3-2-2-1-input AND-AND-AND-OR-AND gate"
AAAOA3221:      AAAO322
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

OOOAO3221:      DESCR = "3-2-2-1-input OR-OR-OR-AND-OR gate"
OOOAO3221:      OOOA322
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

AAAOA3321:      DESCR = "3-3-2-1-input AND-AND-AND-OR-AND gate"
AAAOA3321:      AAAO332
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

AAAOA3331:      DESCR = "3-3-3-1-input AND-AND-AND-OR-AND gate"
AAAOA3331:      AAAO333
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

OOOAO3331:      DESCR = "3-3-3-1-input OR-OR-OR-AND-OR gate"
OOOAO3331:      OOOA333
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

OOOAO3321:      DESCR = "3-3-2-1-input OR-OR-OR-AND-OR gate"
OOOAO3321:      OOOA332
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

AAOOA2214:      DESCR = "2-2-1-4-input AND-AND-OR-OR-AND gate"
AAOOA2214:      AAOOA2213
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

OOAAO2214:      DESCR = "2-2-1-4-input OR-OR-AND-AND-OR gate"
OOAAO2214:      OOAAO2213
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

AAOOA2221:      DESCR = "2-2-2-1-input AND-AND-OR-OR-AND gate"
AAOOA2221:      AAOOA222
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

OOAAO2221:      DESCR = "2-2-2-1-input OR-OR-AND-AND-OR gate"
OOAAO2221:      OOAAO222
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

AAOOA2222:      DESCR = "2-2-2-2-input AND-AND-OR-OR-AND gate"
AAOOA2222:      AAOOA2221
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

OOAAO2222:      DESCR = "2-2-2-2-input OR-OR-AND-AND-OR gate"
OOAAO2222:      OOAO2221
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

AAOOA2231:      DESCR = "2-2-3-1-input AND-AND-OR-OR-AND gate"
AAOOA2231:      AAOOA223
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

OOAAO2231:      DESCR = "2-2-3-1-input OR-OR-AND-AND-OR gate"
OOAAO2231:      OOAAO223
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

AAOOA2241:      DESCR = "2-2-4-1-input AND-AND-OR-OR-AND gate"
AAOOA2241:      AAOOA224
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

AAOOA3212:      DESCR = "3-2-1-2-input AND-AND-OR-OR-AND gate"
AAOOA3212:      AAOA3211
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

OOAAO3212:      DESCR = "3-2-1-2-input OR-OR-AND-AND-OR gate"
OOAAO3212:      OOAO3211
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

AAOOA3312:      DESCR = "3-3-1-2-input AND-AND-OR-OR-AND gate"
AAOOA3312:      AAOA3311
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

AOOOA2122:      DESCR = "2-1-2-2-input AND-OR-OR-OR-AND gate"
AOOOA2122:      AOOA2121
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

OAAAO2122:      DESCR = "2-1-2-2-input OR-AND-AND-AND-OR gate"
OAAAO2122:      OAAO2121
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

AOOOA2132:      DESCR = "2-1-3-2-input AND-OR-OR-OR-AND gate"
AOOOA2132:      AOOA2131
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

OAAAO2132:      DESCR = "2-1-3-2-input OR-AND-AND-AND-OR gate"
OAAAO2132:      OAAO2131
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

OAAAO2222:      DESCR = "2-2-2-2-input OR-AND-AND-AND-OR gate"
OAAAO2222:      OAAO2221
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

OOOAAO2224:     DESCR = "2-2-2-4-input OR-OR-OR-AND-AND-OR gate"
OOOAAO2224:     OOOAAO2223
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

AAAOA22211:     DESCR = "2-2-2-1-1-input AND-AND-AND-OR-AND gate"
AAAOA22211:     AAAO2221
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

AAAOA32211:     DESCR = "3-2-2-1-1-input AND-AND-AND-OR-AND gate"
AAAOA32211:     AAAO3221
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

AAOOA22121:     DESCR = "2-2-1-2-1-input AND-AND-OR-OR-AND gate"
AAOOA22121:     AAOOA2212
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

OOAAO22121:     DESCR = "2-2-1-2-1-input OR-OR-AND-AND-OR gate"
OOAAO22121:     OOAAO2212
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

AAOOA22131:     DESCR = "2-2-1-3-1-input AND-AND-OR-OR-AND gate"
AAOOA22131:     AAOOA2213
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

OOAAO22131:     DESCR = "2-2-1-3-1-input OR-OR-AND-AND-OR gate"
OOAAO22131:     OOAAO2213
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

AAOOOA2222:     DESCR = "2-2-2-2-input AND-AND-OR-OR-OR-AND gate"
AAOOOA2222:     AAOOA2221
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

OOAAAO2222:     DESCR = "2-2-2-2-input OR-OR-AND-AND-AND-OR gate"
OOAAAO2222:     OOAAO2221
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

AAOOOA2232:     DESCR = "2-2-3-2-input AND-AND-OR-OR-OR-AND gate"
AAOOOA2232:     AAOOA2231
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

AAAOOA2224:     DESCR = "2-2-2-4-input AND-AND-AND-OR-OR-AND gate"
AAAOOA2224:     AAAOOA2223
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

AAAOOA3222:     DESCR = "3-2-2-2-input AND-AND-AND-OR-OR-AND gate"
AAAOOA3222:     AAAOA3221
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

AAAOOA22221:    DESCR = "2-2-2-2-1-input AND-AND-AND-OR-OR-AND gate"
AAAOOA22221:    AAAOOA2222
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

OOOAAO22221:    DESCR = "2-2-2-2-1-input OR-OR-OR-AND-AND-OR gate"
OOOAAO22221:    OOOAAO2222
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

AAAOOA22231:    DESCR = "2-2-2-3-1-input AND-AND-AND-OR-OR-AND gate"
AAAOOA22231:    AAAOOA2223
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

OOOAAO22231:    DESCR = "2-2-2-3-1-input OR-OR-OR-AND-AND-OR gate"
OOOAAO22231:    OOOAAO2223
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

AAOOOA22122:    DESCR = "2-2-1-2-2-input AND-AND-OR-OR-OR-AND gate"
AAOOOA22122:    AAOOA22121
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

#   --------    four phases     ------------------------------------

CELLS +=        AOAO2112 OAOA2112 \
                AOAO2121 OAOA2121 \
                AOAO2122 OAOA2122 \
                AOAO2211 OAOA2211 \
                         OAOA2221 \
                AOAO3111 OAOA3111 \
                AOAO3112 OAOA3112 \
                AOAO3211 OAOA3211 \
                AAOAO2212 OOAOA2212 \
                AAOAO2221 OOAOA2221 \
                AAOAO2222 OOAOA2222 \
                AAOAO3211 OOAOA3211 \
                AAOAO3212 OOAOA3212 \
                AAOAO3311 OOAOA3311 \
                AOAAO2114 OAOOA2114 \
                AOAAO2122 OAOOA2122 \
                          OAOOA2212 \
                AOAAO2123 OAOOA2123 \
                          OAOOA2213 \
                          OAOOA2222 
                AOAAO3112 OAOOA3112 \
                AOAAO3113 OAOOA3112 \
                AOAAO3212 OAOOA3212 \
                AOOAO2122 OAAOA2122 \
                AOOAO2131 OAAOA2131 \
                AOOAO2221 OAAOA2221 \
                          OAAOA2231 \
                AOOAO3121 OAAOA3121 \
                AOOAO3122 OAAOA3122 \
                AOOAO3131 OAAOA3131 \
                AOOAO3221 OAAOA3221 \
                AAOAO22111 OOAOA22111 \
                AAOAO22121 OOAOA22121 \
                AAOAO32111 OOAOA32111 \
                AAOAO33111 \
                AOAAO21141 \
                AOAAO21221 OAOOA21221 \
                AOAAO31121 OAOOA31121 \
                AOOAO21211 OAAOA21211 \
                AOOAO21212 OAAOA21212 \
                AOOAO21311 OAAOA21311 \
                           OAAOA22211 \
                AAOAAO2214 OOAOOA2214 \
                AAOAAO2222 OOAOOA2222 \
                AAOAAO3212 OOAOOA3212 \
                AAOOAO2222 OOAAOA2222 \
                AAOOAO2231 OOAAOA2231 \
                AAOOAO3221 OOAAOA3221 \
                AOAAO21112 \
                AOAAO21121 OAOOA21121 \
                           OAOOA21131 \
                AOAAO21131 \
                AOOAAO2124 OAAOOA2124 \
                AOOAAO2132 OAAOOA2132 \
                           OAAOOA2222 \
                AOOAAO3122 OAAOOA3122 \
                AAAOAO22211 OOOAOA22211 \
                AAAOAO22221 \
                AAAOAO32211 \
                AAOAAO22112 OOAOOA22112 \
                AAOAAO22121 OOAOOA22121 \
                AAOAAO22131 OOAOOA22131 \
                AAOOAO22121 OOAAOA22121 \
                AAOOAO22131 OOAAOA22131 \
                AAOOAO22211 OOAAOA22211 \
                AAOOAO22311 \
                AOAAAO21122 OAOOOA21122 \
                AOAAAO21132 \
                AOOAAO21212 OAAOOA21212 \
                AOOAAO21221 OAAOOA21221 \
                            OAAOOA21231 \
                AOOAAO21231 \
                AOOOAO21221 OAAAOA21221 \
                AAOOAO221211 \
                AAOOAAO2224 OOAAOOA2224 \
                AAOOAAO2232 \
                AAAOOAO22221 OOOAAOA22221 \
                AAAOOAO22231 OOOAAOA22231 \
                AAAOAAO22212 \
                AAOOAAO22122 \
                AAOOAAO22221 OOAAOOA22221 \
                             OOAAOOA22231 \
                AAOAAAO22122 \
                AOOAAAO21222

AOAO2112:       DESCR = "2-1-1-2-input AND-OR-AND-OR gate"
AOAO2112:       AOAO2111
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

OAOA2112:       DESCR = "2-1-1-2-input OR-AND-OR-AND gate"
OAOA2112:       OAOA2111
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

AOAO2121:       DESCR = "2-1-2-1-input AND-OR-AND-OR gate"
AOAO2121:       AOA212
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

OAOA2121:       DESCR = "2-1-2-1-input OR-AND-OR-AND gate"
OAOA2121:       OAO212
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

AOAO2122:       DESCR = "2-1-2-2-input AND-OR-AND-OR gate"
AOAO2122:       AOAO2121
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

OAOA2122:       DESCR = "2-1-2-2-input OR-AND-OR-AND gate"
OAOA2122:       OAOA2121
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

AOAO2211:       DESCR = "2-2-1-1-input AND-OR-AND-OR gate"
AOAO2211:       AOA221
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

OAOA2211:       DESCR = "2-2-1-1-input OR-AND-OR-AND gate"
OAOA2211:       OAO221
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

OAOA2221:       DESCR = "2-2-2-1-input OR-AND-OR-AND gate"
OAOA2221:       OAO222
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

AOAO3111:       DESCR = "3-1-1-1-input AND-OR-AND-OR gate"
AOAO3111:       AOA311
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

OAOA3111:       DESCR = "3-1-1-1-input OR-AND-OR-AND gate"
OAOA3111:       OAO311
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

AOAO3112:       DESCR = "3-1-1-2-input AND-OR-AND-OR gate"
AOAO3112:       AOAO3111
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

OAOA3112:       DESCR = "3-1-1-2-input OR-AND-OR-AND gate"
OAOA3112:       OAOA3111
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

AOAO3211:       DESCR = "3-2-1-1-input AND-OR-AND-OR gate"
AOAO3211:       AOA321
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

OAOA3211:       DESCR = "3-2-1-1-input OR-AND-OR-AND gate"
OAOA3211:       OAO321
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

AAOAO2212:      DESCR = "2-2-1-2-input AND-AND-OR-AND-OR gate"
AAOAO2212:      AAOAO2211
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

OOAOA2212:      DESCR = "2-2-1-2-input OR-OR-AND-OR-AND gate"
OOAOA2212:      OOAOA2211
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

AAOAO2221:      DESCR = "2-2-2-1-input AND-AND-OR-AND-OR gate"
AAOAO2221:      AAOA222
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

OOAOA2221:      DESCR = "2-2-2-1-input OR-OR-AND-OR-AND gate"
OOAOA2221:      OOAO222
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

AAOAO2222:      DESCR = "2-2-2-2-input AND-AND-OR-AND-OR gate"
AAOAO2222:      AAOAO2221
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

OOAOA2222:      DESCR = "2-2-2-2-input OR-OR-AND-OR-AND gate"
OOAOA2222:      OOAOA2221
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

AAOAO3211:      DESCR = "3-2-1-1-input AND-AND-OR-AND-OR gate"
AAOAO3211:      AAOA321
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

OOAOA3211:      DESCR = "3-2-1-1-input OR-OR-AND-OR-AND gate"
OOAOA3211:      OOAO321
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

AAOAO3212:      DESCR = "3-2-1-2-input AND-AND-OR-AND-OR gate"
AAOAO3212:      AAOAO3211
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

OOAOA3212:      DESCR = "3-2-1-2-input OR-OR-AND-OR-AND gate"
OOAOA3212:      OOAOA3211
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

AAOAO3311:      DESCR = "3-3-1-1-input AND-AND-OR-AND-OR gate"
AAOAO3311:      AAOA331
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

OOAOA3311:      DESCR = "3-3-1-1-input OR-OR-AND-OR-AND gate"
OOAOA3311:      OOAO331
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

AOAAO2114:      DESCR = "2-1-1-4-input AND-OR-AND-AND-OR gate"
AOAAO2114:      AOAAO2113
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

OAOOA2114:      DESCR = "2-1-1-4-input OR-AND-OR-OR-AND gate"
OAOOA2114:      OAOOA2113
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

AOAAO2122:      DESCR = "2-1-2-2-input AND-OR-AND-AND-OR gate"
AOAAO2122:      AOAO2121
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

OAOOA2122:      DESCR = "2-1-2-2-input OR-AND-OR-OR-AND gate"
OAOOA2122:      OAOA2121
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

OAOOA2212:      DESCR = "2-2-1-2-input OR-AND-OR-OR-AND gate"
OAOOA2212:      OAOA2211
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

AOAAO3123:      DESCR = "3-1-2-3-input AND-OR-AND-AND-OR gate"
AOAAO3123:      AOAAO2122
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

AOAAO2123:      DESCR = "2-1-2-3-input AND-OR-AND-AND-OR gate"
AOAAO2123:      AOAAO2122
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

OAOOA2123:      DESCR = "2-1-2-3-input OR-AND-OR-OR-AND gate"
OAOOA2123:      OAOOA2122
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

OAOOA2213:      DESCR = "2-2-1-3-input OR-AND-OR-OR-AND gate"
OAOOA2213:      OAOOA2212
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

OAOOA2222:      DESCR = "2-2-2-2-input OR-AND-OR-OR-AND gate"
OAOOA2222:      OAOA2221
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

AOAAO3112:      DESCR = "3-1-1-2-input AND-OR-AND-AND-OR gate"
AOAAO3112:      AOAO3111
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

OAOOA3112:      DESCR = "3-1-1-2-input OR-AND-OR-OR-AND gate"
OAOOA3112:      OAOA3111
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

AOAAO3113:      DESCR = "3-1-1-3-input AND-OR-AND-AND-OR gate"
AOAAO3113:      AOAAO3112
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

OAOOA3113:      DESCR = "3-1-1-3-input OR-AND-OR-OR-AND gate"
OAOOA3113:      OAOOA3112
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

AOAAO3212:      DESCR = "3-2-1-2-input AND-OR-AND-AND-OR gate"
AOAAO3212:      AOAO3211
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

OAOOA3212:      DESCR = "3-2-1-2-input OR-AND-OR-OR-AND gate"
OAOOA3212:      OAOA3211
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

AOOAO2122:      DESCR = "2-1-2-2-input AND-OR-OR-AND-OR gate"
AOOAO2122:      AOOAO2121
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

OAAOA2122:      DESCR = "2-1-2-2-input OR-AND-AND-OR-AND gate"
OAAOA2122:      OAAOA2121
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

AOOAO2131:      DESCR = "2-1-3-1-input AND-OR-OR-AND-OR gate"
AOOAO2131:      AOOA213
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

OAAOA2131:      DESCR = "2-1-3-1-input OR-AND-AND-OR-AND gate"
OAAOA2131:      OAAO213
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

AOOAO2221:      DESCR = "2-2-2-1-input AND-OR-OR-AND-OR gate"
AOOAO2221:      AOOA222
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

OAAOA2221:      DESCR = "2-2-2-1-input OR-AND-AND-OR-AND gate"
OAAOA2221:      OAAO222
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

OAAOA2231:      DESCR = "2-2-3-1-input OR-AND-AND-OR-AND gate"
OAAOA2231:      OAAO223
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

AOOAO3121:      DESCR = "3-1-2-1-input AND-OR-OR-AND-OR gate"
AOOAO3121:      AOOA312
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

OAAOA3121:      DESCR = "3-1-2-1-input OR-AND-AND-OR-AND gate"
OAAOA3121:      OAAO312
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

AOOAO3122:      DESCR = "3-1-2-2-input AND-OR-OR-AND-OR gate"
AOOAO3122:      AOOAO3121
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

OAAOA3122:      DESCR = "3-1-2-2-input OR-AND-AND-OR-AND gate"
OAAOA3122:      OAAOA3121
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

AOOAO3131:      DESCR = "3-1-3-1-input AND-OR-OR-AND-OR gate"
AOOAO3131:      AOOA313
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

OAAOA3131:      DESCR = "3-1-3-1-input OR-AND-AND-OR-AND gate"
OAAOA3131:      OAAO313
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

AOOAO3221:      DESCR = "3-2-2-1-input AND-OR-OR-AND-OR gate"
AOOAO3221:      AOOA322
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

OAAOA3221:      DESCR = "3-2-2-1-input OR-AND-AND-OR-AND gate"
OAAOA3221:      OAAO322
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

AAOAO22111:     DESCR = "2-2-1-1-1-input AND-AND-OR-AND-OR gate"
AAOAO22111:     AAOA2211
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

OOAOA22111:     DESCR = "2-2-1-1-1-input OR-OR-AND-OR-AND gate"
OOAOA22111:     OOAO2211
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

AAOAO22121:     DESCR = "2-2-1-2-1-input AND-AND-OR-AND-OR gate"
AAOAO22121:     AAOA2212
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

OOAOA22121:     DESCR = "2-2-1-2-1-input OR-OR-AND-OR-AND gate"
OOAOA22121:     OOAO2212
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

AAOAO32111:     DESCR = "3-2-1-1-1-input AND-AND-OR-AND-OR gate"
AAOAO32111:     AAOA3211
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

OOAOA32111:     DESCR = "3-2-1-1-1-input OR-OR-AND-OR-AND gate"
OOAOA32111:     OOAO3211
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

AAOAO33111:     DESCR = "3-3-1-1-1-input AND-AND-OR-AND-OR gate"
AAOAO33111:     AAOA3311
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

AOAAO21141:     DESCR = "2-1-1-4-1-input AND-OR-AND-AND-OR gate"
AOAAO21141:     AOAAO2114
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

AOAAO21221:     DESCR = "2-1-2-2-1-input AND-OR-AND-AND-OR gate"
AOAAO21221:     AOAAO2122
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

OAOOA21221:     DESCR = "2-1-2-2-1-input OR-AND-OR-OR-AND gate"
OAOOA21221:     OAOOA2122
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

AOAAO31121:     DESCR = "3-1-1-2-1-input AND-OR-AND-AND-OR gate"
AOAAO31121:     AOAAO3112
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

OAOOA31121:     DESCR = "3-1-1-2-1-input OR-AND-OR-OR-AND gate"
OAOOA31121:     OAOOA3112
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

AAOOAO2222:     DESCR = "2-2-2-2-input AND-AND-OR-OR-AND-OR gate"
AAOOAO2222:     AAOOAO2221
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

OOAAOA2222:     DESCR = "2-2-2-2-input OR-OR-AND-AND-OR-AND gate"
OOAAOA2222:     OOAAOA2221
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

AOOAO21211:     DESCR = "2-1-2-1-1-input AND-OR-OR-AND-OR gate"
AOOAO21211:     AOOA2121
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

OAAOA21211:     DESCR = "2-1-2-1-1-input OR-AND-AND-OR-AND gate"
OAAOA21211:     OAAOA2121
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

AOOAO21212:     DESCR = "2-1-2-1-2-input AND-OR-OR-AND-OR gate"
AOOAO21212:     AOOAO21211
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

OAAOA21212:     DESCR = "2-1-2-1-2-input OR-AND-AND-OR-AND gate"
OAAOA21212:     OAAOA21211
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

AOOAO21311:     DESCR = "2-1-3-1-1-input AND-OR-OR-AND-OR gate"
AOOAO21311:     AOOA2131
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

OAAOA21311:     DESCR = "2-1-3-1-1-input OR-AND-AND-OR-AND gate"
OAAOA21311:     OAAO2131
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

OAAOA22211:     DESCR = "2-2-2-1-1-input OR-AND-AND-OR-AND gate"
OAAOA22211:     OAAO2221
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

AAOAAO2214:     DESCR = "2-2-1-4-input AND-AND-OR-AND-AND-OR gate"
AAOAAO2214:     AAOAAO2213
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

OOAOOA2214:     DESCR = "2-2-1-4-input OR-OR-AND-OR-OR-AND gate"
OOAOOA2214:     OOAOOA2213
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

AAOAAO2222:     DESCR = "2-2-2-2-input AND-AND-OR-AND-AND-OR gate"
AAOAAO2222:     AAOAO2221
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

OOAOOA2222:     DESCR = "2-2-2-2-input OR-OR-AND-OR-OR-AND gate"
OOAOOA2222:     OOAOA2221
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

AAOAAO3212:     DESCR = "3-2-1-2-input AND-AND-OR-AND-AND-OR gate"
AAOAAO3212:     AAOAO3211
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

OOAOOA3212:     DESCR = "3-2-1-2-input OR-OR-AND-OR-OR-AND gate"
OOAOOA3212:     OOAOA3211
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

AAOOAO2231:     DESCR = "2-2-3-1-input AND-AND-OR-OR-AND-OR gate"
AAOOAO2231:     AAOOA223
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

OOAAOA2231:     DESCR = "2-2-3-1-input OR-OR-AND-AND-OR-AND gate"
OOAAOA2231:     OOAAO223
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

AAOOAO3221:     DESCR = "3-2-2-1-input AND-AND-OR-OR-AND-OR gate"
AAOOAO3221:     AAOOA322
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

OOAAOA3221:     DESCR = "3-2-2-1-input OR-OR-AND-AND-OR-AND gate"
OOAAOA3221:     OOAAO322
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

AOAAO21112:     DESCR = "2-1-1-1-2-input AND-OR-AND-AND-OR gate"
AOAAO21112:     AOAAO2112
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

AOAAO21121:     DESCR = "2-1-1-2-1-input AND-OR-AND-AND-OR gate"
AOAAO21121:     AOAAO2112
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

OAOOA21121:     DESCR = "2-1-1-2-1-input OR-AND-OR-OR-AND gate"
OAOOA21121:     OAOOA2112
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

OAOOA21131:     DESCR = "2-1-1-3-1-input OR-AND-OR-OR-AND gate"
OAOOA21131:     OAOOA2113
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

AOAAO21131:     DESCR = "2-1-1-3-1-input AND-OR-AND-AND-OR gate"
AOAAO21131:     AOAAO2113
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

AOOAAO2124:     DESCR = "2-1-2-4-input AND-OR-OR-AND-AND-OR gate"
AOOAAO2124:     AOOAAO2123
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

OAAOOA2124:     DESCR = "2-1-2-4-input OR-AND-AND-OR-OR-AND gate"
OAAOOA2124:     OAAOOA2123
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

AOOAAO2132:     DESCR = "2-1-3-1-input AND-OR-OR-AND-AND-OR gate"
AOOAAO2132:     AOOAO2131
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

OAAOOA2132:     DESCR = "2-1-3-1-input OR-AND-AND-OR-OR-AND gate"
OAAOOA2132:     OAAOA2131
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

OAAOOA2222:     DESCR = "2-2-2-1-input OR-AND-AND-OR-OR-AND gate"
OAAOOA2222:     OAAOA2221
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

AOOAAO3122:     DESCR = "3-1-2-2-input AND-OR-OR-AND-AND-OR gate"
AOOAAO3122:     AOOAO3121
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

OAAOOA3122:     DESCR = "3-1-2-2-input OR-AND-AND-OR-OR-AND gate"
OAAOOA3122:     OAAOA3121
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

AAAOAO22211:    DESCR = "2-2-2-1-1-input AND-AND-AND-OR-AND-OR gate"
AAAOAO22211:    AAAOA2221
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

OOOAOA22211:    DESCR = "2-2-2-1-1-input OR-OR-OR-AND-OR-AND gate"
OOOAOA22211:    OOOAO2221
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

AAAOAO22221:    DESCR = "2-2-2-2-1-input AND-AND-AND-OR-AND-OR gate"
AAAOAO22221:    AAAOA2222
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

AAAOAO32211:    DESCR = "3-2-2-1-1-input AND-AND-AND-OR-AND-OR gate"
AAAOAO32211:    AAAOA3221
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

AAOAAO22112:    DESCR = "2-2-1-1-2-input AND-AND-OR-AND-AND-OR gate"
AAOAAO22112:    AAOAO22111
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

OOAOOA22112:    DESCR = "2-2-1-1-2-input OR-OR-AND-OR-OR-AND gate"
OOAOOA22112:    OOAOA22111
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

AAOAAO22121:    DESCR = "2-2-1-2-1-input AND-AND-OR-AND-AND-OR gate"
AAOAAO22121:    AAOAAO2212
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

OOAOOA22121:    DESCR = "2-2-1-2-1-input OR-OR-AND-OR-OR-AND gate"
OOAOOA22121:    OOAOOA2212
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

AAOAAO22131:    DESCR = "2-2-1-3-1-input AND-AND-OR-AND-AND-OR gate"
AAOAAO22131:    AAOAAO2213
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

OOAOOA22131:    DESCR = "2-2-1-3-1-input OR-OR-AND-OR-OR-AND gate"
OOAOOA22131:    OOAOOA2213
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

AAOOAO22121:    DESCR = "2-2-1-2-1-input AND-AND-OR-OR-AND-OR gate"
AAOOAO22121:    AAOOA2212
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

OOAAOA22121:    DESCR = "2-2-1-2-1-input OR-OR-AND-AND-OR-AND gate"
OOAAOA22121:    OOAAO2212
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

AAOOAO22131:    DESCR = "2-2-1-3-1-input AND-AND-OR-OR-AND-OR gate"
AAOOAO22131:    AAOOA2213
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

OOAAOA22131:    DESCR = "2-2-1-3-1-input OR-OR-AND-AND-OR-AND gate"
OOAAOA22131:    OOAAO2213
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

AAOOAO22211:    DESCR = "2-2-2-1-1-input AND-AND-OR-OR-AND-OR gate"
AAOOAO22211:    AAOOA2221
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

OOAAOA22211:    DESCR = "2-2-2-1-1-input OR-OR-AND-AND-OR-AND gate"
OOAAOA22211:    OOAAO2221
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

AAOOAO22311:    DESCR = "2-2-3-1-1-input AND-AND-OR-OR-AND-OR gate"
AAOOAO22311:    AAOOA2231
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

AOAAAO21122:    DESCR = "2-1-1-2-2-input AND-OR-AND-AND-AND-OR gate"
AOAAAO21122:    AOAAO21121
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

OAOOOA21122:    DESCR = "2-1-1-2-2-input OR-AND-OR-OR-OR-AND gate"
OAOOOA21122:    OAOOA21121
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

AOAAAO21132:    DESCR = "2-1-1-3-2-input AND-OR-AND-AND-AND-OR gate"
AOAAAO21132:    AOAAO21131
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

AOOAAO21212:    DESCR = "2-1-2-1-2-input AND-OR-OR-AND-AND-OR gate"
AOOAAO21212:    AOOAO21211
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

OAAOOA21212:    DESCR = "2-1-2-1-2-input OR-AND-AND-OR-OR-AND gate"
OAAOOA21212:    OAAOA21211
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

AOOAAO21221:    DESCR = "2-1-2-2-1-input AND-OR-OR-AND-AND-OR gate"
AOOAAO21221:    AOOAAO2122
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

OAAOOA21221:    DESCR = "2-1-2-2-1-input OR-AND-AND-OR-OR-AND gate"
OAAOOA21221:    OAAOOA2122
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

OAAOOA21231:    DESCR = "2-1-2-3-1-input OR-AND-AND-OR-OR-AND gate"
OAAOOA21231:    OAAOOA2123
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

AOOAAO21231:    DESCR = "2-1-2-3-1-input AND-OR-OR-AND-AND-OR gate"
AOOAAO21231:    AOOAAO2123
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

AOOOAO21221:    DESCR = "2-1-2-2-1-input AND-OR-OR-OR-AND-OR gate"
AOOOAO21221:    AOOOA2122
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

OAAAOA21221:    DESCR = "2-1-2-2-1-input OR-AND-AND-AND-OR-AND gate"
OAAAOA21221:    OAAAO2122
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

AAOOAO221211:   DESCR = "2-2-1-2-2-1-input AND-AND-OR-OR-AND-OR gate"
AAOOAO221211:   AAOOA22121
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

AAOOAAO2224:    DESCR = "2-2-2-4-input AND-AND-OR-OR-AND-AND-OR gate"
AAOOAAO2224:    AAOOAAO2223
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

OOAAOOA2224:    DESCR = "2-2-2-4-input OR-OR-AND-AND-OR-OR-AND gate"
OOAAOOA2224:    OOAAOOA2223
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

AAOOAAO2232:    DESCR = "2-2-3-2-input AND-AND-OR-OR-AND-AND-OR gate"
AAOOAAO2232:    AAOOAO2231
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

AAAOOAO22221:   DESCR = "2-2-2-2-1-input AND-AND-AND-OR-OR-AND-OR gate"
AAAOOAO22221:   AAAOOA2222
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

OOOAAOA22221:   DESCR = "2-2-2-2-1-input OR-OR-OR-AND-AND-OR-AND gate"
OOOAAOA22221:   OOOAAO2222
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

AAAOOAO22231:   DESCR = "2-2-2-3-1-input AND-AND-AND-OR-OR-AND-OR gate"
AAAOOAO22231:   AAAOOA2223
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

OOOAAOA22231:   DESCR = "2-2-2-3-1-input OR-OR-OR-AND-AND-OR-AND gate"
OOOAAOA22231:   OOOAAO2223
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

AAAOAAO22212:   DESCR = "2-2-2-1-2-input AND-AND-AND-OR-AND-AND-OR gate"
AAAOAAO22212:   AAAOAO22211
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

AAOOAAO22122:   DESCR = "2-2-1-2-2-input AND-AND-OR-OR-AND-AND-OR gate"
AAOOAAO22122:   AAOOAO22121
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

AAOOAAO22221:   DESCR = "2-2-2-2-1-input AND-AND-OR-OR-AND-AND-OR gate"
AAOOAAO22221:   AAOOAAO2222
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

OOAAOOA22221:   DESCR = "2-2-2-2-1-input OR-OR-AND-AND-OR-OR-AND gate"
OOAAOOA22221:   OOAAOOA2222
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

OOAAOOA22231:   DESCR = "2-2-2-3-1-input OR-OR-AND-AND-OR-OR-AND gate"
OOAAOOA22231:   OOAAOOA2223
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

AAOAAAO22122:   DESCR = "2-2-1-2-2-input AND-AND-OR-AND-AND-AND-OR gate"
AAOAAAO22122:   AAOAAO22121
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

AOOAAAO21222:   DESCR = "2-1-2-2-2-input AND-OR-OR-AND-AND-AND-OR gate"
AOOAAAO21222:   AOOAAO21221
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

#   --------    five phases     ------------------------------------

CELLS +=        AOAOA21111 OAOAO21111 \
                AOAOA21121 OAOAO21121 \
                           OAOAO21122 \
                           OAOAO22111 \
                           OAOAO32111 \
                AAOAOA22111 OOAOAO22111 \
                AAOAOA22121 OOAOAO22121 \
                AOAAOA21121 OAOOAO21121 \
                AOAAOA21131 OAOOAO21131 \
                            OAOOAO22121 \
                AOAOOA21112 OAOAAO21112 \
                AOAOOA21113 OAOAAO21113 \
                AOAOOA21122 OAOAAO21122 \
                            OAOAAO22112 \
                AOOAOA21211 OAAOAO21211 \
                AOOAOA21221 OAAOAO21221 \
                AOOAOA21311 OAAOAO21311 \
                            OAAOAO22211 \
                AAOAOA221111 OOAOAO221111 \
                AOAAOA211211 OAOOAO211211 \
                AOAAOA211311 OAOOAO211311 \
                AAOAAOA22121 OOAOOAO22121 \
                AAOAAOA22122 \
                AAOAAOA22131 OOAOOAO22131 \
                AAOAOOA22112 OOAOAAO22112 \
                AAOOAOA22211 OOAAOAO22211 \
                AAOOAOA22221 \
                AAOOAOA22311 \
                AOAAOOA21122 OAOOAAO21122 \
                AOAAOOA21132 \
                AOOAAOA21221 OAAOOAO21221 \
                             OAAOOAO21231 \
                AOOAAOA21231 \
                AOOAOOA21212 OAAOAAO21212 \
                AAAOAOA222111 \
                AAOOAOA221211 \
                AAOAAOA221211 \
                AOOAAOA212211 \
                AAOOAAOA22221 OOAAOOAO22221 \
                AAOOAAOA22231 OOAAOOAO22231 \
                AAOAAOOA22122 \
                AOOAAOOA21222 \
                AAOOAOOA22212 

AOAOA21111:     DESCR = "2-1-1-1-1-input AND-OR-AND-OR-AND gate"
AOAOA21111:     AOAO2111
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

OAOAO21111:     DESCR = "2-1-1-1-1-input OR-AND-OR-AND-OR gate"
OAOAO21111:     OAOA2111
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

AOAOA21121:     DESCR = "2-1-1-2-1-input AND-OR-AND-OR-AND gate"
AOAOA21121:     AOAO2112
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

OAOAO21121:     DESCR = "2-1-1-2-1-input OR-AND-OR-AND-OR gate"
OAOAO21121:     OAOA2112
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

OAOAO21122:     DESCR = "2-1-1-2-2-input OR-AND-OR-AND-OR gate"
OAOAO21122:     OAOAO21121
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

OAOAO22111:     DESCR = "2-2-1-1-1-input OR-AND-OR-AND-OR gate"
OAOAO22111:     OAOA2211
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

OAOAO32111:     DESCR = "3-2-1-1-1-input OR-AND-OR-AND-OR gate"
OAOAO32111:     OAOA3211
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

AAOAOA22111:    DESCR = "2-2-1-1-1-input AND-AND-OR-AND-OR-AND gate"
AAOAOA22111:    AAOAO2211
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

OOAOAO22111:    DESCR = "2-2-1-1-1-input OR-OR-AND-OR-AND-OR gate"
OOAOAO22111:    OOAOA2211
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

AAOAOA22121:    DESCR = "2-2-1-2-1-input AND-AND-OR-AND-OR-AND gate"
AAOAOA22121:    AAOAO2212
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

OOAOAO22121:    DESCR = "2-2-1-2-1-input OR-OR-AND-OR-AND-OR gate"
OOAOAO22121:    OOAOA2212
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

AOAAOA21121:    DESCR = "2-1-1-2-1-input AND-OR-AND-AND-OR-AND gate"
AOAAOA21121:    AOAAO2112
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

OAOOAO21121:    DESCR = "2-1-1-2-1-input OR-AND-OR-OR-AND-OR gate"
OAOOAO21121:    OAOOA2112
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

AOAAOA21131:    DESCR = "2-1-1-3-1-input AND-OR-AND-AND-OR-AND gate"
AOAAOA21131:    AOAAO2113
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

OAOOAO21131:    DESCR = "2-1-1-3-1-input OR-AND-OR-OR-AND-OR gate"
OAOOAO21131:    OAOOA2113
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

OAOOAO22121:    DESCR = "2-2-1-2-1-input OR-AND-OR-OR-AND-OR gate"
OAOOAO22121:    OAOOA2212
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

AOAOOA21112:    DESCR = "2-1-1-1-2-input AND-OR-AND-OR-OR-AND gate"
AOAOOA21112:    AOAOA21111
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

OAOAAO21112:    DESCR = "2-1-1-1-2-input OR-AND-OR-AND-AND-OR gate"
OAOAAO21112:    OAOAO21111
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

AOAOOA21113:    DESCR = "2-1-1-1-3-input AND-OR-AND-OR-OR-AND gate"
AOAOOA21113:    AOAOOA21112
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

OAOAAO21113:    DESCR = "2-1-1-1-3-input OR-AND-OR-AND-AND-OR gate"
OAOAAO21113:    OAOAAO21112
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

AOAOOA21122:    DESCR = "2-1-1-2-2-input AND-OR-AND-OR-OR-AND gate"
AOAOOA21122:    AOAOA21121
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

OAOAAO21122:    DESCR = "2-1-1-2-2-input OR-AND-OR-AND-AND-OR gate"
OAOAAO21122:    OAOAO21121
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

OAOAAO22112:    DESCR = "2-2-1-1-2-input OR-AND-OR-AND-AND-OR gate"
OAOAAO22112:    OAOAO22111
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

AOOAOA21211:    DESCR = "2-1-2-1-1-input AND-OR-OR-AND-OR-AND gate"
AOOAOA21211:    AOOAO2121
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

OAAOAO21211:    DESCR = "2-1-2-1-1-input OR-AND-AND-OR-AND-OR gate"
OAAOAO21211:    OAAOA2121
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

AOOAOA21221:    DESCR = "2-1-2-2-1-input AND-OR-OR-AND-OR-AND gate"
AOOAOA21221:    AOOAO2122
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

OAAOAO21221:    DESCR = "2-1-2-2-1-input OR-AND-AND-OR-AND-OR gate"
OAAOAO21221:    OAAOA2122
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

AOOAOA21311:    DESCR = "2-1-3-1-1-input AND-OR-OR-AND-OR-AND gate"
AOOAOA21311:    AOOAO2131
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

OAAOAO21311:    DESCR = "2-1-3-1-1-input OR-AND-AND-OR-AND-OR gate"
OAAOAO21311:    OAAOA2131
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

OAAOAO22211:    DESCR = "2-2-2-1-1-input OR-AND-AND-OR-AND-OR gate"
OAAOAO22211:    OAAOA2221
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

AAOAOA221111:   DESCR = "2-2-1-1-1-1-input AND-AND-OR-AND-OR-AND gate"
AAOAOA221111:   AAOAO22111
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

OOAOAO221111:   DESCR = "2-2-1-1-1-1-input OR-OR-AND-OR-AND-OR gate"
OOAOAO221111:   OOAOA22111
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

AOAAOA211211:   DESCR = "2-1-1-2-1-1-input AND-OR-AND-AND-OR-AND gate"
AOAAOA211211:   AOAAO21121
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

OAOOAO211211:   DESCR = "2-1-1-2-1-1-input OR-AND-OR-OR-AND-OR gate"
OAOOAO211211:   OAOOA21121
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

AOAAOA211311:   DESCR = "2-1-1-3-1-1-input AND-OR-AND-AND-OR-AND gate"
AOAAOA211311:   AOAAO21131
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

OAOOAO211311:   DESCR = "2-1-1-3-1-1-input OR-AND-OR-OR-AND-OR gate"
OAOOAO211311:   OAOOA21131
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

AAOAAOA22121:   DESCR = "2-2-1-2-1-input AND-AND-OR-AND-AND-OR-AND gate"
AAOAAOA22121:   AAOAAO2212
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

OOAOOAO22121:   DESCR = "2-2-1-2-1-input OR-OR-AND-OR-OR-AND-OR gate"
OOAOOAO22121:   OOAOOA2212
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

AAOAAOA22122:   DESCR = "2-2-1-2-2-input AND-AND-OR-AND-AND-OR-AND gate"
AAOAAOA22122:   AAOAAOA22121
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

AAOAAOA22131:   DESCR = "2-2-1-3-1-input AND-AND-OR-AND-AND-OR-AND gate"
AAOAAOA22131:   AAOAAO2213
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

OOAOOAO22131:   DESCR = "2-2-1-3-1-input OR-OR-AND-OR-OR-AND-OR gate"
OOAOOAO22131:   OOAOOA2213
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

AAOAOOA22112:   DESCR = "2-2-1-1-2-input AND-AND-OR-AND-OR-OR-AND gate"
AAOAOOA22112:   AAOAOA22111
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

OOAOAAO22112:   DESCR = "2-2-1-1-2-input OR-OR-AND-OR-AND-AND-OR gate"
OOAOAAO22112:   OOAOAO22111
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

AAOOAOA22211:   DESCR = "2-2-2-1-1-input AND-AND-OR-OR-AND-OR-AND gate"
AAOOAOA22211:   AAOOAO2221
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

OOAAOAO22211:   DESCR = "2-2-2-1-1-input OR-OR-AND-AND-OR-AND-OR gate"
OOAAOAO22211:   OOAAOA2221
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

AAOOAOA22221:   DESCR = "2-2-2-2-1-input AND-AND-OR-OR-AND-OR-AND gate"
AAOOAOA22221:   AAOOAO2222
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

AAOOAOA22311:   DESCR = "2-2-3-1-1-input AND-AND-OR-OR-AND-OR-AND gate"
AAOOAOA22311:   AAOOAO2231
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

AOAAOOA21122:   DESCR = "2-1-1-2-2-input AND-OR-AND-AND-OR-OR-AND gate"
AOAAOOA21122:   AOAAOA21121
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

OAOOAAO21122:   DESCR = "2-1-1-2-2-input OR-AND-OR-OR-AND-AND-OR gate"
OAOOAAO21122:   OAOOAO21121
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

AOAAOOA21132:   DESCR = "2-1-1-3-2-input AND-OR-AND-AND-OR-OR-AND gate"
AOAAOOA21132:   AOAAOA21131
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

AOOAAOA21221:   DESCR = "2-1-2-2-1-input AND-OR-OR-AND-AND-OR-AND gate"
AOOAAOA21221:   AOOAAO2122
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

OAAOOAO21221:   DESCR = "2-1-2-2-1-input OR-AND-AND-OR-OR-AND-OR gate"
OAAOOAO21221:   OAAOOA2122
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

OAAOOAO21231:   DESCR = "2-1-2-3-1-input OR-AND-AND-OR-OR-AND-OR gate"
OAAOOAO21231:   OAAOOA2123
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

AOOAAOA21231:   DESCR = "2-1-2-3-1-input AND-OR-OR-AND-AND-OR-AND gate"
AOOAAOA21231:   AOOAAO2123
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

AOOAOOA21212:   DESCR = "2-1-2-1-2-input AND-OR-OR-AND-OR-OR-AND gate"
AOOAOOA21212:   AOOAOA21211
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

OAAOAAO21212:   DESCR = "2-1-2-1-2-input OR-AND-AND-OR-AND-AND-OR gate"
OAAOAAO21212:   OAAOAO21211
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

AAAOAOA222111:  DESCR = "2-2-2-1-1-1-input AND-AND-AND-OR-AND-OR-AND gate"
AAAOAOA222111:  AAAOAO22211
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

AAOOAOA221211:  DESCR = "2-2-1-2-1-1-input AND-AND-OR-OR-AND-OR-AND gate"
AAOOAOA221211:  AAOOAO22121
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

AAOAAOA221211:  DESCR = "2-2-1-2-1-1-input AND-AND-OR-AND-AND-OR-AND gate"
AAOAAOA221211:  AAOAAO22121
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

AOOAAOA212211:  DESCR = "2-1-2-2-1-1-input AND-OR-OR-AND-AND-OR-AND gate"
AOOAAOA212211:  AOOAAO21221
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

AAOOAAOA22221:  DESCR = "2-2-2-2-1-input AND-AND-OR-OR-AND-AND-OR-AND gate"
AAOOAAOA22221:  AAOOAAO2222
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

OOAAOOAO22221:  DESCR = "2-2-2-2-1-input OR-OR-AND-AND-OR-OR-AND-OR gate"
OOAAOOAO22221:  OOAAOOA2222
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

AAOOAAOA22231:  DESCR = "2-2-2-3-1-input AND-AND-OR-OR-AND-AND-OR-AND gate"
AAOOAAOA22231:  AAOOAAO2223
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

OOAAOOAO22231:  DESCR = "2-2-2-3-1-input OR-OR-AND-AND-OR-OR-AND-OR gate"
OOAAOOAO22231:  OOAAOOA2223
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

AAOAAOOA22122:  DESCR = "2-2-1-2-2-input AND-AND-OR-AND-AND-OR-OR-AND gate"
AAOAAOOA22122:  AAOAAOA22121
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

AOOAAOOA21222:  DESCR = "2-1-2-2-2-input AND-OR-OR-AND-AND-OR-OR-AND gate"
AOOAAOOA21222:  AOOAAOA21221
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

AAOOAOOA22212:  DESCR = "2-2-2-1-2-input AND-AND-OR-OR-AND-OR-OR-AND gate"
AAOOAOOA22212:  AAOOAOA22211
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

#   --------    six phases      ------------------------------------

CELLS +=        AOAOAO211111 OAOAOA211111 \
                AAOAOAO221111 OOAOAOA221111 \
                AOAAOAO211211 OAOOAOA211211 \
                AOAAOAO211311 \
                AOAOAAO211112 OAOAOOA211112 \
                AOAOAAO211113 \
                AOAOOAO211121 OAOAAOA211121 \
                AOOAOAO212111 OAAOAOA212111 \
                AAOOAOAO222111 \
                AAOAAOAO221211 \
                AOOAAOAO212211

AOAOAO211111:   DESCR = "2-1-1-1-1-1-input AND-OR-AND-OR-AND-OR gate"
AOAOAO211111:   AOAOA21111
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

OAOAOA211111:   DESCR = "2-1-1-1-1-1-input OR-AND-OR-AND-OR-AND gate"
OAOAOA211111:   OAOAO21111
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

AAOAOAO221111:  DESCR = "2-2-1-1-1-1-input AND-AND-OR-AND-OR-AND-OR gate"
AAOAOAO221111:  AAOAOA22111
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

OOAOAOA221111:  DESCR = "2-2-1-1-1-1-input OR-OR-AND-OR-AND-OR-AND gate"
OOAOAOA221111:  OOAOAO22111
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

AOAAOAO211211:  DESCR = "2-1-1-2-1-1-input AND-OR-AND-AND-OR-AND-OR gate"
AOAAOAO211211:  AOAAOA21121
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

OAOOAOA211211:  DESCR = "2-1-1-2-1-1-input OR-AND-OR-OR-AND-OR-AND gate"
OAOOAOA211211:  OAOOAO21121
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

AOAAOAO211311:  DESCR = "2-1-1-3-1-1-input AND-OR-AND-AND-OR-AND-OR gate"
AOAAOAO211311:  AOAAOA21131
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

AOAOAAO211112:  DESCR = "2-1-1-1-1-2-input AND-OR-AND-OR-AND-AND-OR gate"
AOAOAAO211112:  AOAOAO211111
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

OAOAOOA211112:  DESCR = "2-1-1-1-1-2-input OR-AND-OR-AND-OR-OR-AND gate"
OAOAOOA211112:  OAOAOA211111
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

AOAOAAO211113:  DESCR = "2-1-1-1-1-31-input AND-OR-AND-OR-AND-AND-OR gate"
AOAOAAO211113:  AOAOAAO211112
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

AOAOOAO211121:  DESCR = "2-1-1-1-2-1-input AND-OR-AND-OR-OR-AND-OR gate"
AOAOOAO211121:  AOAOOA21112
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

OAOAAOA211121:  DESCR = "2-1-1-1-2-1-input OR-AND-OR-AND-AND-OR-AND gate"
OAOAAOA211121:  AOAOOA21112
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

AOOAOAO212111:  DESCR = "2-1-2-1-1-1-input AND-OR-OR-AND-OR-AND-OR gate"
AOOAOAO212111:  AOOAOA21211
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

OAAOAOA212111:  DESCR = "2-1-2-1-1-1-input OR-AND-AND-OR-AND-OR-AND gate"
OAAOAOA212111:  OAAOAO21211
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

AAOOAOAO222111: DESCR = "2-2-2-1-1-1-input AND-AND-OR-OR-AND-OR-AND-OR gate"
AAOOAOAO222111: AAOOAOA22211
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

AAOAAOAO221211: DESCR = "2-2-1-2-1-1-input AND-AND-OR-AND-AND-OR-AND-OR gate"
AAOAAOAO221211: AAOAAOA22121
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

AOOAAOAO212211: DESCR = "2-1-2-2-1-1-input AND-OR-OR-AND-AND-OR-AND-OR gate"
AOOAAOAO212211: AOOAAOA21221
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)
