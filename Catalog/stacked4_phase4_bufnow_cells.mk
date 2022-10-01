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
#   File:           StdCellLib/Catalog/stacked4_phase4_bufnow_cells.mk
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
#   which are buffered now.

#   ----------------------------------------------------------------
#               CELL TARGETS - now buffered
#   ----------------------------------------------------------------

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
                AOAAO2123 OAOOA2123 \
                          OAOOA2212 \
                          OAOOA2213 \
                          OAOOA2222 \
                AOAAO3112 OAOOA3112 \
                AOAAO3113 OAOOA3113 \
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
                AAOAO33111 OOAOA33111 \
                AOAAO21141 OAOOA21141 \
                AOAAO21221 OAOOA21221 \
                AOAAO31121 OAOOA31121 \
                AOOAO21211 OAAOA21211 \
                AOOAO21212 OAAOA21212 \
                AOOAO21311 OAAOA21311 \
                           OAAOA22211 \
                           OAAOA22311 \
                AAOAAO2214 OOAOOA2214 \
                AAOAAO2222 OOAOOA2222 \
                AAOAAO3212 OOAOOA3212 \
                AAOOAO2222 OOAAOA2222 \
                AAOOAO2231 OOAAOA2231 \
                AAOOAO3221 OOAAOA3221 \
                AOAAO21112 \
                AOAAO21121 OAOOA21121 \
                AOAAO21131 OAOOA21131 \
                AOOAAO2124 OAAOOA2124 \
                AOOAAO2132 OAAOOA2132 \
                           OAAOOA2222 \
                           OAAOOA2232 \
                AOOAAO3122 OAAOOA3122 \
                AAAOAO22211 OOOAOA22211 \
                AAAOAO22221 OOOAOA22221 \
                AAAOAO32211 OOOAOA32211 \
                AAAOAO33211 OOOAOA33211 \
                AAOAAO22112 OOAOOA22112 \
                AAOAAO22121 OOAOOA22121 \
                AAOAAO22131 OOAOOA22131 \
                AAOAAO22141 OOAOOA22141 \
                AAOOAO22121 OOAAOA22121 \
                            OOAAOA22122 \
                AAOOAO22131 OOAAOA22131 \
                AAOOAO22211 OOAAOA22211 \
                AAOOAO22311 OOAAOA22311 \
                AOAAAO21122 OAOOOA21122 \
                AOAAAO21132 OAOOOA21132 \
                AOOAAO21212 OAAOOA21212 \
                AOOAAO21221 OAAOOA21221 \
                AOOAAO21231 OAAOOA21231 \
                AOOAAO21241 OAAOOA21241 \
                AOOOAO21221 OAAAOA21221 \
                AAOOAO221211 OOAAOA221211 \
                AAOOAO221311 OOAAOA221311 \
                AAOOAAO2224 OOAAOOA2224 \
                AAOOAAO2232 OOAAOOA2232 \
                AAAOOAO22221 OOOAAOA22221 \
                AAAOOAO22231 OOOAAOA22231 \
                AAAOAAO22212 OOOAOOA22212 \
                AAOOAAO22122 OOAAOOA22122 \
                AAOOAAO22132 OOAAOOA22132 \
                AAOOAAO22221 OOAAOOA22221 \
                AAOOAAO22231 OOAAOOA22231 \
                AAOAAAO22122 OOAOOOA22122 \
                AAOAAAO22132 OOAOOOA22132 \
                AOOAAAO21222 OAAOOOA21222 \
                AOOAAAO21232 OAAOOOA21232 \
                AAAOOAO222211 OOOAAOA222211 \
                AAAOOAAO22222 OOOAAOOA22222 \
                AAOOAAAO22222 OOAAOOOA22222

AOAO2112:       DESCR = "2-1-1-2-input AND-OR-AND-OR gate"
AOAO2112:       AOAOI2111
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

OAOA2112:       DESCR = "2-1-1-2-input OR-AND-OR-AND gate"
OAOA2112:       OAOAI2111
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
AOAO2211:       AOAI221
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

