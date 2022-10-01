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
#   File:           StdCellLib/Catalog/stacked4_phase4_unbuf_cells.mk
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

#   Dependencies for cells with 4 stacked transistors and 4 phases,
#   which are still unbuffered.

#   ----------------------------------------------------------------
#               CELL TARGETS - still unbuffered
#   ----------------------------------------------------------------

#   --------    four phases     ------------------------------------

CELLS +=        AOAOI2112 OAOAI2112 \
                AOAOI2121 OAOAI2121 \
                AOAOI2122 OAOAI2122 \
                AOAOI2211 OAOAI2211 \
                AOAOI2221 OAOAI2221 \
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
                AOAAOI2123 OAOOAI2123 \
                AOAAOI2124 \
                AOAAOI2212 OAOOAI2212 \
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
                AAOAOI33111 OOAOAI33111 \
                AOAAOI21141 OAOOAI21141 \
                AOAAOI21221 OAOOAI21221 \
                AOAAOI21231 \
                AOAAOI31121 OAOOAI31121 \
                AOOAOI21211 OAAOAI21211 \
                AOOAOI21212 OAAOAI21212 \
                AOOAOI21311 OAAOAI21311 \
                AOOAOI22211 OAAOAI22211 \
                            OAAOAI22311 \
                AAOAAOI2214 OOAOOAI2214 \
                AAOAAOI2222 OOAOOAI2222 \
                AAOAAOI2223 \
                AAOAAOI3212 OOAOOAI3212 \
                AAOOAOI2222 OOAAOAI2222 \
                AAOOAOI2231 OOAAOAI2231 \
                AAOOAOI3221 OOAAOAI3221 \
                AOAAOI21112 \
                AOAAOI21121 OAOOAI21121 \
                AOAAOI21131 OAOOAI21131 \
                AOOAAOI2124 OAAOOAI2124 \
                AOOAAOI2132 OAAOOAI2132 \
                AOOAAOI2133 \
                AOOAAOI2222 OAAOOAI2222 \
                            OAAOOAI2232 \
                AOOAAOI3122 OAAOOAI3122 \
                AAAOAOI22211 OOOAOAI22211 \
                AAAOAOI22221 OOOAOAI22221 \
                AAAOAOI32211 OOOAOAI32211 \
                AAAOAOI33211 OOOAOAI33211 \
                AAAOAOI33311 OOOAOAI33311 \
                AAOAAOI22112 OOAOOAI22112 \
                AAOAAOI22113 \
                AAOAAOI22121 OOAOOAI22121 \
                AAOAAOI22122 \
                AAOAAOI22131 OOAOOAI22131 \
                AAOAAOI22141 OOAOOAI22141 \
                AAOAAOI22221 \
                AAOOAOI22121 OOAAOAI22121 \
                             OOAAOAI22122 \
                AAOOAOI22131 OOAAOAI22131 \
                AAOOAOI22211 OOAAOAI22211 \
                AAOOAOI22212 \
                AAOOAOI22311 OOAAOAI22311 \
                AOAAAOI21122 OAOOOAI21122 \
                AOAAAOI21132 OAOOOAI21132 \
                AOAAAOI21222 \
                AOOAAOI21212 OAAOOAI21212 \
                AOOAAOI21213 \
                AOOAAOI21221 OAAOOAI21221 \
                AOOAAOI21231 OAAOOAI21231 \
                AOOAAOI21241 OAAOOAI21241 \
                AOOAAOI21312 \
                AOOAAOI21321 \
                AOOOAOI21221 OAAAOAI21221 \
                AOOOAOI21222 \
                AOOOAOI21321 \
                AAOOAOI221211 OOAAOAI221211 \
                AAOOAOI221311 OOAAOAI221311 \
                AOOAAOI212121 \
                AAOOAAOI2224 OOAAOOAI2224 \
                AAOOAAOI2232 OOAAOOAI2232 \
                AAAOOAOI22221 OOOAAOAI22221 \
                AAAOOAOI22231 OOOAAOAI22231 \
                AAAOAAOI22212 OOOAOOAI22212 \
                AAOOAAOI22122 OOAAOOAI22122 \
                AAOOAAOI22132 OOAAOOAI22132 \
                AAOOAAOI22212 \
                AAOOAAOI22221 OOAAOOAI22221 \
                AAOOAAOI22231 OOAAOOAI22231 \
                AAOOAAOI22241 OOAAOOAI22241 \
                AAOAAAOI22122 OOAOOOAI22122 \
                AAOAAAOI22132 OOAOOOAI22132 \
                AOOAAAOI21222 OAAOOOAI21222 \
                AOOAAAOI21232 OAAOOOAI21232 \
                AOOOAAOI21222 \
                AAOOOAOI22221 \
                AAAOOAOI222211 OOOAAOAI222211 \
                               OOOAAOAI222311 \
                AAOAAOAI221121 \
                AAAOOAAOI22222 OOOAAOOAI22222 \
                               OOOAAOOAI22232 \
                AAOOAAAOI22222 OOAAOOOAI22222 \
                AAOOAAAOI22232 OOAAOOOAI22232

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

