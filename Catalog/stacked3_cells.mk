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

CELLS +=        AND3 \
                AO211 \
                AO31 \
                AO311 \
                AO32 \
                AO321 \
                AO33 \
                AO331 \
                AO332 \
                AO333 \
                AOA211 \
                AOA212 \
                AOA221 \
                AOAO2111 \
                OA211 \
                OA31 \
                OA311 \
                OA32 \
                OA321 \
                OA33 \
                OA331 \
                OA332 \
                OA333 \
                OAO211 \
                OAO212 \
                OAO221 \
                OAOA2111 \
                OR3

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

AO33:           LEVEL = 3
AO33:           AO32
	$(POPCORN) -m aoi -c $@ $< > $@

AO331:          LEVEL = 3
AO331:          AO321
	$(POPCORN) -m aoi -c $@ $< > $@

AO332:          LEVEL = 3
AO332:          AO331
	$(POPCORN) -m aoi -c $@ $< > $@

AO333:          LEVEL = 3
AO333:          AO332
	$(POPCORN) -m aoi -c $@ $< > $@

AOA211:         OA21
	$(POPCORN) -m nand -c $@ $< > $@

AOA212:         OOA22
	$(POPCORN) -m nand -c $@ $< > $@

AOA221:         OA31
	$(POPCORN) -m nand -c $@ $< > $@

AOAO2111:       OAO211
	$(POPCORN) -m nand -c $@ $< > $@

OA211:          AND3
	$(POPCORN) -m oai -c $@ $< > $@

OA31:           OA21
	$(POPCORN) -m oai -c $@ $< > $@

OA311:          OA211
	$(POPCORN) -m oai -c $@ $< > $@

OA32:           OOA22
	$(POPCORN) -m oai -c $@ $< > $@

OA321:          OA221
	$(POPCORN) -m oai -c $@ $< > $@

OA33:           LEVEL = 3
OA33:           OA32
	$(POPCORN) -m oai -c $@ $< > $@

OA331:          LEVEL = 3
OA331:          OA321
	$(POPCORN) -m oai -c $@ $< > $@

OA332:          LEVEL = 3
OA332:          OA331
	$(POPCORN) -m oai -c $@ $< > $@

OA333:          LEVEL = 3
OA333:          OA332
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

else
ifeq ($(BUFFER),3)

#   --------    now buffered    ------------------------------------

CELLS +=        AND3 \
                AO211 \
                AO31 \
                AO311 \
                AO32 \
                AO321 \
                AO33 \
                AO331 \
                AO332 \
                AO333 \
                AOA211 \
                AOA212 \
                AOA221 \
                AOAO2111 \
                OA211 \
                OA31 \
                OA311 \
                OA32 \
                OA321 \
                OA33 \
                OA331 \
                OA332 \
                OA333 \
                OAO211 \
                OAO212 \
                OAO221 \
                OAOA2111 \
                OR3

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

AO33:           LEVEL = 3
AO33:           AO32
	$(POPCORN) -m aoi -c $@ $< > $@

AO331:          LEVEL = 3
AO331:          AO321
	$(POPCORN) -m aoi -c $@ $< > $@

AO332:          LEVEL = 3
AO332:          AO331
	$(POPCORN) -m aoi -c $@ $< > $@

AO333:          LEVEL = 3
AO333:          AO332
	$(POPCORN) -m aoi -c $@ $< > $@

AOA211:         OAI21
	$(POPCORN) -m nand -c $@ $< > $@

AOA212:         OOAI22
	$(POPCORN) -m nand -c $@ $< > $@

AOA221:         OA31
	$(POPCORN) -m nand -c $@ $< > $@

AOAO2111:       OAO211
	$(POPCORN) -m nand -c $@ $< > $@

OA211:          AND3
	$(POPCORN) -m oai -c $@ $< > $@

OA31:           OAI21
	$(POPCORN) -m oai -c $@ $< > $@

OA311:          OA211
	$(POPCORN) -m oai -c $@ $< > $@

OA32:           OOAI22
	$(POPCORN) -m oai -c $@ $< > $@

