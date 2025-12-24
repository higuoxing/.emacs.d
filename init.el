;;; init.el --- initialize emacs                     -*- lexical-binding: t; -*-

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

;; Initialize straight.el
;; See: https://github.com/radian-software/straight.el?tab=readme-ov-file#getting-started
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name
        "straight/repos/straight.el/bootstrap.el"
        (or (bound-and-true-p straight-base-dir)
            user-emacs-directory)))
      (bootstrap-version 7))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(straight-use-package 'use-package)
(eval-and-compile
  ;; Allows imenu to show entries for use-package declarations.
  (setopt use-package-enable-imenu-support t)
  ;; Make use-package print messages when loading packages.
  (setopt use-package-verbose t))

(use-package server
  :config (or (server-running-p) (server-mode)))

(message "Loading early birds...done (%.3fs)"
         (float-time (time-subtract (current-time) before-init-time)))

;;; Long tail
(use-package paren
  :defer t
  :config (show-paren-mode))

(use-package which-key
  :straight t
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

;;; Load other el files.
(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))

;;; UI
(require 'init-ui)

;;; Development experience
(use-package init-emacs)
(use-package init-autoinsert)
(use-package init-vertico)
(use-package init-orderless)
(use-package init-consult)
(use-package marginalia
  :straight t
  :bind
  (:map minibuffer-local-map
	("M-A" . marginalia-cycle))
  :init
  (marginalia-mode))
(use-package magit
  :straight t
  :defer t)
(use-package editorconfig
  :straight t
  :hook (prog-mode . editorconfig-mode))
;; Code completion
(use-package init-corfu)
;; Language server support
(use-package init-eglot)

;;; Languages
(use-package init-lang-lisp)
(use-package init-lang-c)
(use-package init-lang-go)
(use-package init-lang-rust)
(use-package init-lang-python)
(use-package init-lang-markdown)
(use-package init-lang-typst)

(provide 'init)
;;; init.el ends here
