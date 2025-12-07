;;; init.el --- init                                -*- lexical-binding: t; -*-

;; Copyright (C) 2025

;; Author:  <higuoxing@gmail.com>
;; Keywords: convenience

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

;;; Code:

;; Used for debugging start up duration.
;; (borg-report-load-duration)

;;; Early birds
(progn
  ;;; UI
  ;; Prevent showing "Buffer Menu"
  (setq inhibit-startup-buffer-menu t)
  ;; Disable the scroll bar.
  (when (fboundp 'scroll-bar-mode)
    (scroll-bar-mode 0))
  ;; Disable the tool bar.
  (when (fboundp 'tool-bar-mode)
    (tool-bar-mode 0))
  ;; Disable the menu bar.
  (menu-bar-mode 0)
  ;; Display line numbers in status bar.
  (column-number-mode)
  ;; Display line numbers in the left margin.
  (global-display-line-numbers-mode t)

  ;;; Experience
  ;; Keep the visible bell but disable sound.
  (setq visible-bell t)
  ;; Stop creating backup~ files.
  (setq make-backup-files nil)
  ;; Stop creating #autosave# files.
  (setq auto-save-default nil)
  ;; Delete the selected text first before editing.
  (delete-selection-mode t)
  ;; Smooth Scrolling: https://www.emacswiki.org/emacs/SmoothScrolling
  ;; https://github.com/MatthewZMD/.emacs.d#smooth-scrolling
  (setq scroll-conservatively 10000)
  ;; Vertical Scroll
  (setq scroll-step 1)
  (setq scroll-margin 10)
  (setq scroll-conservatively 101)
  (setq scroll-up-aggressively 0.01)
  (setq scroll-down-aggressively 0.01)
  (setq auto-window-vscroll nil)
  (setq fast-but-imprecise-scrolling nil)
  (setq mouse-wheel-scroll-amount '(1 ((shift) . 1)))
  (setq mouse-wheel-progressive-speed nil)
  ;; Horizontal Scroll
  (setq hscroll-step 1)
  (setq hscroll-margin 10))

;; Globals
(defconst my/emacs-directory (concat (getenv "HOME") "/.emacs.d/"))
(defun my/emacs-subdir (d)
  "Translate the sub-directory D of $HOME/.emacs.d into the full path."
  (expand-file-name d my/emacs-directory))

(eval-and-compile
  ;; Allows imenu to show entries for use-package declarations.
  (setopt use-package-enable-imenu-support t)
  ;; Make use-package print messages when loading packages.
  (setopt use-package-verbose t)
  (require 'use-package))

(use-package server
  :functions (server-running-p)
  :config (or (server-running-p) (server-mode)))

(add-to-list 'load-path (my/emacs-subdir "/lisp"))

(progn
  (message "Loading early birds...done (%.3fs)"
           (float-time (time-subtract (current-time) before-init-time))))

;;; Long tail
(use-package paren
  :defer t
  :config (show-paren-mode))

(use-package which-key
  :hook (after-init . which-key-mode)
  ;; Don't display which-key-mode in modeline.
  :diminish which-key-mode
  :config
  (setq which-key-idle-delay 0.2))

;; Doc related
(use-package man
  :defer t
  :config (setq Man-width 80))

(use-package help
  :defer t
  :config (temp-buffer-resize-mode))

(use-package eldoc
  :config (global-eldoc-mode))

;;; Development experience
(use-package ivy
  :hook (after-init . ivy-mode)
  ;; To suppress warnings from flycheck.
  :functions (swiper-isearch swiper-isearch-backward ivy-resume counsel-M-x
			     counsel-find-file counsel-describe-function
			     counsel-describe-variable counsel-describe-symbol
			     counsel-find-library counsel-info-lookup-symbol
			     counsel-unicode-char counsel-git counsel-git-grep counsel-ag
			     counsel-locate counsel-rhythmbox counsel-minibuffer-history)
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

;;; Languages support
;; Re-map prog modes to their tree-sitter modes.
(setq major-mode-remap-alist
      '((c-mode . c-ts-mode)
	(c++-mode . c++-ts-mode)))

(use-package flycheck
  :hook (after-init . global-flycheck-mode)
  :config
  ;; Check syntax on save.
  (setq flycheck-check-syntax-automatically '(mode-enabled save))
  ;; Specify emacs-lisp scripts load path for flycheck.
  (setq flycheck-emacs-lisp-load-path 'inherit))

(use-package autoinsert
  :init
  ;; Make sure autoinsert is enabled only once.
  (when (not (bound-and-true-p auto-insert-mode))
    (auto-insert-mode 1))
  :config
  ;; Don't prompt before insertion.
  (setq auto-insert-query nil))

;; Code complete
(use-package eglot
  :defer t
  :hook ((c-ts-mode . eglot-ensure)
	 (c++-ts-mode . eglot-ensure)))

(use-package corfu
  ;; Optional customizations
  ;; :custom
  ;; (corfu-cycle t)                ;; Enable cycling for `corfu-next/previous'
  ;; (corfu-quit-at-boundary nil)   ;; Never quit at completion boundary
  ;; (corfu-quit-no-match nil)      ;; Never quit, even if there is no match
  ;; (corfu-preview-current nil)    ;; Disable current candidate preview
  ;; (corfu-preselect 'prompt)      ;; Preselect the prompt
  ;; (corfu-on-exact-match 'insert) ;; Configure handling of exact matches

  ;; Enable Corfu only for certain modes. See also `global-corfu-modes'.
  :hook ((prog-mode . corfu-mode)
	 (shell-mode . corfu-mode)
	 (eshell-mode . corfu-mode))

  ;; Enable optional extension modes:
  ;; (corfu-history-mode)
  ;; (corfu-popupinfo-mode)

  :config
  (setq corfu-auto t
	corfu-auto-delay 0.2
	corfu-auto-trigger "." ;; Custom trigger characters
	corfu-quit-no-match 'separator))

;; A few more useful configurations for corfu
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
  (read-extended-command-predicate #'command-completion-default-include-p))

;; Lisp.
(use-package paredit
  ;; Enable this in elisp, ielm
  :hook emacs-lisp-mode inferior-emacs-lisp-mode)

;; Rust
(use-package rust-mode
  :init
  (setq rust-mode-treesitter-derive t))

(use-package flycheck-rust
  ;; There're some variables to set for flycheck before checking
  ;; projects.  I use flycheck-rust to set them up.
  :hook ((rust-mode flycheck-mode) . flycheck-rust-setup))

;; Used for debugging start up duration.
;; (borg-report-after-init-duration)

(provide 'init)
;;; init.el ends here
