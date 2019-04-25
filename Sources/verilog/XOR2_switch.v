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
//  Purpose:        Verilog switch-level model
//
//  ************    IEEE Std 1364-1995 (Verilog '95 HDL)    ***********
//
//  ///////////////////////////////////////////////////////////////////
//
//  Copyright (c) 2019 by chipforge <stdcelllib@nospam.chipforge.org>
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
//                  SWITCH-LEVEL MODEL
//  -------------------------------------------------------------------

module XOR2_switch (Z, B, A);

    output          Z;
    input           B, A;

//  ------------    1st stage - NOR2    -------------------------------

    wire            y;                  // result after 1st stage
    wire            n1;                 // wire between M0PA & M0PB

pmos M0PA (y, n1, A);
pmos M0PB (n1, 'b1, B);

nmos M0NA (y, 'b0, A);
nmos M0NB (y, 'b0, B);

//  ------------    2nd stage - AOI21   -------------------------------

    wire            n2, n3;

pmos M1P0 (Z, n3, y);
pmos M1PA (n3, 'b1, A);
pmos M1PB (n3, 'b1, B);

nmos M1N0 (Z, 'b0, y);
nmos M1NA (Z, n2, A);
nmos M1NB (n2, 'b0, B);

endmodule
