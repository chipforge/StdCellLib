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
#   File:           StdCellLib/Catalog/stacked4_phases_unbuf_cells.mk
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
#   which are still unbuffered.

#   ----------------------------------------------------------------
#               CELL TARGETS - still unbuffered
#   ----------------------------------------------------------------

#   --------    one phase   ----------------------------------------

CELLS +=        NAND4 NOR4

NAND4:          DESCR = "4-input Not-AND (or NAND) gate"
NAND4:          NAND3
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

NOR4:           DESCR = "4-input Not-OR (or NOR) gate"
NOR4:           NOR3
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

#   --------    two phases  ----------------------------------------

CELLS +=        AOI23 OAI23 \
                AOI33 OAI33 \
                AOI41 OAI41 \
                AOI42 OAI42 \
                AOI43 OAI43 \
                AAOI42 OOAI42 \
                AAOI43 OOAI43 \
                AAOI44 OOAI44 \
                AAOI222 OOAI222 \
                AAOI322 OOAI322 \
                AAOI332 OOAI332 \
                AAOI421 OOAI421 \
                        OOAI422 \
                        OOAI431 \
                        OOOAI422 \
                AAAOI2221 OOOAI2221 \
                AAAOI3221 OOOAI3221 \
                AAAOI3222 \
                AAAOI3321 OOOAI3321 \
                AAAOI3331 OOOAI3331 \
                AAAAOI2222 OOOOAI2222

AOI23:          DESCR = "2-3-input AND-OR-Invert gate"
AOI23:          AOI22
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

OAI23:          DESCR = "2-3-input OR-AND-Invert gate"
OAI23:          OAI22
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

AOI33:          DESCR = "3-3-input AND-OR-Invert gate"
AOI33:          AOI32
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

OAI33:          DESCR = "3-3-input OR-AND-Invert gate"
OAI33:          OAI32
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

AOI41:          DESCR = "4-1-input AND-OR-Invert gate"
AOI41:          NAND4
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

OAI41:          DESCR = "4-1-input OR-AND-Invert gate"
OAI41:          NOR4
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

AOI42:          DESCR = "4-2-input AND-OR-Invert gate"
AOI42:          AOI41
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

OAI42:          DESCR = "4-2-input OR-AND-Invert gate"
OAI42:          OAI41
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

AOI43:          DESCR = "4-3-input AND-OR-Invert gate"
AOI43:          AOI42
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

OAI43:          DESCR = "4-3-input OR-AND-Invert gate"
OAI43:          OAI42
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

AAOI42:         DESCR = "4-2-input AND-AND-OR-Invert gate"
AAOI42:         AOI41
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

OOAI42:         DESCR = "4-2-input OR-OR-AND-Invert gate"
OOAI42:         OAI41
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

AAOI43:         DESCR = "4-3-input AND-AND-OR-Invert gate"
AAOI43:         AAOI42
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

OOAI43:         DESCR = "4-3-input OR-OR-AND-Invert gate"
OOAI43:         OOAI42
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

AAOI44:         DESCR = "4-4-input AND-AND-OR-Invert gate"
AAOI44:         AAOI43
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

OOAI44:         DESCR = "4-4-input OR-OR-AND-Invert gate"
OOAI44:         OOAI43
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

AAOI222:        DESCR = "2-2-2-input AND-AND-OR-Invert gate"
AAOI222:        AAOI221
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

OOAI222:        DESCR = "2-2-2-input OR-OR-AND-Invert gate"
OOAI222:        OOAI221
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

AAOI322:        DESCR = "3-2-2-input AND-AND-OR-Invert gate"
AAOI322:        AAOI321
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

OOAI322:        DESCR = "3-2-2-input OR-OR-AND-Invert gate"
OOAI322:        OOAI321
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

AAOI332:        DESCR = "3-3-2-input AND-AND-OR-Invert gate"
AAOI332:        AAOI331
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

OOAI332:        DESCR = "3-3-2-input OR-OR-AND-Invert gate"
OOAI332:        OOAI331
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

AAOI421:        DESCR = "4-2-1-input AND-AND-OR-Invert gate"
AAOI421:        AAOI42
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

OOAI421:        DESCR = "4-2-1-input OR-OR-AND-Invert gate"
OOAI421:        OOAI42
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

OOAI422:        DESCR = "4-2-2-input OR-OR-AND-Invert gate"
OOAI422:        OOAI421
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

OOAI431:        DESCR = "4-3-1-input OR-OR-AND-Invert gate"
OOAI431:        OOAI43
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

OOOAI422:       DESCR = "4-2-2-input OR-OR-OR-AND-Invert gate"
OOOAI422:       OOAI421
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

AAAOI2221:      DESCR = "2-2-2-1-input AND-AND-AND-OR-Invert gate"
AAAOI2221:      AAAOI222
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

OOOAI2221:      DESCR = "2-2-2-1-input OR-OR-OR-AND-Invert gate"
OOOAI2221:      OOOAI222
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

AAAOI3221:      DESCR = "3-2-2-1-input AND-AND-AND-OR-Invert gate"
AAAOI3221:      AAAOI322
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

OOOAI3221:      DESCR = "3-2-2-1-input OR-OR-OR-AND-Invert gate"
OOOAI3221:      OOOAI322
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

AAAOI3222:      DESCR = "3-2-2-2-input AND-AND-AND-OR-Invert gate"
AAAOI3222:      AAAOI3221
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

AAAOI3321:      DESCR = "3-3-2-1-input AND-AND-AND-OR-Invert gate"
AAAOI3321:      AAAOI332
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

OOOAI3321:      DESCR = "3-3-2-1-input OR-OR-OR-AND-Invert gate"
OOOAI3321:      OOOAI332
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

AAAOI3331:      DESCR = "3-3-3-1-input AND-AND-AND-OR-Invert gate"
AAAOI3331:      AAAOI333
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

OOOAI3331:      DESCR = "3-3-3-1-input OR-OR-OR-AND-Invert gate"
OOOAI3331:      OOOAI333
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

AAAAOI2222:      DESCR = "2-2-2-2-input AND-AND-AND-AND-OR-Invert gate"
AAAAOI2222:      AAAOI2221
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

OOOOAI2222:      DESCR = "2-2-2-2-input OR-OR-OR-OR-AND-Invert gate"
OOOOAI2222:      OOOAI2221
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

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
                AAOAI3321 \
                AOOAI2121 OAAOI2121 \
                AOOAI2131 OAAOI2131 \
                AOOAI2141 OAAOI2141 \
                AOOAI2221 OAAOI2221 \
                          OAAOI2231 \
                AOOAI2321 \
                AAOOAI224 OOAAOI224 \
                AAOOAI322 OOAAOI322 \
                AAOOAI323 OOAAOI323 \
                AAOOAI332 OOAAOI332 \
                AAAOAI2222 OOOAOI2222 \
                AAAOAI3221 OOOAOI3221 \
                AAAOAI3321 OOOAOI3321 \
                AAAOAI3331 OOOAOI3331 \
                AAOOAI2214 OOAAOI2214 \
                AAOOAI2221 OOAAOI2221 \
                AAOOAI2222 OOAAOI2222 \
                AAOOAI2231 OOAAOI2231 \
                AAOOAI2241 \
                AAOOAI3212 OOAAOI3212 \
                AAOOAI3312 \
                AOOOAI2122 OAAAOI2122 \
                AOOOAI2132 OAAAOI2132 \
                           OAAAOI2222 \
                            OOOAAOI2224 \
                AAAOAI22211 \
                AAAOAI32211 \
                AAOOAI22121 OOAAOI22121 \
                AAOOAI22131 OOAAOI22131 \
                AAOOOAI2222 OOAAAOI2222 \
                AAOOOAI2232 \
                AAAOOAI2224 \
                AAAOOAI3222 \
                AAAOOAI22221 OOOAAOI22221 \
                AAAOOAI22231 OOOAAOI22231 \
                AAOOOAI22122

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

