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
;;                  NODE SPACES
;;  -------------------------------------------------------------------

;;  ------------    combinatorial inputs    ---------------------------

;   Purpose:
;   define input node names which are used for combinatorial cells

;   Definition:
    (define input-space '(A B C D E F G H I L M N P U V W))

;;  ------------    output node names   -------------------------------

;   Purpose:
;   defeine output node names which are used for combinatorial cells

;   Definition:
    (define output-space '(X Y Z))

;;  ------------    supply symbol node name space   -------------------

;   Purpose:
;   define valid supply symbol names which are used for all cells

;   Usually, SCHEME is case-insensitive but some implementations are not.
;   Hence, the list of symbols contains common low-case / upper-case variations.

;   Definition:
    (define supply-symbol-space '(vcc vdd Vcc Vdd VCC VDD))

;;  ------------    ground plane node name space    -------------------

;   Purpose:
;   define valid ground plane symbols which are used for all cells

;   Usually, SCHEME is case-insensitive but some implementations are not.
;   Hence, the list of symbols contains common low-case / upper-case variations.

;   Definition:
    (define ground-symbol-space '(gnd vss Gnd Vss GND VSS))

;;  -------------------------------------------------------------------
;;                  TRANSISTOR DATA STRUCTURE
;;  -------------------------------------------------------------------

;   define transistor as vector:
;   +-------+-------+-------+-------+-------+-------+-------+
;   | mosfet| gate  | drain | source| bulk  | x-axis| y-axis|
;   | type  | node  | node  | node  | node  | point | point |
;   +-------+-------+-------+-------+-------+-------+-------+
;      #0      #1      #2      #3      #4      #5      #6

;   Example:
;   #('nmos 'A 'X 'VDD 'VDD 1 1 1)

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
            (equal? (vector-ref transistor 0) 'nmos)
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
            (equal? (vector-ref transistor 0) 'pmos)
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
            (vector-ref transistor 1)
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
            (vector-ref transistor 2)
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
            (vector-ref transistor 3)
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
            (vector-ref transistor 4)
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

;;  ------------    getter function : mosfet-stacked    ---------------

;   Contract:
;   mosfet-stacked : mosfet -> number

;   Purpose:
;   get the order of stacked transistor for this transistor

;   Example:
;   (mosfet-stacked '#(nmos A Y VDD substrate 1 1 -1)) => 1

;   Definition:
    (define mosfet-stacked
        (lambda (transistor)
            (vector-ref transistor 5)
        )
    )

;   Test:   !! replace code by a portable SRFI test environemt
    (if build-in-self-test
        (begin
            (if (equal? (mosfet-stacked '#(nmos A Y VDD substrate 1 1 -1)) 1)
                (display "++ passed" (current-error-port))
                (display "-- failed" (current-error-port)))
            (display " mosfet-stacked test" (current-error-port))
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
            (vector-ref transistor 6)
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
            (vector-ref transistor 7)
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
;;                  FUNCTIONS on NETLISTs
;;  -------------------------------------------------------------------

;;  ------------    filter network for pull-up      -------------------

;   Contract:
;   get-pullup-network : netlist -> netlist

;   Purpose:
;   get network with pull-up transistors only

;   Example:
;   (get-pullup-network INV) => #('pmos 'A 'X 'VDD 'VDD 1 1 1)

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
            (if (equal? (get-pullup-network INV) '(#(pmos A Y VDD VDD 1 1 1)))
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
;   (get-pulldown-network INV) => #('nmos 'A 'X 'GND 'GND 1 1 -1)

;   Definition:
    (define get-pulldown-network
        (lambda (netlist)
            (cond
                ; emtpy list?
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
            (if (equal? (get-pulldown-network INV) '(#(nmos A Y GND GND 1 1 -1)))
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
;   (get-vdd-mosfets INV) => #('pmos 'A 'X 'VDD 'VDD 1 1 1)

;   Definition:
    (define get-vdd-mosfets
        (lambda (netlist)
            (cond
                ; emtpy list?
                [(null? netlist) netlist]

                ; if mosfet connected to supply power symbol, add them to netlist and go down recursive
                [(memq (mosfet-source (car netlist)) supply-symbol-space)
                    (cons (car netlist) (get-vdd-mosfets (cdr netlist)))]

                ; just go down
                [else (get-vdd-mosfets (cdr netlist))]
            )
        )
    )

;   Test:   !! replace code by a portable SRFI test environemt
    (if build-in-self-test
        (begin
            (if (equal? (get-vdd-mosfets INV) '(#(pmos A Y VDD VDD 1 1 1)))
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
;   (get-gnd-mosfets INV) => #('nmos 'A 'X 'GND 'GND 1 1 -1)

;   Definition:
    (define get-gnd-mosfets
        (lambda (netlist)
            (cond
                ; empty list?
                [(null? netlist) netlist]

                ; if mosfet connected to ground plane symbol, add them to netlist and go down recursive
                [(memq (mosfet-source (car netlist)) ground-symbol-space)
                    (cons (car netlist) (get-gnd-mosfets (cdr netlist)))]

                ; just go down
                [else (get-gnd-mosfets (cdr netlist))]
            )
        )
    )

;   Test:   !! replace code by a portable SRFI test environemt
    (if build-in-self-test
        (begin
            (if (equal? (get-gnd-mosfets INV) '(#(nmos A Y GND GND 1 1 -1)))
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
;   (get-node-mosfets INV 'Y) => #('nmos 'A 'Y 'GND 'GND 1 1 -1)

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
            (if (equal? (get-node-mosfets INV 'Y) INV)
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
;   (sort-mosfets-ascending INV) => INV

;   Definition:
    (define sort-mosfet-ascending
        (lambda (netlist)
            netlist ; !!
        )
    )

;   Test:   !! replace code by a portable SRFI test environemt
    (if build-in-self-test
        (begin
            (if (equal? (sort-mosfet-ascending INV) INV)
                (display "++ passed" (current-error-port))
                (display "-- failed" (current-error-port)))
            (display " sort-mosfet-ascending test" (current-error-port))
            (newline (current-error-port))
        )
    )
