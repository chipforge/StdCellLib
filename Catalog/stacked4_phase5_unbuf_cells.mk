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
                AOAOAI22111 OAOAOI22111 \
                            OAOAOI32111 \
                AAOAOAI22111 OOAOAOI22111 \
                AAOAOAI22121 OOAOAOI22121 \
                AOAAOAI21121 OAOOAOI21121 \
                AOAAOAI21131 OAOOAOI21131 \
                             OAOOAOI22121 \
                             OAOOAOI22131 \
                AOAOOAI21112 OAOAAOI21112 \
                AOAOOAI21113 OAOAAOI21113 \
                AOAOOAI21114 OAOAAOI21114 \
                AOAOOAI21122 OAOAAOI21122 \
                AOAOOAI21123 OAOAAOI21123 \
                             OAOAAOI22112 \
                             OAOAAOI22113 \
                AOOAOAI21211 OAAOAOI21211 \
                AOOAOAI21221 OAAOAOI21221 \
                AOOAOAI21311 OAAOAOI21311 \
                AOOAOAI22211 OAAOAOI22211 \
                             OAAOAOI22311 \
                AAOAOAI221111 OOAOAOI221111 \
                AOAAOAI211211 OAOOAOI211211 \
                AOAAOAI211311 OAOOAOI211311 \
                              OAOAAOI211131 \
                AAOAAOAI22121 OOAOOAOI22121 \
                AAOAAOAI22131 OOAOOAOI22131 \
                AAOAOOAI22112 OOAOAAOI22112 \
                AAOAOOAI22113 \
                AAOAOOAI22122 \
                AAOOAOAI22211 OOAAOAOI22211 \
                AAOOAOAI22221 OOAAOAOI22221 \
                AAOOAOAI22311 OOAAOAOI22311 \
                AOAAOOAI21122 OAOOAAOI21122 \
                AOAAOOAI21123 OAOOAAOI21123 \
                AOAAOOAI21132 OAOOAAOI21132 \
                              OAOOAAOI22122 \
                AOOAAOAI21221 OAAOOAOI21221 \
                AOOAAOAI21231 OAAOOAOI21231 \
                              OAAOOAOI21241 \
                AOOAAOAI21321 OAAOOAOI21321 \
                              OAAOOAOI22221 \
                AOOAOOAI21212 OAAOAAOI21212 \
                AOOAOOAI21213 OAAOAAOI21213 \
                AOOAOOAI21222 OAAOAAOI21222 \
                AOOAOOAI21312 OAAOAAOI21312 \
                              OAAOAAOI22212 \
                AAAOAOAI222111 OOOAOAOI222111 \
                AAOOAOAI221211 OOAAOAOI221211 \
                AAOOAOAI221311 OOAAOAOI221311 \
                               OOAOOAOI221121 \
                AAOAAOAI221211 OOAOOAOI221211 \
                AAOAAOAI221311 OOAOOAOI221311 \
                AAOAOOAI221112 OOAOAAOI221112 \
                AOOAAOAI212211 OAAOOAOI212211 \
                AOOAAOAI212311 OAAOOAOI212311 \
                AOAAOOAI211212 OAOOAAOI211212 \
                AOAAAOAI211221 OAOOOAOI211221 \
                AAOOAAOAI22221 OOAAOOAOI22221 \
                AAOOAAOAI22231 OOAAOOAOI22231 \
                AAOAAOOAI22122 OOAOOAAOI22122 \
                AAOAAOOAI22132 OOAOOAAOI22132 \
                AOOAAOOAI21222 OAAOOAAOI21222 \
                AOOAAOOAI21232 OAAOOAAOI21232 \
                AAOOAOOAI22212 OOAAOAAOI22212 \
                AAAOOAOAI222211 OOOAAOAOI222211 \
                                OOOAAOAOI222311 \
                AAOOAAOAI222211 OOAAOOAOI222211 \
                AAOOAAOAI222311 OOAAOOAOI222311 \
                AAOOAAOOAI22222 OOAAOOAAOI22222 \
                AAOOAAOOAI22232 OOAAOOAAOI22232

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

