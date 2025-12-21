;;; init-lang-rust.el --- initialize rust language   -*- lexical-binding: t; -*-

;; Copyright (C) 2025  Xing Guo

;; Author: Xing Guo <higuoxing@gmail.com>
;; Keywords: lisp, rust

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

(use-package rust-mode
  :mode ("\\.rs\\'")
  :init
  (setq rust-mode-treesitter-derive t)
  (add-hook 'rust-mode-hook 'eglot-ensure)
  :config
  (setq rust-format-on-save t)
  (prettify-symbols-mode))

(provide 'init-lang-rust)
;;; init-lang-rust.el ends here
