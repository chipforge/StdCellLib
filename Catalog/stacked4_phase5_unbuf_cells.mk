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
#   File:           StdCellLib/Catalog/stacked4_phase5_unbuf_cells.mk
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
