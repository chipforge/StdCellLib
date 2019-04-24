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
;;  File:           StdCellLib/Tools/popcorn/popcorn.scm
;;
;;  Purpose:        Popcorn Main functionality
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

;   R7RS-type library usage declaration
    (import (scheme base)
            (scheme write)              ; display
            (scheme process-context)    ; exit
            (srfi 28)                   ; format
            ; popcorn libs also
            (popcorn-lib)
            (popcorn-cell)
    )

;;  -------------------------------------------------------------------
;;                       PROGRAM
;;  -------------------------------------------------------------------

;;  ------------    Program Name    -----------------------------------

    ; use this as default
    (define eigen-name "popcorn")

;;  ------------    version "screen"    -------------------------------

    (define +version+
        (lambda (eigen-name at-port)
            (format (at-port)
"~a (\"Popcorn\") - Version 2019-04-12

This source is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 3 of the License, or
(at your option) any later version.

This source is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
GNU General Public License for more details.

Copyright (c) 2019 by chipforge - <popcorn@nospam.chipforge.org>"
            eigen-name)
            (newline (at-port))
        )
    )

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

;;  ------------    Example : INV   -----------------------------------

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

    (define INV '(#(pmos A Y VDD VDD 1 1  1)
                  #(nmos A Y GND GND 1 1 -1))
    )

;;  -------------------------------------------------------------------
;;                       GLOBAL OPTIONS
;;  -------------------------------------------------------------------

;;  ------------    usage "screen"  -----------------------------------

    (define +usage+
        (lambda (eigen-name at-port)
            (format (at-port)
"Usage: ~a - Generate new combinatorial cells
   -b number           set threshold value for output buffer
   -e format           specify cell export format
   -h | --help         print help screen and exit
   -H number           set cell high in metal tracks
   -l number           set maximum number of stacked transistors
   -m method           enlarge cell - nand nor aoi oia
   -T file             specify technology file
   -v                  print verbose messages
   --version           print version and exit"
             eigen-name)
            (newline (at-port))
            (exit 2)
        )
    )

;;  ------------    command line options    ---------------------------

;   -b number
    (define buffer-limit 4)