AOAOI2221:      DESCR = "2-2-2-1-input AND-OR-AND-OR-Invert gate"
AOAOI2221:      AOAI222
	$(POPCORN) -m pd -c $@ $< > $@
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

AOAAOI2123:     DESCR = "2-1-2-3-input AND-OR-AND-AND-OR-Invert gate"
AOAAOI2123:     AOAAOI2122
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

OAOOAI2123:     DESCR = "2-1-2-3-input OR-AND-OR-OR-AND-Invert gate"
OAOOAI2123:     OAOOAI2122
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

AOAAOI2124:     DESCR = "2-1-2-4-input AND-OR-AND-AND-OR-Invert gate"
AOAAOI2124:     AOAAOI2123
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

AOAAOI2212:     DESCR = "2-2-1-2-input AND-OR-AND-AND-OR-Invert gate"
AOAAOI2212:     AOAOI2211
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

OAOOAI2212:     DESCR = "2-2-1-2-input OR-AND-OR-OR-AND-Invert gate"
OAOOAI2212:     OAOAI2211
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

OOAOAI33111:    DESCR = "3-3-1-1-1-input OR-OR-AND-OR-AND-Invert gate"
OOAOAI33111:    OOAOI3311
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

AOAAOI21141:    DESCR = "2-1-1-4-1-input AND-OR-AND-AND-OR-Invert gate"
AOAAOI21141:    AOAAOI2114
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

OAOOAI21141:    DESCR = "2-1-1-4-1-input OR-AND-OR-OR-AND-Invert gate"
OAOOAI21141:    OAOOAI2114
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

AOAAOI21221:    DESCR = "2-1-2-2-1-input AND-OR-AND-AND-OR-Invert gate"
AOAAOI21221:    AOAAOI2122
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

OAOOAI21221:    DESCR = "2-1-2-2-1-input OR-AND-OR-OR-AND-Invert gate"
OAOOAI21221:    OAOOAI2122
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

AOAAOI21231:    DESCR = "2-1-2-3-1-input AND-OR-AND-AND-OR-Invert gate"
AOAAOI21231:    AOAAOI2123
	$(POPCORN) -m pd -c $@ $< > $@
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

AOOAOI22211:    DESCR = "2-2-2-1-1-input AND-OR-OR-AND-OR-Invert gate"
AOOAOI22211:    AOOAI2221
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

OAAOAI22211:    DESCR = "2-2-2-1-1-input OR-AND-AND-OR-AND-Invert gate"
OAAOAI22211:    OAAOI2221
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

OAAOAI22311:    DESCR = "2-2-3-1-1-input OR-AND-AND-OR-AND-Invert gate"
OAAOAI22311:    OAAOI2231
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

AAOAAOI2223:    DESCR = "2-2-2-2-input AND-AND-OR-AND-AND-OR-Invert gate"
AAOAAOI2223:    AAOAOI2222
	$(POPCORN) -m nand -c $@ $< > $@
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

