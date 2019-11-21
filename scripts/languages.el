;; Some packages may need this.
(use-package yasnippet
  :ensure t)

;; emacs-lsp
(use-package lsp-mode
  :ensure t
  :config (add-hook 'rust-mode-hook #'lsp))

;; lsp-ui
(use-package lsp-ui
  :ensure t)
(add-hook 'lsp-mode-hook 'lsp-ui-mode)

;; company
(use-package company
  :ensure t)

;; helm configurations.
(use-package helm
  :ensure t)
(require 'helm-config)
(helm-mode 1)

; Use helm-M-x
(global-set-key (kbd "M-x") 'helm-M-x)
; Use helm C-x C-f
(global-set-key (kbd "C-x C-f") 'helm-find-files)
(helm-autoresize-mode t)

;; -------------------------------- Rust ----------------------------------
;; Configuration for rust.
(use-package rust-mode
  :ensure t)
(add-hook 'rust-mode-hook
	  (lambda () (setq indent-tabs-mode nil)))

;; Auto format on saving action.
(setq rust-format-on-save t)
(use-package cargo
  :ensure t)
(add-hook 'rust-mode-hook
	  'cargo-minor-mode)

;; Setup racer
;; `$ rustup toolchain add nightly`   # Enable rust-nightly.
;; `$ rustup component add rust-src`  # Install rust source code.
;; `$ cargo +nightly install racer`   # Install racer.
(use-package racer
  :ensure t)
(add-hook 'rust-mode-hook #'racer-mode)
(add-hook 'racer-mode-hook #'eldoc-mode)
(add-hook 'racer-mode-hook #'company-mode)
(define-key rust-mode-map (kbd "TAB") #'company-indent-or-complete-common)
(setq company-tooltip-align-annotation t)
;; ------------------------------------------------------------------------

;; ------------------------------- C/CC -----------------------------------
;; ------------------------------------------------------------------------

