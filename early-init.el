;;; early-init.el --- Earliest birds               -*- lexical-binding: t -*-

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
  (add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t))

(provide 'early-init)

;; Local Variables:
;; no-byte-compile: t
;; indent-tabs-mode: nil
;; End:
;;; early-init.el ends here
