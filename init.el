(setq gc-cons-threshold 10000000)  ;; A large `gc-cons-threshold` may cause freezing and stuttering during long-term interactive use.
(setq inhibit-startup-message t)   ;; Disable the welcome message.
(scroll-bar-mode -1)               ;; Disable visible scrollbar.
(tool-bar-mode -1)                 ;; Disable tooltips.
(set-fringe-mode 0)                ;; Give some breathing room.
(setq visible-bell t)              ;; Set up the visible bell.
(set-face-attribute 'default nil :font "Fira Code" :height 110)

(setq auto-window-vscroll nil)     ;; Disable auto window scroll
;; Delete the selected text first before editing.
(delete-selection-mode 1)
;; Don’t compact font caches during GC.
(setq inhibit-compacting-font-caches t)

;; Smooth Scrolling: https://www.emacswiki.org/emacs/SmoothScrolling
;; https://github.com/MatthewZMD/.emacs.d#smooth-scrolling
(setq scroll-conservatively 10000)
;; Vertical Scroll
(setq scroll-step 1)
(setq scroll-margin 1)
(setq scroll-conservatively 101)
(setq scroll-up-aggressively 0.01)
(setq scroll-down-aggressively 0.01)
(setq auto-window-vscroll nil)
(setq fast-but-imprecise-scrolling nil)
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1)))
(setq mouse-wheel-progressive-speed nil)
;; Horizontal Scroll
(setq hscroll-step 1)
(setq hscroll-margin 1)

;; Display the line numbers.
(column-number-mode)
(global-display-line-numbers-mode t)

