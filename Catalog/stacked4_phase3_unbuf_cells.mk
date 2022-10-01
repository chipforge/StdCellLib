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
#   File:           StdCellLib/Catalog/stacked4_phase3_unbuf_cells.mk
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
#   which are still unbuffered.

#   ----------------------------------------------------------------
#               CELL TARGETS - still unbuffered
#   ----------------------------------------------------------------

#   --------    three phases    ------------------------------------

CELLS +=        AOAI212 OAOI212 \
                AOAI222 OAOI222 \
                AOAI231 OAOI231 \
                AOAI232 OAOI232 \
                AOAI311 OAOI311 \
                AOAI321 OAOI321 \
                AOAI331 \
                AAOAI222 OOAOI222 \
                AAOAI321 OOAOI321 \
                AAOAI331 OOAOI331 \
                AOOAI214 OAAOI214 \
                         OAAOI224 \
                AOOAI232 OAAOI232 \
                AOOAI233 OAAOI233 \
                AOOAI312 OAAOI312 \
                AOOAI313 OAAOI313 \
                AOOAI314 OAAOI314 \
                AOOAI322 OAAOI322 \
                AOOAI323 OAAOI323 \
                AOOAI332 \
                AAOAI2212 OOAOI2212 \
                AAOAI2221 OOAOI2221 \
                AAOAI2222 OOAOI2222 \
                AAOAI3211 OOAOI3211 \
                AAOAI3221 OOAOI3221 \
                AAOAI3311 OOAOI3311 \
                AAOAI3321 OOAOI3321 \
                AOOAI2121 OAAOI2121 \
                AOOAI2131 OAAOI2131 \
                AOOAI2141 OAAOI2141 \
                AOOAI2221 OAAOI2221 \
                          OAAOI2231 \
                AOOAI2321 \
                         OAAOI2241 \
                AAOOAI224 OOAAOI224 \
                AAOOAI322 OOAAOI322 \
                AAOOAI323 OOAAOI323 \
                AAOOAI332 OOAAOI332 \
                AAAOAI2222 OOOAOI2222 \
                           OOOAOI2223 \
                AAAOAI3221 OOOAOI3221 \
                AAAOAI3321 OOOAOI3321 \
                AAAOAI3322 \
                AAAOAI3331 OOOAOI3331 \
                AAOOAI2214 OOAAOI2214 \
                AAOOAI2221 OOAAOI2221 \
                AAOOAI2222 OOAAOI2222 \
                AAOOAI2231 OOAAOI2231 \
                AAOOAI2241 OOAAOI2241 \
                AAOOAI3212 OOAAOI3212 \
                AAOOAI3312 OOAAOI3312 \
                AOOOAI2122 OAAAOI2122 \
                AOOOAI2132 OAAAOI2132 \
                           OAAAOI2222 \
                           OAAAOI2232 \
                AAAOAI22211 \
                AAAOAI32211 OOOAOI32211 \
                AAAOAI33211 OOOAOI33211 \
                AAOOAI22121 OOAAOI22121 \
                AAOOAI22131 OOAAOI22131 \
                AAOOAI22141 OOAAOI22141 \
                AAOOOAI2222 OOAAAOI2222 \
                AAOOOAI2232 OOAAAOI2232 \
                AAAOOAI2224 OOOAAOI2224 \
                AAAOOAI3222 OOOAAOI3222 \
                AAAOOAI3322 OOOAAOI3322 \
                AAAOOAI22221 OOOAAOI22221 \
                AAAOOAI22231 OOOAAOI22231 \
                AAOOOAI22122 \
                AAOOOAI22132 OOAAAOI22132 \
                AAAOOOAI22222 OOOAAAOI22222

AOAI212:        DESCR = "2-1-2-input AND-OR-AND-Invert gate"
AOAI212:        AOAI211
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

OAOI212:        DESCR = "2-1-2-input OR-AND-OR-Invert gate"
OAOI212:        OAOI211
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

AOAI222:        DESCR = "2-2-2-input AND-OR-AND-Invert gate"
AOAI222:        AOAI221
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

