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
;;  File:           StdCellLib/Tools/commmon/lib.scm
;;
;;  Purpose:        Scheme Module - common functional as library
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

(define-library (common lib)
  (import (scheme base)
          (scheme char)     ; digit-value
;         (scheme sort)     ; list-sort
          (scheme char)     ; string-upcase, string-downcase
          (scheme write)    ; display
          (scheme time)     ; current-second
          (srfi 78)         ; test suite
) (export  ; example cells
           INV-cell
           BUF-cell
           NAND2-cell
           NOR2-cell
           OAI21-cell
           OOAI22-cell
           AOI21-cell
           AAOI22-cell
           ; auxilary stuff
           copyleft-year
  (begin

;;  ------------    srfi-78 test suite  -------------------------------

;   change this switch during development only
;   mode must be a symbol in '(off summary report-failed report)
    (check-set-mode! 'off)
#|
;;  -------------------------------------------------------------------
;;                  EXAMPLE CELLS
;;  -------------------------------------------------------------------

;;  ------------    Example : INV-cell  -------------------------------

;               ^ Vdd
;               |
;           | --+
;      A --o| |   g
;           | --+
;               |
;               *---- Y
;               |
;           | --+
;      A ---| |   1
;           | --+
;               |
;              _|_ Gnd

    (define INV-cell '#("INV" "a Not (or Inverter) gate"
                        ("A") ("Y") ()
                        (#("pmos" "A" "Y" "VDD" "VDD" 1 1  1 "g")
                         #("nmos" "A" "Y" "GND" "GND" 1 1 -1 "1"))
                        ()))

;;  ------------    Example : BUF-cell  -------------------------------

;               ^ Vdd               ^ Vdd
;               |                   |
;           | --+               | --+
;      A --o| |   g         +--o| |   g
;           | --+           |   | --+
;               |           |       |
;               *-----------*       *---- Z
;               |           |       |
;           | --+           |   | --+
;      A ---| |   1         +---| |   1
;           | --+               | --+
;               |                   |
;              _|_ Gnd             _|_ Gnd

    (define BUF-cell '#("BUF" "a non-inverting Buffer gate"
                        ("A") ("Z") ()
                        (#("pmos" "Y" "Z" "VDD" "VDD" 1 2  1 "g")
                         #("nmos" "Y" "Z" "GND" "GND" 1 2 -1 "1")
                         #("pmos" "A" "Y" "VDD" "VDD" 1 1  1 "g")
                         #("nmos" "A" "Y" "GND" "GND" 1 1 -1 "1"))
                        ()))

;;  ------------    Example : NAND2-cell    ---------------------------

;               ^ Vdd               ^ Vdd
;               |                   |
;           | --+               | --+
;      A --o| |   g       A1 --o| |   g
;           | --+               | --+
;               |                   |
;               *-------------------*---- Y
;               |
;           | --+
;      A ---| |   2
;           | --+
;               | N1
;               |
;           | --+
;     A1 ---| |   2
;           | --+
;               |
;              _|_ Gnd

    (define NAND2-cell '#("NAND2" "a 2-input Not-AND (or NAND) gate"
                          ("A1" "A") ("Y") ()
                          (#("pmos" "A1" "Y"  "VDD" "VDD" 1 2  1 "g")
                           #("pmos" "A"  "Y"  "VDD" "VDD" 1 1  1 "g")
                           #("nmos" "A"  "Y"  "N1"  "GND" 1 1 -1 "2")
                           #("nmos" "A1" "N1" "GND" "GND" 2 1 -2 "2"))
                          ()))

;;  ------------    Example : NOR2-cell     ---------------------------

;               ^ Vdd
;               |
;           | --+
;     A1 --o| |   2g
;           | --+
;               |
;               | N1
;           | --+
;      A --o| |   2g
;           | --+
;               |
;               *-------------------*---- Y
;               |                   |
;           | --+               | --+
;      A ---| |   1       A1 ---| |   1
;           | --+               | --+
;               |                   |
;              _|_ Gnd             _|_ Gnd

    (define NOR2-cell '#("NOR2" "a 2-input Not-OR (or NOR) gate"
                         ("B" "A") ("Y") ()
                         (#("pmos" "A1" "N1" "VDD" "VDD" 2 1  2 "2g")
                          #("pmos" "A"  "Y"  "N1"  "VDD" 1 1  1 "2g")
                          #("nmos" "A"  "Y"  "GND" "GND" 1 1 -1 "1")
                          #("nmos" "A1" "Y"  "GND" "GND" 1 2 -1 "1"))
                         ()))

;;  ------------    Example : OAI21-cell    ---------------------------

;                                   ^ Vdd
;                                   |
;                               | --+
;                         B1 --o| |   2g
;                               | --+
;               ^ Vdd               |
;               |                   | N2
;           | --+               | --+
;      A --o| |   g        B --o| |   2g
;           | --+               | --+
;               |                   |
;               *-------------------*---- Y
;               |
;           | --+
;      A ---| |   2
;           | --+
;               | N1
;               *-------------------*
;               |                   |
;           | --+               | --+
;      B ---| |   2       B1 ---| |   2
;           | --+               | --+
;               |                   |
;              _|_ Gnd             _|_ Gnd

    (define OAI21-cell '#("OAI21" "a 2-1-input OR-AND-Invert (or OAI) gate"
                          ("B1" "B" "A") ("Y") ()
                          (#("pmos" "B1" "N2" "VDD" "VDD" 2 2  2 "2g")
                           #("pmos" "B"  "Y"  "N2"  "VDD" 1 2  1 "2g")
                           #("pmos" "A"  "Y"  "VDD" "VDD" 1 1  1 "g")
                           #("nmos" "A"  "Y"  "N1"  "GND" 1 1 -1 "2")
                           #("nmos" "B"  "N1" "GND" "GND" 2 1 -2 "2")
                           #("nmos" "B1" "N1" "GND" "GND" 2 2 -2 "2"))
                          ()))

;;  ------------    Example : OOAI22-cell   ---------------------------

;               ^ Vdd               ^ Vdd
;               |                   |
;           | --+               | --+
;      A1--o|             B1 --o| |   2g
;           | --+               | --+
;               |                   |
;               | N1                | N2
;           | --+               | --+
;      A --o| |   g        B --o| |   2g
;           | --+               | --+
;               |                   |
;               *-------------------*---- Y
;               |                   |
;           | --+               | --+
;      A ---| |   2       A1 ---| |
;           | --+               | --+
;               | N3                | N3
;               *-------------------*
;               |                   |
;           | --+               | --+
;      B ---| |   2       B1 ---| |   2
;           | --+               | --+
;               |                   |
;              _|_ Gnd             _|_ Gnd

    (define OOAI22-cell '#("OOAI22" "a 2-2-input OR-OR-AND-Invert gate"
                           ("B1" "B" "A1" "A") ("Y") ()
                           (#("pmos" "B1" "N2" "VDD" "VDD" 2 2  2 "2g")
                            #("pmos" "B"  "Y"  "N2"  "VDD" 1 2  1 "2g")
                            #("pmos" "A1" "N1" "VDD" "VDD" 2 1  2 "2g")
                            #("pmos" "A"  "Y"  "VDD" "VDD" 1 1  1 "2g")
                            #("nmos" "A"  "Y"  "N3"  "GND" 1 1 -1 "2")
                            #("nmos" "A1" "Y"  "N3"  "GND" 1 2 -1 "2")
                            #("nmos" "B"  "N3" "GND" "GND" 2 1 -2 "2")
                            #("nmos" "B1" "N3" "GND" "GND" 2 2 -2 "2"))
                           ()))

;;  ------------    Example : AOI21-cell    ---------------------------

;               ^ Vdd               ^ Vdd
;               |                   |
;           | --+               | --+
;      B --o| |   2g      B1 --o| |   2g
;           | --+               | --+
;               | N1                |
;               *-------------------*
;               |
;           | --+
;      A --o| |   2g
;           | --+
;               |
;               *-------------------*---- Y
;               |                   |
;           | --+               | --+
;      A ---| |   1        B ---| |   2
;           | --+               | --+
;               |                   |
;              _|_ Gnd              | N2
;                               | --+
;                         B1 ---| |   2
;                               | --+
;                                   |
;                                  _|_ Gnd

    (define AOI21-cell '#("AOI21" "a 2-1-input AND-OR-Invert (or AOI) gate"
                          ("B1" "B" "A") ("Y") ()
                          (#("pmos" "B1" "N1" "VDD" "VDD" 2 2  2 "2g")
                           #("pmos" "B"  "N1" "VDD" "VDD" 2 1  2 "2g")
                           #("pmos" "A"  "Y"  "N1"  "VDD" 1 1  1 "2g")
                           #("nmos" "A"  "Y"  "GND" "GND" 1 1 -1 "1")
                           #("nmos" "B"  "Y"  "N2"  "GND" 1 2 -1 "2")
                           #("nmos" "B1" "N2" "GND" "GND" 2 2 -2 "2"))
                          ()))

;;  ------------    Example : AAOI22-cell   ---------------------------

;               ^ Vdd               ^ Vdd
;               |                   |
;           | --+               | --+
;      B --o| |   2g      B1 --o| |   2g
;           | --+               | --+
;               | N3                |
;               *-------------------*
;               |                   |
;           | --+               | --+
;      A --o| |   2g      A1 --o| |   2g
;           | --+               | --+
;               |                   |
;               *-------------------*---- Y
;               |                   |
;           | --+               | --+
;      A ---| |   2        B ---|     2
;           | --+               | --+
;               | N1                | N2
;               |                   |
;           | --+               | --+
;     A1 ---| |   2       B1 ---|     2
;           | --+               | --+
;               |                   |
;              _|_ Gnd             _|_ Gnd

    (define AAOI22-cell '#("AAOI22" "a 2-2-input AND-AND-OR-Invert gate"
                          ("A1" "A") ("Y") ()
                          (#("pmos" "B1" "N3" "VDD" "VDD" 2 2  2 "2g")
                           #("pmos" "B"  "N3" "VDD" "VDD" 2 1  2 "2g")
                           #("pmos" "A1" "Y"  "N3"  "VDD" 1 2  1 "2g")
                           #("pmos" "A"  "Y"  "N3"  "VDD" 1 1  1 "2g")
                           #("nmos" "A"  "Y"  "N1"  "GND" 1 1 -1 "2")
                           #("nmos" "A1" "N1" "GND" "GND" 2 1 -2 "2")
                           #("nmos" "B"  "Y"  "N2"  "GND" 1 2 -1 "2")
                           #("nmos" "B1" "N2" "GND" "GND" 2 2 -2 "2"))
                          ()))
|#
;;  -------------------------------------------------------------------
;;                  AUXILARY STUFF
;;  -------------------------------------------------------------------

;;  ------------    calculate (c) Copyleft year -----------------------

;   define some user-friendly constants for calculations
    (define second 1)
    (define minute (* 60 second))
    (define hour (* 60 minute))
    (define day (* 24 hour))
    (define calendar-year (* 365 day))

;   
    (define (copyleft-year)
        "Calculate year out of current-second. Returns number."
        (let ((tropical-year (+ calendar-year (* 5 hour) (* 48 minute) (* 45 second)))) ; !!
            ; This is estimated! There is a delta around new-year regarding
            ; leap years. Do you like to use Popcorn around New Year?
            ; Really??
            (+ 1970 (exact (floor (/ (current-second) tropical-year))))))

;   Checks:
;   (check (copyleft-year) => 2021)

;;  ===================================================================
;;                  END OF R7RS LIBRARY
;;  ===================================================================
  )
)