AOAAOI21131:    DESCR = "2-1-1-3-1-input AND-OR-AND-AND-OR-Invert gate"
AOAAOI21131:    AOAAOI2113
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

OAOOAI21131:    DESCR = "2-1-1-3-1-input OR-AND-OR-OR-AND-Invert gate"
OAOOAI21131:    OAOOAI2113
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

AOOAAOI2124:    DESCR = "2-1-2-4-input AND-OR-OR-AND-AND-OR-Invert gate"
AOOAAOI2124:    AOOAAOI2123
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

OAAOOAI2124:    DESCR = "2-1-2-4-input OR-AND-AND-OR-OR-AND-Invert gate"
OAAOOAI2124:    OAAOOAI2123
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

AOOAAOI2132:    DESCR = "2-1-3-2-input AND-OR-OR-AND-AND-OR-Invert gate"
AOOAAOI2132:    AOOAOI2131
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

OAAOOAI2132:    DESCR = "2-1-3-2-input OR-AND-AND-OR-OR-AND-Invert gate"
OAAOOAI2132:    OAAOAI2131
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

AOOAAOI2133:    DESCR = "2-1-3-3-input AND-OR-OR-AND-AND-OR-Invert gate"
AOOAAOI2133:    AOOAAOI2132
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

AOOAAOI2222:    DESCR = "2-2-2-1-input AND-OR-OR-AND-AND-OR-Invert gate"
AOOAAOI2222:    AOOAOI2221
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

OAAOOAI2222:     DESCR = "2-2-2-1-input OR-AND-AND-OR-OR-AND-Invert gate"
OAAOOAI2222:     OAAOAI2221
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

OAAOOAI2232:    DESCR = "2-2-2-1-input OR-AND-AND-OR-OR-AND-Invert gate"
OAAOOAI2232:    OAAOAI2221
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

OOOAOAI22221:   DESCR = "2-2-2-2-1-input OR-OR-OR-AND-OR-AND-Invert gate"
OOOAOAI22221:   OOOAOI2222
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

AAAOAOI32211:   DESCR = "3-2-2-1-1-input AND-AND-AND-OR-AND-OR-Invert gate"
AAAOAOI32211:   AAAOAI3221
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

OOOAOAI32211:   DESCR = "3-2-2-1-1-input OR-OR-OR-AND-OR-AND-Invert gate"
OOOAOAI32211:   OOOAOI3221
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

AAAOAOI33211:   DESCR = "3-3-2-1-1-input AND-AND-AND-OR-AND-OR-Invert gate"
AAAOAOI33211:   AAAOAI3321
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

OOOAOAI33211:   DESCR = "3-3-2-1-1-input OR-OR-OR-AND-OR-AND-Invert gate"
OOOAOAI33211:   OOOAOI3321
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

AAAOAOI33311:   DESCR = "3-3-3-1-1-input AND-AND-AND-OR-AND-OR-Invert gate"
AAAOAOI33311:   AAAOAI3331
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

OOOAOAI33311:   DESCR = "3-3-3-1-1-input OR-OR-OR-AND-OR-AND-Invert gate"
OOOAOAI33311:   OOOAOI3331
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

AAOAAOI22112:   DESCR = "2-2-1-1-2-input AND-AND-OR-AND-AND-OR-Invert gate"
AAOAAOI22112:   AAOAOI22111
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

OOAOOAI22112:   DESCR = "2-2-1-1-2-input OR-OR-AND-OR-OR-AND-Invert gate"
OOAOOAI22112:   OOAOAI22111
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

AAOAAOI22113:   DESCR = "2-2-1-1-3-input AND-AND-OR-AND-AND-OR-Invert gate"
AAOAAOI22113:   AAOAAOI22112
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

AAOAAOI22121:   DESCR = "2-2-1-2-1-input AND-AND-OR-AND-AND-OR-Invert gate"
AAOAAOI22121:   AAOAAOI2212
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