OAOI222:        DESCR = "2-2-2-input OR-AND-OR-Invert gate"
OAOI222:        OAOI221
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

AOAI231:        DESCR = "2-3-1-input AND-OR-AND-Invert gate"
AOAI231:        AOI23
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

OAOI231:        DESCR = "2-3-1-input OR-AND-OR-Invert gate"
OAOI231:        OAI23
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

AOAI232:        DESCR = "2-3-2-input AND-OR-AND-Invert gate"
AOAI232:        AOAI231
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

OAOI232:        DESCR = "2-3-2-input OR-AND-OR-Invert gate"
OAOI232:        OAOI231
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

AOAI311:        DESCR = "3-1-1-input AND-OR-AND-Invert gate"
AOAI311:        AOI31
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

OAOI311:        DESCR = "3-1-1-input OR-AND-OR-Invert gate"
OAOI311:        OAI31
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

OAOI321:        DESCR = "3-2-1-input OR-AND-OR-Invert gate"
OAOI321:        OAI32
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

AOAI321:        DESCR = "3-2-1-input AND-OR-AND-Invert gate"
AOAI321:        AOI32
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

AOAI331:        DESCR = "3-3-1-input AND-OR-AND-Invert gate"
AOAI331:        AOI33
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

AAOAI222:       DESCR = "2-2-2-input AND-AND-OR-AND-Invert gate"
AAOAI222:       AAOAI221
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

OOAOI222:       DESCR = "2-2-2-input OR-OR-AND-OR-Invert gate"
OOAOI222:       OOAOI221
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

AAOAI321:       DESCR = "3-2-1-input AND-AND-OR-AND-Invert gate"
AAOAI321:       AAOI32
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

OOAOI321:       DESCR = "3-2-1-input OR-OR-AND-OR-Invert gate"
OOAOI321:       OOAI32
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

AAOAI331:       DESCR = "3-3-1-input AND-AND-OR-AND-Invert gate"
AAOAI331:       AAOI33
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

OOAOI331:       DESCR = "3-3-1-input OR-OR-AND-OR-Invert gate"
OOAOI331:       OOAI33
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

AOOAI214:       DESCR = "2-1-4-input AND-OR-OR-AND-Invert gate"
AOOAI214:       AOOAI213
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

OAAOI214:       DESCR = "2-1-4-input OR-AND-AND-OR-Invert gate"
OAAOI214:       OAAOI213
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

OAAOI224:       DESCR = "2-2-4-input OR-AND-AND-OR-Invert gate"
OAAOI224:       OAAOI223
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

AOOAI232:       DESCR = "2-3-2-input AND-OR-OR-AND-Invert gate"
AOOAI232:       AOAI231
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

OAAOI232:       DESCR = "2-3-2-input OR-AND-AND-OR-Invert gate"
OAAOI232:       OAOI231
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

AOOAI233:       DESCR = "2-3-3-input AND-OR-OR-AND-Invert gate"
AOOAI233:       AOOAI232
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

OAAOI233:       DESCR = "2-3-3-input OR-AND-AND-OR-Invert gate"
OAAOI233:       OAAOI232
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

AOOAI312:       DESCR = "3-1-2-input AND-OR-OR-AND-Invert gate"
AOOAI312:       AOAI311
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

OAAOI312:       DESCR = "3-1-2-input OR-AND-AND-OR-Invert gate"
OAAOI312:       OAOI311
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

AOOAI313:       DESCR = "3-1-3-input AND-OR-OR-AND-Invert gate"
AOOAI313:       AOOAI312
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

OAAOI313:       DESCR = "3-1-3-input OR-AND-AND-OR-Invert gate"
OAAOI313:       OAAOI312
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

AOOAI314:       DESCR = "3-1-4-input AND-OR-OR-AND-Invert gate"
AOOAI314:       AOOAI313
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

OAAOI314:       DESCR = "3-1-4-input OR-AND-AND-OR-Invert gate"
OAAOI314:       OAAOI313
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

AOOAI322:       DESCR = "3-2-2-input AND-OR-OR-AND-Invert gate"
AOOAI322:       AOAI321
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