OA321:          OA221
	$(POPCORN) -m oai -c $@ $< > $@

OA33:           LEVEL = 3
OA33:           OA32
	$(POPCORN) -m oai -c $@ $< > $@

OA331:          LEVEL = 3
OA331:          OA321
	$(POPCORN) -m oai -c $@ $< > $@

OA332:          LEVEL = 3
OA332:          OA331
	$(POPCORN) -m oai -c $@ $< > $@

OA333:          LEVEL = 3
OA333:          OA332
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

BUFFERED = true

else

#   --------    not buffered    ------------------------------------

CELLS +=        AOAI211 \
                AOAI212 \
                AOAI221 \
                AOAOI2111 \
                AOI211 \
                AOI31 \
                AOI311 \
                AOI32 \
                AOI321 \
                AOI33 \
                AOI331 \
                AOI332 \
                AOI333 \
                NAND3 \
                NOR3 \
                OAI211 \
                OAI31 \
                OAI311 \
                OAI32 \
                OAI321 \
                OAI33 \
                OAI331 \
                OAI332 \
                OAI333 \
                OAOAI2111 \
                OAOI211 \
                OAOI212 \
                OAOI221

AOAI211:        OAI21
	$(POPCORN) -m nand -c $@ $< > $@

AOAI212:        OOAI22
	$(POPCORN) -m nand -c $@ $< > $@

AOAI221:        OAI31
	$(POPCORN) -m nand -c $@ $< > $@

AOAOI2111:      OAOI211
	$(POPCORN) -m nand -c $@ $< > $@

AOI211:         NOR3
	$(POPCORN) -m aoi -c $@ $< > $@

AOI31:          AOI21
	$(POPCORN) -m aoi -c $@ $< > $@

AOI311:         AOI211
	$(POPCORN) -m aoi -c $@ $< > $@

AOI32:          AOI22
	$(POPCORN) -m aoi -c $@ $< > $@

AOI321:         AOI221
	$(POPCORN) -m aoi -c $@ $< > $@

AOI33:          LEVEL = 3
AOI33:          AOI32
	$(POPCORN) -m aoi -c $@ $< > $@

AOI331:         LEVEL = 3
AOI331:         AOI321
	$(POPCORN) -m aoi -c $@ $< > $@

AOI332:         LEVEL = 3
AOI332:         AOI331
	$(POPCORN) -m aoi -c $@ $< > $@

AOI333:         LEVEL = 3
AOI333:         AOI332
	$(POPCORN) -m aoi -c $@ $< > $@

NAND3:          NAND2
	$(POPCORN) -m nand -c $@ $< > $@

NOR3:           NOR2
	$(POPCORN) -m nor -c $@ $< > $@

OAI211:         NAND3
	$(POPCORN) -m oai -c $@ $< > $@

OAI31:          OAI21
	$(POPCORN) -m oai -c $@ $< > $@

OAI311:         OAI211
	$(POPCORN) -m oai -c $@ $< > $@

OAI32:          OOAI22
	$(POPCORN) -m oai -c $@ $< > $@

OAI321:         OAI221
	$(POPCORN) -m oai -c $@ $< > $@

OAI33:          LEVEL = 3
OAI33:          OAI32
	$(POPCORN) -m oai -c $@ $< > $@

OAI331:         LEVEL = 3
OAI331:         OAI321
	$(POPCORN) -m oai -c $@ $< > $@

OAI332:         LEVEL = 3
OAI332:         OAI331
	$(POPCORN) -m oai -c $@ $< > $@

OAI333:         LEVEL = 3
OAI333:         OAI332
	$(POPCORN) -m oai -c $@ $< > $@

OAOAI2111:      AOAI211
	$(POPCORN) -m nor -c $@ $< > $@

OAOI211:        AOI21
	$(POPCORN) -m nor -c $@ $< > $@

OAOI212:        AOI22
	$(POPCORN) -m nor -c $@ $< > $@

OAOI221:        AOI31
	$(POPCORN) -m nor -c $@ $< > $@

endif
endif
