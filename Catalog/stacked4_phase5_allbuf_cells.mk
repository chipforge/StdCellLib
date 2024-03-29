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
#   File:           StdCellLib/Catalog/stacked4_phase5_allbuf_cells.mk
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
#   which are all well buffered.

#   ----------------------------------------------------------------
#               CELL TARGETS - already buffered
#   ----------------------------------------------------------------

#   --------    five phases     ------------------------------------

CELLS +=        AOAOA21111 OAOAO21111 \
                AOAOA21121 OAOAO21121 \
                AOAOA22111 OAOAO22111 \
                           OAOAO32111 \
                AAOAOA22111 OOAOAO22111 \
                AAOAOA22121 OOAOAO22121 \
                AOAAOA21121 OAOOAO21121 \
                AOAAOA21131 OAOOAO21131 \
                            OAOOAO22121 \
                            OAOOAO22131 \
                AOAOOA21112 OAOAAO21112 \
                AOAOOA21113 OAOAAO21113 \
                AOAOOA21114 OAOAAO21114 \
                AOAOOA21122 OAOAAO21122 \
                AOAOOA21123 OAOAAO21123 \
                            OAOAAO22112 \
                            OAOAAO22113 \
                AOOAOA21211 OAAOAO21211 \
                AOOAOA21221 OAAOAO21221 \
                AOOAOA21311 OAAOAO21311 \
                AOOAOA22211 OAAOAO22211 \
                            OAAOAO22311 \
                AAOAOA221111 OOAOAO221111 \
                AOAAOA211211 OAOOAO211211 \
                AOAAOA211311 OAOOAO211311 \
                             OAOAAO211131 \
                AAOAAOA22121 OOAOOAO22121 \
                AAOAAOA22131 OOAOOAO22131 \
                AAOAOOA22112 OOAOAAO22112 \
                AAOAOOA22113 \
                AAOAOOA22122 \
                AAOOAOA22211 OOAAOAO22211 \
                AAOOAOA22221 OOAAOAO22221 \
                AAOOAOA22311 OOAAOAO22311 \
                AOAAOOA21122 OAOOAAO21122 \
                AOAAOOA21123 OAOOAAO21123 \
                AOAAOOA21132 OAOOAAO21132 \
                             OAOOAAO22122 \
                AOOAAOA21221 OAAOOAO21221 \
                AOOAAOA21231 OAAOOAO21231 \
                             OAAOOAO21241 \
                AOOAAOA21321 OAAOOAO21321 \
                             OAAOOAO22221 \
                AOOAOOA21212 OAAOAAO21212 \
                AOOAOOA21213 OAAOAAO21213 \
                AOOAOOA21222 OAAOAAO21222 \
                AOOAOOA21312 OAAOAAO21312 \
                             OAAOAAO22212 \
                AAAOAOA222111 OOOAOAO222111 \
                AAOOAOA221211 OOAAOAO221211 \
                AAOOAOA221311 OOAAOAO221311 \
                              OOAOOAO221121 \
                AAOAAOA221211 OOAOOAO221211 \
                AAOAAOA221311 OOAOOAO221311 \
                AAOAOOA221112 OOAOAAO221112 \
                AOOAAOA212211 OAAOOAO212211 \
                AOOAAOA212311 OAAOOAO212311 \
                AOAAOOA211212 OAOOAAO211212 \
                AOAAAOA211221 OAOOOAO211221 \
                AAOOAAOA22221 OOAAOOAO22221 \
                AAOOAAOA22231 OOAAOOAO22231 \
                AAOAAOOA22122 OOAOOAAO22122 \
                AAOAAOOA22132 OOAOOAAO22132 \
                AOOAAOOA21222 OAAOOAAO21222 \
                AOOAAOOA21232 OAAOOAAO21232 \
                AAOOAOOA22212 OOAAOAAO22212 \
                AAAOOAOA222211 OOOAAOAO222211 \
                               OOOAAOAO222311 \
                AAOOAAOA222211 OOAAOOAO222211 \
                AAOOAAOA222311 OOAAOOAO222311 \
                AAOOAAOOA22222 OOAAOOAAO22222 \
                AAOOAAOOA22232 OOAAOOAAO22232

AOAOA21111:     DESCR = "2-1-1-1-1-input AND-OR-AND-OR-AND gate"
AOAOA21111:     AOAO2111
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

