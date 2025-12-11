;;; init-autoinsert.el --- initialize autoinsert     -*- lexical-binding: t; -*-

;; Copyright (C) 2025  Xing Guo

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

(defun my/sanitize_string (str)
  "Remove newlines from the given STR."
  (replace-regexp-in-string "\n" "" str))

(use-package autoinsert
  :defer t
  :init
  (setq user-full-name
	(my/sanitize_string (shell-command-to-string "git config user.name")))
  (setq user-mail-address
	(my/sanitize_string (shell-command-to-string "git config user.email"))))

(provide 'init-autoinsert)
;;; init-autoinsert.el ends here
