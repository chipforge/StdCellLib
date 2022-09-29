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
#   File:           StdCellLib/Catalog/stacked4_phase3_bufnow_cells.mk
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

#   Dependencies for cells with 4 stacked transistors and 3 phases,
#   which are buffered now.

#   ----------------------------------------------------------------
#               CELL TARGETS - now buffered
#   ----------------------------------------------------------------

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
                AAOA3321 OOAO3321 \
                AOOA2121 OAAO2121 \
                AOOA2131 OAAO2131 \
                AOOA2141 OAAO2141 \
                AOOA2221 OAAO2221 \
                         OAAO2231 \
                AOOA2321 \
                         OAAO2241 \
                AAOOA224 OOAAO224 \
                AAOOA322 OOAAO322 \
                AAOOA323 OOAAO323 \
                AAOOA332 OOAAO332 \
                AAAOA2222 OOOAO2222 \
                          OOOAO2223 \
                AAAOA3221 OOOAO3221 \
                AAAOA3321 OOOAO3321 \
                AAAOA3322 \
                AAAOA3331 OOOAO3331 \
                AAOOA2214 OOAAO2214 \
                AAOOA2221 OOAAO2221 \
                AAOOA2222 OOAAO2222 \
                AAOOA2231 OOAAO2231 \
                AAOOA2241 OOAAO2241 \
                AAOOA3212 OOAAO3212 \
                AAOOA3312 OOAAO3312 \
                AOOOA2122 OAAAO2122 \
                AOOOA2132 OAAAO2132 \
                          OAAAO2222 \
                          OAAAO2232 \
                AAAOA22211 \
                AAAOA32211 OOOAO32211 \
                AAAOA33211 OOOAO33211 \
                AAOOA22121 OOAAO22121 \
                AAOOA22131 OOAAO22131 \
                AAOOA22141 OOAAO22141 \
                AAOOOA2222 OOAAAO2222 \
                AAOOOA2232 OOAAAO2232 \
                AAAOOA2224 OOOAAO2224 \
                AAAOOA3222 OOOAAO3222 \
                AAAOOA3322 OOOAAO3322 \
                AAAOOA22221 OOOAAO22221 \
                AAAOOA22231 OOOAAO22231 \
                AAOOOA22122 \
                AAOOOA22132 OOAAAO22132 \
                AAAOOOA22222 OOOAAAA22222

AOA212:         DESCR = "2-1-2-input AND-OR-AND gate"
AOA212:         AOAI211
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

OAO212:         DESCR = "2-1-2-input OR-AND-OR gate"
OAO212:         OAOI211
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

AOA222:         DESCR = "2-2-2-input AND-OR-AND gate"
AOA222:         AOAI221
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

OAO222:         DESCR = "2-2-2-input OR-AND-OR gate"
OAO222:         OAOI221
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
AOA311:         AOI31
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

OAO311:         DESCR = "3-1-1-input OR-AND-OR gate"
OAO311:         OAI31
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

AOA321:         DESCR = "3-2-1-input AND-OR-AND gate"
AOA321:         AOI32
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

OAO321:         DESCR = "3-2-1-input OR-AND-OR gate"
OAO321:         OAI32
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

AOA331:         DESCR = "3-3-1-input AND-OR-AND gate"
AOA331:         AO33
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

AAOA222:        DESCR = "2-2-2-input AND-AND-OR-AND gate"
AAOA222:        AAOAI221
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

OOAO222:        DESCR = "2-2-2-input OR-OR-AND-OR gate"
OOAO222:        OOAOI221
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

AAOA321:        DESCR = "3-2-1-input AND-AND-OR-AND gate"
AAOA321:        AAOI32
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

OOAO321:        DESCR = "3-2-1-input OR-OR-AND-OR gate"
OOAO321:        OOAI32
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

AAOA331:        DESCR = "3-3-1-input AND-AND-OR-AND gate"
AAOA331:        AAOI33
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

OOAO331:        DESCR = "3-3-1-input OR-OR-AND-OR gate"
OOAO331:        OOAI33
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

AOOA214:        DESCR = "2-1-4-input AND-OR-OR-AND gate"
AOOA214:        AOOAI213
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

OAAO214:        DESCR = "2-1-4-input OR-AND-AND-OR gate"
OAAO214:        OAAOI213
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

OAAO224:        DESCR = "2-2-4-input OR-AND-AND-OR gate"
OAAO224:        OAAOI223
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
AAOA2212:       AAOAI2211
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

OOAO2212:       DESCR = "2-2-1-2-input OR-OR-AND-OR gate"
OOAO2212:       OOAOI2211
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
AAOA3211:       AAOI321
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

