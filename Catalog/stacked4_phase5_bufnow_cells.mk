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
#   File:           StdCellLib/Catalog/stacked4_phase5_bufnow_cells.mk
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
#   which are buffered now.

#   ----------------------------------------------------------------
#               CELL TARGETS - now buffered
#   ----------------------------------------------------------------

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
                            OAAOAO22311 \
                AAOAOA221111 OOAOAO221111 \
                AOAAOA211211 OAOOAI211211 \
                AOAAOA211311 OAOOAO211311 \
                AAOAAOA22121 OOAOOAO22121 \
                AAOAAOA22122 \
                AAOAAOA22131 OOAOOAO22131 \
                AAOAOOA22112 OOAOAAO22112 \
                AAOOAOA22211 OOAAOAO22211 \
                AAOOAOA22221 OOAAOAO22221 \
                AAOOAOA22311 OOAAOAO22311 \
                AOAAOOA21122 OAOOAAO21122 \
                AOAAOOA21132 OAOOAAO21132 \
                AOOAAOA21221 OAAOOAO21221 \
                AOOAAOA21231 OAAOOAO21231 \
                             OAAOOAO21241 \
                AOOAOOA21212 OAAOAAO21212 \
                AAAOAOA222111 OOOAOAO222111 \
                AAOOAOA221211 OOAAOAO221211 \
                AAOOAOA221311 \
                AAOAAOA221211 OOAOOAO221211 \
                AAOAAOA221311 \
                AOOAAOA212211 OAAOOAO212211 \
                AOOAAOA212311 OAAOOAO212311 \
                AAOOAAOA22221 OOAAOOAO22221 \
                AAOOAAOA22231 OOAAOOAO22231 \
                AAOAAOOA22122 OOAOOAAO22122 \
                AAOAAOOA22132 \
                AOOAAOOA21222 OAAOOAAO21222 \
                AOOAAOOA21232 OAAOOAAO21232 \
                AAOOAOOA22212 \OOAAOAAO22212 \
                AAAOOAOA222211 \
                AAOOAAOA222211 \
                AAOOAAOOA22222

AOAOA21111:     DESCR = "2-1-1-1-1-input AND-OR-AND-OR-AND gate"
AOAOA21111:     AOAOI2111
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

OAOAO21111:     DESCR = "2-1-1-1-1-input OR-AND-OR-AND-OR gate"
OAOAO21111:     OAOAI2111
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
AAOAOA22111:    AAOAOI2211
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

OOAOAO22111:    DESCR = "2-2-1-1-1-input OR-OR-AND-OR-AND-OR gate"
OOAOAO22111:    OOAOAI2211
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
AOAAOA21121:    AOAAOI2112
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

OAOOAO21121:    DESCR = "2-1-1-2-1-input OR-AND-OR-OR-AND-OR gate"
OAOOAO21121:    OAOOAI2112
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

AOAAOA21131:    DESCR = "2-1-1-3-1-input AND-OR-AND-AND-OR-AND gate"
AOAAOA21131:    AOAAOI2113
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

OAOOAO21131:    DESCR = "2-1-1-3-1-input OR-AND-OR-OR-AND-OR gate"
OAOOAO21131:    OAOOAI2113
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
AOOAOA21211:    AOOAOI2121
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

OAAOAO21211:    DESCR = "2-1-2-1-1-input OR-AND-AND-OR-AND-OR gate"
OAAOAO21211:    OAAOAI2121
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

OAAOAO22311:    DESCR = "2-2-3-1-1-input OR-AND-AND-OR-AND-OR gate"
OAAOAO22311:    OAAOA2231
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
AAOAAOA22121:   AAOAAOI2212
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

OOAOOAO22121:   DESCR = "2-2-1-2-1-input OR-OR-AND-OR-OR-AND-OR gate"
OOAOOAO22121:   OOAOOAI2212
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

AAOAAOA22122:   DESCR = "2-2-1-2-2-input AND-AND-OR-AND-AND-OR-AND gate"
AAOAAOA22122:   AAOAAOA22121
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

