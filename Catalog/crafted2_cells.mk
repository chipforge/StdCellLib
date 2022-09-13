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
#   Copyright (c)   2021, 2022 by
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

#   --------    tri-state buffers   --------------------------------

CELLS +=        TRI

TRI:            DESCR = "inverting 3-state buffer"

#   --------    (skewed) buffers    --------------------------------

CELLS +=        CBN2 \
                CBP2 \
                CIN2 \
                CIP2
                # probably also: CBx3, CIx3, CBx5, CIx5, CBx7, CIx7

CBN2:           DESCR = "low-skewed, non-inverting Clock Buffer, 2x drive"

CBP2:           DESCR = "high-skewed, non-inverting Clock Buffer, 2x drive"

CIN2:           DESCR = "low-skewed, inverting Clock Buffer, 2x drive"

CIP2:           DESCR = "high-skewed, inverting Clock Buffer, 2x drive"

#   --------    Clock-gating    ------------------------------------

CELLS +=        CGN2 \
                CGP2
                # probably also: CGx3, CGx5, CGx7

CGN2:           DESCR = "skewed negedge Clock-Gating Buffer with low-active Enable, 2x drive"
CGN2:           LATP NOR2 CIN2

CGP2:           DESCR = "skewed posedge Clock-Gating Buffer with high-active Enable, 2x drive"
CGP2:           LATN NAND2 CIP2

#   --------    D-latches   ----------------------------------------

CELLS +=        LATN \
                LATP \
                LATNR \
                LATPR \
                LATNS \
                LATPS \
                LATNE LATNEE \
                LATPE LATPEE \
                LATNER LATNEER \
                LATPER LATPEER \
                LATNES LATNEES \
                LATPES LATPEES

LATN:           DESCR = "low-active D-Latch"
LATN:           TRI

LATP:           DESCR = "high-active D-Latch"
LATP:           TRI

LATNR:          DESCR = "low-active D-Latch with asynchronous high-active Reset"
LATNR:          TRI NOR2

LATRP:          DESCR = "high-active D-Latch with asynchronous high-active Reset"
LATRP:          TRI NOR2

LATNS:          DESCR = "low-active D-Latch with asynchronous low-active Set"
LATNS:          TRI NAND2

LATPS:          DESCR = "high-active D-Latch with asynchronous low-active Set"
LATPS:          TRI NAND2

LATNE:          DESCR = "low-active D-Latch with low-active Clock Enable"
LATNE:          TRI NOR2

LATNEE:         DESCR = "low-active D-Latch with 2 low-active ('or'd) Clock Enable"
LATNEE:         TRI AOI21

LATPE:          DESCR = "high-active D-Latch with high-active Clock Enable"
LATPE:          TRI NAND2

LATPEE:         DESCR = "high-active D-Latch with 2 high-active ('or'd) Clock Enable"
LATPEE:         TRI OAI21

LATNER:         DESCR = "low-active D-Latch with low-active Clock Enable and asynchronous high-active Reset"
LATNER:         TRI NOR2

LATNEER:        DESCR = "low-active D-Latch with low-active ('or'd) Clock Enable and asynchronous high-active Reset"
LATNEER:        TRI NOR2 AOI21

LATPER:         DESCR = "high-active D-Latch with high-active Clock Enable and asynchronous high-active Reset"
LATPER:         TRI NAND2 NOR2

LATPEER:        DESCR = "high-active D-Latch with high-active ('or'd) Clock Enable and asynchronous high-active Reset"
LATPEER:        TRI NOR2 OAI21

LATNES:         DESCR = "low-active D-Latch with low-active Clock Enable and asynchronous low-active Set"
LATNES:         TRI NAND2 NOR2

LATNEES:        DESCR = "low-active D-Latch with low-active ('or'd) Clock Enable and asynchronous low-active Set"
LATNEES:        TRI NAND2 AOI21

LATPES:         DESCR = "high-active D-Latch with high-active Clock Enable and asynchronous low-active Set"
LATPES:         TRI NAND2

LATPEES:        DESCR = "high-active D-Latch with high-active ('or'd) Clock Enable and asynchronous low-active Set"
LATPEES:        TRI NAND2 OAI21

#   --------    neat cells  ----------------------------------------

CELLS +=        MIN13

MIN13:          DESCR = "1-of-3 Minority (or inverting 2-of-3 Majority) gate"

#   --------    multiplexer ----------------------------------------

CELLS +=        MUXI21 \
                MUXIE21 \
                MUXIEN21

MUXI21:         DESCR = "inverting 2-to-1 Multiplexor"
MUXI21:         TRI

MUXIE21:        DESCR = "inverting 2-to-1 Multiplexor with high-active Enable"
MUXIE21:        TRI NAND2

MUXIEN21:       DESCR = "inverting 2-to-1 Multiplexor with low-active Enable"
MUXIEN21:       TRI NOR2

#   --------    others      ----------------------------------------

CELLS +=        TIE0 \
                TIE1

TIE0:           DESCR = "pull-down (or tie low) cell"

TIE1:           DESCR = "pull-up (or tie high) cell"
