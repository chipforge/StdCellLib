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
;;  File:           StdCellLib/Tools/popcorn/popcorn-lib.scm
;;
;;  Purpose:        Scheme Module - popcorn functional library
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

(define-library (popcorn-lib)
  (import (scheme base)
          (scheme sort)     ; list-sort
          (scheme write)    ; display
          (scheme time))    ; current-second
  (export  ; example cells
           INV-cell
           NAND2-cell
           NOR2-cell
           ; cell descriptions
           cell-id cell-id!
           cell-text cell-text!
           cell-inputs cell-inputs!
           cell-outputs cell-outputs!
           cell-clocks cell-clocks!
           cell-netlist cell-netlist!
           cell-additional cell-additional!
           ; mosfet descriptions
           mosfet-type
           mosfet-nmos?
           mosfet-pmos?
           mosfet-gate
           mosfet-drain
           mosfet-source
           mosfet-bulk
           mosfet-stacked
           mosfet-xaxis
           mosfet-yaxis
           ; node descriptions
           input-space?
           output-space?
           clock-space?
           node-space?
           supply-symbol-space?
           ground-symbol-space?
           ; auxilary stuff
           copyleft-year
           stringlist->csv
           stringlist->symbollist
           symbollist->stringlist)
  (begin

;;  ------------    build-in self test  -------------------------------

    ; use this switch during development only
    (define build-in-self-test #t)

;;  -------------------------------------------------------------------
;;                  DESCRIPTION
;;  -------------------------------------------------------------------

;;  In principle every combinatorial cell (in CMOS technology) contains
;;  two functional complementary networks. The pull-up network - build
;;  with pmos transistors - as well as the pull-down network - build
;;  with nmos transistors.

;;  so every netlist becomes, well, a list of transistors

;;  ------------    Example : INV-cell  -------------------------------

;               ^ Vdd
;               |
;           | --+
;      A --o| |     pmos
;           | --+
;               |
;               *---- Y
;               |
;           | --+
;      A ---| |     nmos
;           | --+
;               |
;              _|_ Gnd

    (define INV-cell '#(INV "a Not (or Inverter) gate"
                        (A) (Y) ()
                        (#(pmos A Y VDD VDD 1 1  1)
                         #(nmos A Y GND GND 1 1 -1))
                        ())
    )

;;  ------------    Example : NAND2-cell    ---------------------------

;               ^ Vdd               ^ Vdd
;               |                   |
;           | --+               | --+
;      A --o| |     pmos   B --o| |     pmos
;           | --+               | --+
;               |                   |
;               *-------------------*---- Y
;               |
;           | --+
;      A ---| |     nmos
;           | --+
;               |
;               |
;           | --+
;      B ---| |     nmos
;           | --+
;               |
;              _|_ Gnd

    (define NAND2-cell '#(NAND2 "a 2-input Not-AND (or NAND) gate"
                          (B A) (Y) ()
                          (#(pmos B Y  VDD VDD 1 2  1)
                           #(pmos A Y  VDD VDD 1 1  1)
                           #(nmos A Y  N2  GND 1 1 -1)
                           #(nmos B N2 GND GND 2 1 -2))
                          ())
    )

;;  ------------    Example : NOR2-cell     ---------------------------

;               ^ Vdd
;               |
;           | --+
;      B --o| |     pmos
;           | --+
;               |
;               |
;           | --+
;      A --o| |     pmos
;           | --+
;               |
;               *-------------------*---- Y
;               |                   |
;           | --+               | --+
;      A ---| |     nmos   B ---| |     nmos
;           | --+               | --+
;               |                   |
;              _|_ Gnd             _|_ Gnd

    (define NOR2-cell '#(NAND2 "a 2-input Not-AND (or NAND) gate"
                         (B A) (Y) ()
                         (#(pmos B N1 VDD VDD 2 1  2)
                          #(pmos A Z  N1  VDD 1 1  1)
                          #(nmos A Y  GND GND 1 1 -1)
                          #(nmos B Y  GND GND 1 2 -1))
                         ())
    )

;;  -------------------------------------------------------------------
;;                  CELL DATA STRUCTURE
;;  -------------------------------------------------------------------

;   define cell as vector:
;       +---------------+
;    #0 |  cell id      |               'INV
;       +---------------+
;    #1 |  cell text    |               "a Not (or Inverter) gate"
;       +---------------+
;    #2 |  cell inputs  |               '(A)
;       +---------------+
;    #3 |  cell outputs |               '(Y)
;       +---------------+
;    #4 |  cell clocks  |               '() ; for latches
;       +---------------+
;    #5 |  netlist      |               '(#(pmos A Y VDD VDD 1 1  1)
;       +---------------+                 #(nmos A Y GND GND 1 1 -1))
;    #6 |  additional   |               '() ; e.g. handover ASCII-Art
;       +---------------+

;   define constants for vector indices
    (define |cell-id#| 0)
    (define |cell-text#| 1)
    (define |cell-inputs#| 2)
    (define |cell-outputs#| 3)
    (define |cell-clocks#| 4)
    (define |cell-netlist#| 5)
    (define |cell-additional#| 6)

;;  ------------    getter function : cell-id   -----------------------

;   Contract:
;   cell-id : cell -> symbol

;   Purpose:
;   get the cell ID out of a cell description vector

;   Example:
;   (cell-id INV-cell) => 'INV

;   Definitions:
    (define cell-id
        (lambda (cell)
            (vector-ref cell |cell-id#|)
        )
    )

;   Test:   !! replace code by a portable SRFI test environemt
    (if build-in-self-test
        (begin
            (if (equal? (cell-id INV-cell) 'INV)
                (display "++ passed" (current-error-port))
                (display "-- failed" (current-error-port)))
            (display " cell-id test" (current-error-port))
            (newline (current-error-port))
        )
    )

;;  ------------    setter function : cell-id!  -----------------------

;   Contract:
;   cell-id! : cell symbol -> cell

;   Purpose:
;   set the cell ID in a cell description vector

;   Example:
;   (cell-id! INV-cell 'INV) => 'INV-cell

;   Definitions:
    (define cell-id!
        (lambda (cell id)
            (vector-set! cell |cell-id#| id)
        )
    )

;;  ------------    getter function : cell-text     -------------------

;   Contract:
;   cell-text : cell -> string

;   Purpose:
;   get the cell description out of a cell description vector

;   Example:
;   (cell-text INV-cell) => "a Not (or Inverter) gate"

;   Definition:
    (define cell-text
        (lambda (cell)
            (vector-ref cell |cell-text#|)
        )
    )

;   Test:   !! replace code by a portable SRFI test environemt
    (if build-in-self-test
        (begin
            (if (equal? (cell-text INV-cell) "a Not (or Inverter) gate")
                (display "++ passed" (current-error-port))
                (display "-- failed" (current-error-port)))
            (display " cell-text test" (current-error-port))
            (newline (current-error-port))
        )
    )

;;  ------------    setter function : cell-text!    -------------------

;   Contract:
;   cell-text! : cell string -> cell

;   Purpose:
;   set the cell description in a cell description vector

;   Example:
;   (cell-text! INV-cell "a Not (or Inverter) gate") => INV-cell

;   Definition:
    (define cell-text!
        (lambda (cell text)
            (vector-set! cell |cell-text#| text)
        )
    )

;;  ------------    getter function : cell-inputs   -------------------

;   Contract:
;   cell-inputs : cell -> list-of-symbols

;   Purpose:
;   get the cell input list out of a cell description vector

;   Example:
;   (cell-inputs INV-cell) => '(A)

;   Definition:
    (define cell-inputs
        (lambda (cell)
            (vector-ref cell |cell-inputs#|)
        )
    )

;   Test:   !! replace code by a portable SRFI test environemt
    (if build-in-self-test
        (begin
            (if (equal? (cell-inputs INV-cell) '(A))
                (display "++ passed" (current-error-port))
                (display "-- failed" (current-error-port)))
            (display " cell-inputs test" (current-error-port))
            (newline (current-error-port))
        )
    )

;;  ------------    setter function : cell-inputs!  -------------------

;   Contract:
;   cell-inputs! : cell list-of-symbols -> cell

;   Purpose:
;   set the cell input list in a cell description vector

;   Example:
;   (cell-inputs! INV-cell '(A)) => INV-cell

;   Definition:
    (define cell-inputs!
        (lambda (cell list-of-inputs)
            (vector-set! cell |cell-inputs#| list-of-inputs)
        )
    )

;;  ------------    getter function : cell-outputs  -------------------

;   Contract:
;   cell-outputs : cell -> list-of-symbols

;   Purpose:
;   get the cell output list out of a cell description vector

;   Example:
;   (cell-outputs INV-cell) => '(Y)

;   Definition:
    (define cell-outputs
        (lambda (cell)
            (vector-ref cell |cell-outputs#|)
        )
    )

;   Test:   !! replace code by a portable SRFI test environemt
    (if build-in-self-test
        (begin
            (if (equal? (cell-outputs INV-cell) '(Y))
                (display "++ passed" (current-error-port))
                (display "-- failed" (current-error-port)))
            (display " cell-outputs test" (current-error-port))
            (newline (current-error-port))
        )
    )

;;  ------------    setter function : cell-outputs! -------------------

;   Contract:
;   cell-outputs! : cell list-of-symbols -> cell

;   Purpose:
;   set the cell output list of a cell description vector

;   Example:
;   (cell-outputs! INV-cell '(Y)) => INV-cell

;   Definition:
    (define cell-outputs!
        (lambda (cell list-of-symbols)
            (vector-set! cell |cell-outputs#| list-of-symbols)
        )
    )

;;  ------------    getter function : cell-clocks   -------------------

;   Contract:
;   cell-clocks : cell -> list-of-symbols

;   Purpose:
;   get the cell clock list out of a cell description vector

;   Example:
;   (cell-clocks INV-cell) => '()

;   Definition:
    (define cell-clocks
        (lambda (cell)
            (vector-ref cell |cell-clocks#|)
        )
    )

;   Test:   !! replace code by a portable SRFI test environemt
    (if build-in-self-test
        (begin
            (if (equal? (cell-clocks INV-cell) '())
                (display "++ passed" (current-error-port))
                (display "-- failed" (current-error-port)))
            (display " cell-clocks test" (current-error-port))
            (newline (current-error-port))
        )
    )

;;  ------------    setter function : cell-clocks!  -------------------

;   Contract:
;   cell-clocks! : cell list-of-symbols -> cell

;   Purpose:
;   set the cell clock in a cell description vector

;   Example:
;   (cell-clocks! INV-cell '()) => INV-cell

;   Definition:
    (define cell-clocks!
        (lambda (cell list-of-symbols)
            (vector-set! cell |cell-clocks#| list-of-symbols)
        )
    )

;;  ------------    getter function : cell-netlist  -------------------

;   Contract:
;   cell-netlist : cell -> netlist

;   Purpose:
;   get the netlist out of a cell description vector

;   Example:
;   (cell-outputs INV-cell) => '(Y)

;   Definition:
    (define cell-netlist
        (lambda (cell)
            (vector-ref cell |cell-netlist#|)
        )
    )

;   Test:   !! replace code by a portable SRFI test environemt
    (if build-in-self-test
        (begin
            (if (equal? (cell-netlist INV-cell) '(#(pmos A Y VDD VDD 1 1  1)
                                                  #(nmos A Y GND GND 1 1 -1)))
                (display "++ passed" (current-error-port))
                (display "-- failed" (current-error-port)))
            (display " cell-netlist test" (current-error-port))
            (newline (current-error-port))
        )
    )

;;  ------------    setter function : cell-netlist!     ---------------

;   Contract:
;   cell-netlist! : cell netlist -> cell

;   Purpose:
;   set the netlist in a cell description vector

;   Example:
;   (cell-outputs! INV-cell '(Y)) => INV-cell

;   Definition:
    (define cell-netlist!
        (lambda (cell netlist)
            (vector-set! cell |cell-netlist#| netlist)
        )
    )

;;  ------------    getter function : cell-additional   ---------------

;   Contract:
;   cell-additional : cell -> list-of-string

;   Purpose:
;   get additional informations for the cell out of a cell description vector

;   Example:
;   (cell-additional INV-cell) => '()

;   Definition:
    (define cell-additional
        (lambda (cell)
            (vector-ref cell |cell-additional#|)
        )
    )

;   Test:   !! replace code by a portable SRFI test environemt
    (if build-in-self-test
        (begin
            (if (equal? (cell-additional INV-cell) '())
                (display "++ passed" (current-error-port))
                (display "-- failed" (current-error-port)))
            (display " cell-additional test" (current-error-port))
            (newline (current-error-port))
        )
    )

;;  ------------    setter function : cell-additional!  ---------------

;   Contract:
;   cell-additional! : cell list-of-string -> cell

;   Purpose:
;   set additional informations in a cell description vector

;   Example:
;   (cell-additional! INV-cell '()) => INV-cell

;   Definition:
    (define cell-additional!
        (lambda (cell list-of-symbols)
            (vector-set! cell |cell-additional#| list-of-symbols)
        )
    )

;;  -------------------------------------------------------------------
;;                  TRANSISTOR DATA STRUCTURE
;;  -------------------------------------------------------------------

;   define transistor as vector:        Example:
;       +---------------+
;    #0 |  circuit type |               'nmos
;       +---------------+
;    #1 |  gate node    |               'A
;       +---------------+
;    #2 |  drain node   |               'X
;       +---------------+
;    #3 |  source node  |               'VDD
;       +---------------+
;    #4 |  bulk node    |               'VDD
;       +---------------+
;    #5 |  stucked      |               1
;       +---------------+
;    #6 |  x-axis point |               1
;       +---------------+
;    #7 |  y-axis point |               1
;       +---------------+

;   define constants for vector indices
    (define |circuit-type#| 0)
    (define |gate-node#| 1)
    (define |drain-node#| 2)
    (define |source-node#| 3)
    (define |bulk-node#| 4)
    (define |stucked#| 5)
    (define |xaxis-point#| 6)
    (define |yaxis-point#| 7)

;;  ------------    getter function : mosfet-type   -------------------

;   Contract:
;   mosfet-type : mosfet -> node

;   Purpose:
;   get the mosfet type out of mosfet transistor vector

;   Example:
;   (mosfet-type '#(nmos A Y VDD substrate 1 1 -1)) => 'nmos

;   Definition:
    (define mosfet-type
        (lambda (transistor)
            (vector-ref transistor |circuit-type#|)
        )
    )

;   Test:   !! replace code by a portable SRFI test environemt
    (if build-in-self-test
        (begin
            (if (equal? (mosfet-type '#(nmos A Y VDD substrate 1 1 -1)) 'nmos)
                (display "++ passed" (current-error-port))
                (display "-- failed" (current-error-port)))
            (display " mosfet-type test" (current-error-port))
            (newline (current-error-port))
        )
    )

;;  ------------    getter function : mosfet-nmos?  -------------------

;   Contract:
;   mosfet-nmos? : mosfet -> boolean

;   Purpose:
;   check the mosfet type out of mosfet transistor vector

;   Example:
;   (mosfet-nmos? '#(nmos A Y VDD substrate 1 1 -1)) => #t

;   Definition:
    (define mosfet-nmos?
        (lambda (transistor)
            (equal? (vector-ref transistor |circuit-type#|) 'nmos)
        )
    )

;   Test:   !! replace code by a portable SRFI test environemt
    (if build-in-self-test
        (begin
            (if (mosfet-nmos? '#(nmos A Y VDD substrate 1 1 -1))
                (display "++ passed" (current-error-port))
                (display "-- failed" (current-error-port)))
            (display " mosfet-nmos? test" (current-error-port))
            (newline (current-error-port))
        )
    )

;;  ------------    getter function : mosfet-pmos?  -------------------

;   Contract:
;   mosfet-pmos? : mosfet -> boolean

;   Purpose:
;   check the mosfet type out of mosfet transistor vector

;   Example:
;   (mosfet-pmos? '#(pmos A Y VDD substrate 1 1 -1)) => #t

;   Definition:
    (define mosfet-pmos?
        (lambda (transistor)
            (equal? (vector-ref transistor |circuit-type#|) 'pmos)
        )
    )

;   Test:   !! replace code by a portable SRFI test environemt
    (if build-in-self-test
        (begin
            (if (mosfet-pmos? '#(pmos A Y GND substrate 1 1 1))
                (display "++ passed" (current-error-port))
                (display "-- failed" (current-error-port)))
            (display " mosfet-pmos? test" (current-error-port))
            (newline (current-error-port))
        )
    )

;;  ------------    getter function : mosfet-gate   -------------------

;   Contract:
;   mosfet-gate : mosfet -> node

;   Purpose:
;   get the mosfet gate node out of mosfet transistor vector

;   Example:
;   (mosfet-gate '#(nmos A Y VDD substrate 1 1 -1)) => 'A

;   Definition:
    (define mosfet-gate
        (lambda (transistor)
            (vector-ref transistor |gate-node#|)
        )
    )

;   Test:   !! replace code by a portable SRFI test environemt
    (if build-in-self-test
        (begin
            (if (equal? (mosfet-gate '#(nmos A Y VDD substrate 1 1 -1)) 'A)
                (display "++ passed" (current-error-port))
                (display "-- failed" (current-error-port)))
            (display " mosfet-gate test" (current-error-port))
            (newline (current-error-port))
        )
    )

;;  ------------    getter function : mosfet-drain  -------------------

;   Contract:
;   mosfet-drain : mosfet -> node

;   Purpose:
;   get the mosfet drain node out of mosfet transistor vector

;   Example:
;   (mosfet-drain '#(nmos A Y VDD substrate 1 1 -1)) => 'X

;   Definition:
    (define mosfet-drain
        (lambda (transistor)
            (vector-ref transistor |drain-node#|)
        )
    )

;   Test:   !! replace code by a portable SRFI test environemt
    (if build-in-self-test
        (begin
            (if (equal? (mosfet-drain '#(nmos A Y VDD substrate 1 1 -1)) 'Y)
                (display "++ passed" (current-error-port))
                (display "-- failed" (current-error-port)))
            (display " mosfet-drain test" (current-error-port))
            (newline (current-error-port))
        )
    )

;;  ------------    getter function : mosfet-source -------------------

;   Contract:
;   mosfet-source : mosfet -> node

;   Purpose:
;   get the mosfet source node out of mosfet transistor vector

;   Example:
;   (mosfet-source '#(nmos A Y VDD substrate 1 1 -1)) => 'VDD

;   Definition:
    (define mosfet-source
        (lambda (transistor)
            (vector-ref transistor |source-node#|)
        )
    )

;   Test:   !! replace code by a portable SRFI test environemt
    (if build-in-self-test
        (begin
            (if (equal? (mosfet-source '#(nmos A Y VDD substrate 1 1 -1)) 'VDD)
                (display "++ passed" (current-error-port))
                (display "-- failed" (current-error-port)))
            (display " mosfet-source test" (current-error-port))
            (newline (current-error-port))
        )
    )

;;  ------------    getter function : mosfet-bulk   -------------------

;   Contract:
;   mosfet-bulk : mosfet -> node

;   Purpose:
;   get the mosfet bulk node out of mosfet transistor vector

;   Example:
;   (mosfet-bulk '#(nmos A Y VDD substrate 1 1 -1)) => substrate

;   Definition:
    (define mosfet-bulk
        (lambda (transistor)
            (vector-ref transistor |bulk-node#|)
        )
    )

;   Test:   !! replace code by a portable SRFI test environemt
    (if build-in-self-test
        (begin
            (if (equal? (mosfet-bulk '#(nmos A Y VDD substrate 1 1 -1)) 'substrate)
                (display "++ passed" (current-error-port))
                (display "-- failed" (current-error-port)))
            (display " mosfet-bulk test" (current-error-port))
            (newline (current-error-port))
        )
    )

;;  ------------    getter function : mosfet-xaxis  -------------------

;   Contract:
;   mosfet-xaxis : mosfet -> number

;   Purpose:
;   get the mosfet x-axis coordinate out of mosfet transistor vector

;   Example:
;   (mosfet-xaxis '#(nmos A Y VDD substrate 1 1 -1)) => 1

;   Definition:
    (define mosfet-xaxis
        (lambda (transistor)
            (vector-ref transistor |xaxis-point#|)
        )
    )

;   Test:   !! replace code by a portable SRFI test environemt
    (if build-in-self-test
        (begin
            (if (equal? (mosfet-xaxis '#(nmos A Y VDD substrate 1 1 -1)) 1)
                (display "++ passed" (current-error-port))
                (display "-- failed" (current-error-port)))
            (display " mosfet-xaxis test" (current-error-port))
            (newline (current-error-port))
        )
    )

;;  ------------    getter function : mosfet-yaxis  -------------------

;   Contract:
;   mosfet-yaxis : mosfet -> number

;   Purpose:
;   get the mosfet y-axis coordinate out of mosfet transistor vector

;   Example:
;   (mosfet-yaxis '#(nmos A Y VDD substrate 1 1 -1)) => 1

;   Definition:
    (define mosfet-yaxis
        (lambda (transistor)
            (vector-ref transistor |yaxis-point#|)
        )
    )

;   Test:   !! replace code by a portable SRFI test environemt
    (if build-in-self-test
        (begin
            (if (equal? (mosfet-yaxis '#(nmos A Y VDD substrate 1 1 -1)) -1)
                (display "++ passed" (current-error-port))
                (display "-- failed" (current-error-port)))
            (display " mosfet-yaxis test" (current-error-port))
            (newline (current-error-port))
        )
    )

;;  -------------------------------------------------------------------
;;                  NODE SPACES
;;  -------------------------------------------------------------------

;;  ------------    input node names    -------------------------------

    (define input-space '(A B C D E F G H I L M P R S T U V W))

;   Contract:
;   input-space? : list-of-ports -> boolean

;   Purpose:
;   check whether node is in defined input space for cells

;   Example:
;   (input-space? 'A) => #t
;   (input-space? 'Z) => #f

;   Definition:
    (define input-space?
        (lambda (node)
            (if (memq node input-space) #t #f)
        )
    )

;   Test:   !! replace code by a portable SRFI test environemt
    (if build-in-self-test
        (begin
            (if (and (input-space? 'A) (not (input-space? 'Z)))
                (display "++ passed" (current-error-port))
                (display "-- failed" (current-error-port)))
            (display " input-space? test" (current-error-port))
            (newline (current-error-port))
        )
    )

;;  ------------    output node names   -------------------------------

    (define output-space '(Q Y Z))

;   Contract:
;   output-space? list-of-ports -> boolean

;   Purpose:
;   check wether node is in defined output space for cells

;   Example:
;   (output-space? 'A) => #f
;   (output-space? 'Z) => #t

;   Definition:
    (define output-space?
        (lambda (node)
            (if (memq node output-space) #t #f)
        )
    )

;   Test:   !! replace code by a portable SRFI test environemt
    (if build-in-self-test
        (begin
            (if (and (output-space? 'Z) (not (output-space? 'A)))
                (display "++ passed" (current-error-port))
                (display "-- failed" (current-error-port)))
            (display " output-space? test" (current-error-port))
            (newline (current-error-port))
        )
    )

;;  ------------    clock node names    -------------------------------

    (define clock-space '(X))

;   Contract:
;   clock-space? list-of-ports -> boolean

;   Purpose:
;   check wether node is in defined clock space for cells

;   Example:
;   (clock-space? 'X) => #t

;   Definition:
    (define clock-space?
        (lambda (node)
            (if (memq node clock-space) #t #f)
        )
    )

;   Test:   !! replace code by a portable SRFI test environemt
    (if build-in-self-test
        (begin
            (if (clock-space? 'X)
                (display "++ passed" (current-error-port))
                (display "-- failed" (current-error-port)))
            (display " clock-space? test" (current-error-port))
            (newline (current-error-port))
        )
    )

;;  ------------    internal node names -------------------------------

    (define node-space '(N))

;   Contract:
;   node-space? list-of-nodes -> boolean

;   Purpose:
;   check wether node is in defined node space for cells

;   Example:
;   (node-space? 'N) => #t

;   Definition:
    (define node-space?
        (lambda (node)
            (if (memq node node-space) #t #f)
        )
    )

;   Test:   !! replace code by a portable SRFI test environemt
    (if build-in-self-test
        (begin
            (if (node-space? 'N)
                (display "++ passed" (current-error-port))
                (display "-- failed" (current-error-port)))
            (display " node-space? test" (current-error-port))
            (newline (current-error-port))
        )
    )

;;  ------------    supply symbol node name space   -------------------

;   Usually, SCHEME is case-insensitive but some implementations (and R7RS) are not.
;   Hence, the list of symbols contains common low-case / upper-case variations.

;   Definition:
    (define supply-symbol-space '(vcc vdd Vcc Vdd VCC VDD))

;   Contract:
;   sypply-symbol-space? list-of-ports -> boolean

;   Purpose:
;   check wether node is in defined list for sypply symbols

;   Example:
;   (supply-symbol-space? 'Vdd) => #t
;   (supply-symbol-space? 'gnd) => #f

;   Definition:
    (define supply-symbol-space?
        (lambda (node)
            (if (memq node supply-symbol-space) #t #f)
        )
    )

;   Test:   !! replace code by a portable SRFI test environemt
    (if build-in-self-test
        (begin
            (if (and (supply-symbol-space? 'Vdd) (not (supply-symbol-space? 'gnd)))
                (display "++ passed" (current-error-port))
                (display "-- failed" (current-error-port)))
            (display " supply-symbol-space? test" (current-error-port))
            (newline (current-error-port))
        )
    )

;;  ------------    ground plane node name space    -------------------

;   Usually, SCHEME is case-insensitive but some implementations are not.
;   Hence, the list of symbols contains common low-case / upper-case variations.

;   Definition:
    (define ground-symbol-space '(gnd vss Gnd Vss GND VSS))

;   Contract:
;   ground-symbol-space? list-of-ports -> boolean

;   Purpose:
;   check wether node is in defined list for ground symbols

;   Example:
;   (ground-symbol-space? 'Vdd) => #t
;   (ground-symbol-space? 'gnd) => #f

;   Definition:
    (define ground-symbol-space?
        (lambda (node)
            (if (memq node ground-symbol-space) #t #f)
        )
    )

;   Test:   !! replace code by a portable SRFI test environemt
    (if build-in-self-test
        (begin
            (if (and (ground-symbol-space? 'Gnd) (not (ground-symbol-space? 'vdd)))
                (display "++ passed" (current-error-port))
                (display "-- failed" (current-error-port)))
            (display " ground-symbol-space? test" (current-error-port))
            (newline (current-error-port))
        )
    )

;;  -------------------------------------------------------------------
;;                  FUNCTIONS on NETLISTs
;;  -------------------------------------------------------------------

;;  ------------    filter network for pull-up      -------------------

;   Contract:
;   get-pullup-network : netlist -> netlist

;   Purpose:
;   get network with pull-up transistors only

;   Example:
;   (get-pullup-network (cell-netlist INV-cell)) => #('pmos 'A 'Y 'VDD 'VDD 1 1 1)

;   Note:
;   Implementation with (map) or (filter) are better?

;   Definition:
    (define get-pullup-network
        (lambda (netlist)
            (cond
                ; empty list?
                [(null? netlist) netlist]

                ; if pMOS than add mosfet to netlist, go down recursive
                [(mosfet-pmos? (car netlist))
                    (cons (car netlist) (get-pullup-network (cdr netlist)))]

                ; just go down
                [else (get-pullup-network (cdr netlist))]
            )
        )
    )

;   Test:   !! replace code by a portable SRFI test environemt
    (if build-in-self-test
        (begin
            (if (equal? (get-pullup-network (cell-netlist INV-cell)) '(#(pmos A Y VDD VDD 1 1 1)))
                (display "++ passed" (current-error-port))
                (display "-- failed" (current-error-port)))
            (display " get-pullup-network test" (current-error-port))
            (newline (current-error-port))
        )
    )

;;  ------------    filter network for pull-down    -------------------

;   Contract:
;   get-pulldown-network : netlist -> netlist

;   Purpose:
;   get network with pull-down transistors only

;   Example:
;   (get-pulldown-network (cell-netlist INV-cell)) => #('nmos 'A 'Y 'GND 'GND 1 1 -1)

;   Note:
;   Implementation with (map) or (filter) are better?

;   Definition:
    (define get-pulldown-network
        (lambda (netlist)
            (cond
                ; empty list?
                [(null? netlist) netlist]

                ; if nMOS than add mosfet to netlist, go down recursive
                [(mosfet-nmos? (car netlist))
                    (cons (car netlist) (get-pulldown-network (cdr netlist)))]

                ; just go down
                [else (get-pulldown-network (cdr netlist))]
            )
        )
    )

;   Test:   !! replace code by a portable SRFI test environemt
    (if build-in-self-test
        (begin
            (if (equal? (get-pulldown-network (cell-netlist INV-cell)) '(#(nmos A Y GND GND 1 1 -1)))
                (display "++ passed" (current-error-port))
                (display "-- failed" (current-error-port)))
            (display " get-pulldown-network test" (current-error-port))
            (newline (current-error-port))
        )
    )

;;  ------------    filter for VDD connected transistors    -----------

;   Contract:
;   get-vdd-mosfets : netlist -> netlist

;   Purpose:
;   get all transistors which are connected to VDD

;   Example:
;   (get-vdd-mosfets (cell-netlist INV-cell)) => #('pmos 'A 'Y 'VDD 'VDD 1 1 1)

;   Note:
;   Implementation with (map) or (filter) are better?

;   Definition:
    (define get-vdd-mosfets
        (lambda (netlist)
            (cond
                ; empty list?
                [(null? netlist) netlist]

                ; if mosfet connected to supply power symbol, add them to netlist and go down recursive
                [(supply-symbol-space? (mosfet-source (car netlist)))
                    (cons (car netlist) (get-vdd-mosfets (cdr netlist)))]

                ; just go down
                [else (get-vdd-mosfets (cdr netlist))]
            )
        )
    )

;   Test:   !! replace code by a portable SRFI test environemt
    (if build-in-self-test
        (begin
            (if (equal? (get-vdd-mosfets (cell-netlist INV-cell)) '(#(pmos A Y VDD VDD 1 1 1)))
                (display "++ passed" (current-error-port))
                (display "-- failed" (current-error-port)))
            (display " get-vdd-mosfets test" (current-error-port))
            (newline (current-error-port))
        )
    )

;;  ------------    filter for GND connected transistors    -----------

;   Contract:
;   get-gnd-mosfets : netlist -> netlist

;   Purpose:
;   get all transistors which are connected to GND

;   Example:
;   (get-gnd-mosfets (cell-netlist INV-cell)) => #('nmos 'A 'Y 'GND 'GND 1 1 -1)

;   Note:
;   Implementation with (map) or (filter) are better?

;   Definition:
    (define get-gnd-mosfets
        (lambda (netlist)
            (cond
                ; empty list?
                [(null? netlist) netlist]

                ; if mosfet connected to ground plane symbol, add them to netlist and go down recursive
                [(ground-symbol-space? (mosfet-source (car netlist)))
                    (cons (car netlist) (get-gnd-mosfets (cdr netlist)))]

                ; just go down
                [else (get-gnd-mosfets (cdr netlist))]
            )
        )
    )

;   Test:   !! replace code by a portable SRFI test environemt
    (if build-in-self-test
        (begin
            (if (equal? (get-gnd-mosfets (cell-netlist INV-cell)) '(#(nmos A Y GND GND 1 1 -1)))
                (display "++ passed" (current-error-port))
                (display "-- failed" (current-error-port)))
            (display " get-gnd-mosfets test" (current-error-port))
            (newline (current-error-port))
        )
    )

;;  ------------    filter for node connected transistors   -----------

;   Contract:
;   get-node-mosfets : netlist node -> netlist

;   Purpose:
;   get all transistors which are connected to this node

;   Example:
;   (get-node-mosfets (cell-netlist INV-cell) 'Y) => #('nmos 'A 'Y 'GND 'GND 1 1 -1)

;   Definition:
    (define get-node-mosfets
        (lambda (netlist node)
            (cond
                ; empty list?
                [(null? netlist) netlist]

                ; if mosfet connected to node, add them to netlist and go down recursive
                ; on source pins ..
                [(equal? (mosfet-source (car netlist)) node)
                    (cons (car netlist) (get-node-mosfets (cdr netlist) node))]

                ; .. and drain pins
                [(equal? (mosfet-drain  (car netlist)) node)
                    (cons (car netlist) (get-node-mosfets (cdr netlist) node))]

                ; just go down
                [else (get-node-mosfets (cdr netlist) node)]
            )
        )
    )

;   Test:   !! replace code by a portable SRFI test environemt
    (if build-in-self-test
        (begin
            (if (equal? (get-node-mosfets (cell-netlist INV-cell) 'Y) (cell-netlist INV-cell))
                (display "++ passed" (current-error-port))
                (display "-- failed" (current-error-port)))
            (display " get-node-mosfets test" (current-error-port))
            (newline (current-error-port))
        )
    )

;;  ------------    sort mosfets ascending  ---------------------------

;   Contract:
;   sort-mosfets-ascending : netlist -> netlist

;   Purpose:
;   sort all transistors regarding their names

;   Example:
;   (sort-mosfets-ascending (cell-netlist INV-cell)) => (cell-netlist INV-cell)

;   Definition:
    (define sort-mosfet-ascending
        (lambda (netlist)
            netlist ; !!
        )
    )

;   Test:   !! replace code by a portable SRFI test environemt
    (if build-in-self-test
        (begin
            (if (equal? (sort-mosfet-ascending (cell-netlist INV-cell)) (cell-netlist INV-cell))
                (display "++ passed" (current-error-port))
                (display "-- failed" (current-error-port)))
            (display " sort-mosfet-ascending test" (current-error-port))
            (newline (current-error-port))
        )
    )

;;  -------------------------------------------------------------------
;;                  AUXILARY STUFF
;;  -------------------------------------------------------------------

;;  ------------    calculate (c) Copyleft year -----------------------

;   Contract:
;   copyleft-year : -> number

;   Purpose:
;   use current epoche time to calculate the year inside Copyleft lines

;   Example:
;   (copyleft-year) => 2019

;   Definition:
    (define second 1)
    (define minute (* 60 second))
    (define hour (* 60 minute))
    (define day (* 24 hour))
    (define calendar-year (* 365 day))
    (define copyleft-year
        (lambda ()
            (let ((tropical-year (+ calendar-year (* 5 hour) (* 48 minute) (* 45 second)))) ; !!
                ; This is estimated! There is a delta around new-year regarding leap years.
                ; Do you like to use Popcorn around New Year? Really??
                (+ 1970 (exact (floor (/ (current-second) tropical-year))))
            )
        )
    )

;   Test:   !! replace code by a portable SRFI test environemt
    (if build-in-self-test
        (begin
            (if (> (copyleft-year) 2018)
                (display "++ passed" (current-error-port))
                (display "-- failed" (current-error-port)))
            (display " copyleft-year test" (current-error-port))
            (newline (current-error-port))
        )
    )

;;  ------------    list of strings into comma-separated values -------

;   Contract:
;   stringlist->csv : list-of-strings -> string

;   Purpose:
;   transfer a list of strings into a string with comma-seperated values

;   Example
;   (stringlist->csv ("A" "B" "C")) => "A, B, C"

;   Definition:
    (define stringlist->csv
        (lambda (string-list)
            (if (equal? (cdr string-list) ())
                (car string-list)   ; last value in list
                (string-append (car string-list) ", " (stringlist->csv (cdr string-list)))
            )
        )
    )

;   Test:   !! replace code by a portable SRFI test environemt
    (if build-in-self-test
        (begin
            (if (equal? (stringlist->csv '("C2" "B1" "A0")) "C2, B1, A0")
                (display "++ passed" (current-error-port))
                (display "-- failed" (current-error-port)))
            (display " stringlist->csv test" (current-error-port))
            (newline (current-error-port))
        )
    )

;;  ------------    list of strings into list of symbols    -----------

;   Contract:
;   stringlist->symbollist : list-of-strings -> list-of-symbols

;   Purpose:
;   convert list of strings (e.g. ports) into list of symbols

;   Example:
;   (stringlist->symbollist ("C" "B" "A") => ('C 'B 'A)

;   Definition:
    (define stringlist->symbollist
        (lambda (string-list)
            (map string->symbol string-list)
        )
    )

;   Test:   !! replace code by a portable SRFI test environemt
    (if build-in-self-test
        (begin
            (if (equal? (stringlist->symbollist (list "C2" "B1" "A0")) '(C2 B1 A0))
                (display "++ passed" (current-error-port))
                (display "-- failed" (current-error-port)))
            (display " stringlist->symbollist test" (current-error-port))
            (newline (current-error-port))
        )
    )

;;  ------------    list of symbols into list of strings    -----------

;   Contract:
;   symbollist->stringlist : list-of-symbols -> list-of-strings

;   Purpose:
;   convert list of symbols (e.g. ports) into list of strings

;   Example:
;   (symbollist->stringlist '(C B A) => ("C" "B" "A")

;   Definition:
    (define symbollist->stringlist
        (lambda (symbol-list)
            (map symbol->string symbol-list)
        )
    )

;   Test:   !! replace code by a portable SRFI test environemt
    (if build-in-self-test
        (begin
            (if (equal? (symbollist->stringlist '(C2 B1 A0)) (list "C2" "B1" "A0"))
                (display "++ passed" (current-error-port))
                (display "-- failed" (current-error-port)))
            (display " symbollist->stringlist test" (current-error-port))
            (newline (current-error-port))
        )
    )

;;  ===================================================================
;;                  END OF R7RS LIBRARY
;;  ===================================================================
  )
)
