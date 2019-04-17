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

;;  -------------------------------------------------------------------
;;                  R7RS equivalent FUNCTIONS
;;  -------------------------------------------------------------------

;   Please remove this as soon as clean R7RS Scheme compiler becomes usefull

;;;  ------------    read one line   -----------------------------------
;
;;   Contract:
;;   read-line : port -> string
;
;;   Purpose:
;;   read in one line of text from STDIN
;
;;   Example:
;;   (read-line port) => "Hello World."
;
;;   Definition:
;    (define read-line
;        (lambda (port)
;            (begin
;                (read-char port)
;                (cond
;                    ; end of file
;                    [(eof-object? port) ""]
;
;;                    ; unix newline
;;                    [(eq? port \#newline) ""]
;
;                    ; assume, all others are characters
;                    [else (cons(read-line port))]
;                )
;            )
;        )
;    )

;;  -------------------------------------------------------------------
;;                  FUNCTIONS for CELL DESCRIPTIONS
;;  -------------------------------------------------------------------

;;  ------------    read in cell file   -------------------------------

;   Contract:
;   read-cell-file : filehandler -> netlist

;   Purpose:
;   read in cell file as netlist for further usage

;   Example:
;   (read-cell-file file) => 'INV

;   Definition:
    (define (read-cell-file file-name)
        (let ((file (open-input-file file-name)))
            (let function ((x (read-line file)))
                (if (eof-object? x)
                    (begin
                        (close-input-port file)
                        '()
                    )
                    (cons x (function (read file)))
                )
            )
        )
    )

;;  ------------    write out cell file     ---------------------------

