;;; init-lang-verilog.el --- Verilog / SystemVerilog  -*- lexical-binding: t; -*-

;; Copyright (C) 2025  Xing Guo

;; Author: Xing Guo <higuoxing@gmail.com>
;; Keywords: verilog

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

;; Indentation uses spaces (not tabs) and 2-space steps.  For LSP,
;; install Verible on macOS via Homebrew from the Chips
;; Alliance tap: `brew tap chipsalliance/verible' then `brew install
;; verible'.  See <https://github.com/chipsalliance/homebrew-verible>.

;;; Code:

(defvar my/verilog--slang-hint-shown nil
  "Non-nil after we showed the missing-slang hint once this session.")

(defvar my/slang-server
  (expand-file-name "dist/bin/slang-server" user-emacs-directory))

(defun my/verilog-maybe-hint-missing-slang ()
  "If slang-server is not installed, show a one-time hint."
  (when (and (not (file-exists-p my/slang-server))
             (not my/verilog--slang-hint-shown))
    (setq my/verilog--slang-hint-shown t)
    (message "slang-server not found. Run 'make bootstrap' in .emacs.d")))

;; Configure Eglot to use the explicit slang-server path for verilog-mode
(with-eval-after-load 'eglot
  (add-to-list 'eglot-server-programs
               `(verilog-mode . (,my/slang-server))))

(defun my/verilog-mode-setup ()
  "Buffer-local defaults for Verilog / SystemVerilog."
  (setq-local indent-tabs-mode nil)
  (setq-local tab-width 2)
  (if (file-exists-p my/slang-server)
      (eglot-ensure)
    (my/verilog-maybe-hint-missing-slang)))

(use-package verilog-mode
  :straight t
  :defer t
  :mode (("\\.v\\'" . verilog-mode)
         ("\\.sv\\'" . verilog-mode)
         ("\\.svh\\'" . verilog-mode)
         ("\\.vh\\'" . verilog-mode))
  :hook (verilog-mode . my/verilog-mode-setup)
  :config
  ;; Indentation settings
  (setq verilog-indent-level 2
        verilog-indent-level-module 2
        verilog-indent-level-declaration 2
        verilog-indent-level-behavioral 2
        verilog-case-indent 2
        verilog-cexp-indent 2
        verilog-indent-level-directive 1
        verilog-indent-lists nil))

(provide 'init-lang-verilog)
;;; init-lang-verilog.el ends here