OOAOOAI22121:   DESCR = "2-2-1-2-1-input OR-OR-AND-OR-OR-AND-Invert gate"
OOAOOAI22121:   OOAOOAI2212
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

AAOAAOI22122:   DESCR = "2-2-1-2-2-input AND-AND-OR-AND-AND-OR-Invert gate"
AAOAAOI22122:   AAOAOI22121
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

AAOAAOI22131:   DESCR = "2-2-1-3-1-input AND-AND-OR-AND-AND-OR-Invert gate"
AAOAAOI22131:   AAOAAOI2213
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

OOAOOAI22131:   DESCR = "2-2-1-3-1-input OR-OR-AND-OR-OR-AND-Invert gate"
OOAOOAI22131:   OOAOOAI2213
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

AAOAAOI22141:   DESCR = "2-2-1-4-1-input AND-AND-OR-AND-AND-OR-Invert gate"
AAOAAOI22141:   AAOAAOI2214
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

OOAOOAI22141:   DESCR = "2-2-1-4-1-input OR-OR-AND-OR-OR-AND-Invert gate"
OOAOOAI22141:   OOAOOAI2214
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

AAOAAOI22221:   DESCR = "2-2-2-2-1-input AND-AND-OR-AND-AND-OR-Invert gate"
AAOAAOI22221:   AAOAAOI2222
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

AAOOAOI22121:   DESCR = "2-2-1-2-1-input AND-AND-OR-OR-AND-OR-Invert gate"
AAOOAOI22121:   AAOOAI2212
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

OOAAOAI22121:   DESCR = "2-2-1-2-1-input OR-OR-AND-AND-OR-AND-Invert gate"
OOAAOAI22121:   OOAAOI2212
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

OOAAOAI22122:   DESCR = "2-2-1-2-2-input OR-OR-AND-AND-OR-AND-Invert gate"
OOAAOAI22122:   OOAAOAI22121
	$(POPCORN) -m nand -c $@ $< > $@
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

AAOOAOI22212:   DESCR = "2-2-2-1-2-input AND-AND-OR-OR-AND-OR-Invert gate"
AAOOAOI22212:   AAOOAOI22211
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

AAOOAOI22311:   DESCR = "2-2-3-1-1-input AND-AND-OR-OR-AND-OR-Invert gate"
AAOOAOI22311:   AAOOAI2231
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

OOAAOAI22311:   DESCR = "2-2-3-1-1-input OR-OR-AND-AND-OR-AND-Invert gate"
OOAAOAI22311:   OOAAOI2231
	$(POPCORN) -m pu -c $@ $< > $@
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

OAOOOAI21132:   DESCR = "2-1-1-3-2-input OR-AND-OR-OR-OR-AND-Invert gate"
OAOOOAI21132:   OAOOAI21131
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

AOAAAOI21222:   DESCR = "2-1-2-2-2-input AND-OR-AND-AND-AND-OR-Invert gate"
AOAAAOI21222:   AOAAOI21221
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

AOOAAOI21213:   DESCR = "2-1-2-1-3-input AND-OR-OR-AND-AND-OR-Invert gate"
AOOAAOI21213:   AOOAAOI21212
	$(POPCORN) -m nand -c $@ $< > $@
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

AOOAAOI21241:   DESCR = "2-1-2-4-1-input AND-OR-OR-AND-AND-OR-Invert gate"
AOOAAOI21241:   AOOAAOI2124
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

OAAOOAI21241:   DESCR = "2-1-2-4-1-input OR-AND-AND-OR-OR-AND-Invert gate"
OAAOOAI21241:   OAAOOAI2124
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

AOOAAOI21312:   DESCR = "2-1-3-1-2-input AND-OR-OR-AND-AND-OR-Invert gate"
AOOAAOI21312:   AOOAOI21311
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

AOOAAOI21321:   DESCR = "2-1-3-2-1-input AND-OR-OR-AND-AND-OR-Invert gate"
AOOAAOI21321:   AOOAAOI2132
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