OAOA2211:       DESCR = "2-2-1-1-input OR-AND-OR-AND gate"
OAOA2211:       OAOI221
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
AAOAO2212:      AAOAOI2211
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

OOAOA2212:      DESCR = "2-2-1-2-input OR-OR-AND-OR-AND gate"
OOAOA2212:      OOAOAI2211
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
AOAAO2114:      AOAAOI2113
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

OAOOA2114:      DESCR = "2-1-1-4-input OR-AND-OR-OR-AND gate"
OAOOA2114:      OAOOAI2113
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

OAOOA2212:      DESCR = "2-2-1-2-input OR-AND-OR-OR-AND gate"
OAOOA2212:      OAOA2211
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
AOOAO2122:      AOOAOI2121
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

OAAOA2122:      DESCR = "2-1-2-2-input OR-AND-AND-OR-AND gate"
OAAOA2122:      OAAOAI2121
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

AOOAO2131:      DESCR = "2-1-3-1-input AND-OR-OR-AND-OR gate"
AOOAO2131:      AOOAI213
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

OAAOA2131:      DESCR = "2-1-3-1-input OR-AND-AND-OR-AND gate"
OAAOA2131:      OAAOI213
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

AOOAO2221:      DESCR = "2-2-2-1-input AND-OR-OR-AND-OR gate"
AOOAO2221:      AOOAI222
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

OAAOA2221:      DESCR = "2-2-2-1-input OR-AND-AND-OR-AND gate"
OAAOA2221:      OAAOI222
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

OAAOA2231:      DESCR = "2-2-3-1-input OR-AND-AND-OR-AND gate"
OAAOA2231:      OAAOI223
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
AAOAO22111:     AAOAI2211
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

OOAOA22111:     DESCR = "2-2-1-1-1-input OR-OR-AND-OR-AND gate"
OOAOA22111:     OOAOI2211
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

OOAOA33111:     DESCR = "3-3-1-1-1-input OR-OR-AND-OR-AND gate"
OOAOA33111:     OOAO3311
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

AOAAO21141:     DESCR = "2-1-1-4-1-input AND-OR-AND-AND-OR gate"
AOAAO21141:     AOAAO2114
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

OAOOA21141:     DESCR = "2-1-1-4-1-input OR-AND-OR-OR-AND gate"
OAOOA21141:     OAOOA2114
	$(POPCORN) -m pu -c $@ $< > $@
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

OAAOA22311:     DESCR = "2-2-3-1-1-input OR-AND-AND-OR-AND gate"
OAAOA22311:     OAAO2231
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

AAOAAO2214:     DESCR = "2-2-1-4-input AND-AND-OR-AND-AND-OR gate"
AAOAAO2214:     AAOAAOI2213
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

OOAOOA2214:     DESCR = "2-2-1-4-input OR-OR-AND-OR-OR-AND gate"
OOAOOA2214:     OOAOOAI2213
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

AAOOAO2222:     DESCR = "2-2-2-2-input AND-AND-OR-OR-AND-OR gate"
AAOOAO2222:     AAOOAOI2221
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

OOAAOA2222:     DESCR = "2-2-2-2-input OR-OR-AND-AND-OR-AND gate"
OOAAOA2222:     OOAAOAI2221
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

AAOOAO2231:     DESCR = "2-2-3-1-input AND-AND-OR-OR-AND-OR gate"
AAOOAO2231:     AAOOAI223
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

OOAAOA2231:     DESCR = "2-2-3-1-input OR-OR-AND-AND-OR-AND gate"
OOAAOA2231:     OOAAOI223
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
AOAAO21112:     AOAAOI2112
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

AOAAO21121:     DESCR = "2-1-1-2-1-input AND-OR-AND-AND-OR gate"
AOAAO21121:     AOAAOI2112
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

OAOOA21121:     DESCR = "2-1-1-2-1-input OR-AND-OR-OR-AND gate"
OAOOA21121:     OAOOAI2112
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