AOAOAI22111:    DESCR = "2-2-1-1-1-input AND-OR-AND-OR-AND-Invert gate"
AOAOAI22111:    AOAOI2211
	$(POPCORN) -m pu -c $@ $< > $@
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

OAOOAOI22131:   DESCR = "2-2-1-3-1-input OR-AND-OR-OR-AND-OR-Invert gate"
OAOOAOI22131:   OAOOAI2213
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

AOAOOAI21114:   DESCR = "2-1-1-1-3-input AND-OR-AND-OR-OR-AND-Invert gate"
AOAOOAI21114:   AOAOOAI21113
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

OAOAAOI21114:   DESCR = "2-1-1-1-4-input OR-AND-OR-AND-AND-OR-Invert gate"
OAOAAOI21114:   OAOAAOI21113
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

AOAOOAI21123:   DESCR = "2-1-1-2-3-input AND-OR-AND-OR-OR-AND-Invert gate"
AOAOOAI21123:   AOAOOAI21122
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

OAOAAOI21123:   DESCR = "2-1-1-2-3-input OR-AND-OR-AND-AND-OR-Invert gate"
OAOAAOI21123:   OAOAAOI21122
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

OAOAAOI22112:   DESCR = "2-2-1-1-2-input OR-AND-OR-AND-AND-OR-Invert gate"
OAOAAOI22112:   OAOAOI22111
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

OAOAAOI22113:   DESCR = "2-2-1-1-3-input OR-AND-OR-AND-AND-OR-Invert gate"
OAOAAOI22113:   OAOAAOI22112
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

AOOAOAI22211:   DESCR = "2-2-2-1-1-input AND-OR-OR-AND-OR-AND-Invert gate"
AOOAOAI22211:   AOOAOI2221
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

OAAOAOI22211:   DESCR = "2-2-2-1-1-input OR-AND-AND-OR-AND-OR-Invert gate"
OAAOAOI22211:   OAAOAI2221
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

OAAOAOI22311:   DESCR = "2-2-3-1-1-input OR-AND-AND-OR-AND-OR-Invert gate"
OAAOAOI22311:   OAAOAI2231
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

AAOAOOAI22113:  DESCR = "2-2-1-1-3-input AND-AND-OR-AND-OR-OR-AND-Invert gate"
AAOAOOAI22113:  AAOAOOAI22112
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

AAOAOOAI22122:  DESCR = "2-2-1-2-2-input AND-AND-OR-AND-OR-OR-AND-Invert gate"
AAOAOOAI22122:  AAOAOAI22121
	$(POPCORN) -m nor -c $@ $< > $@
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

OOAAOAOI22221:  DESCR = "2-2-2-2-1-input OR-OR-AND-AND-OR-AND-OR-Invert gate"
OOAAOAOI22221:  OOAAOAI2222
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

AAOOAOAI22311:  DESCR = "2-2-3-1-1-input AND-AND-OR-OR-AND-OR-AND-Invert gate"
AAOOAOAI22311:  AAOOAOI2231
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

OOAAOAOI22311:  DESCR = "2-2-3-1-1-input OR-OR-AND-AND-OR-AND-OR-Invert gate"
OOAAOAOI22311:  OOAAOAI2231
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

AOAAOOAI21122:  DESCR = "2-1-1-2-2-input AND-OR-AND-AND-OR-OR-AND-Invert gate"
AOAAOOAI21122:  AOAAOAI21121
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

OAOOAAOI21122:  DESCR = "2-1-1-2-2-input OR-AND-OR-OR-AND-AND-OR-Invert gate"
OAOOAAOI21122:  OAOOAOI21121
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

AOAAOOAI21123:  DESCR = "2-1-1-2-3-input AND-OR-AND-AND-OR-OR-AND-Invert gate"
AOAAOOAI21123:  AOAAOOAI21122
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

OAOOAAOI21123:  DESCR = "2-1-1-2-3-input OR-AND-OR-OR-AND-AND-OR-Invert gate"
OAOOAAOI21123:  OAOOAAOI21122
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

AOAAOOAI21132:  DESCR = "2-1-1-3-2-input AND-OR-AND-AND-OR-OR-AND-Invert gate"
AOAAOOAI21132:  AOAAOAI21131
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