OOOAAOI2224:    DESCR = "2-2-2-4-input OR-OR-OR-AND-AND-OR-Invert gate"
OOOAAOI2224:    OOOAAOI2223
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

AAAOOAI2224:    DESCR = "2-2-2-4-input AND-AND-AND-OR-OR-AND-Invert gate"
AAAOOAI2224:    AAAOOAI2223
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

AAAOOAI3222:    DESCR = "3-2-2-2-input AND-AND-AND-OR-OR-AND-Invert gate"
AAAOOAI3222:    AAAOAI3221
	$(POPCORN) -m nor -c $@ $< > $@
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

#   --------    four phases     ------------------------------------

CELLS +=        AOAOI2112 OAOAI2112 \
                AOAOI2121 OAOAI2121 \
                AOAOI2122 OAOAI2122 \
                AOAOI2211 OAOAI2211 \
                          OAOAI2221 \
                AOAOI3111 OAOAI3111 \
                AOAOI3112 OAOAI3112 \
                AOAOI3211 OAOAI3211 \
                AAOAOI2212 OOAOAI2212 \
                AAOAOI2221 OOAOAI2221 \
                AAOAOI2222 OOAOAI2222 \
                AAOAOI3211 OOAOAI3211 \
                AAOAOI3212 OOAOAI3212 \
                AAOAOI3311 OOAOAI3311 \
                AOAAOI2114 OAOOAI2114 \
                AOAAOI2122 OAOOAI2122 \
                           OAOOAI2212 \
                AOAAOI2123 OAOOAI2123 \
                           OAOOAI2213 \
                           OAOOAI2222 \
                AOAAOI3112 OAOOAI3112 \
                AOAAOI3113 OAOOAI3113 \
                AOAAOI3212 OAOOAI3212 \
                AOOAOI2122 OAAOAI2122 \
                AOOAOI2131 OAAOAI2131 \
                AOOAOI2221 OAAOAI2221 \
                           OAAOAI2231 \
                AOOAOI3121 OAAOAI3121 \
                AOOAOI3122 OAAOAI3122 \
                AOOAOI3131 OAAOAI3131 \
                AOOAOI3221 OAAOAI3221 \
                AAOAOI22111 OOAOAI22111 \
                AAOAOI22121 OOAOAI22121 \
                AAOAOI32111 OOAOAI32111 \
                AAOAOI33111 \
                AOAAOI21141 \
                AOAAOI21221 OAOOAI21221 \
                AOAAOI31121 OAOOAI31121 \
                AOOAOI21211 OAAOAI21211 \
                AOOAOI21212 OAAOAI21212 \
                AOOAOI21311 OAAOAI21311 \
                            OAAOAI22211 \
                AAOAAOI2214 OOAOOAI2214 \
                AAOAAOI2222 OOAOOAI2222 \
                AAOAAOI3212 OOAOOAI3212 \
                AAOOAOI2222 OOAAOAI2222 \
                AAOOAOI2231 OOAAOAI2231 \
                AAOOAOI3221 OOAAOAI3221 \
                AOAAOI21112 \
                AOAAOI21121 OAOOAI21121 \
                            OAOOAI21131 \
                AOAAOI21131 \
                AOOAAOI2124 OAAOOAI2124 \
                AOOAAOI2132 OAAOOAI2132 \
                            OAAOOAI2222 \
                AOOAAOI3122 OAAOOAI3122 \
                AAAOAOI22211 OOOAOAI22211 \
                AAAOAOI22221 \
                AAAOAOI32211 \
                AAOAAOI22112 OOAOOAI22112 \
                AAOAAOI22121 OOAOOAI22121 \
                AAOAAOI22131 OOAOOAI22131 \
                AAOOAOI22121 OOAAOAI22121 \
                AAOOAOI22131 OOAAOAI22131 \
                AAOOAOI22211 OOAAOAI22211 \
                AAOOAOI22311 \
                AOAAAOI21122 OAOOOAI21122 \
                AOAAAOI21132 \
                AOOAAOI21212 OAAOOAI21212 \
                AOOAAOI21221 OAAOOAI21221 \
                             OAAOOAI21231 \
                AOOAAOI21231 \
                AOOOAOI21221 OAAAOAI21221 \
                AAOOAOI221211 \
                AAOOAAOI2224 OOAAOOAI2224 \
                AAOOAAOI2232 \
                AAAOOAOI22221 OOOAAOAI22221 \
                AAAOOAOI22231 OOOAAOAI22231 \
                AAAOAAOI22212 \
                AAOOAAOI22122 \
                AAOOAAOI22221 OOAAOOAI22221 \
                              OOAAOOAI22231 \
                AAOAAAOI22122 \
                AOOAAAOI21222

AOAOI2112:      DESCR = "2-1-1-2-input AND-OR-AND-OR-Invert gate"
AOAOI2112:      AOAOI2111
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

OAOAI2112:      DESCR = "2-1-1-2-input OR-AND-OR-AND-Invert gate"
OAOAI2112:      OAOAI2111
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

AOAOI2121:      DESCR = "2-1-2-1-input AND-OR-AND-OR-Invert gate"
AOAOI2121:      AOAI212
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

OAOAI2121:      DESCR = "2-1-2-1-input OR-AND-OR-AND-Invert gate"
OAOAI2121:      OAOI212
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

AOAOI2122:      DESCR = "2-1-2-2-input AND-OR-AND-OR-Invert gate"
AOAOI2122:      AOAOI2121
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

OAOAI2122:      DESCR = "2-1-2-2-input OR-AND-OR-AND-Invert gate"
OAOAI2122:      OAOAI2121
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

AOAOI2211:      DESCR = "2-2-1-1-input AND-OR-AND-OR-Invert gate"
AOAOI2211:      AOAI221
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

OAOAI2211:      DESCR = "2-2-1-1-input OR-AND-OR-AND-Invert gate"
OAOAI2211:      OAOI221
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

OAOAI2221:      DESCR = "2-2-2-1-input OR-AND-OR-AND-Invert gate"
OAOAI2221:      OAOI222
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

AOAOI3111:      DESCR = "3-1-1-1-input AND-OR-AND-OR-Invert gate"
AOAOI3111:      AOAI311
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

OAOAI3111:      DESCR = "3-1-1-1-input OR-AND-OR-AND-Invert gate"
OAOAI3111:      OAOI311
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

