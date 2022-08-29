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
;;  File:           StdCellLib/Tools/konstruktivist/konstruktivist.scm
;;
;;  Purpose:        Schematic Main functionality
;;
;;  ************    Revised^7 Report on Scheme (R7RS)   ***************
;;
;;  ///////////////////////////////////////////////////////////////////
;;
;;  Copyright (c) 2021 by
;;                  chipforge <schematic@nospam.chipforge.org>
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
            (exporter circdia)
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
    (define eigen-name "konstruktivist")

;;  ------------    version "screen"    -------------------------------

    (define (+version+ @port)
        "Formats program name, version and license header @port."
        (format (@port)
"~a - Version 2022-VII-04 'FSiC 2022'

This source is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 3 of the License, or
(at your option) any later version.

This source is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
GNU General Public License for more details.

Copyright (c) 2021 - 2022 by chipforge <konstruktivist@nospam.chipforge.org>"
        eigen-name)
        (newline (@port))
    )

;;  ------------    purpose "screen"    -------------------------------

    (define (+purpose+ @port)
        "Formats program purpose @port."
        (format (@port)
"Generate beautiful Schematics.

"   ))

;;  -------------------------------------------------------------------
;;                       GLOBAL OPTIONS
;;  -------------------------------------------------------------------

;;  ------------    usage "screen"  -----------------------------------

    (define (+usage+ @port)
        "Formats usage print-out @port."
        (format (@port)
"Usage: ~a [options] cell-file
   -e format           specify exporter format - CircDia (LaTeX), or gEDA (gschem)
   -h | --help         print help screen and exit

   -v                  print verbose messages
   --version           print version and exit"
         eigen-name)
        (newline (@port))
        (exit 2))

;;  ------------    command line options    ---------------------------

;   -e format
    (define exporter-format 'circdia)

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

            ; -e format
            [(equal? (car arguments) "-e")
                (let* ([value (cadr arguments)]
                       [tail (cddr arguments)])
                    (set! exporter-format (string->symbol value))
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
        (cond
            ; generate CircDia LaTeX schematic
            [(equal? exporter-format 'circdia)
                (begin
                    (exporter:schematic-circdia (common:dataset-cell cell-file))
                    0)] ; exit value

            ; generate gEDA schematic
            [(equal? exporter-format 'geda)
                0])))
