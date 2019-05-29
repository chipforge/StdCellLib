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
  (import (scheme base)
          (scheme write)            ; display
          (scheme file)             ; file io
          (srfi 28)                 ; format
          (srfi 152)                ; string-split
          ; popcorn lib als
          (popcorn-lib))
  (export  read-cell-file
           write-cell-file)
  (begin

;;  ------------    build-in self test  -------------------------------

    ; use this switch during development only
    (define build-in-self-test #t)

;;  -------------------------------------------------------------------
;;                  DESCRIPTION
;;  -------------------------------------------------------------------

;   In principle every combinatorial cell (in CMOS technology) contains
;   two functional complementary networks. The pull-up network - build
;   with pmos transistors - as well as the pull-down network - build
;   with nmos transistors.

;   so every netlist becomes, well, a list of transistors

;;  -------------------------------------------------------------------
;;                  READ/WRITE CELL DESCRIPTIONS
;;  -------------------------------------------------------------------

;;  ------------    read in cell file   -------------------------------

;   Contract:
;   read-cell-file : filehandler -> cell

;   Purpose:
;   read in cell file as vector for further usage

;   Example:
;   (read-cell-file file) => INV-cell

;   Definition:
    (define (read-cell-file file-name)
        (let ((file (open-input-file file-name))
              (return (make-vector 7 '()))
              (netlist '()))
            (let x ((line (read-line file)))
                (if (eof-object? line)
                    '()
                    (begin
                        (cell-text! return line)
                        (let function ((line (read-line file)))
                            (unless (eof-object? line)
                                (cond
                                    ; ignore comment lines, read further
                                    [(equal? (string-ref line 0) #\#)
                                        (function (read-line file))
                                    ]

                                    ; .cell annotated line, get name
                                    [(equal? (substring line 0 4) ".cel")
                                        (begin
                                            (cell-id! return (string->symbol (string-copy line 6)))
                                            (function (read-line file))
                                        )
                                    ]

                                    ; .clocks annotated line, get list
                                    [(equal? (substring line 0 4) ".clo")
                                        (begin
                                            (cell-clocks! return (stringlist->symbollist (string-split (string-copy line 7) #[ ])))
                                            (function (read-line file))
                                        )
                                    ]

                                    ; .inputs annotated line, get list
                                    [(equal? (substring line 0 4) ".inp")
                                        (begin
                                            (cell-inputs! return (stringlist->symbollist (string-split (string-copy line 8) #[ ])))
                                            (function (read-line file))
                                        )
                                    ]

                                    ; .outputs annotated line, get list
                                    [(equal? (substring line 0 4) ".out")
                                        (begin
                                            (cell-outputs! return (stringlist->symbollist (string-split (string-copy line 9) #[ ])))
                                            (function (read-line file))
                                        )
                                    ]

                                    ; .end annotated line, clean up
                                    [(equal? (substring line 0 4) ".end")
                                        (begin
                                            (cell-netlist! return (append netlist '()))
                                            (eof-object)
                                        )
                                    ]

                                    ; collect netlist lines
                                    [else
                                        (begin
                                            (set! netlist (append netlist (list (list->vector (stringlist->symbollist (string-split line #[ ]))))))
                                            (function (read-line file))
                                        )
                                    ]
                                )
                            )
                        )
                    )
                )
            ; done, close file
            (close-input-port file)
            return
            )
        )
    )

;;  ------------    write description line  ---------------------------

;   Contract:
;   write-cell-file : cell -> --

;   Purpose:
;   write cell description to STDOUT

;   Example:
;   (write-cell-file INV-cell) => --

;   Definition:
    (define write-cell-file
        (lambda (cell)
            (let ((at-port current-output-port))
                (begin
                    ; first line header
                    (if (null? (cell-text cell))
                        (format (at-port)
"proudly AUTOGENERATED by \"Popcorn\" R7RS Scheme tool
"                       )
                        (format (at-port)
"~a
"                           (cell-text cell)))
                    ; next mandantory lines
                    (format (at-port)
".cell ~a
.inputs ~a
.outputs ~a
"                       (cell-id cell)
                        (list->string (cell-inputs cell))
                        (list->string (cell-outputs cell)))
                    ; optional clock line
                    (if (null? (cell-clocks cell))
                        '()
                        (format (at-port)
".clocks ~a
"                           (list->string (cell-clocks cell)))
                    )
                    ; additional, e.g. schematic
                    (if (null? (cell-additional cell))
                        '()
                        (format (at-port)
"~a
"                           (cell-additional cell))
                    )
                    ; netlist
                    (format (at-port)
"~a
"                       (cell-netlist cell))
                    ; done
                    (format (at-port)
".end
"                   )
                )
            )
        )
    )

;;  ===================================================================
;;                  END OF R7RS LIBRARY
;;  ===================================================================
  )
)
