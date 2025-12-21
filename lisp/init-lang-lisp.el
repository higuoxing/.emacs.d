;;; init-lang-lisp.el --- initialize lisp language   -*- lexical-binding: t; -*-

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

(use-package elisp-mode
  :defer t
  :init
  (add-hook 'emacs-lisp-mode-hook #'paredit-mode)
  ;; FIXME: Enable flymake automatically is vulnerable.
  ;; https://eshelyaron.com/posts/2024-11-27-emacs-aritrary-code-execution-and-how-to-avoid-it.html
  ;; For future reference.
  ;; Specify elisp load path for flymake.
  ;; (add-to-list 'elisp-flymake-byte-compile-load-path
  ;; 	     (expand-file-name "lisp" user-emacs-directory))
  ;; (add-hook 'emacs-lisp-mode-hook #'flymake-mode)
  )

(use-package ielm
  :defer t
  :init
  (add-hook 'inferior-emacs-lisp-mode-hook #'paredit-mode))

(provide 'init-lang-lisp)
;;; init-lang-lisp.el ends here