OOAO3211:       DESCR = "3-2-1-1-input OR-OR-AND-OR gate"
OOAO3211:       OOAI321
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
AAOA3311:       AAOI331
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

OOAO3311:       DESCR = "3-3-1-1-input OR-OR-AND-OR gate"
OOAO3311:       OOAI331
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

AAOA3321:       DESCR = "3-3-2-1-input AND-AND-OR-AND gate"
AAOA3321:       AAO332
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

OOAO3321:       DESCR = "3-3-2-1-input OR-OR-AND-OR gate"
OOAO3321:       OOA332
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

AOOA2121:       DESCR = "2-1-2-1-input AND-OR-OR-AND gate"
AOOA2121:       AOOAI212
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

OAAO2121:       DESCR = "2-1-2-1-input OR-AND-AND-OR gate"
OAAO2121:       OAAOI212
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

AOOA2131:       DESCR = "2-1-3-1-input AND-OR-OR-AND gate"
AOOA2131:       AOOAI213
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

OAAO2131:       DESCR = "2-1-3-1-input OR-AND-AND-OR gate"
OAAO2131:       OAAOI213
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
AOOA2221:       AOOAI222
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

OAAO2221:       DESCR = "2-2-2-1-input OR-AND-AND-OR gate"
OAAO2221:       OAAOI222
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

OAAO2231:       DESCR = "2-2-3-1-input OR-AND-AND-OR gate"
OAAO2231:       OAAOI223
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

AOOA2321:       DESCR = "2-3-2-1-input AND-OR-OR-AND gate"
AOOA2321:       AOOA232
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

OAAO2241:       DESCR = "2-2-4-1-input OR-AND-AND-OR gate"
OAAO2241:       OAAO224
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

AAOOA224:       DESCR = "2-2-4-input AND-AND-OR-OR-AND gate"
AAOOA224:       AAOOAI223
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

OOAAO224:       DESCR = "2-2-4-input OR-OR-AND-AND-OR gate"
OOAAO224:       OOAAOI223
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
AAAOA2222:      AAAOAI2221
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

OOOAO2222:      DESCR = "2-2-2-2-input OR-OR-OR-AND-OR gate"
OOOAO2222:      OOOAOI2221
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

OOOAO2223:      DESCR = "2-2-2-3-input OR-OR-OR-AND-OR gate"
OOOAO2223:      OOOAO2222
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

AAAOA3221:      DESCR = "3-2-2-1-input AND-AND-AND-OR-AND gate"
AAAOA3221:      AAAOI322
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

OOOAO3221:      DESCR = "3-2-2-1-input OR-OR-OR-AND-OR gate"
OOOAO3221:      OOOAI322
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

AAAOA3321:      DESCR = "3-3-2-1-input AND-AND-AND-OR-AND gate"
AAAOA3321:      AAAOI332
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

OOOAO3321:      DESCR = "3-3-2-1-input OR-OR-OR-AND-OR gate"
OOOAO3321:      OOOAI332
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

AAAOA3322:      DESCR = "3-3-2-2-input AND-AND-AND-OR-AND gate"
AAAOA3322:      AAAO3321
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

AAAOA3331:      DESCR = "3-3-3-1-input AND-AND-AND-OR-AND gate"
AAAOA3331:      AAAOI333
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

OOOAO3331:      DESCR = "3-3-3-1-input OR-OR-OR-AND-OR gate"
OOOAO3331:      OOOAI333
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

AAOOA2214:      DESCR = "2-2-1-4-input AND-AND-OR-OR-AND gate"
AAOOA2214:      AAOOAI2213
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

OOAAO2214:      DESCR = "2-2-1-4-input OR-OR-AND-AND-OR gate"
OOAAO2214:      OOAAOI2213
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

AAOOA2221:      DESCR = "2-2-2-1-input AND-AND-OR-OR-AND gate"
AAOOA2221:      AAOOAI222
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

OOAAO2221:      DESCR = "2-2-2-1-input OR-OR-AND-AND-OR gate"
OOAAO2221:      OOAAOI222
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
AAOOA2231:      AAOOAI223
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

OOAAO2231:      DESCR = "2-2-3-1-input OR-OR-AND-AND-OR gate"
OOAAO2231:      OOAAOI223
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

AAOOA2241:      DESCR = "2-2-4-1-input AND-AND-OR-OR-AND gate"
AAOOA2241:      AAOOA224
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

OOAAO2241:      DESCR = "2-2-4-1-input OR-OR-AND-AND-OR gate"
OOAAO2241:      OOAAO224
	$(POPCORN) -m pd -c $@ $< > $@
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