AOOOAOI21222:   DESCR = "2-1-2-2-2-input AND-OR-OR-OR-AND-OR-Invert gate"
AOOOAOI21222:   AOOOAOI21221
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

AOOOAOI21321:   DESCR = "2-1-3-2-1-input AND-OR-OR-OR-AND-OR-Invert gate"
AOOOAOI21321:   AOOOAI2132
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

AAOOAOI221211:  DESCR = "2-2-1-2-1-1-input AND-AND-OR-OR-AND-OR-Invert gate"
AAOOAOI221211:  AAOOAI22121
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

OOAAOAI221211:  DESCR = "2-2-1-2-2-1-input OR-OR-AND-AND-OR-AND-Invert gate"
OOAAOAI221211:  OOAAOI22121
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

AAOOAOI221311:  DESCR = "2-2-1-3-1-1-input AND-AND-OR-OR-AND-OR-Invert gate"
AAOOAOI221311:  AAOOAI22131
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

OOAAOAI221311:  DESCR = "2-2-1-3-1-1-input OR-OR-AND-AND-OR-AND-Invert gate"
OOAAOAI221311:  AAOOAI22131
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

AOOAAOI212121:  DESCR = "2-1-2-1-2-1-input AND-OR-OR-AND-AND-OR-Invert gate"
AOOAAOI212121:  AOOAAOI21212
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

OOAAOOAI2232:   DESCR = "2-2-3-2-input OR-OR-AND-AND-OR-OR-AND-Invert gate"
OOAAOOAI2232:   OOAAOAI2231
	$(POPCORN) -m nor -c $@ $< > $@
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

OOOAOOAI22212:  DESCR = "2-2-2-1-2-input OR-OR-OR-AND-OR-OR-AND-Invert gate"
OOOAOOAI22212:  OOOAOAI22211
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

AAOOAAOI22122:  DESCR = "2-2-1-2-2-input AND-AND-OR-OR-AND-AND-OR-Invert gate"
AAOOAAOI22122:  AAOOAOI22121
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

OOAAOOAI22122:  DESCR = "2-2-1-2-2-input OR-OR-AND-AND-OR-OR-AND-Invert gate"
OOAAOOAI22122:  OOAAOAI22121
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

AAOOAAOI22132:  DESCR = "2-2-1-3-2-input AND-AND-OR-OR-AND-AND-OR-Invert gate"
AAOOAAOI22132:  AAOOAOI22131
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

OOAAOOAI22132:  DESCR = "2-2-1-3-2-input OR-OR-AND-AND-OR-OR-AND-Invert gate"
OOAAOOAI22132:  OOAAOAI22131
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

AAOOAAOI22212:  DESCR = "2-2-2-1-2-input AND-AND-OR-OR-AND-AND-OR-Invert gate"
AAOOAAOI22212:  AAOOAOI22211
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

AAOOAAOI22231:  DESCR = "2-2-2-3-1-input AND-AND-OR-OR-AND-AND-OR-Invert gate"
AAOOAAOI22231:  AAOOAAOI2223
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

OOAAOOAI22231:  DESCR = "2-2-2-3-1-input OR-OR-AND-AND-OR-OR-AND-Invert gate"
OOAAOOAI22231:  OOAAOOAI2223
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

AAOOAAOI22241:  DESCR = "2-2-2-4-1-input AND-AND-OR-OR-AND-AND-OR-Invert gate"
AAOOAAOI22241:  AAOOAAOI2224
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

OOAAOOAI22241:  DESCR = "2-2-2-4-1-input OR-OR-AND-AND-OR-OR-AND-Invert gate"
OOAAOOAI22241:  OOAAOOAI2224
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

AAOAAAOI22122:  DESCR = "2-2-1-2-2-input AND-AND-OR-AND-AND-AND-OR-Invert gate"
AAOAAAOI22122:  AAOAAOI22121
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

OOAOOOAI22122:  DESCR = "2-2-1-2-2-input OR-OR-AND-OR-OR-OR-AND-Invert gate"
OOAOOOAI22122:  OOAOOAI22121
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