OAOAO21111:     DESCR = "2-1-1-1-1-input OR-AND-OR-AND-OR gate"
OAOAO21111:     OAOA2111
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

AOAOA22111:     DESCR = "2-2-1-1-1-input AND-OR-AND-OR-AND gate"
AOAOA22111:     AOAO2211
	$(POPCORN) -m pu -c $@ $< > $@
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
AAOAOA22111:    AAOAO2211
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

OOAOAO22111:    DESCR = "2-2-1-1-1-input OR-OR-AND-OR-AND-OR gate"
OOAOAO22111:    OOAOA2211
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
AOAAOA21121:    AOAAO2112
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

OAOOAO21121:    DESCR = "2-1-1-2-1-input OR-AND-OR-OR-AND-OR gate"
OAOOAO21121:    OAOOA2112
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

AOAAOA21131:    DESCR = "2-1-1-3-1-input AND-OR-AND-AND-OR-AND gate"
AOAAOA21131:    AOAAO2113
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

OAOOAO21131:    DESCR = "2-1-1-3-1-input OR-AND-OR-OR-AND-OR gate"
OAOOAO21131:    OAOOA2113
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

OAOOAO22121:    DESCR = "2-2-1-2-1-input OR-AND-OR-OR-AND-OR gate"
OAOOAO22121:    OAOOA2212
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

OAOOAO22131:    DESCR = "2-2-1-3-1-input OR-AND-OR-OR-AND-OR gate"
OAOOAO22131:    OAOOA2213
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

AOAOOA21114:    DESCR = "2-1-1-1-3-input AND-OR-AND-OR-OR-AND gate"
AOAOOA21114:    AOAOOA21113
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

OAOAAO21114:    DESCR = "2-1-1-1-4-input OR-AND-OR-AND-AND-OR gate"
OAOAAO21114:    OAOAAO21113
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

AOAOOA21123:    DESCR = "2-1-1-2-3-input AND-OR-AND-OR-OR-AND gate"
AOAOOA21123:    AOAOOA21122
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

OAOAAO21123:    DESCR = "2-1-1-2-3-input OR-AND-OR-AND-AND-OR gate"
OAOAAO21123:    OAOAAO21122
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

OAOAAO22112:    DESCR = "2-2-1-1-2-input OR-AND-OR-AND-AND-OR gate"
OAOAAO22112:    OAOAO22111
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

OAOAAO22113:    DESCR = "2-2-1-1-3-input OR-AND-OR-AND-AND-OR gate"
OAOAAO22113:    OAOAAO22112
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

AOOAOA21211:    DESCR = "2-1-2-1-1-input AND-OR-OR-AND-OR-AND gate"
AOOAOA21211:    AOOAO2121
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

OAAOAO21211:    DESCR = "2-1-2-1-1-input OR-AND-AND-OR-AND-OR gate"
OAAOAO21211:    OAAOA2121
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

AOOAOA22211:    DESCR = "2-2-2-1-1-input AND-OR-OR-AND-OR-AND gate"
AOOAOA22211:    AOOAO2221
	$(POPCORN) -m pu -c $@ $< > $@
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
AAOAAOA22121:   AAOAAO2212
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

OOAOOAO22121:   DESCR = "2-2-1-2-1-input OR-OR-AND-OR-OR-AND-OR gate"
OOAOOAO22121:   OOAOOA2212
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

AAOAAOA22131:   DESCR = "2-2-1-3-1-input AND-AND-OR-AND-AND-OR-AND gate"
AAOAAOA22131:   AAOAAO2213
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

OOAOOAO22131:   DESCR = "2-2-1-3-1-input OR-OR-AND-OR-OR-AND-OR gate"
OOAOOAO22131:   OOAOOA2213
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

AAOAOOA22113:   DESCR = "2-2-1-1-3-input AND-AND-OR-AND-OR-OR-AND gate"
AAOAOOA22113:   AAOAOOA22112
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

AAOAOOA22122:   DESCR = "2-2-1-2-2-input AND-AND-OR-AND-OR-OR-AND gate"
AAOAOOA22122:   AAOAOA22121
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

AAOOAOA22211:   DESCR = "2-2-2-1-1-input AND-AND-OR-OR-AND-OR-AND gate"
AAOOAOA22211:   AAOOAO2221
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

OOAAOAO22211:   DESCR = "2-2-2-1-1-input OR-OR-AND-AND-OR-AND-OR gate"
OOAAOAO22211:   OOAAOA2221
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

