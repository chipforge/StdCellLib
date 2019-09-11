#   ************    LibreSilicon's StdCellLibrary   *******************
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
#   File:           StdCellLib/Catalog/stacked3_cells.mk
#
#   Purpose:        Makefile for Cell Generation with popcorn
#
#   ************    GNU Make 3.80 Source Code       ****************
#
#   ////////////////////////////////////////////////////////////////
#
#   Copyright (c)   2018, 2019 by
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
#   ////////////////////////////////////////////////////////////////////

#   ----------------------------------------------------------------
#               DESCRIPTION
#   ----------------------------------------------------------------

#   list all dependencies for cells with 3 stacked transistors
#
include stacked2_cells.mk

#   ----------------------------------------------------------------
#               CELL TARGETS
#   ----------------------------------------------------------------

ifdef BUFFERED

#   --------    already buffered    --------------------------------

CELLS +=        AAAO332 \
                AAAO333 \
                AAO321 \
                AAO331 \
                AND3 \
                AO211 \
                AO31 \
                AO311 \
                AO32 \
                AAO33 \
                AO331 \
                AO332 \
                AOA211 \
                AOA221 \
                AOAO2111 \
                AOOA212 \
                OA22 \
                OA31 \
                OA32 \
                OAO211 \
                OAO212 \
                OAO221 \
                OAOA2111 \
                OR3 \
                OOA32 \
                OOA321 \
                OOA33 \
                OOA331 \
                OOOA332 \
                OOOA333

AAAO332:        LEVEL = 3
AAAO332:        AAAO331
	$(POPCORN) -m aoi -c $@ $< > $@

AAAO333:        LEVEL = 3
AAAO333:        AAAO332
	$(POPCORN) -m aoi -c $@ $< > $@

AAO331:         LEVEL = 3
AAO331:         AAO321
	$(POPCORN) -m aoi -c $@ $< > $@

AND3:           AND2
	$(POPCORN) -m nand -c $(*F) -c $@ $< > $@

AO211:          OR3
	$(POPCORN) -m aoi -c $@ $< > $@

AO31:           AO21
	$(POPCORN) -m aoi -c $@ $< > $@

AO311:          AO211
	$(POPCORN) -m aoi -c $@ $< > $@

AO32:           AO22
	$(POPCORN) -m aoi -c $@ $< > $@

AO321:          AO221
	$(POPCORN) -m aoi -c $@ $< > $@

AAO33:          LEVEL = 3
AAO33:          AAO32
	$(POPCORN) -m aoi -c $@ $< > $@

AO331:          LEVEL = 3
AO331:          AO321
	$(POPCORN) -m aoi -c $@ $< > $@

AO332:          LEVEL = 3
AO332:          AO331
	$(POPCORN) -m aoi -c $@ $< > $@

AOA211:         OA21
	$(POPCORN) -m nand -c $@ $< > $@

AOA221:         OA31
	$(POPCORN) -m nand -c $@ $< > $@

AOAO2111:       OAO211
	$(POPCORN) -m nand -c $@ $< > $@

AOOA212:        OOA22
	$(POPCORN) -m nand -c $@ $< > $@

OA22:           AND3
	$(POPCORN) -m oai -c $@ $< > $@

OA31:           OA21
	$(POPCORN) -m oai -c $@ $< > $@

OA32:           OA22
	$(POPCORN) -m oai -c $@ $< > $@

OOA32:          OOA22
	$(POPCORN) -m oai -c $@ $< > $@

OAO211:         AO21
	$(POPCORN) -m nor -c $@ $< > $@

OAO212:         AO22
	$(POPCORN) -m nor -c $@ $< > $@

OAO221:         AO31
	$(POPCORN) -m nor -c $@ $< > $@

OAOA2111:       AOA211
	$(POPCORN) -m nor -c $@ $< > $@

OR3:            OR2
	$(POPCORN) -m nor -c $@ $< > $@

OOA321:         OOA221
	$(POPCORN) -m oai -c $@ $< > $@