AOAAO21131:     DESCR = "2-1-1-3-1-input AND-OR-AND-AND-OR gate"
AOAAO21131:     AOAAOI2113
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

OAOOA21131:     DESCR = "2-1-1-3-1-input OR-AND-OR-OR-AND gate"
OAOOA21131:     OAOOAI2113
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

AOOAAO2124:     DESCR = "2-1-2-4-input AND-OR-OR-AND-AND-OR gate"
AOOAAO2124:     AOOAAOI2123
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

OAAOOA2124:     DESCR = "2-1-2-4-input OR-AND-AND-OR-OR-AND gate"
OAAOOA2124:     OAAOOAI2123
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

OAAOOA2232:     DESCR = "2-2-3-1-input OR-AND-AND-OR-OR-AND gate"
OAAOOA2232:     OAAOA2231
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
AAAOAO22211:    AAAOAI2221
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

OOOAOA22211:    DESCR = "2-2-2-1-1-input OR-OR-OR-AND-OR-AND gate"
OOOAOA22211:    OOOAOI2221
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

AAAOAO22221:    DESCR = "2-2-2-2-1-input AND-AND-AND-OR-AND-OR gate"
AAAOAO22221:    AAAOA2222
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

OOOAOA22221:    DESCR = "2-2-2-2-1-input OR-OR-OR-AND-OR-AND gate"
OOOAOA22221:    OOOAO2222
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

AAAOAO32211:    DESCR = "3-2-2-1-1-input AND-AND-AND-OR-AND-OR gate"
AAAOAO32211:    AAAOA3221
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

OOOAOA32211:    DESCR = "3-2-2-1-1-input OR-OR-OR-AND-OR-AND gate"
OOOAOA32211:    OOOAO3221
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

AAAOAO33211:    DESCR = "3-3-2-1-1-input AND-AND-AND-OR-AND-OR gate"
AAAOAO33211:    AAAOA3321
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

OOOAOA33211:    DESCR = "3-3-2-1-1-input OR-OR-OR-AND-OR-AND gate"
OOOAOA33211:    OOOAO3321
	$(POPCORN) -m pu -c $@ $< > $@
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
AAOAAO22131:    AAOAAOI2213
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

OOAOOA22131:    DESCR = "2-2-1-3-1-input OR-OR-AND-OR-OR-AND gate"
OOAOOA22131:    OOAOOAI2213
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

AAOAAO22141:    DESCR = "2-2-1-4-1-input AND-AND-OR-AND-AND-OR gate"
AAOAAO22141:    AAOAAO2214
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

OOAOOA22141:    DESCR = "2-2-1-4-1-input OR-OR-AND-OR-OR-AND gate"
OOAOOA22141:    OOAOOA2214
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

AAOOAO22121:    DESCR = "2-2-1-2-1-input AND-AND-OR-OR-AND-OR gate"
AAOOAO22121:    AAOOAI2212
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

OOAAOA22121:    DESCR = "2-2-1-2-1-input OR-OR-AND-AND-OR-AND gate"
OOAAOA22121:    OOAAOI2212
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

OOAAOA22122:    DESCR = "2-2-1-2-2-input OR-OR-AND-AND-OR-AND gate"
OOAAOA22122:    OOAAOA22121
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

AAOOAO22131:    DESCR = "2-2-1-3-1-input AND-AND-OR-OR-AND-OR gate"
AAOOAO22131:    AAOOAI2213
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

OOAAOA22131:    DESCR = "2-2-1-3-1-input OR-OR-AND-AND-OR-AND gate"
OOAAOA22131:    OOAAOI2213
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

OOAAOA22311:    DESCR = "2-2-3-1-1-input OR-OR-AND-AND-OR-AND gate"
OOAAOA22311:    OOAAO2231
	$(POPCORN) -m pu -c $@ $< > $@
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

OAOOOA21132:    DESCR = "2-1-1-3-2-input OR_AND-OR-OR-OR-AND gate"
OAOOOA21132:    OAOOA21131
	$(POPCORN) -m nor -c $@ $< > $@
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
AOOAAO21221:    AOOAAOI2122
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