AOAOI3112:      DESCR = "3-1-1-2-input AND-OR-AND-OR-Invert gate"
AOAOI3112:      AOAOI3111
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

OAOAI3112:      DESCR = "3-1-1-2-input OR-AND-OR-AND-Invert gate"
OAOAI3112:      OAOAI3111
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

AOAOI3211:      DESCR = "3-2-1-1-input AND-OR-AND-OR-Invert gate"
AOAOI3211:      AOAI321
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

OAOAI3211:      DESCR = "3-2-1-1-input OR-AND-OR-AND-Invert gate"
OAOAI3211:      OAOI321
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

AAOAOI2212:     DESCR = "2-2-1-2-input AND-AND-OR-AND-OR-Invert gate"
AAOAOI2212:     AAOAOI2211
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

OOAOAI2212:     DESCR = "2-2-1-2-input OR-OR-AND-OR-AND-Invert gate"
OOAOAI2212:     OOAOAI2211
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

AAOAOI2221:     DESCR = "2-2-2-1-input AND-AND-OR-AND-OR-Invert gate"
AAOAOI2221:     AAOAI222
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

OOAOAI2221:     DESCR = "2-2-2-1-input OR-OR-AND-OR-AND-Invert gate"
OOAOAI2221:     OOAOI222
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

AAOAOI2222:     DESCR = "2-2-2-2-input AND-AND-OR-AND-OR-Invert gate"
AAOAOI2222:     AAOAOI2221
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

OOAOAI2222:     DESCR = "2-2-2-2-input OR-OR-AND-OR-AND-Invert gate"
OOAOAI2222:     OOAOAI2221
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

AAOAOI3211:     DESCR = "3-2-1-1-input AND-AND-OR-AND-OR-Invert gate"
AAOAOI3211:     AAOAI321
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

OOAOAI3211:     DESCR = "3-2-1-1-input OR-OR-AND-OR-AND-Invert gate"
OOAOAI3211:     OOAOI321
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

AAOAOI3212:     DESCR = "3-2-1-2-input AND-AND-OR-AND-OR-Invert gate"
AAOAOI3212:     AAOAOI3211
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

OOAOAI3212:     DESCR = "3-2-1-2-input OR-OR-AND-OR-AND-Invert gate"
OOAOAI3212:     OOAOAI3211
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

AAOAOI3311:     DESCR = "3-3-1-1-input AND-AND-OR-AND-OR-Invert gate"
AAOAOI3311:     AAOAI331
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

OOAOAI3311:     DESCR = "3-3-1-1-input OR-OR-AND-OR-AND-Invert gate"
OOAOAI3311:     OOAOI331
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

AOAAOI2114:     DESCR = "2-1-1-4-input AND-OR-AND-AND-OR-Invert gate"
AOAAOI2114:     AOAAOI2113
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

OAOOAI2114:     DESCR = "2-1-1-4-input OR-AND-OR-OR-AND-Invert gate"
OAOOAI2114:     OAOOAI2113
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

AOAAOI2122:     DESCR = "2-1-2-2-input AND-OR-AND-AND-OR-Invert gate"
AOAAOI2122:     AOAOI2121
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

OAOOAI2122:     DESCR = "2-1-2-2-input OR-AND-OR-OR-AND-Invert gate"
OAOOAI2122:     OAOAI2121
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

OAOOAI2212:     DESCR = "2-2-1-2-input OR-AND-OR-OR-AND-Invert gate"
OAOOAI2212:     OAOAI2211
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

AOAAOI3123:     DESCR = "3-1-2-3-input AND-OR-AND-AND-OR-Invert gate"
AOAAOI3123:     AOAAOI2122
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

AOAAOI2123:     DESCR = "2-1-2-3-input AND-OR-AND-AND-OR-Invert gate"
AOAAOI2123:     AOAAOI2122
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

OAOOAI2123:     DESCR = "2-1-2-3-input OR-AND-OR-OR-AND-Invert gate"
OAOOAI2123:     OAOOAI2122
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

OAOOAI2213:     DESCR = "2-2-1-3-input OR-AND-OR-OR-AND-Invert gate"
OAOOAI2213:     OAOOAI2212
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

OAOOAI2222:     DESCR = "2-2-2-2-input OR-AND-OR-OR-AND-Invert gate"
OAOOAI2222:     OAOAI2221
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

AOAAOI3112:     DESCR = "3-1-1-2-input AND-OR-AND-AND-OR-Invert gate"
AOAAOI3112:     AOAOI3111
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

OAOOAI3112:     DESCR = "3-1-1-2-input OR-AND-OR-OR-AND-Invert gate"
OAOOAI3112:     OAOAI3111
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

AOAAOI3113:     DESCR = "3-1-1-3-input AND-OR-AND-AND-OR-Invert gate"
AOAAOI3113:     AOAAOI3112
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

OAOOAI3113:     DESCR = "3-1-1-3-input OR-AND-OR-OR-AND-Invert gate"
OAOOAI3113:     OAOOAI3112
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

AOAAOI3212:     DESCR = "3-2-1-2-input AND-OR-AND-AND-OR-Invert gate"
AOAAOI3212:     AOAOI3211
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

OAOOAI3212:     DESCR = "3-2-1-2-input OR-AND-OR-OR-AND-Invert gate"
OAOOAI3212:     OAOAI3211
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

AOOAOI2122:     DESCR = "2-1-2-2-input AND-OR-OR-AND-OR-Invert gate"
AOOAOI2122:     AOOAOI2121
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

OAAOAI2122:     DESCR = "2-1-2-2-input OR-AND-AND-OR-AND-Invert gate"
OAAOAI2122:     OAAOAI2121
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

AOOAOI2131:     DESCR = "2-1-3-1-input AND-OR-OR-AND-OR-Invert gate"
AOOAOI2131:     AOOAI213
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

OAAOAI2131:     DESCR = "2-1-3-1-input OR-AND-AND-OR-AND-Invert gate"
OAAOAI2131:     OAAOI213
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

AOOAOI2221:     DESCR = "2-2-2-1-input AND-OR-OR-AND-OR-Invert gate"
AOOAOI2221:     AOOAI222
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

OAAOAI2221:     DESCR = "2-2-2-1-input OR-AND-AND-OR-AND-Invert gate"
OAAOAI2221:     OAAOI222
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

OAAOAI2231:     DESCR = "2-2-3-1-input OR-AND-AND-OR-AND-Invert gate"
OAAOAI2231:     OAAOI223
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

AOOAOI3121:     DESCR = "3-1-2-1-input AND-OR-OR-AND-OR-Invert gate"
AOOAOI3121:     AOOAI312
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

OAAOAI3121:     DESCR = "3-1-2-1-input OR-AND-AND-OR-AND-Invert gate"
OAAOAI3121:     OAAOI312
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

AOOAOI3122:     DESCR = "3-1-2-2-input AND-OR-OR-AND-OR-Invert gate"
AOOAOI3122:     AOOAOI3121
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

OAAOAI3122:     DESCR = "3-1-2-2-input OR-AND-AND-OR-AND-Invert gate"
OAAOAI3122:     OAAOAI3121
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

