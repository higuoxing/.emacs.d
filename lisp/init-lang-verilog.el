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

;; Indentation uses spaces (not tabs) and 2-space steps.  For LSP and
;; formatting, install Verible on macOS via Homebrew from the Chips
;; Alliance tap: `brew tap chipsalliance/verible' then `brew install
;; verible'.  See <https://github.com/chipsalliance/homebrew-verible>.

;;; Code:

(defvar my/verilog--verible-hint-shown nil
  "Non-nil after we showed the missing-Verible hint once this session.")

(defun my/verilog-maybe-hint-missing-verible ()
  "If Verible is not installed, show a one-time hint in the echo area."
  (when (and (not (executable-find "verible-verilog-ls"))
             (not my/verilog--verible-hint-shown))
    (setq my/verilog--verible-hint-shown t)
    (message
     (concat
      "Verilog: `verible-verilog-ls' not found — install: "
      "`brew tap chipsalliance/verible' then `brew install verible' "
      "(https://github.com/chipsalliance/homebrew-verible)"))))

(with-eval-after-load 'eglot
  (add-to-list 'eglot-server-programs
               '(verilog-mode . ("verible-verilog-ls"))))

(defun my/verilog--format-with-verible-cli ()
  "Format the buffer with Verible's `verible-verilog-format' executable.

This is the same Verible toolchain as `verible-verilog-ls'; we use the
CLI because Eglot does not reliably expose Verible's LSP formatter.

`call-process-region': fourth arg DELETE must be t or the region is
duplicated; fifth arg must be `(t nil)' so stderr is not mixed into the
buffer.  After replace, restore point via offset from `point-min'."
  (when-let ((cmd (executable-find "verible-verilog-format")))
    (save-restriction
      (widen)
      (let ((off (- (point) (point-min))))
        (call-process-region (point-min) (point-max) cmd
                             t '(t nil) nil "-")
        (goto-char (+ (point-min)
                      (min off (max 0 (- (point-max) (point-min))))))))))

(defun my/verilog-format-before-save ()
  "On save, format with Verible via `my/verilog--format-with-verible-cli'.

If `verible-verilog-format' is not on `exec-path', do nothing."
  (my/verilog--format-with-verible-cli))

(defun my/verilog-mode-setup ()
  "Buffer-local defaults for Verilog / SystemVerilog."
  (setq-local indent-tabs-mode nil)
  (setq-local tab-width 2)
  (add-hook 'before-save-hook #'my/verilog-format-before-save nil t)
  (if (executable-find "verible-verilog-ls")
      (eglot-ensure)
    (my/verilog-maybe-hint-missing-verible)))

(use-package verilog-mode
  :straight t
  :defer t
  :mode (("\\.v\\'" . verilog-mode)
         ("\\.sv\\'" . verilog-mode)
         ("\\.svh\\'" . verilog-mode)
         ("\\.vh\\'" . verilog-mode))
  :hook (verilog-mode . my/verilog-mode-setup)
  :config
  ;; Two-space indentation is widely used and avoids the wide tab alignment
  ;; that makes `parameter' lists in #( ) blocks look misaligned.
  (setq verilog-indent-level 2
        verilog-indent-level-module 2
        verilog-indent-level-declaration 2
        verilog-indent-level-behavioral 2
        verilog-case-indent 2
        verilog-cexp-indent 2
        verilog-indent-level-directive 1
        ;; If you prefer continuation lines under `always @(' to align with the
        ;; opening paren, set this back to t (default).
        verilog-indent-lists nil))

(provide 'init-lang-verilog)
;;; init-lang-verilog.el ends here
