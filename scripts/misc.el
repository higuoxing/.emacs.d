;; Set proxy of my ema
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

;; --------------------------------------- Helm -----------------------------------------------
(use-package helm
  :ensure t)
(require 'helm-config)
(helm-mode 1)

;; Remap <Tab> to autocompletion.
(define-key helm-map (kbd "TAB") #'helm-execute-persistent-action)
(define-key helm-map (kbd "C-z") #'helm-select-action)

;; Use `helm-M-x` to eval commands.
(global-set-key (kbd "M-x") #'helm-M-x)

;; Use `helm-C-x-C-f` to find files.
(global-set-key (kbd "C-x C-f") #'helm-find-files)

;; Use `helm-C-x-C-b` to list buffers.
(global-set-key (kbd "C-x C-b") #'helm-buffers-list)

;; --------------------------------------------------------------------------------------------

;; ---------------------------------------- Keymaps -------------------------------------------
;; Select rectangle region.
(global-set-key (kbd "C-x v") 'rectangle-mark-mode)

;; Select common region.
(global-set-key (kbd "C-x C-v") 'set-mark-command)

;; Remap `C-s`/`C-r` to search-forward/backward-regex
(global-set-key (kbd "C-s") #'isearch-forward-regexp)
(global-set-key (kbd "C-r") #'isearch-backward-regexp)
;; --------------------------------------------------------------------------------------------
