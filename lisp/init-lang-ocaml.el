;;; init-lang-ocaml.el --- initialize OCaml language  -*- lexical-binding: t; -*-

;; Copyright (C) 2026  Xing Guo

;; Author: Xing Guo <higuoxing@gmail.com>
;; Keywords: ocaml

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

;; Requires OCaml and OPAM installed:
;;   brew install opam
;;   opam init
;;   opam install ocaml-lsp-server

;;; Code:

;; Tuareg mode for OCaml
(use-package tuareg
  :straight t
  :mode (("\\.ml[ily]?\\'" . tuareg-mode))
  :init
  (add-hook 'tuareg-mode-hook 'eglot-ensure))

;; Optional: dune configuration file support
(use-package dune
  :straight t
  :mode (("dune\\'" . dune-mode)
         ("dune-project\\'" . dune-mode)
         ("dune-workspace\\'" . dune-mode)))

(provide 'init-lang-ocaml)
;;; init-lang-ocaml.el ends here
