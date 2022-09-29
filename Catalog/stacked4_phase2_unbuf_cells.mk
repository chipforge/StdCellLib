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
#   File:           StdCellLib/Catalog/stacked4_phase2_unbuf_cells.mk
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

#   Dependencies for cells with 4 stacked transistors and up to 2 phases,
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
                AAAAOI2222 OOOOAI2222 \
                           OOOOAI3222 \
                AAAAOI3322 OOOOAI3322

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

AAAAOI2222:     DESCR = "2-2-2-2-input AND-AND-AND-AND-OR-Invert gate"
AAAAOI2222:     AAAOI2221
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

OOOOAI2222:     DESCR = "2-2-2-2-input OR-OR-OR-OR-AND-Invert gate"
OOOOAI2222:     OOOAI2221
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

OOOOAI3222:     DESCR = "3-2-2-2-input OR-OR-OR-OR-AND-Invert gate"
OOOOAI3222:     OOOAI3221
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

AAAAOI3322:     DESCR = "3-3-2-2-input AND-AND-AND-AND-OR-Invert gate"
AAAAOI3322:     AAAOI3321
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

OOOOAI3322:     DESCR = "3-3-2-2-input OR-OR-OR-OR-AND-Invert gate"
OOOOAI3322:     OOOAI3321
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)
