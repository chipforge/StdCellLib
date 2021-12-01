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
;;  File:           StdCellLib/Tools/scarbata/scarbata.scm
;;
;;  Purpose:        Scarbata Main functionality
;;
;;  ************    Revised^7 Report on Scheme (R7RS)   ***************
;;
;;  ///////////////////////////////////////////////////////////////////
;;
;;  Copyright (c) 2019 - 2021 by
;;                  chipforge <scarbata@nospam.chipforge.org>
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
            (srfi 78)                   ; test suite
            ; r7rs modules for StdCellLib also
            (common cell)
            (exporter generic)
            (exporter table)
    )

;;  ------------    srfi-78 test suite  -------------------------------

    ; change this switch during development only
    ; mode must be a symbol in '(off summary report-failed report)
    (check-set-mode! 'off)

;;  -------------------------------------------------------------------
;;                       PROGRAM
;;  -------------------------------------------------------------------

;;  ------------    Program Name    -----------------------------------

    ; use this as default
    (define eigen-name "scarbata")

;;  ------------    version "screen"    -------------------------------

    (define (+version+ @port)
        "Formats program name, version and license header @port."
        (format (@port)
"~a - Version 2021-X-31 'Halloween'

This source is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 3 of the License, or
(at your option) any later version.

This source is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
GNU General Public License for more details.

Copyright (c) 2019 - 2021 by chipforge <scarbata@nospam.chipforge.org>"
        eigen-name)
        (newline (@port))
    )

;;  ------------    purpose "screen"    -------------------------------

    (define (+purpose+ @port)
        "Formats program purpose @port."
        (format (@port)
"Optimize truth tables and/or generate boolean equations.

"   ))

;;  -------------------------------------------------------------------
;;                       GLOBAL OPTIONS
;;  -------------------------------------------------------------------

;;  ------------    usage "screen"  -----------------------------------

    (define (+usage+ @port)
        "Formats usage print-out @port."
        (format (@port)
"Usage: ~a [options] table-file
   -C cmos             equation for CMOS 'pullup' or 'pulldown' network
   -h | --help         print help screen and exit
   -m | --cdnf         minterm generation / canonical disjunctive normal form
   -M | --ccnf         maxterm generation / canonical conjunctive normal form
   -o                  optimize / simplify / reduce
   -R | --rsnf | --anf ring sum, or algebraic normal form
   -v                  print verbose messages
   --version           print version and exit"
         eigen-name)
        (newline (@port))
        (exit 2))

;;  ------------    command line options    ---------------------------

;   -C cmos
    (define cmos-network "")

;   -o
    (define simplify-all #f)

;   -m
    (define dnf-equation #f)

;   -M
    (define cnf-equation #f)

;   -R
    (define anf-equation #f)

;   -v
    (define verbose-mode #f)

;   table file
    (define table-file "")

;;  ------------    command line parsing    ---------------------------

    ; auxiliary function
    (define (parsing-error)
        "Displays unknown command line option @current-error-port."
        (begin (display "command line parsing failed." (current-error-port))
               (newline (current-error-port))
               (newline (current-error-port))))

    (define (set-parameters-with-args! arguments)
        "Set options by command line arguments."
        (cond
            ; empty list?
            [(null? arguments) 
                (begin
                    (parsing-error)
                    (+usage+ current-error-port)
                    (exit 1))] ; done, do not parse further

            ; --anf
            [(equal? (car arguments) "--anf")
                (let* ([tail (cdr arguments)])
                    (set! anf-equation #t)
                    (set! simplify-all #t)
                    (set-parameters-with-args! tail))]

            ; -C cmos
            [(equal? (car arguments) "-C")
                (let* ([value (cadr arguments)]
                       [tail (cddr arguments)])
                    (set! cmos-network value)
                    (set-parameters-with-args! tail))]

            ; --ccnf
            [(equal? (car arguments) "--ccnf")
                (let* ([tail (cdr arguments)])
                    (set! cnf-equation #t)
                    (set-parameters-with-args! tail))]

            ; --cdnf
            [(equal? (car arguments) "--cdnf")
                (let* ([tail (cdr arguments)])
                    (set! dnf-equation #t)
                    (set-parameters-with-args! tail))]

            ; --cnf
            [(equal? (car arguments) "--cnf")
                (let* ([tail (cdr arguments)])
                    (set! cnf-equation #t)
                    (set! simplify-all #t)
                    (set-parameters-with-args! tail))]

            ; --dnf
            [(equal? (car arguments) "--dnf")
                (let* ([tail (cdr arguments)])
                    (set! dnf-equation #t)
                    (set! simplify-all #t)
                    (set-parameters-with-args! tail))]

            ; -h
            [(equal? (car arguments) "-h")
                (begin
                    (+purpose+ current-error-port)
                    (+usage+ current-error-port)
                    (exit 2))] ; done, do not parse further

            ; --help
            [(equal? (car arguments) "--help")
                (begin
                    (+purpose+ current-error-port)
                    (+usage+ current-error-port)
                    (exit 2))] ; done, do not parse further


            ; -m
            [(equal? (car arguments) "-m")
                (let* ([tail (cdr arguments)])
                    (set! dnf-equation #t)
                    (set-parameters-with-args! tail))]

            ; -M
            [(equal? (car arguments) "-M")
                (let* ([tail (cdr arguments)])
                    (set! cnf-equation #t)
                    (set-parameters-with-args! tail))]

            ; -o
            [(equal? (car arguments) "-o")
                (let* ([tail (cdr arguments)])
                    (set! simplify-all #t)
                    (set-parameters-with-args! tail))]

            ; -R
            [(equal? (car arguments) "-R")
                (let* ([tail (cdr arguments)])
                    (set! anf-equation #t)
                    (set! simplify-all #t)
                    (set-parameters-with-args! tail))]

            ; --rsnf
            [(equal? (car arguments) "--rsnf")
                (let* ([tail (cdr arguments)])
                    (set! anf-equation #t)
                    (set! simplify-all #t)
                    (set-parameters-with-args! tail))]

            ; -v
            [(equal? (car arguments) "-v")
                (let* ([tail (cdr arguments)])
                    (set! verbose-mode #t)
                    (set-parameters-with-args! tail))]

            ; --version
            [(equal? (car arguments) "--version")
                (begin
                    (+version+ current-error-port)
                    (exit 3))]; done, do not parse further

            ; table file name
            [(null? (cdr arguments))
                (set! table-file (car arguments))]

            ; unkown arguments
            [else
                (begin
                    (parsing-error)
                    (+usage+ current-error-port)
                    (exit 1))])) ; done, do not parse further

    (define (print-parameters @port)
        "Formats all options by value @port."
        (begin
            ; -C cmos
            (format (@port)
"CMOS Network: ~a"
             cmos-network)
            (newline (@port))

            ; --cnf
            (format (@port)
"CNF Equation: ~a"
             cnf-equation)
            (newline (@port))

            ; --dnf
            (format (@port)
"DNF Equation: ~a"
             dnf-equation)
            (newline (@port))

            ; --anf
            (format (@port)
"ANF Equation: ~a"
             anf-equation)
            (newline (@port))

            ; -o
            (format (@port)
"Simplify All: ~a"
             simplify-all)
            (newline (@port))

            ; -v
            (format (@port)
"Verbose Mode: ~a"
             verbose-mode)
            (newline (@port))

            ; cell decription
            (format (@port)
"Table File: ~a"
             table-file)
            (newline (@port))))

;;  -------------------------------------------------------------------
;;                       MAIN
;;  -------------------------------------------------------------------

;;  ------------    main function   -----------------------------------

(define (main args)
    "Main program."
    (begin
        ; parse command line and set values / modes
        (set-parameters-with-args! (cdr args))
        (if verbose-mode (print-parameters current-error-port))

        ; select work load
;        (case expansion-method
;            ((none nand nor aoi oai pu pd)
;                 (let ([cell (expand-cell (common:dataset-cell cell-file) expansion-method buffer-limit cell-name cell-descr)])
;                    ; beautify annotation with schematic here !!
;                    (rdisplay (exporter:dataset-cell cell))
;                    0))   ; exit value
;        (else => (begin
;                    (+usage+ current-error-port)
;                    2)))))  ; exit value - wrong usage
))