OAOOAAOI21132:  DESCR = "2-1-1-3-2-input OR-AND-OR-OR-AND-AND-OR-Invert gate"
OAOOAAOI21132:  OAOOAOI21131
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

OAOOAAOI22122:  DESCR = "2-2-1-2-2-input OR-AND-OR-OR-AND-AND-OR-Invert gate"
OAOOAAOI22122:  OAOOAOI22121
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

AOOAAOAI21221:  DESCR = "2-1-2-2-1-input AND-OR-OR-AND-AND-OR-AND-Invert gate"
AOOAAOAI21221:  AOOAAOI2122
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

OAAOOAOI21221:  DESCR = "2-1-2-2-1-input OR-AND-AND-OR-OR-AND-OR-Invert gate"
OAAOOAOI21221:  OAAOOAI2122
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

AOOAAOAI21231:  DESCR = "2-1-2-3-1-input AND-OR-OR-AND-AND-OR-AND-Invert gate"
AOOAAOAI21231:  AOOAAOI2123
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

OAAOOAOI21231:  DESCR = "2-1-2-3-1-input OR-AND-AND-OR-OR-AND-OR-Invert gate"
OAAOOAOI21231:  OAAOOAI2123
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

OAAOOAOI21241:  DESCR = "2-1-2-4-1-input OR-AND-AND-OR-OR-AND-OR-Invert gate"
OAAOOAOI21241:  OAAOOAI2124
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

AOOAAOAI21321:  DESCR = "2-1-3-2-1-input AND-OR-OR-AND-AND-OR-AND-Invert gate"
AOOAAOAI21321:  AOOAAOI2132
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

OAAOOAOI21321:  DESCR = "2-1-3-2-1-input OR-AND-AND-OR-OR-AND-OR-Invert gate"
OAAOOAOI21321:  OAAOOAI2132
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

OAAOOAOI22221:  DESCR = "2-2-2-2-1-input OR-AND-AND-OR-OR-AND-OR-Invert gate"
OAAOOAOI22221:  OAAOOAI2222
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

AOOAOOAI21212:  DESCR = "2-1-2-1-2-input AND-OR-OR-AND-OR-OR-AND-Invert gate"
AOOAOOAI21212:  AOOAOAI21211
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

OAAOAAOI21212:  DESCR = "2-1-2-1-2-input OR-AND-AND-OR-AND-AND-OR-Invert gate"
OAAOAAOI21212:  OAAOAOI21211
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

AOOAOOAI21213:  DESCR = "2-1-2-1-3-input AND-OR-OR-AND-OR-OR-AND-Invert gate"
AOOAOOAI21213:  AOOAOOAI21212
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

OAAOAAOI21213:  DESCR = "2-1-2-1-3-input OR-AND-AND-OR-AND-AND-OR-Invert gate"
OAAOAAOI21213:  OAAOAAOI21212
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

AOOAOOAI21222:  DESCR = "2-1-2-2-2-input AND-OR-OR-AND-OR-OR-AND-Invert gate"
AOOAOOAI21222:  AOOAOAI21221
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

OAAOAAOI21222:  DESCR = "2-1-2-2-2-input OR-AND-AND-OR-AND-AND-OR-Invert gate"
OAAOAAOI21222:  OAAOAOI21221
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

AOOAOOAI21312:  DESCR = "2-1-3-1-2-input AND-OR-OR-AND-OR-OR-AND-Invert gate"
AOOAOOAI21312:  AOOAOAI21311
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

OAAOAAOI21312:  DESCR = "2-1-3-1-2-input OR-AND-AND-OR-AND-AND-OR-Invert gate"
OAAOAAOI21312:  OAAOAOI21311
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

OAAOAAOI22212:  DESCR = "2-2-2-1-2-input OR-AND-AND-OR-AND-AND-OR-Invert gate"
OAAOAAOI22212:  OAAOAOI22211
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

AAAOAOAI222111: DESCR = "2-2-2-1-1-1-input AND-AND-AND-OR-AND-OR-AND-Invert gate"
AAAOAOAI222111: AAAOAOI22211
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

OOOAOAOI222111:  DESCR = "2-2-2-1-1-1-input OR-OR-OR-AND-OR-AND-OR-Invert gate"
OOOAOAOI222111:  OOOAOAI22211
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