OAAOI322:       DESCR = "3-2-2-input OR-AND-AND-OR-Invert gate"
OAAOI322:       OAOI321
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

AOOAI323:       DESCR = "3-2-3-input AND-OR-OR-AND-Invert gate"
AOOAI323:       AOOAI322
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

OAAOI323:       DESCR = "3-2-3-input OR-AND-AND-OR-Invert gate"
OAAOI323:       OAAOI322
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

AOOAI332:       DESCR = "3-2-3-input AND-OR-OR-AND-Invert gate"
AOOAI332:       AOAI331
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

AAOAI2212:      DESCR = "2-2-1-2-input AND-AND-OR-AND-Invert gate"
AAOAI2212:      AAOAI2211
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

OOAOI2212:      DESCR = "2-2-1-2-input OR-OR-AND-OR-Invert gate"
OOAOI2212:      OOAOI2211
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

AAOAI2221:      DESCR = "2-2-2-1-input AND-AND-OR-AND-Invert gate"
AAOAI2221:      AAOI222
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

OOAOI2221:      DESCR = "2-2-2-1-input OR-OR-AND-OR-Invert gate"
OOAOI2221:      OOAI222
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

AAOAI2222:      DESCR = "2-2-2-2-input AND-AND-OR-AND-Invert gate"
AAOAI2222:      AAOAI2221
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

OOAOI2222:      DESCR = "2-2-2-2-input OR-OR-AND-OR-Invert gate"
OOAOI2222:      OOAOI2221
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

AAOAI3211:      DESCR = "3-2-1-1-input AND-AND-OR-AND-Invert gate"
AAOAI3211:      AAOI321
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

OOAOI3211:      DESCR = "3-2-1-1-input OR-OR-AND-OR-Invert gate"
OOAOI3211:      OOAI321
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

AAOAI3221:      DESCR = "3-2-2-1-input AND-AND-OR-AND-Invert gate"
AAOAI3221:      AAOI322
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

OOAOI3221:      DESCR = "3-2-2-1-input OR-OR-AND-OR-Invert gate"
OOAOI3221:      OOAI322
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

AAOAI3311:      DESCR = "3-3-1-1-input AND-AND-OR-AND-Invert gate"
AAOAI3311:      AAOI331
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

OOAOI3311:      DESCR = "3-3-1-1-input OR-OR-AND-OR-Invert gate"
OOAOI3311:      OOAI331
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

AAOAI3321:      DESCR = "3-3-2-1-input AND-AND-OR-AND-Invert gate"
AAOAI3321:      AAOI332
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

OOAOI3321:      DESCR = "3-3-2-1-input OR-OR-AND-OR-Invert gate"
OOAOI3321:      OOAI332
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

AOOAI2121:      DESCR = "2-1-2-1-input AND-OR-OR-AND-Invert gate"
AOOAI2121:      AOOAI212
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

OAAOI2121:      DESCR = "2-1-2-1-input OR-AND-AND-OR-Invert gate"
OAAOI2121:      OAAOI212
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

AOOAI2131:      DESCR = "2-1-3-1-input AND-OR-OR-AND-Invert gate"
AOOAI2131:      AOOAI213
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

OAAOI2131:      DESCR = "2-1-3-1-input OR-AND-AND-OR-Invert gate"
OAAOI2131:      OAAOI213
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

AOOAI2141:      DESCR = "2-1-4-1-input AND-OR-OR-AND-Invert gate"
AOOAI2141:      AOOAI214
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

OAAOI2141:      DESCR = "2-1-4-1-input OR-AND-AND-OR-Invert gate"
OAAOI2141:      OAAOI214
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

AOOAI2221:      DESCR = "2-2-2-1-input AND-OR-OR-AND-Invert gate"
AOOAI2221:      AOOAI222
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

OAAOI2221:      DESCR = "2-2-2-1-input OR-AND-AND-OR-Invert gate"
OAAOI2221:      OAAOI222
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

OAAOI2231:      DESCR = "2-2-3-1-input OR-AND-AND-OR-Invert gate"
OAAOI2231:      OAAOI223
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