OAAOOA21221:    DESCR = "2-1-2-2-1-input OR-AND-AND-OR-OR-AND gate"
OAAOOA21221:    OAAOOAI2122
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

AOOAAO21231:    DESCR = "2-1-2-3-1-input AND-OR-OR-AND-AND-OR gate"
AOOAAO21231:    AOOAAOI2123
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

OAAOOA21231:    DESCR = "2-1-2-3-1-input OR-AND-AND-OR-OR-AND gate"
OAAOOA21231:    OAAOOAI2123
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

AOOAAO21241:    DESCR = "2-1-2-4-1-input AND-OR-OR-AND-AND-OR gate"
AOOAAO21241:    AOOAAO2124
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

OAAOOA21241:    DESCR = "2-1-2-4-1-input OR-AND-AND-OR-OR-AND gate"
OAAOOA21241:    OAAOOA2124
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

AOOOAO21221:    DESCR = "2-1-2-2-1-input AND-OR-OR-OR-AND-OR gate"
AOOOAO21221:    AOOOA2122
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

OAAAOA21221:    DESCR = "2-1-2-2-1-input OR-AND-AND-AND-OR-AND gate"
OAAAOA21221:    OAAAO2122
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

AAOOAO221211:   DESCR = "2-2-1-2-1-1-input AND-AND-OR-OR-AND-OR gate"
AAOOAO221211:   AAOOA22121
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

OOAAOA221211:   DESCR = "2-2-1-2-2-1-input OR-OR-AND-AND-OR-AND gate"
OOAAOA221211:   OOAAO22121
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

AAOOAO221311:   DESCR = "2-2-1-3-1-1-input AND-AND-OR-OR-AND-OR gate"
AAOOAO221311:   AAOOA22131
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

OOAAOA221311:   DESCR = "2-2-1-3-1-1-input OR-OR_AND-AND-OR-AND gate"
OOAAOA221311:   AAOOA22131
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

AAOOAAO2224:    DESCR = "2-2-2-4-input AND-AND-OR-OR-AND-AND-OR gate"
AAOOAAO2224:    AAOOAAOI2223
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

OOAAOOA2224:    DESCR = "2-2-2-4-input OR-OR-AND-AND-OR-OR-AND gate"
OOAAOOA2224:    OOAAOOAI2223
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

AAOOAAO2232:    DESCR = "2-2-3-2-input AND-AND-OR-OR-AND-AND-OR gate"
AAOOAAO2232:    AAOOAO2231
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

OOAAOOA2232:    DESCR = "2-2-3-2-input OR-OR-AND-AND-OR-OR-AND gate"
OOAAOOA2232:    OOAAOA2231
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

AAAOOAO22221:   DESCR = "2-2-2-2-1-input AND-AND-AND-OR-OR-AND-OR gate"
AAAOOAO22221:   AAAOOAI2222
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

OOOAAOA22221:   DESCR = "2-2-2-2-1-input OR-OR-OR-AND-AND-OR-AND gate"
OOOAAOA22221:   OOOAAOI2222
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

AAAOOAO22231:   DESCR = "2-2-2-3-1-input AND-AND-AND-OR-OR-AND-OR gate"
AAAOOAO22231:   AAAOOAI2223
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

OOOAAOA22231:   DESCR = "2-2-2-3-1-input OR-OR-OR-AND-AND-OR-AND gate"
OOOAAOA22231:   OOOAAOI2223
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

AAAOAAO22212:   DESCR = "2-2-2-1-2-input AND-AND-AND-OR-AND-AND-OR gate"
AAAOAAO22212:   AAAOAO22211
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

OOOAOOA22212:   DESCR = "2-2-2-1-2-input OR-OR-OR-AND-OR-OR-AND gate"
OOOAOOA22212:   OOOAOA22211
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

AAOOAAO22122:   DESCR = "2-2-1-2-2-input AND-AND-OR-OR-AND-AND-OR gate"
AAOOAAO22122:   AAOOAO22121
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

