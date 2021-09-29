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
;;  Copyright (c) 2019 - 2021 by
;;                  chipforge <popcorn@nospam.chipforge.org>
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
            (popcorn expander)
            (exporter generic)
            (exporter cell)
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
    (define eigen-name "popcorn")

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

Copyright (c) 2019 - 2021 by chipforge <popcorn@nospam.chipforge.org>"
        eigen-name)
        (newline (@port))
    )

;;  ------------    purpose "screen"    -------------------------------

    (define (+purpose+ @port)
        "Formats program purpose @port."
        (format (@port)
"Generate new combinatorial cell.

"   ))

;;  -------------------------------------------------------------------
;;                       GLOBAL OPTIONS
;;  -------------------------------------------------------------------

;;  ------------    usage "screen"  -----------------------------------

    (define (+usage+ @port)
        "Formats usage print-out @port."
        (format (@port)
"Usage: ~a [options] cell-file
   -b number           set threshold value for output buffer
   -c cellname         cell name for generated output
   -h | --help         print help screen and exit
   -H number           set cell highth in metal tracks
   -m method           enlarge cell - aoi nand none nor oai pd pu
   -T file             TOML configuration file
   -v                  print verbose messages
   --version           print version and exit"
         eigen-name)
        (newline (@port))
        (exit 2))

;;  ------------    command line options    ---------------------------

;   -b number
    (define buffer-limit 4)

;   -c cellname
    (define cell-name "CELL")

;   -d string
    (define cell-descr ".AUTOGENERATED by \'Popcorn\' R7RS Scheme tool")

;   -H number
    (define track-high 9)

;   -m method
    (define expansion-method 'none)

;   -T file
    (define toml-file "LS1u_std.toml")

;   -v
    (define verbose-mode #f)

;   cell file
    (define cell-file "")

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

            ; -b number
            [(equal? (car arguments) "-b")
                (let* ([value (cadr arguments)]
                       [tail (cddr arguments)])
                    (set! buffer-limit (string->number value))   ; !! value check missing
                    (set-parameters-with-args! tail))]

            ; -c cellname
            [(equal? (car arguments) "-c")
                (let* ([value (cadr arguments)]
                       [tail (cddr arguments)])
                    (set! cell-name value)
                    (set-parameters-with-args! tail))]

            ; -D string
            [(equal? (car arguments) "-D")
                (let* ([value (cadr arguments)]
                       [tail (cddr arguments)])
                    (set! cell-descr value)
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


            ; -H number
            [(equal? (car arguments) "-H")
                (let* ([value (cadr arguments)]
                       [tail (cddr arguments)])
                    (set! track-high (string->number value))  ; !! value check missing)]
                    (set-parameters-with-args! tail))]

            ; -m method
            [(equal? (car arguments) "-m")
                (let* ([value (cadr arguments)]
                       [tail (cddr arguments)])
                    (set! expansion-method (string->symbol value))
                    (set-parameters-with-args! tail))]

            ; -T file
            [(equal? (car arguments) "-T")
                (let* ([value (cadr arguments)]
                       [tail (cddr arguments)])
                    (set! toml-file value)  ; !! value check missing)]
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

            ; cell file name
            [(null? (cdr arguments))
                (set! cell-file (car arguments))]

            ; unkown arguments
            [else
                (begin
                    (parsing-error)
                    (+usage+ current-error-port)
                    (exit 1))])) ; done, do not parse further

    (define (print-parameters @port)
        "Formats all options by value @port."
        (begin
            ; -b number
            (format (@port)
"Buffer Limit: ~a stacked transistors"
            buffer-limit)
            (newline (@port))

            ; -c cellname
            (format (@port)
"Cell Name: ~a"
             cell-name)
            (newline (@port))

            ; -D string
            (format (@port)
"Cell Description: ~a"
             cell-descr)
            (newline (@port))

            ; -H number
            (format (@port)
"Cell High: ~a metal tracks"
             track-high)
            (newline (@port))

            ; -m method
            (format (@port)
"Expansion Method: ~a"
             expansion-method)
            (newline (@port))

            ; -T file
            (format (@port)
"TOML File: ~a"
             toml-file)
            (newline (@port))

            ; -v
            (format (@port)
"Verbose Mode: ~a"
             verbose-mode)
            (newline (@port))

            ; cell decription
            (format (@port)
"Cell File: ~a"
             cell-file)
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
        (case expansion-method
            ((none nand nor aoi oai pu pd)
                 (let ([cell (expand-cell (common:dataset-cell cell-file) expansion-method buffer-limit cell-name cell-descr)])
                    ; beautify annotation with schematic here !!
                    (rdisplay (exporter:dataset-cell cell))
                    0))   ; exit value
        (else => (begin
                    (+usage+ current-error-port)
                    2)))))  ; exit value - wrong usage