;; Disable line numbers for some modes.
(dolist (mode '(org-mode-hook
		term-mode-hook
		eshell-mode-hook
		neotree-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

;; Set native compiling logging level.
(setq warning-minimum-level :error)

;; Initialize package sources
(require 'package)
(setq package-archives
      '(;; ("gnu" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
	;; ("melpa" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")
	;; ("org" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/org/")))
	("gnu" . "https://elpa.gnu.org/packages/")
	("melpa" . "https://melpa.org/packages/")
	("org" . "http://orgmode.org/elpa/")))

(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

;; Initialize use-package on non-linux platforms
(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)
;; Keep init.el clean.
(setq custom-file (concat user-emacs-directory "/custom.el"))

;; NOTE: If you want to move everything out of the ~/.emacs.d folder
;; reliably, set `user-emacs-directory` before loading `no-littering`.
;; (setq user-emacs-directory "~/.cache/emacs")
(use-package no-littering)
;; Store all backup and autosave files in the tmp dir
;; (setq backup-directory-alist
;;  `((".*" . ,temporary-file-directory)))
;; no-littering doesn't set this by default so we must place
;; auto save files in the same path as it uses for sessions.
(setq auto-save-file-name-transforms
      `((".*" ,(no-littering-expand-var-file-name "auto-save/") t)))

(use-package all-the-icons
  :if (display-graphic-p)) ;; Required by doom-modeline
(use-package nyan-mode
  :init
  (nyan-mode)
  :config
  (setq nyan-wavy-trail t)
  (nyan-start-animation)
  :hook
  ;; Only enable it in prog mode.
  prog-mode)

(use-package doom-modeline
  :hook
  (after-init . doom-modeline-mode)
  :custom
  ((setq doom-modeline-lsp t)
   ;; Don't compact font caches during GC. Windows Laggy issue.
   (setq inhibit-compacting-font-caches t)
   ;; Whether display icons for buffer states. It respects `doom-modeline-icon'.
   (setq doom-modeline-buffer-state-icon t)
   (setq doom-modeline-persp-name t)
   (setq doom-modeline-display-default-persp-name t)
   (setq doom-modeline-env-version t)
   (setq doom-modeline-bar-width 5)
   (setq doom-modeline-icon t)
   (setq doom-modeline-major-mode-icon t)
   (setq doom-modeline-major-mode-color-icon t)
   (setq doom-modeline-buffer-file-name-style 'truncate-upto-project)
   (setq doom-modeline-buffer-state-icon t)
   (setq doom-modeline-buffer-modification-icon t)
   (setq doom-modeline-minor-modes nil)
   (setq doom-modeline-enable-word-count nil)
   (setq doom-modeline-buffer-encoding t)
   (setq doom-modeline-indent-info t)
   (setq doom-modeline-checker-simple-format t)
   (setq doom-modeline-vcs-max-length 12)
   (setq doom-modeline-env-version t)))

;; If it doesn't work, please evaluate (fira-code-mode-install-fonts)
(use-package fira-code-mode
  :if (display-graphic-p)
  :custom
  (fira-code-mode-disabled-ligatures '("[]" "#{" "#(" "#_" "#_(" "x" ":" "<>"))
  :hook
  prog-mode)

;; (use-package doom-themes
;;   :config
;;   (setq doom-themes-enable-bold t)
;;   (setq doom-themes-enable-italic t)
;;   (load-theme 'doom-dracula t))
(use-package kaolin-themes
  :config
  (load-theme 'kaolin-galaxy t)
  (kaolin-treemacs-theme))

(use-package page-break-lines)
(use-package dashboard
  :config
  (dashboard-setup-startup-hook)
  (setq dashboard-startup-banner 'logo)
  (setq dashboard-set-file-icons t)
  (setq dashboard-center-content t)
  (setq dashboard-set-heading-icons t)
  (setq dashboard-items '((recents  . 5)
			  (projects . 3)
			  (agenda . 4)))
  (setq inhibit-startup-message t))

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

;; Make ESC quit prompts.
(global-set-key (kbd "<esc>") 'keyboard-escape-quit)
;; Magic key.
(define-prefix-command 'magic-key)
(global-set-key (kbd "M-m") 'magic-key)

;; Disabe and remap some Emacs's default keybinding.
(global-unset-key (kbd "C-v"))  ;; scroll-up-command
(global-unset-key (kbd "M-v"))  ;; scroll-down-command
(global-unset-key (kbd "C-t"))  ;; switch char
(global-unset-key (kbd "C-j"))  ;; (electric-newline-and-maybe-indent)
(global-set-key (kbd "M-n") 'scroll-up)
(global-set-key (kbd "M-p") 'scroll-down)

;; Use general to manage key bindings.
(use-package general
  :config
  (general-create-definer my/leader-key
    :prefix "M-m"))

;; Split window, keep consistent with my tmux configuration.
(my/leader-key
  "|" 'split-window-right
  "-" 'split-window-below)

(my/leader-key
  "t" '(:ignore t :which-key "Text")
  "b" '(:ignore b :which-key "Buffer")
  "p" '(:ignore p :which-key "Project"))

(use-package all-the-icons-ivy-rich
  :ensure t
  :init (all-the-icons-ivy-rich-mode 1))

(use-package ivy-rich
  :ensure t
  :init (ivy-rich-mode 1))
(use-package counsel
  :diminish
  :bind (("M-x" . counsel-M-x)
	 ("C-c f" . counsel-fzf)
	 ("C-x C-f" . counsel-find-file)
	 :map counsel-find-file-map
	 ("C-h" . counsel-up-directory)
	 :map minibuffer-local-map
	 ("C-r" . counsel-minibuffer-history))
  :config
  (setq ivy-initial-inputs-alist nil) ;; Don't start search with '^'
  (my/leader-key
    "bb" '(counsel-switch-buffer :which-key "Switch Buffer")))

(use-package swiper)
(use-package ivy
  :after swiper
  :diminish
  :bind (("C-s" . swiper-isearch)
	 ("C-r" . swiper-isearch-backward)
	 :map ivy-minibuffer-map
	 ("TAB" . ivy-alt-done)
	 ("C-l" . ivy-alt-done)
	 ;; I don't need these two lines since I love emacs key-bindings.
	 ;; ("C-j" . ivy-next-line)
	 ;; ("C-k" . ivy-previous-line)
	 :map ivy-switch-buffer-map
	 ("C-k" . ivy-previous-line)
	 ("C-l" . ivy-done)
	 ("C-d" . ivy-switch-buffer-kill)
	 :map ivy-reverse-i-search-map
	 ("C-k" . ivy-previous-line)
	 ("C-d" . ivy-reverse-i-search-kill))
  :config (ivy-mode 1))

(use-package ivy-xref
  :init
  ;; xref initialization is different in Emacs 27 - there are two different
  ;; variables which can be set rather than just one
  (when (>= emacs-major-version 27)
    (setq xref-show-definitions-function #'ivy-xref-show-defs))
  ;; Necessary in Emacs <27. In Emacs 27 it will affect all xref-based
  ;; commands other than xref-find-definitions (e.g. project-find-regexp)
  ;; as well
  (setq xref-show-xrefs-function #'ivy-xref-show-xrefs))

(use-package which-key
  :init (which-key-mode)
  :diminish which-key-mode
  :config (setq which-key-idle-delay 0.05))

(use-package ivy-rich
  :after ivy
  :init (ivy-rich-mode 1))

(use-package helpful
  :commands (helpful-callable helpful-variable helpful-command helpful-key)
  :custom
  (counsel-describe-function-function #'helpful-callable)
  (counsel-describe-variable-function #'helpful-variable)
  :bind
  ([remap describe-function] . counsel-describe-function)
  ([remap describe-command] . helpful-command)
  ([remap describe-variable] . counsel-describe-variable)
  ([remap describe-key] . helpful-key))

;; I don't need to load hydra ASAP.
(use-package hydra
  :config
  (defhydra hydra-text-scale (:timeout 3) "Scale text"
    ("k" text-scale-increase "in")
    ("j" text-scale-decrease "out")
    ("f" nil "finish" :exit t))
  (my/leader-key
    "ts" '(hydra-text-scale/body :which-key "Scale text")))

;; Navigate between window.
(use-package windmove
  :config
  (my/leader-key
    "h" '(windmove-left  :which-key "Window move left")
    "j" '(windmove-down  :which-key "Window move down")
    "k" '(windmove-up    :which-key "Window move up")
    "l" '(windmove-right :which-key "Window move right")))


(defun my/neotree-project-dir ()
  "Open NeoTree using the git root."
  (interactive)
  (let ((project-dir (projectile-project-root))
	(file-name (buffer-file-name)))
    (neotree-toggle)
    (if project-dir
	(if (neo-global--window-exists-p)
	    (progn
	      (neotree-dir project-dir)
	      (neotree-find file-name)))
      (message "Could not find git project root."))))
(use-package neotree
  :config
  (setq neo-theme (if (display-graphic-p) 'icons 'arrow))
  (my/leader-key
    "n" '(my/neotree-project-dir :which-key "Neotree toggle")))

(use-package sudo-edit
  :commands
  (sudo-edit))

(use-package magit
  :commands
  magit-status)
(use-package fzf)
(use-package rg)
(use-package projectile)

(use-package counsel-projectile
  :after (rg)
  :init (counsel-projectile-mode)
  :config
  (my/leader-key
    "pd" '(counsel-projectile-find-dir :which-key "Find dir")
    "pf" '(projectile-find-file :which-key "Find file")
    "pg" '(magit :which-key "Git")
    "ps" '(counsel-projectile-rg :which-key "Ripgrep")
    "pp" '(counsel-projectile-switch-project :which-key "Switch project")
    "pe" '(projectile-run-eshell :which-key "Run eshell")
    "pc" '(projectile-compile-project :which-key "Compile project")
    "pt" '(projectile-test-project :which-key "Test project")))

(use-package yasnippet
  :init
  (yas-global-mode 1)
  :config
  (setq yas-snippet-dirs
	'("~/.emacs.d/snippets/")))

;; Disable hightlight indent.
;; (use-package highlight-indent-guides
;;   :if (display-graphic-p)
;;   :diminish
;;   ;; Enable manually if needed, it a severe bug which potentially core-dumps Emacs
;;   ;; https://github.com/DarthFennec/highlight-indent-guides/issues/76
;;   :commands (highlight-indent-guides-mode)
;;   :hook
;;   (prog-mode . highlight-indent-guides-mode)
;;   :custom
;;   (highlight-indent-guides-method 'character)
;;   (highlight-indent-guides-responsive 'top)
;;   (highlight-indent-guides-delay 0)
;;   (highlight-indent-guides-auto-character-face-perc 7))

(use-package company)
(use-package lsp-mode
  :init
  ;; set prefix for lsp-command-keymap (few alternatives - "C-l", "C-c l")
  (setq lsp-keymap-prefix "M-m g")
  :hook
  ((python-mode . lsp) ;; pip install python-lsp-server --user
   (c-mode . lsp)
   (c++-mode . lsp)
   (go-mode . lsp)
   (rust-mode . lsp)
   (tuareg-mode . lsp) ;; opam install ocaml-lsp-server
   (lsp-mode . lsp-enable-which-key-integration))
  :commands
  lsp
  :config
  ;; "M-m g g b": Jump back in lsp-mode.
  (define-key lsp-command-map "gb" 'xref-pop-marker-stack))

;; optionally
(use-package lsp-ui
  :commands
  lsp-ui-mode)

(use-package lsp-ivy
  :commands
  lsp-ivy-workspace-symbol)

;; (use-package lsp-treemacs
;;  :commands
;;  lsp-treemacs-errors-list)

;; optionally if you want to use debugger
;; (use-package dap-mode)
;; (use-package dap-LANGUAGE) to load the dap adapter for your language

(use-package rust-mode
  :config
  (setq rust-format-on-save t)
  (add-hook 'rust-mode-hook
	    (lambda () (prettify-symbols-mode))))

(use-package go-mode)

(use-package yaml-mode)

(use-package tuareg
  :config
  (setq tuareg-match-patterns-aligned t))
(use-package ocamlformat) ;; opam install ocamlformat
;; Have a nice camel as the mode name
;; (add-hook 'before-save-hook 'ocamlformat-before-save)
(add-hook 'tuareg-mode-hook
	  (lambda() (setq tuareg-mode-name "🐫")))
;; Pretty symbols.
(add-hook 'tuareg-mode-hook
	  (lambda()
	    (when (functionp 'prettify-symbols-mode)
	      (prettify-symbols-mode))))

(use-package org-auto-tangle
  :hook
  (org-mode . org-auto-tangle-mode))

(with-eval-after-load 'org
  (org-babel-do-load-languages
   'org-babel-load-languages '((emacs-lisp . t)
			       (python . t)))
  (setq org-confirm-babel-evaluate nil)
  (setq org-startup-with-beamer-mode t)

  (setq org-latex-pdf-process '("xelatex -interaction nonstopmode %f"
				"xelatex -interaction nonstopmode %f"))

  (require 'org-tempo)
  (add-to-list 'org-structure-template-alist '("el" . "src emacs-lisp"))
  (add-to-list 'org-structure-template-alist '("py" . "src python"))
  (add-to-list 'org-structure-template-alist '("cpp" . "src cpp"))
  (add-to-list 'org-structure-template-alist '("go" . "src go")))

;; See: https://github.com/jschaf/esup/issues/54#issuecomment-651247749
(use-package esup
  :commands
  esup
  :config
  (setq esup-depth 0))