OOA33:          LEVEL = 3
OOA33:          OOA32
	$(POPCORN) -m oai -c $@ $< > $@

OOA331:         LEVEL = 3
OOA331:         OOA321
	$(POPCORN) -m oai -c $@ $< > $@

OOOA332:        LEVEL = 3
OOOA332:        OOA331
	$(POPCORN) -m oai -c $@ $< > $@

OOOA333:        LEVEL = 3
OOOA333:        OOOA332
	$(POPCORN) -m oai -c $@ $< > $@

else
ifeq ($(BUFFER),3)

#   --------    now buffered    ------------------------------------

CELLS +=        AAAO332 \
                AAAO333 \
                AAO321 \
                AAO331 \
                AND3 \
                AO211 \
                AO31 \
                AO311 \
                AO32 \
                AO33 \
                AO331 \
                AO332 \
                AOA211 \
                AOA221 \
                AOAO2111 \
                AOOA212 \
                OA22 \
                OA31 \
                OA32 \
                OAO211 \
                OAO212 \
                OAO221 \
                OAOA2111 \
                OR3 \
                OOA32 \
                OOA321 \
                OOA33 \
                OOA331 \
                OOOA332 \
                OOOA333

AAAO332:        LEVEL = 3
AAAO332:        AAAO331
	$(POPCORN) -m aoi -c $@ $< > $@

AAAO333:        LEVEL = 3
AAAO333:        AAAO332
	$(POPCORN) -m aoi -c $@ $< > $@

AAO331:         LEVEL = 3
AAO331:         AAO321
	$(POPCORN) -m aoi -c $@ $< > $@

AND3:           NAND2
	$(POPCORN) -m nand -c $@ $< > $@

AO211:          OR3
	$(POPCORN) -m aoi -c $@ $< > $@

AO31:           AOI21
	$(POPCORN) -m aoi -c $@ $< > $@

AO311:          AO211
	$(POPCORN) -m aoi -c $@ $< > $@

AO32:           AOI22
	$(POPCORN) -m aoi -c $@ $< > $@

AO321:          AO221
	$(POPCORN) -m aoi -c $@ $< > $@

AAO33:          LEVEL = 3
AAO33:          AAO32
	$(POPCORN) -m aoi -c $@ $< > $@

AO331:          LEVEL = 3
AO331:          AO321
	$(POPCORN) -m aoi -c $@ $< > $@

AO332:          LEVEL = 3
AO332:          AO331
	$(POPCORN) -m aoi -c $@ $< > $@

AOA211:         OAI21
	$(POPCORN) -m nand -c $@ $< > $@

AOA221:         OA31
	$(POPCORN) -m nand -c $@ $< > $@

AOAO2111:       OAO211
	$(POPCORN) -m nand -c $@ $< > $@

AOOA212:        OOAI22
	$(POPCORN) -m nand -c $@ $< > $@

OA22:           AND3
	$(POPCORN) -m oai -c $@ $< > $@

OA31:           OAI21
	$(POPCORN) -m oai -c $@ $< > $@

OA32:           OA22
	$(POPCORN) -m oai -c $@ $< > $@

OOA32:          OOAI22
	$(POPCORN) -m oai -c $@ $< > $@

OAO211:         AOI21
	$(POPCORN) -m nor -c $@ $< > $@

OAO212:         AOI22
	$(POPCORN) -m nor -c $@ $< > $@

OAO221:         AO31
	$(POPCORN) -m nor -c $@ $< > $@

OAOA2111:       AOA211
	$(POPCORN) -m nor -c $@ $< > $@

OR3:            NOR2
	$(POPCORN) -m nor -c $@ $< > $@

OOA321:         OOA221
	$(POPCORN) -m oai -c $@ $< > $@

OOA33:          LEVEL = 3
OOA33:          OOA32
	$(POPCORN) -m oai -c $@ $< > $@

OA331:          LEVEL = 3
OA331:          OOA321
	$(POPCORN) -m oai -c $@ $< > $@

OOOA332:        LEVEL = 3
OOOA332:        OOA331
	$(POPCORN) -m oai -c $@ $< > $@