AOAAOOA21123:   DESCR = "2-1-1-2-3-input AND-OR-AND-AND-OR-OR-AND gate"
AOAAOOA21123:   AOAAOOA21122
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

OAOOAAO21123:   DESCR = "2-1-1-2-3-input OR-AND-OR-OR-AND-AND-OR gate"
OAOOAAO21123:   OAOOAAO21122
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

OAOOAAO22122:   DESCR = "2-2-1-2-2-input OR-AND-OR-OR-AND-AND-OR gate"
OAOOAAO22122:   OAOOAO22121
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

AOOAAOA21221:   DESCR = "2-1-2-2-1-input AND-OR-OR-AND-AND-OR-AND gate"
AOOAAOA21221:   AOOAAO2122
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

OAAOOAO21221:   DESCR = "2-1-2-2-1-input OR-AND-AND-OR-OR-AND-OR gate"
OAAOOAO21221:   OAAOOA2122
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

AOOAAOA21231:   DESCR = "2-1-2-3-1-input AND-OR-OR-AND-AND-OR-AND gate"
AOOAAOA21231:   AOOAAO2123
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

OAAOOAO21231:   DESCR = "2-1-2-3-1-input OR-AND-AND-OR-OR-AND-OR gate"
OAAOOAO21231:   OAAOOA2123
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

OAAOOAO21241:   DESCR = "2-1-2-4-1-input OR-AND-AND-OR-OR-AND-OR gate"
OAAOOAO21241:   OAAOOA2124
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

AOOAAOA21321:   DESCR = "2-1-3-2-1-input AND-OR-OR-AND-AND-OR-AND gate"
AOOAAOA21321:   AOOAAO2132
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

OAAOOAO21321:   DESCR = "2-1-3-2-1-input OR-AND-AND-OR-OR-AND-OR gate"
OAAOOAO21321:   OAAOOA2132
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

OAAOOAO22221:   DESCR = "2-2-2-2-1-input OR-AND-AND-OR-OR-AND-OR gate"
OAAOOAO22221:   OAAOOA2222
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

AOOAOOA21213:   DESCR = "2-1-2-1-3-input AND-OR-OR-AND-OR-OR-AND gate"
AOOAOOA21213:   AOOAOOA21212
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

OAAOAAO21213:   DESCR = "2-1-2-1-3-input OR-AND-AND-OR-AND-AND-OR gate"
OAAOAAO21213:   OAAOAAO21212
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

AOOAOOA21222:   DESCR = "2-1-2-2-2-input AND-OR-OR-AND-OR-OR-AND gate"
AOOAOOA21222:   AOOAOA21221
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

OAAOAAO21222:   DESCR = "2-1-2-2-2-input OR-AND-AND-OR-AND-AND-OR gate"
OAAOAAO21222:   OAAOAO21221
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

AOOAOOA21312:   DESCR = "2-1-3-1-2-input AND-OR-OR-AND-OR-OR-AND gate"
AOOAOOA21312:   AOOAOA21311
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

OAAOAAO21312:   DESCR = "2-1-3-1-2-input OR-AND-AND-OR-AND-AND-OR gate"
OAAOAAO21312:   OAAOAO21311
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

OAAOAAO22212:   DESCR = "2-2-2-1-2-input OR-AND-AND-OR-AND-AND-OR gate"
OAAOAAO22212:   OAAOAO22211
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

OOAAOAO221311:  DESCR = "2-2-1-3-1-1-input OR-OR-AND-AND-OR-AND-OR gate"
OOAAOAO221311:  OOAAOA22131
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

OOAOOAO221121:  DESCR = "2-2-1-1-2-1-input OR-OR-AND-OR-OR-AND-OR gate"
OOAOOAO221121:  OOAOOA22112
	$(POPCORN) -m pd -c $@ $< > $@
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

OOAOOAO221311:  DESCR = "2-2-1-3-1-1-input OR-OR-AND-OR-OR-AND-OR gate"
OOAOOAO221311:  OOAOOA22131
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

AAOAOOA221112:  DESCR = "2-2-1-1-1-2-input AND-AND-OR-AND-OR-OR-AND gate"
AAOAOOA221112:  AAOAOA221111
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