AAOAAAOI22132:  DESCR = "2-2-1-3-2-input AND-AND-OR-AND-AND-AND-OR-Invert gate"
AAOAAAOI22132:  AAOAAOI22131
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

OOAOOOAI22132:  DESCR = "2-2-1-3-2-input OR-OR-AND-OR-OR-OR-AND-Invert gate"
OOAOOOAI22132:  OOAOOAI22131
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

AOOAAAOI21222:  DESCR = "2-1-2-2-2-input AND-OR-OR-AND-AND-AND-OR-Invert gate"
AOOAAAOI21222:  AOOAAOI21221
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

OAAOOOAI21222:  DESCR = "2-1-2-2-2-input OR-AND-AND-OR-OR-OR-AND-Invert gate"
OAAOOOAI21222:  OAAOOAI21221
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

AOOAAAOI21232:  DESCR = "2-1-2-3-2-input AND-OR-OR-AND-AND-AND-OR-Invert gate"
AOOAAAOI21232:  AOOAAOI21231
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

OAAOOOAI21232:  DESCR = "2-1-2-3-2-input OR-AND-AND-OR-OR-OR-AND-Invert gate"
OAAOOOAI21232:  OAAOOAI21231
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

AOOOAAOI21222:  DESCR = "2-1-2-2-2-input AND-OR-OR-OR-AND-AND-OR-Invert gate"
AOOOAAOI21222:  AOOOAOI21221
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

AAOOOAOI22221:  DESCR = "2-2-2-2-1-input AND-AND-OR-OR-OR-AND-OR-Invert gate"
AAOOOAOI22221:  AAOOOAI2222
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

AAAOOAOI222211: DESCR = "2-2-2-2-1-1-input AND-AND-AND-OR-OR-AND-OR-Invert gate"
AAAOOAOI222211: AAAOOAI22221
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

OOOAAOAI222211: DESCR = "2-2-2-2-1-1-input OR-OR-OR-AND-AND-OR-AND-Invert gate"
OOOAAOAI222211: OOOAAOI22221
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

OOOAAOAI222311: DESCR = "2-2-2-3-1-1-input OR-OR-OR-AND-AND-OR-AND-Invert gate"
OOOAAOAI222311: OOOAAOI22231
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

AAOAAOAI221121: DESCR = "2-2-1-1-2-1-input AND-AND-OR-AND-AND-OR-AND-Invert gate"
AAOAAOAI221121: AAOAAOI22112
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

AAAOOAAOI22222: DESCR = "2-2-2-2-2-input AND-AND-AND-OR-OR-AND-OR-Invert gate"
AAAOOAAOI22222: AAAOOAOI22221
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

OOOAAOOAI22222: DESCR = "2-2-2-2-2-input OR-OR-OR-AND-AND-OR-OR-AND-Invert gate"
OOOAAOOAI22222: OOOAAOAI22221
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

OOOAAOOAI22232: DESCR = "2-2-2-3-2-input OR-OR-OR-AND-AND-OR-OR-AND-Invert gate"
OOOAAOOAI22232: OOOAAOAI22231
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

AAOOAAAOI22222: DESCR = "2-2-2-2-2-input AND-AND-OR-OR-AND-AND-AND-OR-Invert gate"
AAOOAAAOI22222: AAOOAAOI22221
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

OOAAOOOAI22222: DESCR = "2-2-2-2-2-2-input OR-OR-AND-AND-OR-OR-OR-AND-Invert gate"
OOAAOOOAI22222: OOAAOOAI22221
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

AAOOAAAOI22232: DESCR = "2-2-2-3-2-input AND-AND-OR-OR-AND-AND-AND-OR-Invert gate"
AAOOAAAOI22232: AAOOAAOI22231
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

OOAAOOOAI22232: DESCR = "2-2-2-3-2-input OR-OR-AND-AND-OR-OR-OR-AND-Invert gate"
OOAAOOOAI22232: OOAAOOAI22231
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)