OOAAO3312:      DESCR = "3-3-1-2-input OR-OR-AND-AND-OR gate"
OOAAO3312:      OOAO3311
	$(POPCORN) -m nand -c $@ $< > $@
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

OAAAO2232:      DESCR = "2-2-3-2-input OR-AND-AND-AND-OR gate"
OAAAO2232:      OAAO2231
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

OOOAO32211:     DESCR = "3-2-2-1-1-input OR-OR-OR-AND-OR gate"
OOOAO32211:     OOOA3221
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

AAAOA33211:     DESCR = "3-3-2-1-1-input AND-AND-AND-OR-AND gate"
AAAOA33211:     AAAO3321
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

OOOAO33211:     DESCR = "3-3-2-1-1-input OR-OR-OR-AND-OR gate"
OOOAO33211:     OOOA3321
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

AAOOA22121:     DESCR = "2-2-1-2-1-input AND-AND-OR-OR-AND gate"
AAOOA22121:     AAOOAI2212
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

OOAAO22121:     DESCR = "2-2-1-2-1-input OR-OR-AND-AND-OR gate"
OOAAO22121:     OOAAOI2212
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

AAOOA22131:     DESCR = "2-2-1-3-1-input AND-AND-OR-OR-AND gate"
AAOOA22131:     AAOOAI2213
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

OOAAO22131:     DESCR = "2-2-1-3-1-input OR-OR-AND-AND-OR gate"
OOAAO22131:     OOAAOI2213
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

AAOOA22141:     DESCR = "2-2-1-4-1-input AND-AND-OR-OR-AND gate"
AAOOA22141:     AAOOA2214
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

OOAAO22141:     DESCR = "2-2-1-4-1-input OR-OR-AND-AND-OR gate"
OOAAO22141:     OOAAO2214
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

OOAAAO2232:     DESCR = "2-2-3-2-input OR-OR-AND-AND-AND-OR gate"
OOAAAO2232:     OOAAO2231
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

AAAOOA2224:     DESCR = "2-2-2-4-input AND-AND-AND-OR-OR-AND gate"
AAAOOA2224:     AAAOOAI2223
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

OOOAAO2224:     DESCR = "2-2-2-4-input OR-OR-OR-AND-AND-OR gate"
OOOAAO2224:     OOOAAOI2223
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

AAAOOA3222:     DESCR = "3-2-2-2-input AND-AND-AND-OR-OR-AND gate"
AAAOOA3222:     AAAOA3221
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

OOOAAO3222:     DESCR = "3-2-2-2-input OR-OR-OR-AND-AND-OR gate"
OOOAAO3222:     OOOAO3221
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

AAAOOA3322:     DESCR = "3-3-2-2-input AND-AND-AND-OR-OR-AND gate"
AAAOOA3322:     AAAOA3321
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

OOOAAO3322:     DESCR = "3-3-2-2-input OR-OR-OR-AND-AND-OR gate"
OOOAAO3322:     OOOAO3321
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

AAAOOA22221:    DESCR = "2-2-2-2-1-input AND-AND-AND-OR-OR-AND gate"
AAAOOA22221:    AAAOOAI2222
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

OOOAAO22221:    DESCR = "2-2-2-2-1-input OR-OR-OR-AND-AND-OR gate"
OOOAAO22221:    OOOAAOI2222
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

AAAOOA22231:    DESCR = "2-2-2-3-1-input AND-AND-AND-OR-OR-AND gate"
AAAOOA22231:    AAAOOAI2223
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

OOOAAO22231:    DESCR = "2-2-2-3-1-input OR-OR-OR-AND-AND-OR gate"
OOOAAO22231:    OOOAAOI2223
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

AAOOOA22122:    DESCR = "2-2-1-2-2-input AND-AND-OR-OR-OR-AND gate"
AAOOOA22122:    AAOOA22121
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

AAOOOA22132:    DESCR = "2-2-1-3-2-input AND-AND-OR-OR-OR-AND gate"
AAOOOA22132:    AAOOA22131
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

OOAAAO22132:    DESCR = "2-2-1-3-2-input OR-OR-AND-AND-AND-OR gate"
OOAAAO22132:    OOAAO22131
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

AAAOOOA22222:   DESCR = "2-2-2-2-2-input AND-AND-AND-OR-OR-OR-AND gate"
AAAOOOA22222:   AAAOOA22221
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

OOOAAAO22222:   DESCR = "2-2-2-2-2-input OR-OR-OR-AND-AND-AND-OR gate"
OOOAAAO22222:   OOOAAO22221
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)