;   -e format
    (define export-format 'cell)

;   -H number
    (define track-high 9)

;   -l number
    (define stacked-limit 4)

;   -m method
    (define extension-method 'none)

;   -T file
    (define technology-file "scmos.tech")

;   -v
    (define verbose-mode #f)

;   cell desciption
    (define cell-file "")

;;  ------------    command line parsing    ---------------------------

    ; auxiliary function
    (define parsing-error
        (lambda (wrong-arg)
            (begin (display "command line parsing failed: " (current-error-port))
                   (display wrong-arg (current-error-port))
                   (newline (current-error-port))
            )
        )
    )

    (define set-parameters-with-args!
        (lambda (eigen-name arguments)
            (cond
                ; empty list?
                [(null? (car arguments)) arguments]

                ; -b number
                [(equal? (car arguments) "-b")
                    (let ([value (car (cdr arguments))]
                          [tail (cddr arguments)])
                        (set! buffer-limit value)   ; !! value check missing
                        (set-parameters-with-args! eigen-name tail)
                    )
                ]

                ; -e format
                [(equal? (car arguments) "-e")
                    (let ([value (car (cdr arguments))]
                          [tail (cddr arguments)])
                        (set! export-format value)  ; !! value check missing)]
                        (set-parameters-with-args! eigen-name tail)
                    )
                ]

                ; -h
                [(equal? (car arguments) "-h")
                    (begin
                        (+usage+ eigen-name current-error-port)
                        (exit 2) ; done, do not parse further
                    )
                ]
                ; --help
                [(equal? (car arguments) "--help")
                    (begin
                        (+usage+ eigen-name current-error-port)
                        (exit 2) ; done, do not parse further
                    )
                ]

                ; -H number
                [(equal? (car arguments) "-H")
                    (let ([value (car (cdr arguments))]
                          [tail (cddr arguments)])
                        (set! track-high value)  ; !! value check missing)]
                        (set-parameters-with-args! eigen-name tail)
                    )
                ]

                ; -l number
                [(equal? (car arguments) "-l")
                    (let ([value (car (cdr arguments))]
                          [tail (cddr arguments)])
                        (set! stacked-limit value)  ; !! value check missing)]
                        (set-parameters-with-args! eigen-name tail)
                    )
                ]

                ; -m method
                [(equal? (car arguments) "-m")
                    (let ([value (car (cdr arguments))]
                          [tail (cddr arguments)])
                        (set! extension-method value)  ; !! value check missing)]
                        (set-parameters-with-args! eigen-name tail)
                    )
                ]

                ; -T file
                [(equal? (car arguments) "-T")
                    (let ([value (car (cdr arguments))]
                          [tail (cddr arguments)])
                        (set! technology-file value)  ; !! value check missing)]
                        (set-parameters-with-args! eigen-name tail)
                    )
                ]

                ; -v
                [(equal? (car arguments) "-v")
                    (let ([tail (cdr arguments)])
                        (set! verbose-mode #t)
                        (set-parameters-with-args! eigen-name tail)
                    )
                ]

                ; --version
                [(equal? (car arguments) "--version")
                    (begin
                        (+version+ eigen-name current-error-port)
                        (exit 3) ; done, do not parse further
                    )
                ]

                ; file name
                [(null? (cdr arguments))
                    (set! cell-file (car arguments))
                ]

                [else (parsing-error (car arguments)) ]
            )
        )
    )

    (define print-parameters
        (lambda (at-port)
            (begin
                    ; -b number
                    (format (at-port)
"Buffer Limit: ~a stacked transistors"
                     buffer-limit)
                    (newline (at-port))

                    ; -e format
                    (format (at-port)
"Export Format: ~a"
                     export-format)
                    (newline (at-port))

                    ; -H number
                    (format (at-port)
"Cell High: ~a metal tracks"
                     track-high)
                    (newline (at-port))

                    ; -l number
                    (format (at-port)
"Stacked Transistor Limit: ~a"
                     stacked-limit)
                    (newline (at-port))

                    ; -m method
                    (format (at-port)
"Extension Method: ~a"
                     extension-method)
                    (newline (at-port))

                    ; -T file
                    (format (at-port)
"Technology File: ~a"
                     technology-file)
                    (newline (at-port))

                    ; -v
                    (format (at-port)
"Verbose Mode: ~a"
                     verbose-mode)
                    (newline (at-port))

                    ; cell decription
                    (format (at-port)
"Cell Description: ~a"
                     cell-file)
                    (newline (at-port))
            )
        )
    )

;;  -------------------------------------------------------------------
;;                       FUNCTIONS
;;  -------------------------------------------------------------------

;;  ------------    get highest free nmos transistor    ---------------

;   Contract:
;   get-highest-nmos : netlist -> transistor

;   Purpose:
;   find highest nmos transistor, which can be extended

;   Example:
;   (get-highest-nmos INV) => #('nmos 'A 'X 'GND 'GND 1 1 -1)

;   Definition:
    (define get-highest-nmos
        (lambda (netlist)
            (cond
                ; emtpy list?
                [(null? netlist) netlist]

                ;; !!
                [else (get-highest-nmos (cdr netlist))]
            )
        )
    )

;   Test:   !! replace code by a portable SRFI test environemt
    (if build-in-self-test
        (begin
            (if (equal? (get-highest-nmos INV) '(#(nmos A Y GND GND 1 1 -1)))
                (display "++ passed" (current-error-port))
                (display "-- failed" (current-error-port)))
            (display " get-node-mosfets test" (current-error-port))
            (newline (current-error-port))
        )
    )

;;  -------------------------------------------------------------------
;;                       MAIN
;;  -------------------------------------------------------------------

;;  ------------    main function   -----------------------------------

    (define (main args)
        (begin
            ; parse command line and set values / modes
            (let ((eigen-name (car args)))
            (set-parameters-with-args! eigen-name (cdr args))
            (if verbose-mode (print-parameters current-error-port))

;        (+usage+ eigen-name current-error-port)
            (write-cell-file (read-cell-file cell-file))
;            (display (read-cell-file cell-file))
            0
            )
        )
    )