OOOA333:        LEVEL = 3
OOOA333:        OOOA332
	$(POPCORN) -m oai -c $@ $< > $@

BUFFERED = true

else

#   --------    not buffered    ------------------------------------

CELLS +=        AAAOI332 \
                AAAOI333 \
                AAOI321 \
                AAOI331 \
                AOAI211 \
                AOAI221 \
                AOAOI2111 \
                AOI211 \
                AOI31 \
                AOI32 \
                AAOI33 \
                AOI331 \
                AOOAI212 \
                NAND3 \
                NOR3 \
                OAI22 \
                OAI31 \
                OAI32 \
                OAOAI2111 \
                OAOI211 \
                OAOI212 \
                OAOI221 \
                OOAI32 \
                OOAI321 \
                OOAI33 \
                OOAI331 \
                OOOAI332 \
                OOOOAI333

AAAOI332:       LEVEL = 3
AAAOI332:       AOI331
	$(POPCORN) -m aoi -c $@ $< > $@

AAAOI333:       LEVEL = 3
AAAOI333:       AAAOI332
	$(POPCORN) -m aoi -c $@ $< > $@

AAOI331:        LEVEL = 3
AAOI331:        AAOI321
	$(POPCORN) -m aoi -c $@ $< > $@

AAOI321:        LEVEL = 3
AAOI321:        AAOI221
	$(POPCORN) -m aoi -c $@ $< > $@

AOAI211:        OAI21
	$(POPCORN) -m nand -c $@ $< > $@

AOAI221:        OAI31
	$(POPCORN) -m nand -c $@ $< > $@

AOAOI2111:      OAOI211
	$(POPCORN) -m nand -c $@ $< > $@

AOI211:         NOR3
	$(POPCORN) -m aoi -c $@ $< > $@

AOI31:          AOI21
	$(POPCORN) -m aoi -c $@ $< > $@

AOI32:          AOI22
	$(POPCORN) -m aoi -c $@ $< > $@

AOI32:          AOI22
	$(POPCORN) -m aoi -c $@ $< > $@

AOI321:         AOI221
	$(POPCORN) -m aoi -c $@ $< > $@

AAOI33:         LEVEL = 3
AAOI33:         AAOI32
	$(POPCORN) -m aoi -c $@ $< > $@

AOI331:         LEVEL = 3
AOI331:         AOI321
	$(POPCORN) -m aoi -c $@ $< > $@

AOOAI212:       OOAI22
	$(POPCORN) -m nand -c $@ $< > $@

NAND3:          NAND2
	$(POPCORN) -m nand -c $@ $< > $@

NOR3:           NOR2
	$(POPCORN) -m nor -c $@ $< > $@

OAI22:          NAND3
	$(POPCORN) -m oai -c $@ $< > $@

OAI31:          OAI21
	$(POPCORN) -m oai -c $@ $< > $@

OAI32:          OAI22
	$(POPCORN) -m oai -c $@ $< > $@

OOAI32:         OOAI22
	$(POPCORN) -m oai -c $@ $< > $@

OAOAI2111:      AOAI211
	$(POPCORN) -m nor -c $@ $< > $@

OAOI211:        AOI21
	$(POPCORN) -m nor -c $@ $< > $@

OAOI212:        AOI22
	$(POPCORN) -m nor -c $@ $< > $@

OAOI221:        AOI31
	$(POPCORN) -m nor -c $@ $< > $@

OOAI321:        OOAI221
	$(POPCORN) -m oai -c $@ $< > $@

OOAI33:         LEVEL = 3
OOAI33:         OOAI32
	$(POPCORN) -m oai -c $@ $< > $@

OOAI331:        LEVEL = 3
OOAI331:        OOAI321
	$(POPCORN) -m oai -c $@ $< > $@

OOOAI332:       LEVEL = 3
OOOAI332:       OOAI331
	$(POPCORN) -m oai -c $@ $< > $@

OOOAI333:       LEVEL = 3
OOOAI333:       OOOAI332
	$(POPCORN) -m oai -c $@ $< > $@

endif
endif
