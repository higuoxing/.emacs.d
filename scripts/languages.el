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

;; ------------------------------- Emacs Lisp -----------------------------
(use-package highlight-defined
  :ensure t)
(add-hook 'emacs-lisp-mode-hook 'highlight-defined-mode)
;; ------------------------------------------------------------------------

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
(use-package ccls)
(setq ccls-executable "ccls")
(use-package clang-format
  :ensure t)

(defun clang-format-region-or-buffer ()
  "Use `clang-format` to format buffer or region"
  (interactive)
  (if (use-region-p)
      (clang-format-region (region-beginning) (region-end))
    (clang-format-buffer)))

(add-hook 'c-mode-common-hook
	  (lambda ()
	    ;; Map `C-c C-f` to `clang-format`
	    ;; If we have a selected region, then we format that region
	    ;; Or we format the buffer.
	    (local-set-key (kbd "C-c C-f") #'clang-format-region-or-buffer)))
;; ------------------------------------------------------------------------

;; ------------------------------ Typescript ------------------------------
;; TODO
;; ------------------------------------------------------------------------

;; --------------------------------- Go -----------------------------------
(use-package go-mode
  :ensure t)
(add-to-list 'exec-path "$GOPATH/bin")
(add-hook 'before-save-hook 'gofmt-before-save)
;; ------------------------------------------------------------------------
