;;  ************    LibreSilicon's StdCellLibrary   *******************
;;
;;  Organisation:   Chipforge
;;                  Germany / European Union
;;
;;  Profile:        Chipforge focus on fine System-on-Chip Cores in
;;                  Verilog HDL Code which are easy understandable and
;;                  adjustable. For further information see
;;                          www.chipforge.org
;;                  there are projects from small cores up to PCBs, too.
;;
;;  File:           StdCellLib/Tools/popcorn/popcorn-verilog.scm
;;
;;  Purpose:        Scheme Module - export Verilog descriptions
;;
;;  ************    Revised^7 Report on Scheme (R7RS)   ***************
;;
;;  ///////////////////////////////////////////////////////////////////
;;
;;  Copyright (c)   2019 by
;;                  chipforge - <popcorn@nospam.chipforge.org>
;;
;;  This source file may be used and distributed without restriction
;;  provided that this copyright statement is not removed from the
;;  file and that any derivative work contains the original copyright
;;  notice and the associated disclaimer.
;;
;;  This source is free software; you can redistribute it and/or modify
;;  it under the terms of the GNU General Public License as published by
;;  the Free Software Foundation; either version 3 of the License, or
;;  (at your option) any later version.
;;
;;  This source is distributed in the hope that it will be useful,
;;  but WITHOUT ANY WARRANTY; without even the implied warranty of
;;  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
;;  GNU General Public License for more details.
;;
;;   (__)  You should have received a copy of the GNU General Public
;;   oo )  License along with this program; if not, write to the
;;   /_/|  Free Software Foundation Inc., 51 Franklin St., 5th Floor,
;;         Boston, MA 02110-1301, USA
;;
;;  GNU General Public License v3.0 - http://www.gnu.org/licenses/gpl-3.0.html
;;  ///////////////////////////////////////////////////////////////////

