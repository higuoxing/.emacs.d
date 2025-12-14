;;; init-flycheck.el --- initialize flycheck         -*- lexical-binding: t; -*-

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

(use-package flycheck
  :hook (after-init . global-flycheck-mode)
  :config
  ;; Check syntax on save.
  (setq flycheck-check-syntax-automatically '(mode-enabled save))
  ;; Specify emacs-lisp scripts load path for flycheck.
  (setq flycheck-emacs-lisp-load-path 'inherit)
  ;; Disable flake8 as there're many errors.
  (setq-default flycheck-disabled-checkers '(python-flake8)))

(provide 'init-flycheck)
;;; init-flycheck.el ends here
