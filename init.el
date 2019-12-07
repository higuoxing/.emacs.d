(package-initialize)
(require 'package)

;; Setup packages' archives.
(setq package-archives '(("MELPA" . "http://melpa.org/packages/")
			 ("GNU ELPA" . "http://elpa.gnu.org/packages/")
			 ("ORG MODE" . "http://orgmode.org/elpa/")))

;; Add my custom scripts
(add-to-list 'load-path (concat user-emacs-directory "/scripts/"))

;; Load "appearance.el"
(load "appearance")

;; Load "misc.el"
(load "misc")

;; Load "languages.el"
(load "languages")

;; Load "file-tree.el"
(load "file-tree")

;; Load "window.el"
(load "window")

;; Load "terminal.el"
(load "terminal")
