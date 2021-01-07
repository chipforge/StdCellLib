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
;;  File:           StdCellLib/Tools/cobblestone/cobblestone.scm
;;
;;  Purpose:        Cobblestone Main functionality
;;
;;  ************    Revised^7 Report on Scheme (R7RS)   ***************
;;
;;  ///////////////////////////////////////////////////////////////////
;;
;;  Copyright (c)   2019 - 2021 by
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
            (exporter lef)
            (exporter magic)
            (exporter svg)
    )

;;  -------------------------------------------------------------------
;;                       PROGRAM
;;  -------------------------------------------------------------------

;;  ------------    Program Name    -----------------------------------

    ; use this as default
    (define eigen-name "cobblestone")

;;  ------------    version "screen"    -------------------------------

    (define (+version+ eigen-name @port)
        "Formats program name, version and license header @port."
        (format (@port)
"~a (\"Cobblestone\") - Version 2021-01-04

This source is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 3 of the License, or
(at your option) any later version.

This source is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
GNU General Public License for more details.

Copyright (c) 2019 - 2021 by chipforge <cobblestone@nospam.chipforge.org>"
        eigen-name)
        (newline (@port))
    )

;;  ------------    srfi-78 test suite  -------------------------------

    ; change this switch during development only
    ; mode must be a symbol in '(off summary report-failed report)
    (check-set-mode! 'off)

;;  -------------------------------------------------------------------
;;                       GLOBAL OPTIONS
;;  -------------------------------------------------------------------

;;  ------------    usage "screen"  -----------------------------------

    (define (+usage+ eigen-name @port)
        "Formats usage print-out @port."
        (format (@port)
"Usage: ~a - Generate physical VLSI layout
   -e format           specify exporter format - lef, magic or svg
   -h | --help         print help screen and exit
   -H number           set cell highth in metal tracks
   -s rule-set         MOSIS rule set - scmos, subm, deep or user
   -T file             TOML configuration file
   -v                  print verbose messages
   --version           print version and exit"
         eigen-name)
        (newline (@port))
        (exit 2)
    )

;;  ------------    command line options    ---------------------------

;   -e format
    (define exporter-format 'magic)

;   -H number
    (define track-high 9)

;   -s rule-set
    (define rule-set 'user)

;   -T file
    (define toml-file "LS1u_std.toml")

;   -v
    (define verbose-mode #f)

;   cell desciption
    (define cell-file "")

;;  ------------    command line parsing    ---------------------------

    ; auxiliary function
    (define (parsing-error wrong-arg)
        "Displays unknown command line option @current-error-port."
        (begin (display "command line parsing failed: " (current-error-port))
               (display wrong-arg (current-error-port))
               (newline (current-error-port))))

    (define (set-parameters-with-args! eigen-name arguments)
        "Set options by command line arguments."
        (cond
            ; empty list?
            [(null? arguments) parsing-error]

            ; -e format
            [(equal? (car arguments) "-e")
                (let ([value (car (cdr arguments))]
                      [tail (cddr arguments)])
                    (set! exporter-format (string->symbol value))
                    (set-parameters-with-args! eigen-name tail))]

            ; -h
            [(equal? (car arguments) "-h")
                (begin
                    (+usage+ eigen-name current-error-port)
                    (exit 2))] ; done, do not parse further

            ; --help
            [(equal? (car arguments) "--help")
                (begin
                    (+usage+ eigen-name current-error-port)
                    (exit 2))] ; done, do not parse further


            ; -H number
            [(equal? (car arguments) "-H")
                (let ([value (car (cdr arguments))]
                      [tail (cddr arguments)])
                    (set! track-high (string->number value))  ; !! value check missing)]
                    (set-parameters-with-args! eigen-name tail))]

            ; -s rule-set
            [(equal? (car arguments) "-s")
                (let ([value (car (cdr arguments))]
                      [tail (cddr arguments)])
                    (set! rule-set (string->symbol value))
                    (set-parameters-with-args! eigen-name tail))]

            ; -T file
            [(equal? (car arguments) "-T")
                (let ([value (car (cdr arguments))]
                      [tail (cddr arguments)])
                    (set! toml-file value)  ; !! value check missing)]
                    (set-parameters-with-args! eigen-name tail))]

            ; -v
            [(equal? (car arguments) "-v")
                (let ([tail (cdr arguments)])
                    (set! verbose-mode #t)
                    (set-parameters-with-args! eigen-name tail))]

            ; --version
            [(equal? (car arguments) "--version")
                (begin
                    (+version+ eigen-name current-error-port)
                    (exit 3))]; done, do not parse further

            ; cell file name
            [(null? (cdr arguments))
                (set! cell-file (car arguments))]

            ; unkown arguments
            [else (parsing-error (car arguments))]))

    (define (print-parameters @port)
        "Formats all options by value @port."
        (begin
                ; -e format
                (format (@port)
"Exporter Format: ~a"
                 exporter-format)
                (newline (@port))

                ; -H number
                (format (@port)
"Cell High: ~a metal tracks"
                 track-high)
                (newline (@port))

                ; -s rule-set
                (format (@port)
"MOSIS rule set: ~a"
                 rule-set)
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
"Cell Description: ~a"
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
        (let ((eigen-name (car args)))
            (set-parameters-with-args! eigen-name (or (cdr args) '("--help")))
            (if verbose-mode (print-parameters current-error-port))

            ; select work load
            (cond
                ; generate magic layout format
                [(equal? exporter-format 'magic)
                    (begin
                        (exporter:layout-magic (common:dataset-cell cell-file))
                        0)] ; exit value

                ; generate lef layout format
                [(equal? exporter-format 'lef)
                    (begin
                        (exporter:layout-lef (common:dataset-cell cell-file))
                        0)] ; exit value

                ; generate svg layout format
                [(equal? exporter-format 'svg)
                    (begin
                        (exporter:layout-svg (common:dataset-cell cell-file))
                        0)] ; exit value

                ; selection failed, unknown exporter-format value
                [else
                    (begin
                        (+usage+ eigen-name current-error-port)
                        2)])))) ; exit value - wrong usage

