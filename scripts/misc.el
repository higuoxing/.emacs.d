;; Set proxy of my emacs.
(setq url-proxy-services '(("no_proxy" . "")
			   ("http_proxy" . "127.0.0.1:8118")
			   ("https_proxy" . "127.0.0.1:8118")))

;; Useless auto-generated configuration file.
(setq custom-file (concat user-emacs-directory "/garbage.el"))

;; Silence ring-bell.
(setq ring-bell-function 'ignore)

;; Get rid of backup files.
(setq make-backup-files nil)

;; Keep my `.emacs.d/` clean
(use-package no-littering
  :ensure t)
(setq auto-save-file-name-transforms
      `((".*" ,(no-littering-expand-var-file-name "auto-save/") t)))
