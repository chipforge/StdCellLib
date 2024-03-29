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
//  File:           StdCellLib/Sources/macros/CGN2.v
//
//  Purpose:        Clock Gating for negative Clock (skewed), drives 2x
//
//  ************    IEEE Std 1364-1995 (Verilog HDL)    ***************
//
//  ///////////////////////////////////////////////////////////////////
//
//  Copyright (c) 2021 by
//                  chipforge <stdcelllib@nospam.chipforge.org>
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
//                          MACRO
//  -------------------------------------------------------------------

module CGN2 (XO, EN, XI);

    output  X0;
    input   EN, XI;

    wire latched, enabled;

//  ------------    latch   -------------------------------------------

    // Please keep in mind, that this latch might need a Set or Reset.
    // Check the functionality, while following flipflops might need a
    // clock during the reset period (synchronous Set/Reset).
    // Use LATSP or LATRP than.

    LATP (latched, EN, XI);

//  ------------    combinatorial   -----------------------------------

    // Both signals, latched and input clock, are low-active.

    NOR2 (enabled, latched, XI);

//  ------------    drive output    -----------------------------------

    // Handle driver strength flexible.

    CIN2 (XO, enabled);

endmodule
