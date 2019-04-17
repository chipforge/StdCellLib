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
;;  ************    Revised^5 Report on Scheme (R5RS)   ***************
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

;;  ------------    Version Strings     -------------------------------

    (define version-screen (list
"Popcorn 2019-04-12" ""
"This source is free software; you can redistribute it and/or modify"
"it under the terms of the GNU General Public License as published by"
"the Free Software Foundation; either version 3 of the License, or"
"(at your option) any later version." ""
"This source is distributed in the hope that it will be useful,"
"but WITHOUT ANY WARRANTY; without even the implied warranty of"
"MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the"
"GNU General Public License for more details." ""
"Copyright (c) 2019 by chipforge - <popcorn@nospam.chipforge.org>"
    ))

;;  ------------    build-in self test  -------------------------------

    ; use this switch during development
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

;;  ------------    help screen     -----------------------------------

    (define help-screen (list
"popcorn - Generate new combinatorial cells"
"   -b number           set threshold value for output buffer"
"   -e format           specify cell export format"
"   -h | --help         print help screen and exit"
"   -H number           set cell high in metal tracks"
"   -l number           set maximum number of stacked transistors"
"   -m method           enlarge cell - nand nor aoi oia"
"   -T file             specify technology file"
"   -v                  print verbose messages"
"   --version           print version and exit"
    ))

;;  ------------    print-list-of-strings   ---------------------------

    (define print-list-of-strings
        (lambda (string-list at-port)
            (cond
                ; empty list?
                [(null? string-list) (newline (at-port))]

                ; print line, call next
                [else (begin (display (car string-list) (at-port))
                             (newline (at-port))
                             (print-list-of-strings (cdr string-list) (current-error-port)))]
            )
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
        (lambda (args)
            (cond
                ; empty list?
                [(null? args) args] ; all done

                ; file name
                [(null? (cdr args))
                    (set! cell-file (car args))
                ]

                ; -b number
                [(equal? (car args) "-b")
                    (let ((value (car (cdr args)))
                          (tail (cddr args)))
                        (set! buffer-limit value)   ; !! value check missing
                        (set-parameters-with-args! tail)
                    )
                ]

                ; -e format
                [(equal? (car args) "-e")
                    (let ((value (car (cdr args)))
                          (tail (cddr args)))
                        (set! export-format value)  ; !! value check missing)]
                        (set-parameters-with-args! tail)
                    )
                ]

                ; -h
                [(equal? (car args) "-h")
                    (begin
                        (print-list-of-strings help-screen (current-error-port))
                        (exit) ; done, do not parse further
                    )
                ]
                ; --help
                [(equal? (car args) "--help")
                    (begin
                        (print-list-of-strings help-screen (current-error-port))
                        (exit) ; done, do not parse further
                    )
                ]

                ; -H number
                [(equal? (car args) "-H")
                    (let ((value (car (cdr args)))
                          (tail (cddr args)))
                        (set! track-high value)  ; !! value check missing)]
                        (set-parameters-with-args! tail)
                    )
                ]

                ; -l number
                [(equal? (car args) "-l")
                    (let ((value (car (cdr args)))
                          (tail (cddr args)))
                        (set! stacked-limit value)  ; !! value check missing)]
                        (set-parameters-with-args! tail)
                    )
                ]

                ; -m method
                [(equal? (car args) "-m")
                    (let ((value (car (cdr args)))
                          (tail (cddr args)))
                        (set! extension-method value)  ; !! value check missing)]
                        (set-parameters-with-args! tail)
                    )
                ]

                ; -T file
                [(equal? (car args) "-T")
                    (let ((value (car (cdr args)))
                          (tail (cddr args)))
                        (set! technology-file value)  ; !! value check missing)]
                        (set-parameters-with-args! tail)
                    )
                ]

                ; -v
                [(equal? (car args) "-v")
                    (let ((tail (cdr args)))
                        (set! verbose-mode #t)
                        (set-parameters-with-args! tail)
                    )
                ]

                ; --version
                [(equal? (car args) "--version")
                    (begin
                        (print-list-of-strings version-screen (current-error-port))
                        (exit) ; done, do not parse further
                    )
                ]
                [else (parsing-error (car args)) ]
            )
        )
    )

    (define print-parameters
        (lambda ()
            (begin  (command-line) ; !! R7RS
;;            (begin  (command-line-arguments) ; Chicken )-:

                    ; -b number
                    (display "Buffer Limit: " (current-error-port))
                    (display buffer-limit (current-error-port))
                    (display " stacked transistors" (current-error-port))
                    (newline (current-error-port))

                    ; -e format
                    (display "Export Format: " (current-error-port))
                    (display export-format (current-error-port))
                    (newline (current-error-port))

                    ; -H number
                    (display "Cell High: " (current-error-port))
                    (display track-high (current-error-port))
                    (display " metal tracks" (current-error-port))
                    (newline (current-error-port))

                    ; -l number
                    (display "Stacked Transistor Limit: " (current-error-port))
                    (display stacked-limit (current-error-port))
                    (newline (current-error-port))

                    ; -m method
                    (display "Extension Method: " (current-error-port))
                    (display extension-method (current-error-port))
                    (newline (current-error-port))

                    ; -T file
                    (display "Technology File: " (current-error-port))
                    (display technology-file (current-error-port))
                    (newline (current-error-port))

                    ; -v
                    (display "Verbose Mode: " (current-error-port))
                    (display verbose-mode (current-error-port))
                    (newline (current-error-port))

                    ; cell decription
                    (display "Cell Description: " (current-error-port))
                    (display cell-file (current-error-port))
                    (newline (current-error-port))
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

;   use Popcorn Library
    (load "popcorn-lib.scm")

;;  ------------    main function   -----------------------------------

    (begin
        ; parse command line and set values / modes
        (set-parameters-with-args! (cdr (command-line)))
        (if verbose-mode (print-parameters))

        (load "popcorn-cell.scm")
        (display (read-cell-file cell-file))
    )

