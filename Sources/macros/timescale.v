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
//  File:           StdCellLib/Sources/macros/timescale.v
//
//  Purpose:        Timescale statement centralized
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

`ifdef __TIMESCALE__
`else

`define __TIMESCALE__
// synthesis translate_off
`timescale 1 ns / 1 ps
// synthesis translate_on

`endif //__TIMESCALE__