(define-library (popcorn-verilog)
  (import (scheme base)
          (scheme write)    ; !!
          (scheme char)            ; string-upcase
          (scheme file)            ; file io
          (srfi 28)                ; format
          ; popcorn libs also
          (popcorn-lib)
          (popcorn-cell))
  (export export-verilog-switch
          export-verilog-bench)
  (begin

;;  ------------    build-in self test  -------------------------------

    ; use this switch during development only
    (define build-in-self-test #t)

;;  -------------------------------------------------------------------
;;                  AUXILARY FUNCTIONS
;;  -------------------------------------------------------------------

;;  ------------    input list into stimuli list    -------------------

;   Contract:
;   inputlist->stimulilist : list-of-inputs -> list-of-stimuli

;   Purpose:
;   transfer a list of input symbols into list of strings

;   Example:
;   (inputlist->stimulilist '(C B A)) => ("stimuli[2]" "stimuli[1]" "stimuli[0]")

;   Definition:
    (define inputlist->stimulilist
        (lambda (input-list)
            (let ((index (length input-list)))
                (if (equal? (cdr input-list) '())
                    (cons "stimuli[0]" '())    ; last value in list
                    (append (list (string-append "stimuli[" (number->string (- index 1)) "]")) (inputlist->stimulilist (cdr input-list)))
                )
            )
        )
    )

;   Test:   !! replace code by a portable SRFI test environemt
    (if build-in-self-test
        (begin
            (if (equal? (inputlist->stimulilist '(C B A)) '("stimuli[2]" "stimuli[1]" "stimuli[0]"))
                (display "++ passed" (current-error-port))
                (display "-- failed" (current-error-port)))
            (display " inputlist->stimulilist test" (current-error-port))
            (newline (current-error-port))
        )
    )

;;  ------------    output list into response list  -------------------

;   Contract:
;   outputlist->responselist : list-of-outputs -> list-of-responses

;   Purpose:
;   transfer a list of output symbols into list of strings

;   Example:
;   (outputlist->responselist '(Z Y X)) => ("response[2]" "response[1]" "response[0]")

;   Definition:
    (define outputlist->responselist
        (lambda (output-list)
            (let ((index (length output-list)))
                (if (equal? (cdr output-list) '())
                    (cons "response[0]" '())    ; last value in list
                    (append (list (string-append "response[" (number->string (- index 1)) "]")) (outputlist->responselist (cdr output-list)))
                )
            )
        )
    )

;   Test:   !! replace code by a portable SRFI test environemt
    (if build-in-self-test
        (begin
            (if (equal? (outputlist->responselist '(Z Y X)) '("response[2]" "response[1]" "response[0]"))
                (display "++ passed" (current-error-port))
                (display "-- failed" (current-error-port)))
            (display " outputlist->responselist test" (current-error-port))
            (newline (current-error-port))
        )
    )

;;  ------------    clock list into signal list     -------------------

;   Contract:
;   clocklist->signallist : list-of-clocks -> list-of-signals

;   Purpose:
;   transfer a list of clock symbols into list of strings

;   Example:
;   (clocklist->signallist '(Ckl)) => ("clk_tb")

;   Definition:
    (define clocklist->signallist
        (lambda (clock-list)
            (if (equal? clock-list '())
                clock-list
                (cons "clk_tb" '())
            )
        )
    )

;   Test:   !! replace code by a portable SRFI test environemt
    (if build-in-self-test
        (begin
            (if (equal? (clocklist->signallist (list 'Clk)) '("clk_tb"))
                (display "++ passed" (current-error-port))
                (display "-- failed" (current-error-port)))
            (display " clocklist->signallist test" (current-error-port))
            (newline (current-error-port))
        )
    )

;;  ------------    port lists into table format    -------------------

;   Contract:
;   portlists->tableformat : lists-of-ports -> table-format as string

;   Purpose:
;   transfer lists of ports into well-formed table format

;   Example:
;   (portlists->tableformat '(Y A)) => ("\\t%b\\t:%b")

;   Definition:
    (define portlists->tableformat
        (lambda (port-list)
            (cond
                ; empty list?
                [(null? port-list) ""]
                ; output port?
                [(output-space? (car port-list)) (string-append "\\t:\%b" (portlists->tableformat (cdr port-list)))]
                ; inputs and clock
                [else (string-append "\\t\%b" (portlists->tableformat (cdr port-list)))]
            )
        )
    )

;   Test:   !! replace code by a portable SRFI test environemt
    (if build-in-self-test
        (begin
            (if (equal? (portlists->tableformat '(A Y)) "\\t%b\\t:%b")
                (display "++ passed" (current-error-port))
                (display "-- failed" (current-error-port)))
            (display " portlists->tableformat test" (current-error-port))
            (newline (current-error-port))
        )
    )

;;  -------------------------------------------------------------------
;;                  WRITING FILE FRAME
;;  -------------------------------------------------------------------

;;  ------------    export verilog header   ---------------------------

;   Contract:
;   export-verilog-header : cell purspose-string-> --

;   Purpose:
;   generate Verilog Header on STDOUT

;   Example:
;   (export-verilog-header INV-cell "Verilog Model") => --

;   Definition:
    (define export-verilog-header
        (lambda (cell purpose-string)
            (let ((at-port current-output-port))
                (begin
                    (format (at-port)
"//  ************    LibreSilicon's StdCellLibrary   *******************
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
//  Cell:           ~a
//
//  Purpose:        ~a
//                  proudly AUTOGENERATED by \"Popcorn\" R7RS Scheme tool
//
//  ************    IEEE Std 1364-1995 (Verilog '95 HDL)    ***********
//
//  ///////////////////////////////////////////////////////////////////
//
//  Copyright (c) ~d by chipforge <stdcelllib@nospam.chipforge.org>
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
//                  ~a
//  -------------------------------------------------------------------

"                   (cell-id cell) purpose-string (copyleft-year) (string-upcase purpose-string))
                )
            )
        )
    )

;;  ------------    export verilog footer   ---------------------------

;   Contract:
;   export-verilog-footer : -> --

;   Purpose:
;   generate Verilog Footer on STDOUT

;   Example:
;   (export-verilog-footer) => --

;   Definition:
    (define export-verilog-footer
        (lambda ()
            (let ((at-port current-output-port))
                (begin
                    (format (at-port)
"endmodule
"                   )
                )
            )
        )
    )

;;  -------------------------------------------------------------------
;;                  WRITING CELL DESCRIPTIONS
;;  -------------------------------------------------------------------

;;  ------------    export verilog module   ---------------------------

;   Contract:
;   export-verilog-module : cell -> --

;   Purpose:
;   generate Verilog '95 module frame on STDOUT

;   Example:
;   (export-verilog-module INV-cell) => --

;   Definition:
    (define export-verilog-module
        (lambda (cell)
            (let ((at-port current-output-port))
                (format (at-port)
"module ~a (~a);

    output      ~a;
    input       ~a;

    parameter vdd = 1'b1;
    parameter gnd = 1'b0;

"                   (cell-id cell)
                    (stringlist->csv (symbollist->stringlist (append (cell-outputs cell) (cell-inputs cell) (cell-clocks cell))))
                    (stringlist->csv (symbollist->stringlist (cell-outputs cell)))
                    (stringlist->csv (symbollist->stringlist (cell-inputs cell)))
                )
            )
        )
    )

;;  ------------    export verilog mosfet   ---------------------------

;   Contract:
;   export-verilog-mosfet : transistor -> --

;   Purpose:
;   generate Verilog '95 transistor line on STDOUT

;   Example:
;   (export-verilog-mosfet '#(nmos A Y VDD substrate 1 1 -1)) => --

;   Definition:
    (define export-verilog-mosfet
        (lambda (mosfet)
            (let ((at-port current-output-port))
                (format (at-port)
"    ~a (~a, ~a, ~a);
"                   (mosfet-type mosfet) (mosfet-drain mosfet) (mosfet-source mosfet) (mosfet-gate mosfet)
                )
            )
        )
    )

;;  ------------    export verilog netlist  ---------------------------

;   Contract:
;   export-verilog-netlist : cell -> --

;   Purpose:
;   generate Verilog '95 netlist frame on STDOUT

;   Example:
;   (export-verilog-netlist INV-cell) => --

;   Definition:
    (define export-verilog-netlist
        (lambda (cell)
            (let ((at-port current-output-port))
                (map (lambda (n) (export-verilog-mosfet n)) (cell-netlist cell))
            )
        )
    )

;;  ------------    export verilog switch   ---------------------------

;   Contract:
;   export-verilog-switch : cell -> --

;   Purpose:
;   generate Verilog Switch level description on STDOUT

;   Example:
;   (export-verilog-switch INV-cell) => --"

;   Definition:
    (define export-verilog-switch
        (lambda (cell)
            (let ((at-port current-output-port))
                (begin
                    ; header
                    (export-verilog-header cell "Verilog Switch Model")
                    ; module
                    (export-verilog-module cell)
                    ; stages
                    (export-verilog-netlist cell)
                    ; footer
                    (export-verilog-footer)
                )
            )
        )
    )

;;  -------------------------------------------------------------------
;;                  WRITING WORK BENCH DESCRIPTIONS
;;  -------------------------------------------------------------------

;;  ------------    export verilog definitions  -----------------------

;   Contract:
;   export-verilog-definitions : -> --

;   Purpose:
;   generate Verilog work bench definitions on STDOUT

;   Example:
;   (export-verilog-definitions INV-cell) => --

;   Definition:
    (define export-verilog-definitions
        (lambda (cell)
            (let ((at-port current-output-port))
                (begin
                    (format (at-port)
"//  Event principles:
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

//`include \"timescale.v\"

`define             TIMELIMIT       10_000

//  ------------    definitions     -----------------------------------

`define             CLK_PERIOD      10
`define             RST_PERIOD      200
`define             STROBE          (0.8 * `CLK_PERIOD)

module ~a_bench (
//  Sorry, work benches do not have ports
);

"                   (cell-id cell))
                )
            )
        )
    )

;;  ------------    export verilog globals  ---------------------------

;   Contract:
;   export-verilog-globals : -> --

;   Purpose:
;   generate Verilog global signal definitions on STDOUT

;   Example:
;   (export-verilog-globals) => --

;   Definition:
    (define export-verilog-globals
        (lambda ()
            (let ((at-port current-output-port))
                (begin
                    (format (at-port)
"//  ------------    global signals      -------------------------------

    reg             clk_tb = 1'b1;      // start with falling edge

always @ (clk_tb)
begin
    clk_tb <= #(`CLK_PERIOD/2) ~~clk_tb;
end

    reg             rst_tb = 1'b0;      // start inactive

initial
begin
    #1;
    // activate reset
    rst_tb <= ~~rst_tb;
    #(`RST_PERIOD);
    // release reset
    rst_tb <= ~~rst_tb;
end

"                   )
                )
            )
        )
    )

;;  ------------    export verilog dut  -------------------------------

;   Contract:
;   export-verilog-dut : -> --

;   Purpose:
;   generate Verilog device-under-test definitions on STDOUT

;   Example:
;   (export-verilog-dut INV-cell) => --

;   Definition:
    (define export-verilog-dut
        (lambda (cell)
            (let ((input-width (length (cell-inputs cell)))
                  (output-width (length (cell-outputs cell)))
                  (at-port current-output-port))
                (begin
                    (format (at-port)
"//  ------------    device-under-test (DUT) ---------------------------

    localparam      INWIDTH = ~d;
    localparam      OUTWIDTH = ~d;

    reg [INWIDTH-1:0] stimuli = 0;      // for input pattern
    wire [OUTWIDTH-1:0] response;       // for model outputs

//  instantiate DUT by order
~a dut (~a);

"                   input-width output-width (cell-id cell)
                    (stringlist->csv (append (outputlist->responselist (cell-outputs cell)) (inputlist->stimulilist (cell-inputs cell)) (clocklist->signallist (cell-clocks cell)))))
                )
            )
        )
    )

;;  ------------    export verilog stimulus ---------------------------

;   Contract:
;   export-verilog-stimulus : -> --

;   Purpose
;   generate Verilog stimulus functionality on STDOUT

;   Example:
;   (export-verilog-stimulus INV-cell) => --

;   Definition:
    (define export-verilog-stimulus
        (lambda (cell)
            (let ((at-port current-output-port))
                (begin
                    (format (at-port)
"//  ------------    stimulus functionality  ---------------------------

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
        stimuli <= stimuli + 1;
        #(`STROBE);
    end
end
endtask

    integer i;

initial
begin
    t_initialize;

    $display(\".table\");

    for (i=0; i<2**INWIDTH; i=i+1)
        begin
        $display(\".~a\", ~a);
        t_step(1);
        end

    $display(\".endtable\");
    $finish;
end

initial
begin
    $dumpfile(`DUMPFILE);
    $dumpvars;

    #(`TIMELIMIT);
    $display(\"\\t%m: *time limit (%t) reached*\", $time);
    $finish;
end
"                   (portlists->tableformat (append (cell-clocks cell) (cell-inputs cell) (cell-outputs cell)))
                    (stringlist->csv (append (clocklist->signallist (cell-clocks cell)) (inputlist->stimulilist (cell-inputs cell)) (outputlist->responselist (cell-outputs cell)))))
                )
            )
        )
    )

;;  ------------    export verilog work bench   -----------------------

;   Contract:
;   export-verilog-bench : cell -> --

;   Purpose:
;   generate Verilog Stimulus (kind of work bench) description on STDOUT

;   Example:
;   (export-verilog-bench INV-cell) => --"

;   Definition:
    (define export-verilog-bench
        (lambda (cell)
            (let ((at-port current-output-port))
                (begin
                    ; header
                    (export-verilog-header cell "Verilog Stimulus Work Bench")
                    ; definions
                    (export-verilog-definitions cell)
                    ; globals
                    (export-verilog-globals)
                    ; device under test
                    (export-verilog-dut cell)
                    ; stimulus
                    (export-verilog-stimulus cell)
                    ; footer
                    (export-verilog-footer)
                )
            )
        )
    )

;;  ===================================================================
;;                  END OF R7RS LIBRARY
;;  ===================================================================
  )
)
