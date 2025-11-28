;;; early-init.el --- early birds                    -*- lexical-binding: t; -*-

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

;; Load whatever looks newer.
(setq load-prefer-newer t)

;; Load borg package manager.
(add-to-list 'load-path (expand-file-name "lib/borg" user-emacs-directory))
(require 'borg)
(borg-initialize)

;; Disable loading old package.el make straight.el/elpaca load faster.
(setq package-enable-at-startup nil)

;; Reduce garbage collection during startup
(setq gc-cons-threshold most-positive-fixnum)
(setq gc-cons-percentage 0.6)

;; Disable file-name-handler during startup (speed up startup)
(defvar my/file-name-handler-alist file-name-handler-alist)
(setq file-name-handler-alist nil)
;; Restore file handlers after start up.
(add-hook 'emacs-startup-hook
	  (lambda ()
	    (setq gc-cons-threshold 16777216) ;; 16MB
	    (setq gc-cons-percentage 0.1)
	    (setq file-name-handler-alist my/file-name-handler-alist)))

;; Don't automatically resize the frame during startup.
;; Significantly improve the performance.
(setq frame-inhibit-implied-resize t)

(with-eval-after-load 'package
  (setq package-archives '(("melpa" . "https://melpa.org/packages/")
                           ("gnu"   . "https://elpa.gnu.org/packages/")
                           ("org"   . "https://orgmode.org/elpa/"))))

(provide 'early-init)
;;; early-init.el ends here
