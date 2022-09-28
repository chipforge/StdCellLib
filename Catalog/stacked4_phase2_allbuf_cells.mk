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
#   File:           StdCellLib/Catalog/stacked4_phase2_allbuf_cells.mk
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
