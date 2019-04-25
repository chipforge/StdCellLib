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
//  File:           StdCellLib/TBench/verilog/XOR2_stim.v
//
//  Purpose:        XOR2 stimulus generation
//
//  ************    IEEE Std 1364-2001 (Verilog HDL)    ***************
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
//                  DESCRIPTION
//  -------------------------------------------------------------------

//  Event principles:
//
//       one clock cycle
//      |---------------|
//       _______         _______         _______
//      ||      |       ||      |       ||      |
//      ||      |       ||      |       ||      |       clk_tb
//  ____||      |_______||      |_______||      |_____
//
//                   ^ STROBE        ^ STROBE
//
//                   ^ write here    ^ write here
//                                   ^ read here
//                   |---------------|
//                    one task cycle

`include "timescale.v"

//  -------------------------------------------------------------------
//                  CONFIGURATION
//  -------------------------------------------------------------------

`define             TIMELIMIT       10_000

//  ------------    global signals      -------------------------------

`define             CLK_PERIOD      10
`define             RST_PERIOD      200
`define             STROBE          (0.8 * `CLK_PERIOD)

module XOR2_stim (
//  Sorry, testbenches do not have ports
);

//  ------------    global signals      -------------------------------

    reg             clk_tb = ~0;        // start with falling edge

always @ (clk_tb)
begin
    clk_tb <= #(`CLK_PERIOD/2) ~clk_tb;
end

    reg             rst_tb = 0;         // start inactive

initial
begin
    #1;
    // activate reset
    rst_tb <= ~0;
    rst_tb <= #(`RST_PERIOD) 0;
end

//  ------------    testbench top level signals -----------------------

    localparam      WIDTH = 2;

    reg [WIDTH-1:0] r_stimuli = 0;      // for input pattern
    wire            w_response;         // for model

//  ------------    device-under-test (DUT) ---------------------------

// switch-level model
XOR2_switch dut_switch (
    .Z              (w_response),       // Z
    .B              (r_stimuli[1]),     // B
    .A              (r_stimuli[0])      // A
);

//  ------------    test functionality  -------------------------------

task t_initialize;
begin
    #1;
    @ (negedge rst_tb);
    @ (posedge clk_tb);
    @ (posedge clk_tb);
    #(`STROBE);
end
endtask

task t_step;
    input integer reps;
begin
    repeat(reps) begin
        @ (posedge clk_tb);
        r_stimuli <= r_stimuli + 1;
        #(`STROBE);
    end
end
endtask

    integer i;

initial
begin
    t_initialize;

    $display(".table");
    $display(".//\tB\tA\t:\tZ;");

    for (i=0; i<2**WIDTH; i=i+1)
        begin
        $display(".\t%b\t%b\t:\t%b;", r_stimuli[1], r_stimuli[0], w_response);
        t_step(1);
        end

    $display(".endtable");
    $finish;
end

//  ------------    testbench flow control  ---------------------------

initial
begin
    $dumpfile(`DUMPFILE);
    $dumpvars;

    #(`TIMELIMIT);
    $display("\t%m: *time limit (%t) reached*", $time);
    $finish;
end

endmodule