AOOAOI3131:     DESCR = "3-1-3-1-input AND-OR-OR-AND-OR-Invert gate"
AOOAOI3131:     AOOAI313
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

OAAOAI3131:     DESCR = "3-1-3-1-input OR-AND-AND-OR-AND-Invert gate"
OAAOAI3131:     OAAOI313
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

AOOAOI3221:     DESCR = "3-2-2-1-input AND-OR-OR-AND-OR-Invert gate"
AOOAOI3221:     AOOAI322
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

OAAOAI3221:     DESCR = "3-2-2-1-input OR-AND-AND-OR-AND-Invert gate"
OAAOAI3221:     OAAOI322
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

AAOAOI22111:    DESCR = "2-2-1-1-1-input AND-AND-OR-AND-OR-Invert gate"
AAOAOI22111:    AAOAI2211
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

OOAOAI22111:    DESCR = "2-2-1-1-1-input OR-OR-AND-OR-AND-Invert gate"
OOAOAI22111:    OOAOI2211
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

AAOAOI22121:    DESCR = "2-2-1-2-1-input AND-AND-OR-AND-OR-Invert gate"
AAOAOI22121:    AAOAI2212
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

OOAOAI22121:    DESCR = "2-2-1-2-1-input OR-OR-AND-OR-AND-Invert gate"
OOAOAI22121:    OOAOI2212
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

AAOAOI32111:    DESCR = "3-2-1-1-1-input AND-AND-OR-AND-OR-Invert gate"
AAOAOI32111:    AAOAI3211
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

OOAOAI32111:    DESCR = "3-2-1-1-1-input OR-OR-AND-OR-AND-Invert gate"
OOAOAI32111:    OOAOI3211
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

AAOAOI33111:    DESCR = "3-3-1-1-1-input AND-AND-OR-AND-OR-Invert gate"
AAOAOI33111:    AAOAI3311
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

AOAAOI21141:    DESCR = "2-1-1-4-1-input AND-OR-AND-AND-OR-Invert gate"
AOAAOI21141:    AOAAOI2114
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

AOAAOI21221:    DESCR = "2-1-2-2-1-input AND-OR-AND-AND-OR-Invert gate"
AOAAOI21221:    AOAAOI2122
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

OAOOAI21221:    DESCR = "2-1-2-2-1-input OR-AND-OR-OR-AND-Invert gate"
OAOOAI21221:    OAOOAI2122
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

AOAAOI31121:    DESCR = "3-1-1-2-1-input AND-OR-AND-AND-OR-Invert gate"
AOAAOI31121:    AOAAOI3112
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

OAOOAI31121:    DESCR = "3-1-1-2-1-input OR-AND-OR-OR-AND-Invert gate"
OAOOAI31121:    OAOOAI3112
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

AOOAOI21211:    DESCR = "2-1-2-1-1-input AND-OR-OR-AND-OR-Invert gate"
AOOAOI21211:    AOOAI2121
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

OAAOAI21211:    DESCR = "2-1-2-1-1-input OR-AND-AND-OR-AND-Invert gate"
OAAOAI21211:    OAAOAI2121
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

AOOAOI21212:    DESCR = "2-1-2-1-2-input AND-OR-OR-AND-OR-Invert gate"
AOOAOI21212:    AOOAOI21211
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

OAAOAI21212:    DESCR = "2-1-2-1-2-input OR-AND-AND-OR-AND-Invert gate"
OAAOAI21212:    OAAOAI21211
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

AOOAOI21311:    DESCR = "2-1-3-1-1-input AND-OR-OR-AND-OR-Invert gate"
AOOAOI21311:    AOOAI2131
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

OAAOAI21311:    DESCR = "2-1-3-1-1-input OR-AND-AND-OR-AND-Invert gate"
OAAOAI21311:    OAAOI2131
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

OAAOAI22211:    DESCR = "2-2-2-1-1-input OR-AND-AND-OR-AND-Invert gate"
OAAOAI22211:    OAAOI2221
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

AAOAAOI2214:    DESCR = "2-2-1-4-input AND-AND-OR-AND-AND-OR-Invert gate"
AAOAAOI2214:    AAOAAOI2213
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

OOAOOAI2214:    DESCR = "2-2-1-4-input OR-OR-AND-OR-OR-AND-Invert gate"
OOAOOAI2214:    OOAOOAI2213
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

AAOAAOI2222:    DESCR = "2-2-2-2-input AND-AND-OR-AND-AND-OR-Invert gate"
AAOAAOI2222:    AAOAOI2221
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

OOAOOAI2222:    DESCR = "2-2-2-2-input OR-OR-AND-OR-OR-AND-Invert gate"
OOAOOAI2222:    OOAOAI2221
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

AAOAAOI3212:    DESCR = "3-2-1-2-input AND-AND-OR-AND-AND-OR-Invert gate"
AAOAAOI3212:    AAOAOI3211
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

OOAOOAI3212:    DESCR = "3-2-1-2-input OR-OR-AND-OR-OR-AND-Invert gate"
OOAOOAI3212:    OOAOAI3211
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

AAOOAOI2222:    DESCR = "2-2-2-2-input AND-AND-OR-OR-AND-OR-Invert gate"
AAOOAOI2222:    AAOOAOI2221
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

OOAAOAI2222:    DESCR = "2-2-2-2-input OR-OR-AND-AND-OR-AND-Invert gate"
OOAAOAI2222:    OOAAOAI2221
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

AAOOAOI2231:    DESCR = "2-2-3-1-input AND-AND-OR-OR-AND-OR-Invert gate"
AAOOAOI2231:    AAOOAI223
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

OOAAOAI2231:    DESCR = "2-2-3-1-input OR-OR-AND-AND-OR-AND-Invert gate"
OOAAOAI2231:    OOAAOI223
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

AAOOAOI3221:    DESCR = "3-2-2-1-input AND-AND-OR-OR-AND-OR-Invert gate"
AAOOAOI3221:    AAOOAI322
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

OOAAOAI3221:    DESCR = "3-2-2-1-input OR-OR-AND-AND-OR-AND-Invert gate"
OOAAOAI3221:    OOAAOI322
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

AOAAOI21112:    DESCR = "2-1-1-1-2-input AND-OR-AND-AND-OR-Invert gate"
AOAAOI21112:    AOAAOI2112
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

AOAAOI21121:    DESCR = "2-1-1-2-1-input AND-OR-AND-AND-OR-Invert gate"
AOAAOI21121:    AOAAOI2112
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

OAOOAI21121:    DESCR = "2-1-1-2-1-input OR-AND-OR-OR-AND-Invert gate"
OAOOAI21121:    OAOOAI2112
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

OAOOAI21131:    DESCR = "2-1-1-3-1-input OR-AND-OR-OR-AND-Invert gate"
OAOOAI21131:    OAOOAI2113
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

AOAAOI21131:    DESCR = "2-1-1-3-1-input AND-OR-AND-AND-OR-Invert gate"
AOAAOI21131:    AOAAOI2113
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

AOOAAOI2124:    DESCR = "2-1-2-4-input AND-OR-OR-AND-AND-OR-Invert gate"
AOOAAOI2124:    AOOAAOI2123
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

