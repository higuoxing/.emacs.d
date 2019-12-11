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

;; flycheck
(use-package flycheck
  :ensure t)

;; gtags
;; Installation: yay -S global
;; Have to set this variable to non-nil value before loading `helm-gtags`
(if (executable-find "global")
    (progn
      (use-package helm-gtags
	:init
	(add-hook 'c-mode-hook 'helm-gtags-mode)
	(add-hook 'c++-mode-hook 'helm-gtags-mode)
	(add-hook 'asm-mode-hook 'helm-gtags-mode)
	:ensure t
	:config
	(setq
	 helm-gtags-ignore-case t
	 helm-gtags-auto-update t)))
  (message "%s GNU GLOBAL not found in exec-path. `helm-gtags` will not load" "script/language.el"))

;; ------------------------------- Emacs Lisp -----------------------------
(use-package highlight-defined
  :ensure t)
(add-hook 'emacs-lisp-mode-hook 'highlight-defined-mode)

(defun eval-region-or-buffer ()
  "Eval elisp region or buffer"
  (interactive)  
  (if (use-region-p)
      (eval-region (region-beginning) (region-end))
    (eval-buffer)))

(add-hook 'emacs-lisp-mode-hook #'(lambda ()
				    (local-set-key (kbd "C-c C-c C-r") #'eval-region-or-buffer)))
;; ------------------------------------------------------------------------

;; -------------------------------- Rust ----------------------------------
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
(if (executable-find "racer")
    (progn
      (use-package racer
	:ensure t)
      (add-hook 'rust-mode-hook #'racer-mode))
  (message "%s +nightly racer not found in exec-path. `racer-mode` will not load" "script/language.el"))

(add-hook 'racer-mode-hook #'eldoc-mode)
(add-hook 'racer-mode-hook #'company-mode)
(define-key rust-mode-map (kbd "TAB") #'company-indent-or-complete-common)
(setq company-tooltip-align-annotation t)
;; ------------------------------------------------------------------------

;; ------------------------------- C/CC -----------------------------------
(if (executable-find "clang-format")
    (progn
      (use-package clang-format
	:ensure t)
      (defun clang-format-region-or-buffer ()
	"Use `clang-format` to format buffer or region"	
	(interactive)
	(if (use-region-p)
	    (clang-format-region (region-beginning) (region-end))
	  (clang-format-buffer)))
      (add-hook 'c-mode-common-hook (lambda ()
				      ;; Map `C-c C-f` to `clang-format`
				      ;; If we have a selected region, then we format that region
				      ;; Or we format the buffer
				      (local-set-key (kbd "C-c C-f") #'clang-format-region-or-buffer))))
  (message "%s clang-format not found in exec-path. `clang-format` will not load" "script/language.el"))
;; ------------------------------------------------------------------------

;; ------------------------------ Typescript ------------------------------
;; TODO
;; ------------------------------------------------------------------------

;; --------------------------------- Go -----------------------------------
(if (executable-find "go")
    (use-package go-mode
      :ensure t)
  (message "%s go not found in exec-path `go-mode` will not be enabled" "script/lanaguage.el"))

;; Install it by executing `go get golang.org/x/tools/cmd/...`;; 
(if (executable-find "gofmt")
    (add-hook 'before-save-hook 'gofmt-before-save)
  (message "%s gofmt not found in exec-path `gofmt-before-save will not be enabled`" "script/lanaguage.el"))

;; Install it by executing `go get github.com/rogpeppe/godef`
(if (executable-find "godef")
    (add-hook 'go-mode-hook (lambda ()
			      (local-set-key (kbd "C-c C-j") 'godef-jump)
			      (local-set-key (kbd "C-c C-d") 'godef-describe)
			      (local-set-key (kbd "C-c C-b") 'pop-tag-mark)))
  (message "%s godef not found in exec-path `godef-jump` will not be be enabled" "script/lanaguage.el"))

;; Install it by executing `go get golang.org/x/tools/gopls`
(if (executable-find "gopls")
    (add-hook 'go-mode-hook 'lsp-deferred)
  (message "%s gopls not found in exec-path `lsp-deferred` will not be enabled" "script/language.el"))

;; Install it by executing `go get golang.org/x/lint/golint`
(if (executable-find "golint")
    (use-package golint
      :ensure t)
  (message "%s golint not found in exec-path `golint` will not be enabled" "script/language.el"))
;; ------------------------------------------------------------------------