AOOAI2321:      DESCR = "2-3-2-1-input AND-OR-OR-AND-Invert gate"
AOOAI2321:      AOOAI232
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

OAAOI2241:      DESCR = "2-2-4-1-input OR-AND-AND-OR-Invert gate"
OAAOI2241:      OAAOI224
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

AAOOAI224:      DESCR = "2-2-4-input AND-AND-OR-OR-AND-Invert gate"
AAOOAI224:      AAOOAI223
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

OOAAOI224:      DESCR = "2-2-4-input OR-OR-AND-AND-OR-Invert gate"
OOAAOI224:      OOAAOI223
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

AAOOAI322:      DESCR = "3-2-2-input AND-AND-OR-OR-AND-Invert gate"
AAOOAI322:      AAOAI321
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

OOAAOI322:      DESCR = "3-2-2-input OR-OR-AND-AND-OR-Invert gate"
OOAAOI322:      OOAOI321
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

AAOOAI323:      DESCR = "3-2-3-input AND-AND-OR-OR-AND-Invert gate"
AAOOAI323:      AAOOAI322
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

OOAAOI323:      DESCR = "3-2-3-input OR-OR-AND-AND-OR-Invert gate"
OOAAOI323:      OOAAOI322
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

AAOOAI332:      DESCR = "3-3-2-input AND-AND-OR-OR-AND-Invert gate"
AAOOAI332:      AAOAI331
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

OOAAOI332:      DESCR = "3-3-2-input OR-OR-AND-AND-OR-Invert gate"
OOAAOI332:      OOAOI331
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

AAAOAI2222:     DESCR = "2-2-2-2-input AND-AND-AND-OR-AND-Invert gate"
AAAOAI2222:     AAAOAI2221
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

OOOAOI2222:     DESCR = "2-2-2-2-input OR-OR-OR-AND-OR-Invert gate"
OOOAOI2222:     OOOAOI2221
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

OOOAOI2223:     DESCR = "2-2-2-3-input OR-OR-OR-AND-OR-Invert gate"
OOOAOI2223:     OOOAOI2222
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

AAAOAI3221:     DESCR = "3-2-2-1-input AND-AND-AND-OR-AND-Invert gate"
AAAOAI3221:     AAAOI322
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

OOOAOI3221:     DESCR = "3-2-2-1-input OR-OR-OR-AND-OR-Invert gate"
OOOAOI3221:     OOOAI322
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

AAAOAI3321:     DESCR = "3-3-2-1-input AND-AND-AND-OR-AND-Invert gate"
AAAOAI3321:     AAAOI332
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

OOOAOI3321:     DESCR = "3-3-2-1-input OR-OR-OR-AND-OR-Invert gate"
OOOAOI3321:     OOOAI332
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

AAAOAI3322:     DESCR = "3-3-2-2-input AND-AND-AND-OR-AND-Invert gate"
AAAOAI3322:     AAAOI3321
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

AAAOAI3331:     DESCR = "3-3-3-1-input AND-AND-AND-OR-AND-Invert gate"
AAAOAI3331:     AAAOI333
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

OOOAOI3331:     DESCR = "3-3-3-1-input OR-OR-OR-AND-OR-Invert gate"
OOOAOI3331:     OOOAI333
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

AAOOAI2214:     DESCR = "2-2-1-4-input AND-AND-OR-OR-AND-Invert gate"
AAOOAI2214:     AAOOAI2213
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

OOAAOI2214:     DESCR = "2-2-1-4-input OR-OR-AND-AND-OR-Invert gate"
OOAAOI2214:     OOAAOI2213
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

AAOOAI2221:     DESCR = "2-2-2-1-input AND-AND-OR-OR-AND-Invert gate"
AAOOAI2221:     AAOOAI222
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

OOAAOI2221:     DESCR = "2-2-2-1-input OR-OR-AND-AND-OR-Invert gate"
OOAAOI2221:     OOAAOI222
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

