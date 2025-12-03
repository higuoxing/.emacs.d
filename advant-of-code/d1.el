;;; d1.el --- Day 1 for Advant of Code.              -*- lexical-binding: t; -*-

;; Copyright (C) 2025

;; Author: Xing Guo <higuoxing@gmail.com>
;; Keywords: lisp

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <https://www.gnu.org/licenses/>.

;;; Commentary:

;; 

;;; Code:

(load (concat default-directory "aoc-helpers.el"))
(require 'cl-lib)

(defun find-password (start-point moves)
  "Find the password by simulating MOVES on the given START-POINT."
  (cl-reduce (lambda (acc move)
	       (let* ((point (car acc))
		      (times-of-pointing-at-zero (cdr acc))
		      (direction (if (> (length move) 0) (substring move 0 1) ""))
		      (steps (if (> (length move) 0) (string-to-number (substring move 1)) 0))
		      (next-point (if (string-equal direction "R")
				      (mod (+ point steps) 100)
				    (if (string-equal direction "L")
					(mod (+ point (- 100 steps)) 100)
				      point)))
		      (next-times-of-pointing-at-zero (if (= next-point 0)
							  (+ times-of-pointing-at-zero 1)
							times-of-pointing-at-zero)))
		 (cons next-point next-times-of-pointing-at-zero)))
	     moves
	     :initial-value (cons start-point 0))
  )

(let* ((contents (aoc/read-input "./d1.input"))
       (moves (split-string contents "\n"))
       (start-point 50)
       (password (find-password start-point moves)))
  (message "Password1 is %s" (number-to-string (cdr password))))

(defun find-password/2 (start-point moves)
  "Find the password by simulating MOVES on the given START-POINT."
  (cl-reduce (lambda (acc move)
	       (let* ((point (car acc))
		      (times-of-pointing-at-zero (cdr acc))
		      (direction (if (> (length move) 0) (substring move 0 1) ""))
		      (steps (if (> (length move) 0) (string-to-number (substring move 1)) 0))
		      (next-point (if (string-equal direction "R")
				      (+ (mod point 100) steps)
				    (if (string-equal direction "L")
					(- (mod point -100) steps)
				      point)))
		      (next-times-of-pointing-at-zero (if (string-equal direction "R")
							  (+ times-of-pointing-at-zero (/ next-point 100))
							(if (string-equal direction "L")
							    (+ times-of-pointing-at-zero (/ next-point -100))
							  times-of-pointing-at-zero))))
		 (cons (if (> next-point 100) (mod next-point 100) (mod next-point -100)) next-times-of-pointing-at-zero)))
	     moves
	     :initial-value (cons start-point 0))
  )

(let* ((contents (aoc/read-input "./d1.input"))
       (moves (split-string contents "\n"))
       (start-point 50)
       (password (find-password/2 start-point moves)))
  (message "Password2 is %s" (number-to-string (cdr password))))

(provide 'd1)
;;; d1.el ends here