AAOAAOA22131:   DESCR = "2-2-1-3-1-input AND-AND-OR-AND-AND-OR-AND gate"
AAOAAOA22131:   AAOAAOI2213
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

OOAOOAO22131:   DESCR = "2-2-1-3-1-input OR-OR-AND-OR-OR-AND-OR gate"
OOAOOAO22131:   OOAOOAI2213
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
AAOOAOA22211:   AAOOAOI2221
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

OOAAOAO22211:   DESCR = "2-2-2-1-1-input OR-OR-AND-AND-OR-AND-OR gate"
OOAAOAO22211:   OOAAOAI2221
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

AAOOAOA22221:   DESCR = "2-2-2-2-1-input AND-AND-OR-OR-AND-OR-AND gate"
AAOOAOA22221:   AAOOAO2222
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

OOAAOAO22221:   DESCR = "2-2-2-2-1-input OR-OR-AND-AND-OR-AND-OR gate"
OOAAOAO22221:   OOAAOA2222
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

AAOOAOA22311:   DESCR = "2-2-3-1-1-input AND-AND-OR-OR-AND-OR-AND gate"
AAOOAOA22311:   AAOOAO2231
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

OOAAOAO22311:   DESCR = "2-2-3-1-1-input OR-OR-AND-AND-OR-AND-OR gate"
OOAAOAO22311:   OOAAOA2231
	$(POPCORN) -m pd -c $@ $< > $@
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

OAOOAAO21132:   DESCR = "2-1-1-3-2-input OR-AND-OR-OR-AND-AND-OR gate"
OAOOAAO21132:   OAOOAO21131
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

AOOAAOA21221:   DESCR = "2-1-2-2-1-input AND-OR-OR-AND-AND-OR-AND gate"
AOOAAOA21221:   AOOAAOI2122
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

OAAOOAO21221:   DESCR = "2-1-2-2-1-input OR-AND-AND-OR-OR-AND-OR gate"
OAAOOAO21221:   OAAOOAI2122
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

AOOAAOA21231:   DESCR = "2-1-2-3-1-input AND-OR-OR-AND-AND-OR-AND gate"
AOOAAOA21231:   AOOAAOI2123
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

OAAOOAO21231:   DESCR = "2-1-2-3-1-input OR-AND-AND-OR-OR-AND-OR gate"
OAAOOAO21231:   OAAOOAI2123
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

OAAOOAO21241:   DESCR = "2-1-2-4-1-input OR-AND-AND-OR-OR-AND-OR gate"
OAAOOAO21241:   OAAOOA2124
	$(POPCORN) -m pd -c $@ $< > $@
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

OOOAOAO222111:  DESCR = "2-2-2-1-1-1-input OR-OR-OR-AND-OR-AND-OR gate"
OOOAOAO222111:  OOOAOA22211
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

AAOOAOA221211:  DESCR = "2-2-1-2-1-1-input AND-AND-OR-OR-AND-OR-AND gate"
AAOOAOA221211:  AAOOAO22121
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

OOAAOAO221211:  DESCR = "2-2-1-2-1-1-input OR-OR-AND-AND-OR-AND-OR gate"
OOAAOAO221211:  OOAAOA22121
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

AAOOAOA221311:  DESCR = "2-2-1-3-1-1-input AND-AND-OR-OR-AND-OR-AND gate"
AAOOAOA221311:  AAOOAO22131
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

AAOAAOA221211:  DESCR = "2-2-1-2-1-1-input AND-AND-OR-AND-AND-OR-AND gate"
AAOAAOA221211:  AAOAAO22121
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

OOAOOAO221211:  DESCR = "2-2-1-2-1-1-input OR-OR-AND-OR-OR-AND-OR gate"
OOAOOAO221211:  OOAOOA22121
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

AAOAAOA221311:  DESCR = "2-2-1-3-1-1-input AND-AND-OR-AND-AND-OR-AND gate"
AAOAAOA221311:  AAOAAO22131
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