OAAOOAI2124:    DESCR = "2-1-2-4-input OR-AND-AND-OR-OR-AND-Invert gate"
OAAOOAI2124:    OAAOOAI2123
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

AOOAAOI2132:    DESCR = "2-1-3-1-input AND-OR-OR-AND-AND-OR-Invert gate"
AOOAAOI2132:    AOOAOI2131
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

OAAOOAI2132:    DESCR = "2-1-3-1-input OR-AND-AND-OR-OR-AND-Invert gate"
OAAOOAI2132:    OAAOAI2131
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

OAAOOAI2222:    DESCR = "2-2-2-1-input OR-AND-AND-OR-OR-AND-Invert gate"
OAAOOAI2222:    OAAOAI2221
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

AOOAAOI3122:    DESCR = "3-1-2-2-input AND-OR-OR-AND-AND-OR-Invert gate"
AOOAAOI3122:    AOOAOI3121
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

OAAOOAI3122:    DESCR = "3-1-2-2-input OR-AND-AND-OR-OR-AND-Invert gate"
OAAOOAI3122:    OAAOAI3121
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

AAAOAOI22211:   DESCR = "2-2-2-1-1-input AND-AND-AND-OR-AND-OR-Invert gate"
AAAOAOI22211:   AAAOAI2221
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

OOOAOAI22211:   DESCR = "2-2-2-1-1-input OR-OR-OR-AND-OR-AND-Invert gate"
OOOAOAI22211:   OOOAOI2221
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

AAAOAOI22221:   DESCR = "2-2-2-2-1-input AND-AND-AND-OR-AND-OR-Invert gate"
AAAOAOI22221:   AAAOAI2222
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

AAAOAOI32211:   DESCR = "3-2-2-1-1-input AND-AND-AND-OR-AND-OR-Invert gate"
AAAOAOI32211:   AAAOAI3221
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

AAOAAOI22112:   DESCR = "2-2-1-1-2-input AND-AND-OR-AND-AND-OR-Invert gate"
AAOAAOI22112:   AAOAOI22111
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

OOAOOAI22112:   DESCR = "2-2-1-1-2-input OR-OR-AND-OR-OR-AND-Invert gate"
OOAOOAI22112:   OOAOAI22111
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

AAOAAOI22121:   DESCR = "2-2-1-2-1-input AND-AND-OR-AND-AND-OR-Invert gate"
AAOAAOI22121:   AAOAAOI2212
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

OOAOOAI22121:   DESCR = "2-2-1-2-1-input OR-OR-AND-OR-OR-AND-Invert gate"
OOAOOAI22121:   OOAOOAI2212
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

AAOAAOI22131:   DESCR = "2-2-1-3-1-input AND-AND-OR-AND-AND-OR-Invert gate"
AAOAAOI22131:   AAOAAOI2213
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

OOAOOAI22131:   DESCR = "2-2-1-3-1-input OR-OR-AND-OR-OR-AND-Invert gate"
OOAOOAI22131:   OOAOOAI2213
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

AAOOAOI22121:   DESCR = "2-2-1-2-1-input AND-AND-OR-OR-AND-OR-Invert gate"
AAOOAOI22121:   AAOOAI2212
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

OOAAOAI22121:   DESCR = "2-2-1-2-1-input OR-OR-AND-AND-OR-AND-Invert gate"
OOAAOAI22121:   OOAAOI2212
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

AAOOAOI22131:   DESCR = "2-2-1-3-1-input AND-AND-OR-OR-AND-OR-Invert gate"
AAOOAOI22131:   AAOOAI2213
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

OOAAOAI22131:   DESCR = "2-2-1-3-1-input OR-OR-AND-AND-OR-AND-Invert gate"
OOAAOAI22131:   OOAAOI2213
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

AAOOAOI22211:   DESCR = "2-2-2-1-1-input AND-AND-OR-OR-AND-OR-Invert gate"
AAOOAOI22211:   AAOOAI2221
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

OOAAOAI22211:   DESCR = "2-2-2-1-1-input OR-OR-AND-AND-OR-AND-Invert gate"
OOAAOAI22211:   OOAAOI2221
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

AAOOAOI22311:   DESCR = "2-2-3-1-1-input AND-AND-OR-OR-AND-OR-Invert gate"
AAOOAOI22311:   AAOOAI2231
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

AOAAAOI21122:   DESCR = "2-1-1-2-2-input AND-OR-AND-AND-AND-OR-Invert gate"
AOAAAOI21122:   AOAAOI21121
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

OAOOOAI21122:   DESCR = "2-1-1-2-2-input OR-AND-OR-OR-OR-AND-Invert gate"
OAOOOAI21122:   OAOOAI21121
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

AOAAAOI21132:   DESCR = "2-1-1-3-2-input AND-OR-AND-AND-AND-OR-Invert gate"
AOAAAOI21132:   AOAAOI21131
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

AOOAAOI21212:   DESCR = "2-1-2-1-2-input AND-OR-OR-AND-AND-OR-Invert gate"
AOOAAOI21212:   AOOAOI21211
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

OAAOOAI21212:   DESCR = "2-1-2-1-2-input OR-AND-AND-OR-OR-AND-Invert gate"
OAAOOAI21212:   OAAOAI21211
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

AOOAAOI21221:   DESCR = "2-1-2-2-1-input AND-OR-OR-AND-AND-OR-Invert gate"
AOOAAOI21221:   AOOAAOI2122
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

OAAOOAI21221:   DESCR = "2-1-2-2-1-input OR-AND-AND-OR-OR-AND-Invert gate"
OAAOOAI21221:   OAAOOAI2122
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

OAAOOAI21231:   DESCR = "2-1-2-3-1-input OR-AND-AND-OR-OR-AND-Invert gate"
OAAOOAI21231:   OAAOOAI2123
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

AOOAAOI21231:   DESCR = "2-1-2-3-1-input AND-OR-OR-AND-AND-OR-Invert gate"
AOOAAOI21231:   AOOAAOI2123
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

AOOOAOI21221:   DESCR = "2-1-2-2-1-input AND-OR-OR-OR-AND-OR-Invert gate"
AOOOAOI21221:   AOOOAI2122
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

OAAAOAI21221:   DESCR = "2-1-2-2-1-input OR-AND-AND-AND-OR-AND-Invert gate"
OAAAOAI21221:   OAAAOI2122
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

AAOOAOI221211:  DESCR = "2-2-1-2-2-1-input AND-AND-OR-OR-AND-OR-Invert gate"
AAOOAOI221211:  AAOOAI22121
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

AAOOAAOI2224:   DESCR = "2-2-2-4-input AND-AND-OR-OR-AND-AND-OR-Invert gate"
AAOOAAOI2224:   AAOOAAOI2223
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

OOAAOOAI2224:   DESCR = "2-2-2-4-input OR-OR-AND-AND-OR-OR-AND-Invert gate"
OOAAOOAI2224:   OOAAOOAI2223
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

AAOOAAOI2232:   DESCR = "2-2-3-2-input AND-AND-OR-OR-AND-AND-OR-Invert gate"
AAOOAAOI2232:   AAOOAOI2231
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

