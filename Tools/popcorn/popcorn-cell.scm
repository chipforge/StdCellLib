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
;;  File:           StdCellLib/Tools/popcorn/popcorn-cell.scm
;;
;;  Purpose:        Scheme Module - cell description read-in / write-out
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

(define-library (popcorn-cell)
  (import (scheme base) (scheme write) (scheme file))
  (export read-cell-file)
  (begin

;;  ------------    build-in self test  -------------------------------

    ; use this switch during development only
    (define build-in-self-test #t)

;;  -------------------------------------------------------------------
;;                      DESCRIPTION
;;  -------------------------------------------------------------------

;;  In principle every combinatorial cell (in CMOS technology) contains
;;  two functional complementary networks. The pull-up network - build
;;  with pmos transistors - as well as the pull-down network - build
;;  with nmos transistors.

;;  so every netlist becomes, well, a list of transistors

;;  ------------    Example : INV-cell  -------------------------------

;;              ^ Vdd
;;              |
;;          | --+
;;     A --o| |     pmos
;;          | --+
;;              |
;;              |
;;              *---- Y
;;              |
;;              |
;;          | --+
;;     A ---| |     nmos
;;          | --+
;;              |
;;             _|_ Gnd

    (define INV-cell '#(INV "a Not (or Inverter) gate" (A) (Y) (#(pmos A Y VDD VDD 1 1  1)
                                                                #(nmos A Y GND GND 1 1 -1)))
    )

;;  -------------------------------------------------------------------
;;                  CELL DATA STRUCTURE
;;  -------------------------------------------------------------------

;   define cell as vector:
;       +---------------+
;    #0 |  cell id      |               'INV
;       +---------------+
;    #1 |  cell text    |               "a Not (or Inverter) gate"
;       +---------------+
;    #2 |  cell inputs  |               '(A)
;       +---------------+
;    #3 |  cell outputs |               '(Y)
;       +---------------+
;    #4 |  netlist      |               '(#(pmos A Y VDD VDD 1 1  1)
;       +---------------+                 #(nmos A Y GND GND 1 1 -1))

;   define constants for vector indices
    (define |cell-id#| 0)
    (define |cell-text#| 1)
    (define |cell-inputs#| 2)
    (define |cell-outputs#| 3)
    (define |cell-netlist#| 4)

;;  ------------    getter function : cell-id   -----------------------

;   Contract:
;   cell-id : cell -> symbol

;   Purpose:
;   get the cell ID out of a cell description vector

;   Example:
;   (cell-id INV-cell) => 'INV

;   Definitions:
    (define cell-id
        (lambda (cell)
            (vector-ref cell |cell-id#|)
        )
    )

;   Test:   !! replace code by a portable SRFI test environemt
    (if build-in-self-test
        (begin
            (if (equal? (cell-id INV-cell) 'INV)
                (display "++ passed" (current-error-port))
                (display "-- failed" (current-error-port)))
            (display " cell-id test" (current-error-port))
            (newline (current-error-port))
        )
    )

;;  ------------    getter function : cell-text     -------------------

;   Contract:
;   cell-text : cell -> string

;   Purpose:
;   get the cell description out of a cell description vector

;   Example:
;   (cell-text INV-cell) => "a Not (or Inverter) gate"

;   Definition:
    (define cell-text
        (lambda (cell)
            (vector-ref cell |cell-text#|)
        )
    )

;   Test:   !! replace code by a portable SRFI test environemt
    (if build-in-self-test
        (begin
            (if (equal? (cell-text INV-cell) "a Not (or Inverter) gate")
                (display "++ passed" (current-error-port))
                (display "-- failed" (current-error-port)))
            (display " cell-text test" (current-error-port))
            (newline (current-error-port))
        )
    )

;;  ------------    getter function : cell-inputs   -------------------

;   Contract:
;   cell-inputs : cell -> list-of-symbols

;   Purpose:
;   get the cell input list out of a cell description vector

;   Example:
;   (cell-inputs INV-cell) => '(A)

;   Definition:
    (define cell-inputs
        (lambda (cell)
            (vector-ref cell |cell-inputs#|)
        )
    )

;   Test:   !! replace code by a portable SRFI test environemt
    (if build-in-self-test
        (begin
            (if (equal? (cell-inputs INV-cell) '(A))
                (display "++ passed" (current-error-port))
                (display "-- failed" (current-error-port)))
            (display " cell-inputs test" (current-error-port))
            (newline (current-error-port))
        )
    )

;;  ------------    getter function : cell-outputs  -------------------

;   Contract:
;   cell-outputs : cell -> list-of-symbols

;   Purpose:
;   get the cell output list out of a cell description vector

;   Example:
;   (cell-outputs INV-cell) => '(Y)

;   Definition:
    (define cell-outputs
        (lambda (cell)
            (vector-ref cell |cell-outputs#|)
        )
    )

;   Test:   !! replace code by a portable SRFI test environemt
    (if build-in-self-test
        (begin
            (if (equal? (cell-outputs INV-cell) '(Y))
                (display "++ passed" (current-error-port))
                (display "-- failed" (current-error-port)))
            (display " cell-outputs test" (current-error-port))
            (newline (current-error-port))
        )
    )

;;  ------------    getter function : cell-netlist  -------------------

;   Contract:
;   cell-netlist : cell -> netlist

;   Purpose:
;   get the netlist out of a cell description vector

;   Example:
;   (cell-outputs INV-cell) => '(Y)

;   Definition:
    (define cell-netlist
        (lambda (cell)
            (vector-ref cell |cell-netlist#|)
        )
    )

;   Test:   !! replace code by a portable SRFI test environemt
    (if build-in-self-test
        (begin
            (if (equal? (cell-netlist INV-cell) '(#(pmos A Y VDD VDD 1 1  1)
                                                  #(nmos A Y GND GND 1 1 -1)))
                (display "++ passed" (current-error-port))
                (display "-- failed" (current-error-port)))
            (display " cell-netlist test" (current-error-port))
            (newline (current-error-port))
        )
    )

;;  -------------------------------------------------------------------
;;                  READING CELL DESCRIPTIONS
;;  -------------------------------------------------------------------

;;  ------------    read in cell file   -------------------------------

;   Contract:
;   read-cell-file : filehandler -> cell

;   Purpose:
;   read in cell file as vector for further usage

;   Example:
;   (read-cell-file file) => INV-cell

;   Definition:
;    (define (read-cell-file file-name)
;        (let ((file (open-input-file file-name)))
;            (let function ((x (read-line file)))
;                (if (eof-object? x)
;                    (begin
;                        (close-input-port file)
;                        '()
;                    ); else
;                    (cons x (function (read-line file)))
;                )
;            )
;        )
;    )

    (define (read-cell-file file-name)
        (let ((file (open-input-file file-name))
              (return (make-vector 5 "")))
            (let x ((line (read-line file)))
                (if (eof-object? line)
                    '()
                    (begin
                        (vector-set! return |cell-text#| line)
                        (let function ((line (read-line file)))
                            (unless (eof-object? line)
                                (cond
                                    ; ignore comment lines, read further
                                    [(equal? (string-ref line 0) #\#)
                                        (function (read-line file))
                                    ]

                                    ; .end annotated line, done
                                    [(equal? (substring line 0 4) ".end")
                                        (eof-object)
                                    ]

                                    ; .cell annotated line, get name
                                    [(equal? (substring line 0 4) ".cel")
                                        (begin
                                            (vector-set! return |cell-id#| line) ; !! parsing
                                            (function (read-line file))
                                        )
                                    ]

                                    ; .inputs annotated line, get name
                                    [(equal? (substring line 0 4) ".inp")
                                        (begin
                                            (vector-set! return |cell-inputs#| line) ; !! parsing
                                            (function (read-line file))
                                        )
                                    ]

                                    ; .outputs annotated line, get name
                                    [(equal? (substring line 0 4) ".out")
                                        (begin
                                            (vector-set! return |cell-outputs#| line) ; !! parsing
                                            (function (read-line file))
                                        )
                                    ]

                                    ; take line as netlist circuit
                                    [else
                                        (begin
                                            (vector-set! return |cell-netlist#| line) ; !! parse & append
                                            (function (read-line file))
                                        )
                                    ]
                                )
                            )
                        )
                    )
                )
            (close-input-port file)
            return
            )
        )
    )

;;  -------------------------------------------------------------------
;;                  WRITING CELL DESCRIPTIONS
;;  -------------------------------------------------------------------

;;  ------------    write description line  ---------------------------

;   Contract:
;   write-cell-decription : string -> --

;   Purpose:
;   write cell description to STDOUT

;   Example:
;   (cell-description "cell" => "cell"

;   Definition:
    (define cell-description
        (lambda (description)
            (format description)
            (newline)
        )
    )

;;  ------------    write out cell file     ---------------------------

;   Contract:
;   print-whole-cell : "list of strings" -> --

;   Example:
;   (print-whole-cell list-of-strings) => cell

;   Definition:
    (define print-whole-cell
        (lambda (description cell-id input-list output-list netlist)
            (format
"~a
.cell ~a
.input ~a
.output ~a
"
             description cell-id input-list output-list netlist)
        )
    )
  )
)
