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

(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))

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

;;; UI
(require 'init-ui)

;;; Development experience
(require 'init-autoinsert)
(require 'init-ivy)
(require 'init-magit)
(require 'init-editorconfig)
;; Code completion
(require 'init-corfu)
;; Language server support
(require 'init-eglot)
(require 'init-flycheck)
(require 'init-xref)

;;; Languages
(require 'init-lang-lisp)
(require 'init-lang-c)
(require 'init-lang-rust)
(require 'init-lang-markdown)
(require 'init-lang-typst)

;; Used for debugging start up duration.
;; (borg-report-after-init-duration)

(provide 'init)
;;; init.el ends here