AAOOAI2222:     DESCR = "2-2-2-2-input AND-AND-OR-OR-AND-Invert gate"
AAOOAI2222:     AAOOAI2221
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

OOAAOI2222:     DESCR = "2-2-2-2-input OR-OR-AND-AND-OR-Invert gate"
OOAAOI2222:     OOAOI2221
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

AAOOAI2231:     DESCR = "2-2-3-1-input AND-AND-OR-OR-AND-Invert gate"
AAOOAI2231:     AAOOAI223
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

OOAAOI2231:     DESCR = "2-2-3-1-input OR-OR-AND-AND-OR-Invert gate"
OOAAOI2231:     OOAAOI223
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

AAOOAI2241:     DESCR = "2-2-4-1-input AND-AND-OR-OR-AND-Invert gate"
AAOOAI2241:     AAOOAI224
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

OOAAOI2241:     DESCR = "2-2-4-1-input OR-OR-AND-AND-OR-Invert gate"
OOAAOI2241:     OOAAOI224
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

AAOOAI3212:     DESCR = "3-2-1-2-input AND-AND-OR-OR-AND-Invert gate"
AAOOAI3212:     AAOAI3211
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

OOAAOI3212:     DESCR = "3-2-1-2-input OR-OR-AND-AND-OR-Invert gate"
OOAAOI3212:     OOAOI3211
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

AAOOAI3312:     DESCR = "3-3-1-2-input AND-AND-OR-OR-AND-Invert gate"
AAOOAI3312:     AAOAI3311
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

OOAAOI3312:     DESCR = "3-3-1-2-input OR-OR-AND-AND-OR-Invert gate"
OOAAOI3312:     OOAOI3311
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

AOOOAI2122:     DESCR = "2-1-2-2-input AND-OR-OR-OR-AND-Invert gate"
AOOOAI2122:     AOOAI2121
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

OAAAOI2122:     DESCR = "2-1-2-2-input OR-AND-AND-AND-OR-Invert gate"
OAAAOI2122:     OAAOI2121
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

AOOOAI2132:     DESCR = "2-1-3-2-input AND-OR-OR-OR-AND-Invert gate"
AOOOAI2132:     AOOAI2131
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

OAAAOI2132:     DESCR = "2-1-3-2-input OR-AND-AND-AND-OR-Invert gate"
OAAAOI2132:     OAAOI2131
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

OAAAOI2222:     DESCR = "2-2-2-2-input OR-AND-AND-AND-OR-Invert gate"
OAAAOI2222:     OAAOI2221
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

OAAAOI2232:     DESCR = "2-2-3-2-input OR-AND-AND-AND-OR-Invert gate"
OAAAOI2232:     OAAOI2231
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

AAAOAI22211:    DESCR = "2-2-2-1-1-input AND-AND-AND-OR-AND-Invert gate"
AAAOAI22211:    AAAOI2221
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

AAAOAI32211:    DESCR = "3-2-2-1-1-input AND-AND-AND-OR-AND-Invert gate"
AAAOAI32211:    AAAOI3221
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

OOOAOI32211:    DESCR = "3-2-2-1-1-input OR-OR-OR-AND-OR-Invert gate"
OOOAOI32211:    OOOAI3221
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

AAAOAI33211:     DESCR = "3-3-2-1-1-input AND-AND-AND-OR-AND-Invert gate"
AAAOAI33211:     AAAOI3321
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

OOOAOI33211:    DESCR = "3-3-2-1-1-input OR-OR-OR-AND-OR-Invert gate"
OOOAOI33211:    OOOAI3321
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

AAOOAI22121:    DESCR = "2-2-1-2-1-input AND-AND-OR-OR-AND-Invert gate"
AAOOAI22121:    AAOOAI2212
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

OOAAOI22121:    DESCR = "2-2-1-2-1-input OR-OR-AND-AND-OR-Invert gate"
OOAAOI22121:    OOAAOI2212
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

AAOOAI22131:    DESCR = "2-2-1-3-1-input AND-AND-OR-OR-AND-Invert gate"
AAOOAI22131:    AAOOAI2213
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

