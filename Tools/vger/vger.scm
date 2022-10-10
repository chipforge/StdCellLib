;;;;    ************    LibreSilicon's StdCellLibrary   *******************
;;;;
;;;;    Organisation:   Chipforge
;;;;                    Germany / European Union
;;;;
;;;;    Profile:        Chipforge focus on fine System-on-Chip Cores in
;;;;                    Verilog HDL Code which are easy understandable and
;;;;                    adjustable. For further information see
;;;;                            www.chipforge.org
;;;;                    there are projects from small cores up to PCBs, too.
;;;;
;;;;    File:           StdCellLib/Tools/VGer/VGer.scm
;;;;
;;;;    Purpose:        V'Ger cell export functionality
;;;;
;;;;    ************    Revised^7 Report on Scheme (R7RS)   ***************
;;;;
;;;;    ///////////////////////////////////////////////////////////////////
;;;;
;;;;    Copyright (c) 2022 by
;;;;                    chipforge <popcorn@nospam.chipforge.org>
;;;;
;;;;    This source file may be used and distributed without restriction
;;;;    provided that this copyright statement is not removed from the
;;;;    file and that any derivative work contains the original copyright
;;;;    notice and the associated disclaimer.
;;;;
;;;;    This source is free software; you can redistribute it and/or modify
;;;;    it under the terms of the GNU General Public License as published by
;;;;    the Free Software Foundation; either version 3 of the License, or
;;;;    (at your option) any later version.
;;;;
;;;;    This source is distributed in the hope that it will be useful,
;;;;    but WITHOUT ANY WARRANTY; without even the implied warranty of
;;;;    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
;;;;    GNU General Public License for more details.
;;;;
;;;;     (__)  You should have received a copy of the GNU General Public
;;;;     oo )  License along with this program; if not, write to the
;;;;     /_/|  Free Software Foundation Inc., 51 Franklin St., 5th Floor,
;;;;           Boston, MA 02110-1301, USA
;;;;
;;;;    GNU General Public License v3.0 - http://www.gnu.org/licenses/gpl-3.0.html
;;;;    ///////////////////////////////////////////////////////////////////

    ;; R7RS-type library usage declaration
    (import (scheme base)
            (scheme write)              ; display
            (scheme process-context)    ; exit
            (srfi 28)                   ; format
            (srfi 78)                   ; test suite
            ;; r7rs modules for StdCellLib also
            (common cell)
            (exporter spice)
            (exporter verilog)
    )

;;;     ------------    srfi-78 test suite  -------------------------------

    ;; change this switch during development only
    ;; mode must be a symbol in '(off summary report-failed report)
    (check-set-mode! 'off)

;;;     -------------------------------------------------------------------
;;;                     PROGRAM
;;;     -------------------------------------------------------------------

;;;     ------------    Program Name    -----------------------------------

    ;; use this as default
    (define +eigen-name+ "vger")

;;;     ------------    version "screen"    -------------------------------

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

Copyright (c) 2022 by chipforge <vger@nospam.chipforge.org>"
        +eigen-name+)
        (newline (@port))
    )

;;;     ------------    purpose "screen"    -------------------------------

    (define (+purpose+ @port)
        "Formats program purpose @port."
        (format (@port)
"Export cell descriptions into models and test benches.

"   ))

;;;     -------------------------------------------------------------------
;;;                     GLOBAL OPTIONS
;;;     -------------------------------------------------------------------

;;;     ------------    usage "screen"  -----------------------------------

    (define (+usage+ @port)
        "Formats usage print-out @port."
        (format (@port)
"Usage: ~a [options] cell-file
   -B                  write out a Test Bench
   -e format           specify the design format in which the file is generated
   -h | --help         print help screen and exit
   -v                  print verbose messages
   --version           print version and exit"
         +eigen-name+)
        (newline (@port))
        (exit 2))

;;;     ------------    command line options    ---------------------------

    ;; -B
    (define +test-bench+ #f)

    ;; -e format
    (define +exporter-format+ 'verilog)

    ;; -v
    (define +verbose-mode+ #f)

    ;; cell file
    (define +cell-file+ "")

;;;     ------------    command line parsing    ---------------------------

    ;; auxiliary function
    (define (parsing-error)
        "Displays unknown command line option @current-error-port."
        (begin (display "command line parsing failed." (current-error-port))
               (newline (current-error-port))
               (newline (current-error-port))))

    (define (set-parameters-with-args! arguments)
        "Set options by command line arguments."
        (cond
            ;; empty list?
            [(null? arguments) 
                (begin
                    (parsing-error)
                    (+usage+ current-error-port)
                    (exit 1))] ; done, do not parse further

            ;; -B
            [(equal? (car arguments) "-B")
                (let* ([tail (cdr arguments)])
                (set! +test-bench+ #t)
                    (set-parameters-with-args! tail))]

            ;; -e format
            [(equal? (car arguments) "-e")
                (let* ([value (cadr arguments)]
                       [tail (cddr arguments)])
                    (set! +exporter-format+ (string->symbol value))
                    (set-parameters-with-args! tail))]

            ;; -h
            [(equal? (car arguments) "-h")
                (begin
                    (+purpose+ current-error-port)
                    (+usage+ current-error-port)
                    (exit 2))] ; done, do not parse further

            ;; --help
            [(equal? (car arguments) "--help")
                (begin
                    (+purpose+ current-error-port)
                    (+usage+ current-error-port)
                    (exit 2))] ; done, do not parse further

            ;; -v
            [(equal? (car arguments) "-v")
                (let* ([tail (cdr arguments)])
                    (set! +verbose-mode+ #t)
                    (set-parameters-with-args! tail))]

            ;; --version
            [(equal? (car arguments) "--version")
                (begin
                    (+version+ current-error-port)
                    (exit 3))]; done, do not parse further

            ;; cell file name
            [(null? (cdr arguments))
                (set! +cell-file+ (car arguments))]

            ;; unkown arguments
            [else
                (begin
                    (parsing-error)
                    (+usage+ current-error-port)
                    (exit 1))])) ; done, do not parse further

    (define (print-parameters @port)
        "Formats all options by value @port."
        (begin
            ;; -B
            (format (@port)
"Test Bench: ~a"
             +test-bench+)
            (newline (@port))

            ;; -e format 
            (format (@port)
"Exporter format: ~a"
             +exporter-format+)
            (newline (@port))

            ;; -v
            (format (@port)
"Verbose Mode: ~a"
             +verbose-mode+)
            (newline (@port))

            ;; cell decription
            (format (@port)
"Cell File: ~a"
             +cell-file+)
            (newline (@port))))

;;;     -------------------------------------------------------------------
;;;                     MAIN
;;;     -------------------------------------------------------------------

;;;     ------------    main function   -----------------------------------

(define (main args)
    "Main program."
    (begin
        ;; parse command line and set values / modes
        (set-parameters-with-args! (cdr args))
        (if +verbose-mode+ (print-parameters current-error-port))

        ;; select work load
;        (case expansion-method
;            ((none nand nor pu pd)
;                 (let ([cell (expand-cell (common:dataset-cell +cell-file+) expansion-method buffer-limit cell-name cell-descr)])
;                    ;; beautify annotation with schematic here !!
;                    (rdisplay (exporter:dataset-cell cell))
;                    0))   ; exit value
;        (else => 
            (begin
                    (+usage+ current-error-port)
                    2)))  ; exit value - wrong usage