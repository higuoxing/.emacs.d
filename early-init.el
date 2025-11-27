;; -*- lexical-binding:t; no-byte-compile:t -*-
;; Load whatever looks newer.
(setq load-prefer-newer t)

;; Load borg package manager.
(add-to-list 'load-path (expand-file-name "lib/borg" user-emacs-directory))
(require 'borg)
(borg-initialize)

(setq package-enable-at-startup nil)