AAAOOAOI22221:  DESCR = "2-2-2-2-1-input AND-AND-AND-OR-OR-AND-OR-Invert gate"
AAAOOAOI22221:  AAAOOAI2222
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

OOOAAOAI22221:  DESCR = "2-2-2-2-1-input OR-OR-OR-AND-AND-OR-AND-Invert gate"
OOOAAOAI22221:  OOOAAOI2222
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

AAAOOAOI22231:  DESCR = "2-2-2-3-1-input AND-AND-AND-OR-OR-AND-OR-Invert gate"
AAAOOAOI22231:  AAAOOAI2223
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

OOOAAOAI22231:  DESCR = "2-2-2-3-1-input OR-OR-OR-AND-AND-OR-AND-Invert gate"
OOOAAOAI22231:  OOOAAOI2223
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

AAAOAAOI22212:  DESCR = "2-2-2-1-2-input AND-AND-AND-OR-AND-AND-OR-Invert gate"
AAAOAAOI22212:  AAAOAOI22211
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

AAOOAAOI22122:  DESCR = "2-2-1-2-2-input AND-AND-OR-OR-AND-AND-OR-Invert gate"
AAOOAAOI22122:  AAOOAOI22121
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

AAOOAAOI22221:  DESCR = "2-2-2-2-1-input AND-AND-OR-OR-AND-AND-OR-Invert gate"
AAOOAAOI22221:  AAOOAAOI2222
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

OOAAOOAI22221:  DESCR = "2-2-2-2-1-input OR-OR-AND-AND-OR-OR-AND-Invert gate"
OOAAOOAI22221:  OOAAOOAI2222
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

OOAAOOAI22231:  DESCR = "2-2-2-3-1-input OR-OR-AND-AND-OR-OR-AND-Invert gate"
OOAAOOAI22231:  OOAAOOAI2223
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

AAOAAAOI22122:  DESCR = "2-2-1-2-2-input AND-AND-OR-AND-AND-AND-OR-Invert gate"
AAOAAAOI22122:  AAOAAOI22121
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

AOOAAAOI21222:  DESCR = "2-1-2-2-2-input AND-OR-OR-AND-AND-AND-OR-Invert gate"
AOOAAAOI21222:  AOOAAOI21221
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

#   --------    five phases     ------------------------------------

CELLS +=        AOAOAI21111 OAOAOI21111 \
                AOAOAI21121 OAOAOI21121 \
                            OAOAOI21122 \
                            OAOAOI22111 \
                            OAOAOI32111 \
                AAOAOAI22111 OOAOAOI22111 \
                AAOAOAI22121 OOAOAOI22121 \
                AOAAOAI21121 OAOOAOI21121 \
                AOAAOAI21131 OAOOAOI21131 \
                             OAOOAOI22121 \
                AOAOOAI21112 OAOAAOI21112 \
                AOAOOAI21113 OAOAAOI21113 \
                AOAOOAI21122 OAOAAOI21122 \
                             OAOAAOI22112 \
                AOOAOAI21211 OAAOAOI21211 \
                AOOAOAI21221 OAAOAOI21221 \
                AOOAOAI21311 OAAOAOI21311 \
                             OAAOAOI22211 \
                AAOAOAI221111 OOAOAOI221111 \
                AOAAOAI211211 OAOOAOI211211 \
                AOAAOAI211311 OAOOAOI211311 \
                AAOAAOAI22121 OOAOOAOI22121 \
                AAOAAOAI22122 \
                AAOAAOAI22131 OOAOOAOI22131 \
                AAOAOOAI22112 OOAOAAOI22112 \
                AAOOAOAI22211 OOAAOAOI22211 \
                AAOOAOAI22221 \
                AAOOAOAI22311 \
                AOAAOOAI21122 OAOOAAOI21122 \
                AOAAOOAI21132 \
                AOOAAOAI21221 OAAOOAOI21221 \
                              OAAOOAOI21231 \
                AOOAAOAI21231 \
                AOOAOOAI21212 OAAOAAOI21212 \
                AAAOAOAI222111 \
                AAOOAOAI221211 \
                AAOAAOAI221211 \
                AOOAAOAI212211 \
                AAOOAAOAI22221 OOAAOOAOI22221 \
                AAOOAAOAI22231 OOAAOOAOI22231 \
                AAOAAOOAI22122 \
                AOOAAOOAI21222 \
                AAOOAOOAI22212

AOAOAI21111:    DESCR = "2-1-1-1-1-input AND-OR-AND-OR-AND-Invert gate"
AOAOAI21111:    AOAOI2111
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

OAOAOI21111:    DESCR = "2-1-1-1-1-input OR-AND-OR-AND-OR-Invert gate"
OAOAOI21111:    OAOAI2111
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

AOAOAI21121:    DESCR = "2-1-1-2-1-input AND-OR-AND-OR-AND-Invert gate"
AOAOAI21121:    AOAOI2112
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

OAOAOI21121:    DESCR = "2-1-1-2-1-input OR-AND-OR-AND-OR-Invert gate"
OAOAOI21121:    OAOAI2112
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

OAOAOI21122:    DESCR = "2-1-1-2-2-input OR-AND-OR-AND-OR-Invert gate"
OAOAOI21122:    OAOAOI21121
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

OAOAOI22111:    DESCR = "2-2-1-1-1-input OR-AND-OR-AND-OR-Invert gate"
OAOAOI22111:    OAOAI2211
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

OAOAOI32111:    DESCR = "3-2-1-1-1-input OR-AND-OR-AND-OR-Invert gate"
OAOAOI32111:    OAOAI3211
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

AAOAOAI22111:   DESCR = "2-2-1-1-1-input AND-AND-OR-AND-OR-AND-Invert gate"
AAOAOAI22111:   AAOAOI2211
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

OOAOAOI22111:   DESCR = "2-2-1-1-1-input OR-OR-AND-OR-AND-OR-Invert gate"
OOAOAOI22111:   OOAOAI2211
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

AAOAOAI22121:   DESCR = "2-2-1-2-1-input AND-AND-OR-AND-OR-AND-Invert gate"
AAOAOAI22121:   AAOAOI2212
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

OOAOAOI22121:   DESCR = "2-2-1-2-1-input OR-OR-AND-OR-AND-OR-Invert gate"
OOAOAOI22121:   OOAOAI2212
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

AOAAOAI21121:   DESCR = "2-1-1-2-1-input AND-OR-AND-AND-OR-AND-Invert gate"
AOAAOAI21121:   AOAAOI2112
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

OAOOAOI21121:   DESCR = "2-1-1-2-1-input OR-AND-OR-OR-AND-OR-Invert gate"
OAOOAOI21121:   OAOOAI2112
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

AOAAOAI21131:   DESCR = "2-1-1-3-1-input AND-OR-AND-AND-OR-AND-Invert gate"
AOAAOAI21131:   AOAAOI2113
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

OAOOAOI21131:   DESCR = "2-1-1-3-1-input OR-AND-OR-OR-AND-OR-Invert gate"
OAOOAOI21131:   OAOOAI2113
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