OOAAOOA22122:   DESCR = "2-2-1-2-2-input OR-OR-AND-AND-OR-OR-AND gate"
OOAAOOA22122:   OOAAOA22121
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

AAOOAAO22132:   DESCR = "2-2-1-3-2-input AND-AND-OR-OR-AND-AND-OR gate"
AAOOAAO22132:   AAOOAO22131
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

OOAAOOA22132:   DESCR = "2-2-1-3-2-input OR-OR-AND-AND-OR-OR-AND gate"
OOAAOOA22132:   OOAAOA22131
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

AAOOAAO22221:   DESCR = "2-2-2-2-1-input AND-AND-OR-OR-AND-AND-OR gate"
AAOOAAO22221:   AAOOAAOI2222
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

OOAAOOA22221:   DESCR = "2-2-2-2-1-input OR-OR-AND-AND-OR-OR-AND gate"
OOAAOOA22221:   OOAAOOAI2222
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

AAOOAAO22231:   DESCR = "2-2-2-3-1-input AND-AND-OR-OR-AND-AND-OR gate"
AAOOAAO22231:   AAOOAAOI2223
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

OOAAOOA22231:   DESCR = "2-2-2-3-1-input OR-OR-AND-AND-OR-OR-AND gate"
OOAAOOA22231:   OOAAOOAI2223
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

AAOAAAO22122:   DESCR = "2-2-1-2-2-input AND-AND-OR-AND-AND-AND-OR gate"
AAOAAAO22122:   AAOAAO22121
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

OOAOOOA22122:   DESCR = "2-2-1-2-2-input OR-OR-AND-OR-OR-OR-AND gate"
OOAOOOA22122:   OOAOOA22121
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

AAOAAAO22132:   DESCR = "2-2-1-3-2-input AND-AND-OR-AND-AND-AND-OR gate"
AAOAAAO22132:   AAOAAO22131
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

OOAOOOA22132:   DESCR = "2-2-1-3-2-input OR-OR-AND-OR-OR-OR-AND gate"
OOAOOOA22132:   OOAOOA22131
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

AOOAAAO21222:   DESCR = "2-1-2-2-2-input AND-OR-OR-AND-AND-AND-OR gate"
AOOAAAO21222:   AOOAAO21221
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

OAAOOOA21222:   DESCR = "2-1-2-2-2-input OR-AND-AND-OR-OR-OR-AND gate"
OAAOOOA21222:   OAAOOA21221
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

AOOAAAO21232:   DESCR = "2-1-2-3-2-input AND-OR-OR-AND-AND-AND-OR gate"
AOOAAAO21232:   AOOAAO21231
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

OAAOOOA21232:   DESCR = "2-1-2-3-2-input OR-AND-AND-OR-OR-OR-AND gate"
OAAOOOA21232:   OAAOOA21231
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

AAAOOAO222211:  DESCR = "2-2-2-2-1-1-input AND-AND-AND-OR-OR-AND-OR gate"
AAAOOAO222211:  AAAOOA22221
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

OOOAAOA222211:  DESCR = "2-2-2-2-1-1-input OR-OR-OR-AND-AND-OR-AND gate"
OOOAAOA222211:  OOOAAO22221
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

AAAOOAAO22222:  DESCR = "2-2-2-2-1-1-input AND-AND-AND-OR-OR-AND-OR gate"
AAAOOAAO22222:  AAAOOAO22221
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

OOOAAOOA22222:  DESCR = "2-2-2-2-1-1-input OR-OR-OR-AND-AND-OR-OR-AND gate"
OOOAAOOA22222:  OOOAAOA22221
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

AAOOAAAO22222:  DESCR = "2-2-2-2-2-2-input AND-AND-OR-OR-AND-AND-AND-OR gate"
AAOOAAAO22222:  AAOOAAO22221
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

OOAAOOOA22222:  DESCR = "2-2-2-2-2-2-input OR-OR-AND-AND-OR-OR-OR-AND gate"
OOAAOOOA22222:  OOAAOOA22221
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)
