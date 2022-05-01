;; This file contains configuration for packages management.

(package-initialize)
(require 'package)

;; Setup packages' archives
(setq package-archives '(("MELPA" . "http://melpa.org/packages/")
			 ("GNU ELPA" . "http://elpa.gnu.org/packages/")
			 ("ORG MODE" . "http://orgmode.org/elpa/")))
