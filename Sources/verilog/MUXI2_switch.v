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
//  File:           StdCellLib/Sources/verilog/MUXI2_switch.v
//
//  Purpose:        MUXI2 switch-level model
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

module MUXI2_switch (
    output              Z,
    input               S,
    input               A1,
    input               A0
);

//  ------------    1st stage - NAND2   -------------------------------

    wire                y;              // result after 1st stage
    wire                n_ba;           // wire between M0NA & M0NB

pmos M0PA (y, 'b1, A);
pmos M0PB (y, 'b1, B);

nmos M0NA (y, n_ba, A);
nmos M0NB (n_ba, 'b0, B);

//  ------------    2nd stage - OAI21   -------------------------------

    wire                p_ba;           // wire between M1PA & M1PB
    wire                n_0ba;          // wire between M1NO, M1NA & M1NB

pmos M1P0 (Z, 'b1, y);
pmos M1PB (p_ba, 'b1, B);
pmos M1PA (Z, p_ba, A);

nmos M1N0 (Z, n_0ba, y);
nmos M1NA (n_0ba, 'b0, A);
nmos M1NB (n_0ba, 'b0, B);

endmodule
