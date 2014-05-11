#!/usr/bin/emacs --script

;;; csv-test.el --- Example of CSV data processing

;; Copyright (C) 2014 Artem Petrov <pa2311@gmail.com>

;; Author: Artem Petrov <pa2311@gmail.com>
;; Created: 11 May 2014
;; Keywords: csv parsing calculation
;; Version: 0.1.0

;; This file is not part of GNU Emacs.

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;;; caption

(message (concat "\n\tEmacs v" emacs-version " on "
                 (prin1-to-string system-type) " " system-name))
(message "\tcsv-test v0.1.0\n")

;;;; function definitions

(defun calc-ge (Ne Gfuel)
  "Calculates specific fuel consumption (ge)."
  (* (/ Gfuel Ne) 1000.0)
  )

;;;; main

(let ((srcFileName "example/data.csv")
      (resultFileName (concat "result__" (format-time-string "%Y-%m-%d_%H-%M") ".csv"))
      (nextLine t)
      (begOfLine nil)
      (endOfLine nil)
      (currData nil)
      (elemsOfString nil)
      (csvDelimiter ";")
      )
  (find-file srcFileName)
  (goto-char (point-min))
  (forward-line 1)
  (while nextLine
    (beginning-of-line)
    (setq begOfLine (line-beginning-position))
    (setq endOfLine (line-end-position))
    (setq currData (buffer-substring-no-properties begOfLine endOfLine))
    (when (not (equal (length currData) 0))
      (setq elemsOfString (split-string currData csvDelimiter t))
      (end-of-line)
      (insert csvDelimiter
              (number-to-string (calc-ge (string-to-number (elt elemsOfString 0))
                                         (string-to-number (elt elemsOfString 1)))))
      )
    (setq nextLine (= (forward-line 1) 0))
    )
  (write-file resultFileName)
  (kill-buffer (current-buffer))
  (message "Caclulation completed.\n")
  )