AOOAAOA212211:  DESCR = "2-1-2-2-1-1-input AND-OR-OR-AND-AND-OR-AND gate"
AOOAAOA212211:  AOOAAO21221
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

OAAOOAO212211:  DESCR = "2-1-2-2-1-1-input OR-AND-AND-OR-OR-AND-OR gate"
OAAOOAO212211:  OAAOOA21221
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

AOOAAOA212311:  DESCR = "2-1-2-3-1-1-input AND-OR-OR-AND-AND-OR-AND gate"
AOOAAOA212311:  AOOAAO21231
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

OAAOOAO212311:  DESCR = "2-1-2-3-1-1-input OR-AND-AND-OR-OR-AND-OR gate"
OAAOOAO212311:  OAAOOA21231
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

AAOOAAOA22221:  DESCR = "2-2-2-2-1-input AND-AND-OR-OR-AND-AND-OR-AND gate"
AAOOAAOA22221:  AAOOAAOI2222
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

OOAAOOAO22221:  DESCR = "2-2-2-2-1-input OR-OR-AND-AND-OR-OR-AND-OR gate"
OOAAOOAO22221:  OOAAOOAI2222
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

AAOOAAOA22231:  DESCR = "2-2-2-3-1-input AND-AND-OR-OR-AND-AND-OR-AND gate"
AAOOAAOA22231:  AAOOAAOI2223
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

OOAAOOAO22231:  DESCR = "2-2-2-3-1-input OR-OR-AND-AND-OR-OR-AND-OR gate"
OOAAOOAO22231:  OOAAOOAI2223
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

AAOAAOOA22122:  DESCR = "2-2-1-2-2-input AND-AND-OR-AND-AND-OR-OR-AND gate"
AAOAAOOA22122:  AAOAAOA22121
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

OOAOOAAO22122:  DESCR = "2-2-1-2-2-input OR-OR-AND-OR-OR-AND-AND-OR gate"
OOAOOAAO22122:  OOAOOAO22121
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

AAOAAOOA22132:  DESCR = "2-2-1-3-2-input AND-AND-OR-AND-AND-OR-OR-AND gate"
AAOAAOOA22132:  AAOAAOA22131
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

AOOAAOOA21222:  DESCR = "2-1-2-2-2-input AND-OR-OR-AND-AND-OR-OR-AND gate"
AOOAAOOA21222:  AOOAAOA21221
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

OAAOOAAO21222:  DESCR = "2-1-2-2-2-input OR-AND-AND-OR-OR-AND-AND-OR gate"
OAAOOAAO21222:  OAAOOAO21221
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

AOOAAOOA21232:  DESCR = "2-1-2-3-2-input AND-OR-OR-AND-AND-OR-OR-AND gate"
AOOAAOOA21232:  AOOAAOA21231
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

OAAOOAAO21232:  DESCR = "2-1-2-3-2-input OR-AND-AND-OR-OR-AND-AND-OR gate"
OAAOOAAO21232:  OAAOOAO21231
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

AAOOAOOA22212:  DESCR = "2-2-2-1-2-input AND-AND-OR-OR-AND-OR-OR-AND gate"
AAOOAOOA22212:  AAOOAOA22211
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

OOAAOAAO22212:  DESCR = "2-2-2-1-2-input OR-OR-AND-AND-OR-AND-AND-OR gate"
OOAAOAAO22212:  OOAAOAO22211
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

AAAOOAOA222211: DESCR = "2-2-2-2-1-1-input AND-AND-AND-OR-OR-AND-OR-AND gate"
AAAOOAOA222211: AAAOOAO22221
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

AAOOAAOA222211: DESCR = "2-2-2-2-1-1-input AND-AND-OR-OR-AND-AND-OR-AND gate"
AAOOAAOA222211: AAOOAAO22221
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

AAOOAAOOA22222: DESCR = "2-2-2-2-2-2-input AND-AND-OR-OR-AND-AND-OR-OR-AND gate"
AAOOAAOOA22222: AAOOAAOA22221
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)
