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

    wire                z_c;            // result after 1st stage
    wire                p_ba;           // wire between pmos-B & pmos-A

pmos p1a (z_c, p_ba, A);
pmos p1b (p_ba, 'b1, B);

nmos n1a (z_c, 'b0, A);
nmos n1b (z_c, 'b0, B);

//  ------------    2nd stage - AOI21   -------------------------------

    wire                p_cba;          // wire between pmos-C & (pmos-B | pmos-A)
    wire                n_ba;           // wire between nmos-B & nmos-A

pmos p2c (Z, p_cba, z_c);
pmos p2a (p_cba, 'b1, A);
pmos p2b (p_cba, 'b1, B);

nmos n2c (Z, 'b0, z_c);
nmos n2a (Z, n_ba, A);
nmos n2b (n_ba, 'b0, B);

endmodule