AAOOAOAI221211: DESCR = "2-2-1-2-1-1-input AND-AND-OR-OR-AND-OR-AND-Invert gate"
AAOOAOAI221211: AAOOAOI22121
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

OOAAOAOI221211: DESCR = "2-2-1-2-1-1-input OR-OR-AND-AND-OR-AND-OR-Invert gate"
OOAAOAOI221211: OOAAOAI22121
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

AAOOAOAI221311: DESCR = "2-2-1-3-1-1-input AND-AND-OR-OR-AND-OR-AND-Invert gate"
AAOOAOAI221311: AAOOAOI22131
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

OOAAOAOI221311: DESCR = "2-2-1-3-1-1-input OR-OR-AND-AND-OR-AND-OR-Invert gate"
OOAAOAOI221311: OOAAOAI22131
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

OOAOOAOI221121: DESCR = "2-2-1-1-2-1-input OR-OR-AND-OR-OR-AND-OR-Invert gate"
OOAOOAOI221121: OOAOOAI22112
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

AAOAAOAI221211: DESCR = "2-2-1-2-1-1-input AND-AND-OR-AND-AND-OR-AND-Invert gate"
AAOAAOAI221211: AAOAAOI22121
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

OOAOOAOI221211: DESCR = "2-2-1-2-1-1-input OR-OR-AND-OR-OR-AND-OR-Invert gate"
OOAOOAOI221211: OOAOOAI22121
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

AAOAAOAI221311: DESCR = "2-2-1-3-1-1-input AND-AND-OR-AND-AND-OR-AND-Invert gate"
AAOAAOAI221311: AAOAAOI22131
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

OOAOOAOI221311: DESCR = "2-2-1-3-1-1-input OR-OR-AND-OR-OR-AND-OR-Invert gate"
OOAOOAOI221311: OOAOOAI22131
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

AAOAOOAI221112: DESCR = "2-2-1-1-1-2-input AND-AND-OR-AND-OR-OR-AND-Invert gate"
AAOAOOAI221112: AAOAOAI221111
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

OOAOAAOI221112: DESCR = "2-2-1-1-1-2-input OR-OR-AND-OR-AND-AND-OR-Invert gate"
OOAOAAOI221112: OOAOAOI221111
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

AOOAAOAI212211: DESCR = "2-1-2-2-1-1-input AND-OR-OR-AND-AND-OR-AND-Invert gate"
AOOAAOAI212211: AOOAAOI21221
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

OAAOOAOI212211: DESCR = "2-1-2-2-1-1-input OR-AND-AND-OR-OR-AND-OR-Invert gate"
OAAOOAOI212211: OAAOOAI21221
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

AOOAAOAI212311: DESCR = "2-1-2-3-1-1-input AND-OR-OR-AND-AND-OR-AND-Invert gate"
AOOAAOAI212311: AOOAAOI21231
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

OAAOOAOI212311: DESCR = "2-1-2-3-1-1-input OR-AND-AND-OR-OR-AND-OR-Invert gate"
OAAOOAOI212311: OAAOOAI21231
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

AOAAOOAI211212: DESCR = "2-1-1-2-1-2-input AND-OR-AND-AND-OR-OR-AND-Invert gate"
AOAAOOAI211212: AOAAOAI211211
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

OAOOAAOI211212: DESCR = "2-1-1-2-1-2-input OR-AND-OR-OR-AND-AND-OR-Invert gate"
OAOOAAOI211212: OAOOAOI211211
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

AOAAAOAI211221: DESCR = "2-1-1-2-2-1-input AND-OR-AND-AND-AND-OR-AND-Invert gate"
AOAAAOAI211221: AOAAAOI21122
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

OAOOOAOI211221: DESCR = "2-1-1-2-2-1-input OR-AND-OR-OR-OR-AND-OR-Invert gate"
OAOOOAOI211221: OAOOOAI21122
	$(POPCORN) -m pd -c $@ $< > $@
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

OOAOOAAOI22122: DESCR = "2-2-1-2-2-input OR-OR-AND-OR-OR-AND-AND-OR-Invert gate"
OOAOOAAOI22122: OOAOOAOI22121
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