OAOOAOI22121:   DESCR = "2-2-1-2-1-input OR-AND-OR-OR-AND-OR-Invert gate"
OAOOAOI22121:   OAOOAI2212
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

AOAOOAI21112:   DESCR = "2-1-1-1-2-input AND-OR-AND-OR-OR-AND-Invert gate"
AOAOOAI21112:   AOAOAI21111
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

OAOAAOI21112:   DESCR = "2-1-1-1-2-input OR-AND-OR-AND-AND-OR-Invert gate"
OAOAAOI21112:   OAOAOI21111
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

AOAOOAI21113:   DESCR = "2-1-1-1-3-input AND-OR-AND-OR-OR-AND-Invert gate"
AOAOOAI21113:   AOAOOAI21112
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

OAOAAOI21113:   DESCR = "2-1-1-1-3-input OR-AND-OR-AND-AND-OR-Invert gate"
OAOAAOI21113:   OAOAAOI21112
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

AOAOOAI21122:   DESCR = "2-1-1-2-2-input AND-OR-AND-OR-OR-AND-Invert gate"
AOAOOAI21122:   AOAOAI21121
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

OAOAAOI21122:   DESCR = "2-1-1-2-2-input OR-AND-OR-AND-AND-OR-Invert gate"
OAOAAOI21122:   OAOAOI21121
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

OAOAAOI22112:   DESCR = "2-2-1-1-2-input OR-AND-OR-AND-AND-OR-Invert gate"
OAOAAOI22112:   OAOAOI22111
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

AOOAOAI21211:   DESCR = "2-1-2-1-1-input AND-OR-OR-AND-OR-AND-Invert gate"
AOOAOAI21211:   AOOAOI2121
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

OAAOAOI21211:   DESCR = "2-1-2-1-1-input OR-AND-AND-OR-AND-OR-Invert gate"
OAAOAOI21211:   OAAOAI2121
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

AOOAOAI21221:   DESCR = "2-1-2-2-1-input AND-OR-OR-AND-OR-AND-Invert gate"
AOOAOAI21221:   AOOAOI2122
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

OAAOAOI21221:   DESCR = "2-1-2-2-1-input OR-AND-AND-OR-AND-OR-Invert gate"
OAAOAOI21221:   OAAOAI2122
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

AOOAOAI21311:   DESCR = "2-1-3-1-1-input AND-OR-OR-AND-OR-AND-Invert gate"
AOOAOAI21311:   AOOAOI2131
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

OAAOAOI21311:   DESCR = "2-1-3-1-1-input OR-AND-AND-OR-AND-OR-Invert gate"
OAAOAOI21311:   OAAOAI2131
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

OAAOAOI22211:   DESCR = "2-2-2-1-1-input OR-AND-AND-OR-AND-OR-Invert gate"
OAAOAOI22211:   OAAOAI2221
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

AAOAOAI221111:  DESCR = "2-2-1-1-1-1-input AND-AND-OR-AND-OR-AND-Invert gate"
AAOAOAI221111:  AAOAOI22111
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

OOAOAOI221111:  DESCR = "2-2-1-1-1-1-input OR-OR-AND-OR-AND-OR-Invert gate"
OOAOAOI221111:  OOAOAI22111
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

AOAAOAI211211:  DESCR = "2-1-1-2-1-1-input AND-OR-AND-AND-OR-AND-Invert gate"
AOAAOAI211211:  AOAAOI21121
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

OAOOAOI211211:  DESCR = "2-1-1-2-1-1-input OR-AND-OR-OR-AND-OR-Invert gate"
OAOOAOI211211:  OAOOAI21121
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

AOAAOAI211311:  DESCR = "2-1-1-3-1-1-input AND-OR-AND-AND-OR-AND-Invert gate"
AOAAOAI211311:  AOAAOI21131
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

OAOOAOI211311:  DESCR = "2-1-1-3-1-1-input OR-AND-OR-OR-AND-OR-Invert gate"
OAOOAOI211311:  OAOOAI21131
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

AAOAAOAI22121:  DESCR = "2-2-1-2-1-input AND-AND-OR-AND-AND-OR-AND-Invert gate"
AAOAAOAI22121:  AAOAAOI2212
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

OOAOOAOI22121:  DESCR = "2-2-1-2-1-input OR-OR-AND-OR-OR-AND-OR-Invert gate"
OOAOOAOI22121:  OOAOOAI2212
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

AAOAAOAI22122:  DESCR = "2-2-1-2-2-input AND-AND-OR-AND-AND-OR-AND-Invert gate"
AAOAAOAI22122:  AAOAAOAI22121
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

AAOAAOAI22131:  DESCR = "2-2-1-3-1-input AND-AND-OR-AND-AND-OR-AND-Invert gate"
AAOAAOAI22131:  AAOAAOI2213
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

OOAOOAOI22131:  DESCR = "2-2-1-3-1-input OR-OR-AND-OR-OR-AND-OR-Invert gate"
OOAOOAOI22131:  OOAOOAI2213
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

AAOAOOAI22112:  DESCR = "2-2-1-1-2-input AND-AND-OR-AND-OR-OR-AND-Invert gate"
AAOAOOAI22112:  AAOAOAI22111
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

OOAOAAOI22112:  DESCR = "2-2-1-1-2-input OR-OR-AND-OR-AND-AND-OR-Invert gate"
OOAOAAOI22112:  OOAOAOI22111
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

AAOOAOAI22211:  DESCR = "2-2-2-1-1-input AND-AND-OR-OR-AND-OR-AND-Invert gate"
AAOOAOAI22211:  AAOOAOI2221
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

OOAAOAOI22211:  DESCR = "2-2-2-1-1-input OR-OR-AND-AND-OR-AND-OR-Invert gate"
OOAAOAOI22211:  OOAAOAI2221
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

AAOOAOAI22221:  DESCR = "2-2-2-2-1-input AND-AND-OR-OR-AND-OR-AND-Invert gate"
AAOOAOAI22221:  AAOOAOI2222
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

AAOOAOAI22311:  DESCR = "2-2-3-1-1-input AND-AND-OR-OR-AND-OR-AND-Invert gate"
AAOOAOAI22311:  AAOOAOI2231
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

AOAAOOAI21122:  DESCR = "2-1-1-2-2-input AND-OR-AND-AND-OR-OR-AND-Invert gate"
AOAAOOAI21122:  AOAAOAI21121
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

OAOOAAOI21122:  DESCR = "2-1-1-2-2-input OR-AND-OR-OR-AND-AND-OR-Invert gate"
OAOOAAOI21122:  OAOOAOI21121
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

AOAAOOAI21132:  DESCR = "2-1-1-3-2-input AND-OR-AND-AND-OR-OR-AND-Invert gate"
AOAAOOAI21132:  AOAAOAI21131
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

AOOAAOAI21221:  DESCR = "2-1-2-2-1-input AND-OR-OR-AND-AND-OR-AND-Invert gate"
AOOAAOAI21221:  AOOAAOI2122
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

OAAOOAOI21221:  DESCR = "2-1-2-2-1-input OR-AND-AND-OR-OR-AND-OR-Invert gate"
OAAOOAOI21221:  OAAOOAI2122
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

