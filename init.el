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

(use-package flycheck-aspell)

(use-package autoinsert
  :init
  ;; Make sure autoinsert is enabled only once.
  (when (not (bound-and-true-p auto-insert-mode))
    (auto-insert-mode 1))
  :config
  ;; Don't prompt before insertion.
  (setq auto-insert-query nil))

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
