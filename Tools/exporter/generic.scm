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
;;  File:           StdCellLib/Tools/exporter/generic
;;
;;  Purpose:        Scheme Module - help export with generic functions
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

(define-library (exporter generic)
  (import (scheme base)
          (scheme write)    ; display
          (srfi 78)         ; test suite
          (common lib)
) (export rdisplay
          ; generic output formater
          generic-fileheader
          generic-copyleft
          generic-license
          generic-filefooter
) (begin

;;  ------------    srfi-78 test suite  -------------------------------

    ; change this switch during development only
    ; mode must be a symbol in '(off summary report-failed report)
    (check-set-mode! 'off)

;;  ------------    recursive display   -------------------------------

    (define (rdisplay alist)
        "Display content of embedded lists recursivly.
        No return Value, similiar to 'display'"
        (if (null? alist)
            ""
            (let ((element (car alist)))
                (if (list? element)
                    ; embedded list, go down
                    (rdisplay element)
                    ; just an element, display
                    (display element))
                ; traverse list further
                (rdisplay (cdr alist)))))

;;  ------------    generic file header     ---------------------------

    (define (generic-fileheader comment-sign file-name purpose)
        "Generates generic file heder lines, starting with comment-sign.
        Returns list for (map display (list ..))"
        (list
            comment-sign " ************    LibreSilicon's StdCellLib    **********************"
            "\n" comment-sign " ATTENTION:      This file is AUTO-GENERATED, please do not change."
            "\n" comment-sign
            "\n" comment-sign " Home:           https://www.github.com/chipforge/stdcelllib"
            "\n" comment-sign
            "\n" comment-sign " File:           " file-name
            "\n" comment-sign
            "\n" comment-sign " Purpose:        " purpose
            "\n" comment-sign " ///////////////////////////////////////////////////////////////////"))

;;  ------------    generic copyleft lines  ---------------------------

    (define (generic-copyleft comment-sign)
        "Generates generic copyleft lines, starting with comment-sign.
        Returns list for (map display (list ..))"
        (list
            "\n" comment-sign
            "\n" comment-sign " Copyright (c) " (copyleft-year) " by"
            "\n" comment-sign "                 chipforge <stdcelllib@nospam.chipforge.org>"
            "\n" comment-sign " All rights reserved."))

;;  ------------    generic license text    ---------------------------

    (define (generic-license comment-sign)
        "Generates generic license text line by line, starting with comment-sign.
        Returns list for (map display (list ..))"
        (list
            "\n" comment-sign
            "\n" comment-sign " This Standard Cell Library is licensed under the Libre Silicon"
            "\n" comment-sign " public license; you can redistribute it and/or modify it under"
            "\n" comment-sign " the terms of the Libre Silicon public license as published by"
            "\n" comment-sign " the Libre Silicon alliance, either version 1 of the License, or"
            "\n" comment-sign " (at your option) any later version."
            "\n" comment-sign
            "\n" comment-sign " This design is distributed in the hope that it will be useful,"
            "\n" comment-sign " but WITHOUT ANY WARRANTY; without even the implied warranty of"
            "\n" comment-sign " MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE."
            "\n" comment-sign " See the Libre Silicon Public License for more details."
            "\n" comment-sign
            "\n" comment-sign " ///////////////////////////////////////////////////////////////////"))

;;  ------------    generic file footer     ---------------------------

    (define (generic-filefooter comment-sign file-name purpose)
        "Generates generic footer text line by line, starting with comment-sign.
        Returns list for (map display (list ..))"
        (list
            "\n" comment-sign "                   Thanks for all the fish :-)"
            "\n" comment-sign
            "\n" comment-sign "          ;;       .;;;. ;; ;; ;; ;;;;. ;;;; ;;;. ;;;;. .;;;. ;;;;"
            "\n" comment-sign "          ;;;;;;   ;; ;; ;; ;; ;; ;; ;; ;;  ;; ;; ;; ;; ;; ;; ;;"
            "\n" comment-sign "       ;, ;;       ;;    ;;;;; ;; ;; ;; ;;; ;; ;; ;;;;' ;;,,, ;;;"
            "\n" comment-sign "    ;;;;;;;;;;;;   ;; ;; ;; ;; ;; ;;;;' ;;  ;; ;; ;;';; ;; ;; ;;"
            "\n" comment-sign "       :' ;;       ';;;' ;; ;; ;; ;;    ;;  ';;;' ;; ;; ';;;; ;;;;"
            "\n" comment-sign
            "\n" comment-sign " END OF AUTO-GENERATED FILE " file-name purpose))

;;  ===================================================================
;;                  END OF R7RS LIBRARY
;;  ===================================================================
  )
)