OAAOOAOI21231:  DESCR = "2-1-2-3-1-input OR-AND-AND-OR-OR-AND-OR-Invert gate"
OAAOOAOI21231:  OAAOOAI2123
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

AOOAAOAI21231:  DESCR = "2-1-2-3-1-input AND-OR-OR-AND-AND-OR-AND-Invert gate"
AOOAAOAI21231:  AOOAAOI2123
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

AOOAOOAI21212:  DESCR = "2-1-2-1-2-input AND-OR-OR-AND-OR-OR-AND-Invert gate"
AOOAOOAI21212:  AOOAOAI21211
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

OAAOAAOI21212:  DESCR = "2-1-2-1-2-input OR-AND-AND-OR-AND-AND-OR-Invert gate"
OAAOAAOI21212:  OAAOAOI21211
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

AAAOAOAI222111: DESCR = "2-2-2-1-1-1-input AND-AND-AND-OR-AND-OR-AND-Invert gate"
AAAOAOAI222111: AAAOAOI22211
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

AAOOAOAI221211: DESCR = "2-2-1-2-1-1-input AND-AND-OR-OR-AND-OR-AND-Invert gate"
AAOOAOAI221211: AAOOAOI22121
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

AAOAAOAI221211: DESCR = "2-2-1-2-1-1-input AND-AND-OR-AND-AND-OR-AND-Invert gate"
AAOAAOAI221211: AAOAAOI22121
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

AOOAAOAI212211: DESCR = "2-1-2-2-1-1-input AND-OR-OR-AND-AND-OR-AND-Invert gate"
AOOAAOAI212211: AOOAAOI21221
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

AAOOAAOAI22221: DESCR = "2-2-2-2-1-input AND-AND-OR-OR-AND-AND-OR-AND-Invert gate"
AAOOAAOAI22221: AAOOAAOI2222
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

OOAAOOAOI22221: DESCR = "2-2-2-2-1-input OR-OR-AND-AND-OR-OR-AND-OR-Invert gate"
OOAAOOAOI22221: OOAAOOAI2222
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

AAOOAAOAI22231: DESCR = "2-2-2-3-1-input AND-AND-OR-OR-AND-AND-OR-AND-Invert gate"
AAOOAAOAI22231: AAOOAAOI2223
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

OOAAOOAOI22231: DESCR = "2-2-2-3-1-input OR-OR-AND-AND-OR-OR-AND-OR-Invert gate"
OOAAOOAOI22231: OOAAOOAI2223
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

AAOAAOOAI22122: DESCR = "2-2-1-2-2-input AND-AND-OR-AND-AND-OR-OR-AND-Invert gate"
AAOAAOOAI22122: AAOAAOAI22121
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

AOOAAOOAI21222: DESCR = "2-1-2-2-2-input AND-OR-OR-AND-AND-OR-OR-AND-Invert gate"
AOOAAOOAI21222: AOOAAOAI21221
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

AAOOAOOAI22212: DESCR = "2-2-2-1-2-input AND-AND-OR-OR-AND-OR-OR-AND-Invert gate"
AAOOAOOAI22212: AAOOAOAI22211
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

#   --------    six phases      ------------------------------------

CELLS +=        AOAOAOI211111 OAOAOAI211111 \
                AAOAOAOI221111 OOAOAOAI221111 \
                AOAAOAOI211211 OAOOAOAI211211 \
                AOAAOAOI211311 \
                AOAOAAOI211112 OAOAOOAI211112 \
                AOAOAAOI211113 \
                AOAOOAOI211121 OAOAAOAI211121 \
                AOOAOAOI212111 OAAOAOAI212111 \
                AAOOAOAOI222111 \
                AAOAAOAOI221211 \
                AOOAAOAOI212211

AOAOAOI211111:  DESCR = "2-1-1-1-1-1-input AND-OR-AND-OR-AND-OR-Invert gate"
AOAOAOI211111:  AOAOAI21111
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

OAOAOAI211111:  DESCR = "2-1-1-1-1-1-input OR-AND-OR-AND-OR-AND-Invert gate"
OAOAOAI211111:  OAOAOI21111
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

AAOAOAOI221111: DESCR = "2-2-1-1-1-1-input AND-AND-OR-AND-OR-AND-OR-Invert gate"
AAOAOAOI221111: AAOAOAI22111
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

OOAOAOAI221111: DESCR = "2-2-1-1-1-1-input OR-OR-AND-OR-AND-OR-AND-Invert gate"
OOAOAOAI221111: OOAOAOI22111
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

AOAAOAOI211211: DESCR = "2-1-1-2-1-1-input AND-OR-AND-AND-OR-AND-OR-Invert gate"
AOAAOAOI211211: AOAAOAI21121
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

OAOOAOAI211211: DESCR = "2-1-1-2-1-1-input OR-AND-OR-OR-AND-OR-AND-Invert gate"
OAOOAOAI211211: OAOOAOI21121
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

AOAAOAOI211311: DESCR = "2-1-1-3-1-1-input AND-OR-AND-AND-OR-AND-OR-Invert gate"
AOAAOAOI211311: AOAAOAI21131
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

AOAOAAOI211112: DESCR = "2-1-1-1-1-2-input AND-OR-AND-OR-AND-AND-OR-Invert gate"
AOAOAAOI211112: AOAOAOI211111
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

OAOAOOAI211112: DESCR = "2-1-1-1-1-2-input OR-AND-OR-AND-OR-OR-AND-Invert gate"
OAOAOOAI211112: OAOAOAI211111
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

AOAOAAOI211113: DESCR = "2-1-1-1-1-31-input AND-OR-AND-OR-AND-AND-OR-Invert gate"
AOAOAAOI211113: AOAOAAOI211112
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

AOAOOAOI211121: DESCR = "2-1-1-1-2-1-input AND-OR-AND-OR-OR-AND-OR-Invert gate"
AOAOOAOI211121: AOAOOAI21112
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

OAOAAOAI211121: DESCR = "2-1-1-1-2-1-input OR-AND-OR-AND-AND-OR-AND-Invert gate"
OAOAAOAI211121: AOAOOAI21112
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

AOOAOAOI212111: DESCR = "2-1-2-1-1-1-input AND-OR-OR-AND-OR-AND-OR-Invert gate"
AOOAOAOI212111: AOOAOAI21211
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

OAAOAOAI212111: DESCR = "2-1-2-1-1-1-input OR-AND-AND-OR-AND-OR-AND-Invert gate"
OAAOAOAI212111: OAAOAOI21211
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

AAOOAOAOI222111: DESCR = "2-2-2-1-1-1-input AND-AND-OR-OR-AND-OR-AND-OR-Invert gate"
AAOOAOAOI222111: AAOOAOAI22211
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

AAOAAOAOI221211: DESCR = "2-2-1-2-1-1-input AND-AND-OR-AND-AND-OR-AND-OR-Invert gate"
AAOAAOAOI221211: AAOAAOAI22121
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

AOOAAOAOI212211: DESCR = "2-1-2-2-1-1-input AND-OR-OR-AND-AND-OR-AND-OR-Invert gate"
AOOAAOAOI212211: AOOAAOAI21221
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)