AAOAAOOAI22132: DESCR = "2-2-1-3-2-input AND-AND-OR-AND-AND-OR-OR-AND-Invert gate"
AAOAAOOAI22132: AAOAAOAI22131
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

OOAOOAAOI22132: DESCR = "2-2-1-3-2-input OR-OR-AND-OR-OR-AND-AND-OR-Invert gate"
OOAOOAAOI22132: OOAOOAOI22131
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

AOOAAOOAI21222: DESCR = "2-1-2-2-2-input AND-OR-OR-AND-AND-OR-OR-AND-Invert gate"
AOOAAOOAI21222: AOOAAOAI21221
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

OAAOOAAOI21222: DESCR = "2-1-2-2-2-input OR-AND-AND-OR-OR-AND-AND-OR-Invert gate"
OAAOOAAOI21222: OAAOOAOI21221
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

AOOAAOOAI21232: DESCR = "2-1-2-3-2-input AND-OR-OR-AND-AND-OR-OR-AND-Invert gate"
AOOAAOOAI21232: AOOAAOAI21231
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

OAAOOAAOI21232: DESCR = "2-1-2-3-2-input OR-AND-AND-OR-OR-AND-AND-OR-Invert gate"
OAAOOAAOI21232: OAAOOAOI21231
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

AAOOAOOAI22212: DESCR = "2-2-2-1-2-input AND-AND-OR-OR-AND-OR-OR-AND-Invert gate"
AAOOAOOAI22212: AAOOAOAI22211
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

OOAAOAAOI22212: DESCR = "2-2-2-1-2-input OR-OR-AND-AND-OR-AND-AND-OR-Invert gate"
OOAAOAAOI22212: OOAAOAOI22211
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

AAAOOAOAI222211: DESCR = "2-2-2-2-1-1-input AND-AND-AND-OR-OR-AND-OR-AND-Invert gate"
AAAOOAOAI222211: AAAOOAOI22221
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

OOOAAOAOI222211: DESCR = "2-2-2-2-1-1-input OR-OR-OR-AND-AND-OR-AND-OR-Invert gate"
OOOAAOAOI222211: OOOAAOAI22221
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

OOOAAOAOI222311: DESCR = "2-2-2-3-1-1-input OR-OR-OR-AND-AND-OR-AND-OR-Invert gate"
OOOAAOAOI222311: OOOAAOAI22231
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

AAOOAAOAI222211: DESCR = "2-2-2-2-1-1-input AND-AND-OR-OR-AND-AND-OR-AND-Invert gate"
AAOOAAOAI222211: AAOOAAOI22221
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

OOAAOOAOI222211: DESCR = "2-2-2-2-1-1-input OR-OR-AND-AND-OR-OR-AND-OR-Invert gate"
OOAAOOAOI222211: OOAAOOAI22221
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

AAOOAAOAI222311: DESCR = "2-2-2-3-1-1-input AND-AND-OR-OR-AND-AND-OR-AND-Invert gate"
AAOOAAOAI222311: AAOOAAOI22231
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

OOAAOOAOI222311: DESCR = "2-2-2-3-1-1-input OR-OR-AND-AND-OR-OR-AND-OR-Invert gate"
OOAAOOAOI222311: OOAAOOAI22231
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

AAOOAAOOAI22222: DESCR = "2-2-2-2-2-2-input AND-AND-OR-OR-AND-AND-OR-OR-AND-Invert gate"
AAOOAAOOAI22222: AAOOAAOAI22221
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

OOAAOOAAOI22222: DESCR = "2-2-2-2-2-2-input OR-OR-AND-AND-OR-OR-AND-AND-OR-Invert gate"
OOAAOOAAOI22222: OOAAOOAOI22221
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

AAOOAAOOAI22232: DESCR = "2-2-2-2-3-2-input AND-AND-OR-OR-AND-AND-OR-OR-AND-Invert gate"
AAOOAAOOAI22232: AAOOAAOAI22231
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

OOAAOOAAOI22232: DESCR = "2-2-2-2-3-2-input OR-OR-AND-AND-OR-OR-AND-AND-OR=Invert gate"
OOAAOOAAOI22232: OOAAOOAOI22231
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)