OOAOAAO221112:  DESCR = "2-2-1-1-1-2-input OR-OR-AND-OR-AND-AND-OR gate"
OOAOAAO221112:  OOAOAO221111
	$(POPCORN) -m nand -c $@ $< > $@
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

AOAAOOA211212:  DESCR = "2-1-1-2-1-2-input AND-OR-AND-AND-OR-OR-AND gate"
AOAAOOA211212:  AOAAOA211211
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

OAOOAAO211212:  DESCR = "2-1-1-2-1-2-input OR-AND-OR-OR-AND-AND-OR gate"
OAOOAAO211212:  OAOOAO211211
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

AOAAAOA211221:  DESCR = "2-1-1-2-2-1-input AND-OR-AND-AND-AND-OR-AND gate"
AOAAAOA211221:  AOAAAO21122
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

OAOOOAO211221:  DESCR = "2-1-1-2-2-1-input OR-AND-OR-OR-OR-AND-OR gate"
OAOOOAO211221:  OAOOOA21122
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

AAOOAAOA22221:  DESCR = "2-2-2-2-1-input AND-AND-OR-OR-AND-AND-OR-AND gate"
AAOOAAOA22221:  AAOOAAO2222
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

OOAAOOAO22221:  DESCR = "2-2-2-2-1-input OR-OR-AND-AND-OR-OR-AND-OR gate"
OOAAOOAO22221:  OOAAOOA2222
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

AAOOAAOA22231:  DESCR = "2-2-2-3-1-input AND-AND-OR-OR-AND-AND-OR-AND gate"
AAOOAAOA22231:  AAOOAAO2223
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

OOAAOOAO22231:  DESCR = "2-2-2-3-1-input OR-OR-AND-AND-OR-OR-AND-OR gate"
OOAAOOAO22231:  OOAAOOA2223
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

OOAOOAAO22132:  DESCR = "2-2-1-3-2-input OR-OR-AND-OR-OR-AND-AND-OR gate"
OOAOOAAO22132:  OOAOOAO22131
	$(POPCORN) -m nand -c $@ $< > $@
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

OOOAAOAO222211: DESCR = "2-2-2-2-1-1-input OR-OR-OR-AND-AND-OR-AND-OR gate"
OOOAAOAO222211: OOOAAOA22221
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

OOOAAOAO222311: DESCR = "2-2-2-3-1-1-input OR-OR-OR-AND-AND-OR-AND-OR gate"
OOOAAOAO222311: OOOAAOA22231
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

AAOOAAOA222211: DESCR = "2-2-2-2-1-1-input AND-AND-OR-OR-AND-AND-OR-AND gate"
AAOOAAOA222211: AAOOAAO22221
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

OOAAOOAO222211: DESCR = "2-2-2-2-1-1-input OR-OR-AND-AND-OR-OR-AND-OR gate"
OOAAOOAO222211: OOAAOOA22221
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

AAOOAAOA222311: DESCR = "2-2-2-3-1-1-input AND-AND-OR-OR-AND-AND-OR-AND gate"
AAOOAAOA222311: AAOOAAO22231
	$(POPCORN) -m pu -c $@ $< > $@
	$(STACKED4)

OOAAOOAO222311: DESCR = "2-2-2-3-1-1-input OR-OR-AND-AND-OR-OR-AND-OR gate"
OOAAOOAO222311: OOAAOOA22231
	$(POPCORN) -m pd -c $@ $< > $@
	$(STACKED4)

AAOOAAOOA22222: DESCR = "2-2-2-2-2-2-input AND-AND-OR-OR-AND-AND-OR-OR-AND gate"
AAOOAAOOA22222: AAOOAAOA22221
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

OOAAOOAAO22222: DESCR = "2-2-2-2-2-2-input OR-OR-AND-AND-OR-OR-AND-AND-OR gate"
OOAAOOAAO22222: OOAAOOAO22221
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)

AAOOAAOOA22232: DESCR = "2-2-2-2-3-2-input AND-AND-OR-OR-AND-AND-OR-OR-AND gate"
AAOOAAOOA22232: AAOOAAOA22231
	$(POPCORN) -m nor -c $@ $< > $@
	$(STACKED4)

OOAAOOAAO22232: DESCR = "2-2-2-2-3-2-input OR-OR-AND-AND-OR-OR-AND-AND-OR gate"
OOAAOOAAO22232: OOAAOOAO22231
	$(POPCORN) -m nand -c $@ $< > $@
	$(STACKED4)
