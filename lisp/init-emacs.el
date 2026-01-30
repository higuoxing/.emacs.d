;;; init-emacs.el --- initialize emacs               -*- lexical-binding: t; -*-

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

;; A few more useful configurations for corfu, vertico.
(use-package emacs
  :custom
  ;; TAB cycle if there are only few candidates
  ;; (completion-cycle-threshold 3)

  ;; Enable indentation+completion using the TAB key.
  ;; `completion-at-point' is often bound to M-TAB.
  (tab-always-indent 'complete)

  ;; Emacs 30 and newer: Disable Ispell completion function.
  ;; Try `cape-dict' as an alternative.
  (text-mode-ispell-word-completion nil)

  ;; Hide commands in M-x which do not apply to the current mode.  Corfu
  ;; commands are hidden, since they are not used via M-x. This setting is
  ;; useful beyond Corfu.
  (read-extended-command-predicate #'command-completion-default-include-p)
  ;; Enable context menu. `vertico-multiform-mode' adds a menu in the minibuffer to switch display modes.
  (context-menu-mode t)
  ;; Support opening new minubuffers from inside existing minibuffers.
  (enable-recursive-minibuffers t)
  ;; Do not allow the cursor in the minibuffer prompt.
  (minibuffer-prompt-properties
   '(read-only t cursor-intangible-mode t face minibuffer-prompt)))

;; Resize the whole frame, and not only a window.
(defun my/zoom-frame (&optional delta)
  "Adjust the font size of the current frame by DELTA (in 1/10pt)."
  (interactive)
  (let* ((delta (or delta 10))
	 (old-height (face-attribute 'default :height))
         (new-height (+ old-height delta)))
    (set-face-attribute 'default (selected-frame) :height new-height)
    (message "Font size set to: %dpt" (/ new-height 10))))

(defun my/zoom-frame-out ()
  "Decrease frame font size by 1pt."
  (interactive)
  (my/zoom-frame -10))

(global-set-key (kbd "C-x C-=") 'my/zoom-frame)
(global-set-key (kbd "C-x C--") 'my/zoom-frame-out)

(provide 'init-emacs)
;;; init-emacs.el ends here