OOAAOI22131:    DESCR = "2-2-1-3-1-input OR-OR-AND-AND-OR-Invert gate"
OOAAOI22131:    OOAAOI2213
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

AAOOAI22141:    DESCR = "2-2-1-4-1-input AND-AND-OR-OR-AND-Invert gate"
AAOOAI22141:    AAOOAI2214
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

OOAAOI22141:    DESCR = "2-2-1-4-1-input OR-OR-AND-AND-OR-Invert gate"
OOAAOI22141:    OOAAOI2214
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

AAOOOAI2222:    DESCR = "2-2-2-2-input AND-AND-OR-OR-OR-AND-Invert gate"
AAOOOAI2222:    AAOOAI2221
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

OOAAAOI2222:    DESCR = "2-2-2-2-input OR-OR-AND-AND-AND-OR-Invert gate"
OOAAAOI2222:    OOAAOI2221
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

AAOOOAI2232:    DESCR = "2-2-3-2-input AND-AND-OR-OR-OR-AND-Invert gate"
AAOOOAI2232:    AAOOAI2231
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

OOAAAOI2232:    DESCR = "2-2-3-2-input OR-OR-AND-AND-AND-OR-Invert gate"
OOAAAOI2232:    OOAAOI2231
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

AAAOOAI2224:    DESCR = "2-2-2-4-input AND-AND-AND-OR-OR-AND-Invert gate"
AAAOOAI2224:    AAAOOAI2223
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

OOOAAOI2224:    DESCR = "2-2-2-4-input OR-OR-OR-AND-AND-OR-Invert gate"
OOOAAOI2224:    OOOAAOI2223
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

AAAOOAI3222:    DESCR = "3-2-2-2-input AND-AND-AND-OR-OR-AND-Invert gate"
AAAOOAI3222:    AAAOAI3221
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

OOOAAOI3222:    DESCR = "3-2-2-2-input OR-OR-OR-AND-AND-OR-Invert gate"
OOOAAOI3222:    OOOAOI3221
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

AAAOOAI3322:    DESCR = "3-3-2-2-input AND-AND-AND-OR-OR-AND-Invert gate"
AAAOOAI3322:    AAAOAI3321
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

OOOAAOI3322:    DESCR = "3-3-2-2-input OR-OR-OR-AND-AND-OR-Invert gate"
OOOAAOI3322:    OOOAOI3321
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

AAAOOAI22221:   DESCR = "2-2-2-2-1-input AND-AND-AND-OR-OR-AND-Invert gate"
AAAOOAI22221:   AAAOOAI2222
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

OOOAAOI22221:   DESCR = "2-2-2-2-1-input OR-OR-OR-AND-AND-OR-Invert gate"
OOOAAOI22221:   OOOAAOI2222
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

AAAOOAI22231:   DESCR = "2-2-2-3-1-input AND-AND-AND-OR-OR-AND-Invert gate"
AAAOOAI22231:   AAAOOAI2223
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

OOOAAOI22231:   DESCR = "2-2-2-3-1-input OR-OR-OR-AND-AND-OR-Invert gate"
OOOAAOI22231:   OOOAAOI2223
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

AAOOOAI22122:   DESCR = "2-2-1-2-2-input AND-AND-OR-OR-OR-AND-Invert gate"
AAOOOAI22122:   AAOOAI22121
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

AAOOOAI22132:   DESCR = "2-2-1-3-2-input AND-AND-OR-OR-OR-AND-Invert gate"
AAOOOAI22132:   AAOOAI22131
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

OOAAAOI22132:   DESCR = "2-2-1-3-2-input OR-OR-AND-AND-AND-OR-Invert gate"
OOAAAOI22132:   OOAAOI22131
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

AAAOOOAI22222:  DESCR = "2-2-2-2-2-input AND-AND-AND-OR-OR-OR-AND-Invert gate"
AAAOOOAI22222:  AAAOOAI22221
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

OOOAAAOI22222:  DESCR = "2-2-2-2-2-input OR-OR-OR-AND-AND-AND-OR-Invert gate"
OOOAAAOI22222:  OOOAAOI22221
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)
