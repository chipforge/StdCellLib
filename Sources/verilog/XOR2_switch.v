//  ************    LibreSilicon's StdCellLibrary   *******************
//
//  Organisation:   Chipforge
//                  Germany / European Union
//
//  Profile:        Chipforge focus on fine System-on-Chip Cores in
//                  Verilog HDL Code which are easy understandable and
//                  adjustable. For further information see
//                          www.chipforge.org
//                  there are projects from small cores up to PCBs, too.
//
//  File:           StdCellLib/Sources/verilog/XOR2_switch.v
//
//  Purpose:        XOR2 switch-level model
//
//  ************    IEEE Std 1364-2001 (Verilog HDL)    ***************
//
//  ///////////////////////////////////////////////////////////////////
//
//  Copyright (c) 2018 by chipforge <hsank@nospam.chipforge.org>
//  All rights reserved.
//
//      This Standard Cell Library is licensed under the Libre Silicon
//      public license; you can redistribute it and/or modify it under
//      the terms of the Libre Silicon public license as published by
//      the Libre Silicon alliance, either version 1 of the License, or
//      (at your option) any later version.
//
//      This design is distributed in the hope that it will be useful,
//      but WITHOUT ANY WARRANTY; without even the implied warranty of
//      MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
//      See the Libre Silicon Public License for more details.
//
//  ///////////////////////////////////////////////////////////////////

//  -------------------------------------------------------------------
//                          SWITCH-LEVEL MODEL
//  -------------------------------------------------------------------

module XOR2_switch (
    output              Z,
    input               B,
    input               A
);

//  ------------    1st stage - NOR2    -------------------------------

    wire                y;              // result after 1st stage
    wire                p_ba;           // wire between M0PA & M0PB

pmos M0PA (y, p_ba, A);
pmos M0PB (p_ba, 'b1, B);

nmos M0NA (y, 'b0, A);
nmos M0NB (y, 'b0, B);

//  ------------    2nd stage - AOI21   -------------------------------

    wire                p_0ba;          // wire between M1P0, M1PA & M1PB
    wire                n_ba;           // wire between M1NB & M1NA

pmos M1P0 (Z, p_0ba, y);
pmos M1PA (p_0ba, 'b1, A);
pmos M1PB (p_0ba, 'b1, B);

nmos M1N0 (Z, 'b0, y);
nmos M1NA (Z, n_ba, A);
nmos M1NB (n_ba, 'b0, B);

endmodule
