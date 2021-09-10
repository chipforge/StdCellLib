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
#   File:           StdCellLib/Catalog/crafted2_cells.mk
#
#   Purpose:        Makefile for Cell Generation
#
#   ************    GNU Make 3.80 Source Code       ****************
#
#   ////////////////////////////////////////////////////////////////
#
#   Copyright (c)   2021 by
#                   chipforge - <stdcelllib@nospam.chipforge.org>
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

#   dependencies for (hand-)crafted cells with 2 stacked transistors

#   ----------------------------------------------------------------
#               CELL TARGETS
#   ----------------------------------------------------------------

#   --------    (skewed) buffers    --------------------------------

CELLS +=        BUFN2 \
                BUFP2
                # probably also: BUFx3, BUFx5, BUFx7

#   --------    clock gates     ------------------------------------

CELLS +=        CGN2 \
                CGP2
                # eventually also: CGx3, CGx5, CGx7

#   --------    D-flip-flops    ------------------------------------

CELLS +=        DFFN \
                DFFP

#   --------    D-latches   ----------------------------------------

CELLS +=        LATN \
                LATP \
                LATRN \
                LATRP \
                LATSN \
                LATSP \
                LATEN \
                LATEP \
                LATERN \
                LATERP \
                LATESN \
                LATESP

#   --------    neat cells  ----------------------------------------

CELLS +=        MIN13

#   --------    multiplexer ----------------------------------------

CELLS +=        MUXI21 \
                MUXIE21 \
                MUXIEN21
