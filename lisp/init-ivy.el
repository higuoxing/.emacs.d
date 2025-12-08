;;; init-ivy.el --- initialize ivy                   -*- lexical-binding: t; -*-

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
(use-package ivy
  :hook (after-init . ivy-mode)
  ;; To suppress warnings from flycheck.
  :functions (swiper-isearch swiper-isearch-backward ivy-resume counsel-M-x
			     counsel-find-file counsel-describe-function
			     counsel-describe-variable counsel-describe-symbol
			     counsel-find-library counsel-info-lookup-symbol
			     counsel-unicode-char counsel-git counsel-git-grep counsel-ag
			     counsel-locate counsel-rhythmbox counsel-minibuffer-history
			     counsel-switch-buffer)
  :config
  (setq ivy-use-virtual-buffers t)
  (setq enable-recursive-minibuffers t)
  (setq ivy-use-selectable-prompt t)
  (keymap-global-set "C-s" #'swiper-isearch)
  (keymap-global-set "C-r" #'swiper-isearch-backward)
  (keymap-global-set "C-c C-r" #'ivy-resume)
  (keymap-global-set "<f6>" #'ivy-resume)
  (keymap-global-set "M-x" #'counsel-M-x)
  (keymap-global-set "C-x C-f" #'counsel-find-file)
  (keymap-global-set "<f1> f" #'counsel-describe-function)
  (keymap-global-set "<f1> v" #'counsel-describe-variable)
  (keymap-global-set "<f1> o" #'counsel-describe-symbol)
  (keymap-global-set "<f1> l" #'counsel-find-library)
  (keymap-global-set "<f2> i" #'counsel-info-lookup-symbol)
  (keymap-global-set "<f2> u" #'counsel-unicode-char)
  (keymap-global-set "C-c g" #'counsel-git)
  (keymap-global-set "C-c j" #'counsel-git-grep)
  (keymap-global-set "C-c k" #'counsel-ag)
  (keymap-global-set "C-x l" #'counsel-locate)
  (keymap-global-set "C-S-o" #'counsel-rhythmbox)
  (keymap-global-set "C-x C-b" #'counsel-switch-buffer)
  (keymap-set minibuffer-local-map "C-r" #'counsel-minibuffer-history))

;; Use ivy with xref.
(use-package ivy-xref
  :functions (ivy-xref-show-defs ivy-xref-show-xrefs)
  :init
  ;; xref initialization is different in Emacs 27 - there are two different
  ;; variables which can be set rather than just one
  :config
  (when (>= emacs-major-version 27)
    (setq-default xref-show-definitions-function #'ivy-xref-show-defs))
  ;; Necessary in Emacs <27. In Emacs 27 it will affect all xref-based
  ;; commands other than xref-find-definitions (e.g. project-find-regexp)
  ;; as well
  (setq-default xref-show-xrefs-function #'ivy-xref-show-xrefs)
  (keymap-global-set "C-x g g g" #'xref-find-definitions)
  (keymap-global-set "C-x g g r" #'xref-find-references))

(provide 'init-ivy)
;;; init-ivy.el ends here
