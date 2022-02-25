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
;;  File:           StdCellLib/Tools/exporter/circdia.scm
;;
;;  Purpose:        Scheme Module - export schematic based on Circdia LaTeX
;;
;;  ************    Revised^7 Report on Scheme (R7RS)   ***************
;;
;;  ///////////////////////////////////////////////////////////////////
;;
;;  Copyright (c)   2021 by
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

(define-library (exporter circdia)
  (import (scheme base)
          (srfi 78)         ; test suite
          (common lib)
          (common cell)
          (exporter generic)
) (export ; exporter
          exporter:schematic-circdia
) (begin

;;  ------------    srfi-78 test suite  -------------------------------

    ; change this switch during development only
    ; mode must be a symbol in '(off summary report-failed report)
    (check-set-mode! 'report) ;(check-set-mode! 'off)

;;  -------------------------------------------------------------------
;;                  BASICS
;;  -------------------------------------------------------------------

    ; place circuits on a grid, every circuit takes a piece of space

    ; ^ yabs
    ; |
    ; | +-------+-------+-------+
    ; | | pmos  | pmos  | pmos  |
    ; | |   @   |   @   |   @   |
    ; | | (1;1) | (2;1) | (3;1) |
    ; | +-------+-------+-------+
    ; | ========================= ymid
    ; | +-------+-------+-------+   ---
    ; | | nmos  | nmos  | nmos  |    ^
    ; | |   @   |   @   |   @   |    | grid
    ; | | (1;-1)| (2;-1)| (3;-1)|    v
    ; | +-------+-------+-------+   ---
    ; +----------------------------> xabs

    ; |<----->|
    ;   grid

;;  ------------    local defines   -----------------------------------

    (define grid 9)
    (define xgrid (+ grid 2))
    (define ygrid (- grid 2))

;;  -------------------------------------------------------------------
;;                  HELPER FUNCTIONS
;;  -------------------------------------------------------------------

;;  ------------    schematic size  -----------------------------------

    (define (xsize cell)
        "Calculate absolut value for schematic size along x-axis.
        Returns integer"
        0)

    (define (ysize cell)
        "Calculate absolut value for schematic size along y-axis.
        Returns integer"
        0)

;;  -------------------------------------------------------------------
;;                  CIRCUITS
;;  -------------------------------------------------------------------

;;  ------------    power   -------------------------------------------

    (define (circuit-supply xpos ypos)
        "Generates LaTeX for one power supply symbol.
        Returns list for (map display (list ..))"
        (list
            "\n    \\power{" (+ (* xpos xgrid) 2) "}{" (+ (* ypos ygrid) 1) "}{U}{}"))

;;  ------------    ground  -------------------------------------------

    (define (circuit-ground xpos ypos)
        "Generates LaTeX for one ground symbol.
        Returns list for (map display (list ..))"
        (list
            "\n    \\ground{" (+ (* xpos xgrid) 2) "}{" (- (* ypos ygrid) 1) "}{D}"))

;;  ------------    output  -------------------------------------------

    (define (circuit-output xpos note)
        "Generates LaTeX for one output pin.
        Returns list for (map display (list ..))"
        (list
            "\n    \\pin{" (+ (* xpos xgrid) 4) "}{0}{R}{" note "}"))

;;  ------------    nmos    -------------------------------------------

    (define (circuit-nmos xpos ypos size gate)
        "Generates LaTeX for one nMOS transistor.
        Returns list for (map display (list ..))"
        (list
            "\n    \\pin{" (- (* xpos xgrid) 4) "}{" (+ (* ypos ygrid) 2) "}{L}{" gate "}"
            "\n    \\trans[\\wireUD{1}]{nenh*}{" (* xpos xgrid) "}{" (+ (* ypos ygrid) (/ ygrid 2)) "}{R}{" size "}{}"))

;;  ------------    pmos    -------------------------------------------

    (define (circuit-pmos xpos ypos size gate)
        "Generates LaTeX for one pMOS transistor.
        Returns list for (map display (list ..))"
        (list
            "\n    \\pin{" (- (* xpos xgrid) 4) "}{" (- (* ypos ygrid) 2) "}{L}{" gate "}"
            "\n    \\trans[\\wireUD{1}]{penh*}{" (* xpos xgrid) "}{" (- (* ypos ygrid) (/ ygrid 2)) "}{R}{}{ " size "}"))

;;  -------------------------------------------------------------------
;;                  MAIN
;;  -------------------------------------------------------------------

    (define (parse-netlist netlist)
        "Parse the netlist and collect circuit outlines
        Returns list for (map display (list ..))"
        (if (null? netlist)
            ""
            (let* ([circuit (car netlist)]
                   [gate (gate circuit)]
                   [size (size circuit)]
                   [x-axis (x-axis (place circuit))]
                   [y-axis (y-axis (place circuit))])
                (list
                    ; check for mosfets
                    (if (pmos? circuit) (circuit-pmos x-axis y-axis size gate) "")
                    (if (nmos? circuit) (circuit-nmos x-axis y-axis size gate) "")
                    ; check for power and ground
                    (if (grounded? circuit) (circuit-ground x-axis y-axis) "")
                    (if (powered?  circuit) (circuit-supply x-axis y-axis) "")
                    ; check next circuit recursive
                    (parse-netlist (cdr netlist))))))

;;  ------------    circuitdiagram  -----------------------------------

    (define (circuitdiagram cell)
        "Generates circuitdiagram frame.
        Returns list for (map display (list ..))"
        (let* ([current-netlist (netlist cell)])
            (list
                "\n\\begin{circuitdiagram}{" (xsize cell) "}{" (ysize cell) "}"
                "\n"
                (parse-netlist current-netlist)
                "\n"
                "\n\\end{circuitdiagram}"
                ; generate topics !!
            )
        ))

;;  ------------    exporter schematic in latex -----------------------

    (define (exporter:schematic-circdia cell)
        "Display Circdia LaTeX schematic.
        Returns list for (map display (list ..))"
        (map rdisplay
            (list
                (generic-fileheader "%%" (id cell) "Schematic File")
                (generic-copyleft "%%")
                (generic-license "%%")
                (circuitdiagram cell)
                (generic-filefooter "%%" (id cell) "Schematic File"))))

;;  ===================================================================
;;                  END OF R7RS LIBRARY
;;  ===================================================================
  )
)
