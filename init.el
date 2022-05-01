(setq gc-cons-threshold 100000000) ;; Prevent GC?
(setq inhibit-startup-message t) ;; Disable the welcome message.
(scroll-bar-mode -1)             ;; Disable visible scrollbar.
(tool-bar-mode -1)               ;; Disable tooltips.
(set-fringe-mode 0)              ;; Give some breathing room.
(setq visible-bell t)            ;; Set up the visible bell.
(set-face-attribute 'default nil :font "Fira Code" :height 130)

;; Store all backup and autosave files in the tmp dir
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

;; Make ESC quit prompts
(global-set-key (kbd "<esc>") 'keyboard-escape-quit)
;; Magic key.
(define-prefix-command 'magic-key)
(global-set-key (kbd "M-m") 'magic-key)

;; Initialize package sources
(require 'package)
(setq package-archives
      '(("gnu" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
        ("melpa" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")
	("org" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/org/")))
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

(column-number-mode)
(global-display-line-numbers-mode t)

;; Disable line numbers for some modes.
(dolist (mode '(org-mode-hook
		term-mode-hook
		eshell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

(use-package command-log-mode)
(use-package swiper)
(use-package counsel
  :diminish
  :bind ((("M-x" . counsel-M-x)
	  ("C-x b" . counsel-ibuffer)
	  ("C-x C-f" . counsel-find-file)
	  :map minibuffer-local-map
	  ("C-r" . counsel-minibuffer-history)))
  :config
  (setq ivy-initial-inputs-alist nil)) ;; Don't start search with '^'

(use-package helm :diminish)

(use-package ivy
  :diminish
  :bind (("C-s" . swiper)
	 :map ivy-minibuffer-map
	 ("TAB" . ivy-alt-done)
	 ("C-l" . ivy-alt-done)
	 ("C-j" . ivy-next-line)
	 ("C-k" . ivy-previous-line)
	 :map ivy-switch-buffer-map
	 ("C-k" . ivy-previous-line)
	 ("C-l" . ivy-done)
	 ("C-d" . ivy-switch-buffer-kill)
	 :map ivy-reverse-i-search-map
	 ("C-k" . ivy-previous-line)
	 ("C-d" . ivy-reverse-i-search-kill))
  :config (ivy-mode 1))

(use-package all-the-icons) ;; Needed by doom-modeline
(use-package doom-modeline
  :init (doom-modeline-mode 1)
  :custom ((doom-modeline-height 15)))

(use-package fira-code-mode
  :custom (fira-code-mode-disabled-ligatures '("[]" "#{" "#(" "#_" "#_(" "x"))
  :hook prog-mode)

(use-package doom-themes
  :config
  (setq doom-themes-enable-bold t)
  (setq doom-themes-enable-italic t)
  (load-theme 'doom-dracula t))

(use-package page-break-lines)
(use-package dashboard
  :ensure t
  :config
  (dashboard-setup-startup-hook)
  (setq dashboard-startup-banner 'logo)
  (setq dashboard-set-file-icons t)
  (setq dashboard-center-content t))

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package which-key
  :init (which-key-mode)
  :diminish which-key-mode
  :config (setq which-key-idle-delay 0.2))

(use-package ivy-rich
  :init (ivy-rich-mode 1))

(use-package helpful
  :custom
  (counsel-describe-function-function #'helpful-callable)
  (counsel-describe-variable-function #'helpful-variable)
  :bind
  ([remap describe-function] . counsel-describe-function)
  ([remap describe-command] . helpful-command)
  ([remap describe-variable] . counsel-describe-variable)
  ([remap describe-key] . helpful-key))

;; Key bindings.
(use-package general
  :config
  (general-create-definer rune/my-leader-key
    :prefix "M-m"))

(rune/my-leader-key
  "|" 'split-window-right
  "-" 'split-window-below)

(use-package hydra)
(defhydra hydra-text-scale (:timeout 4) "Scale text"
  ("k" text-scale-increase "in")
  ("j" text-scale-decrease "out")
  ("f" nil "finish" :exit t))

(rune/my-leader-key
  "t" '(:ignore t :which-key "Text")
  "b" '(:ignore b :which-key "Buffer")
  "p" '(:ignore p :which-key "Project"))

(rune/my-leader-key
  "ts" '(hydra-text-scale/body :which-key "Scale text"))

(rune/my-leader-key
  "bb" '(helm-mini :which-key "Switch buffer"))

(use-package projectile
  :init (projectile-mode 1)
  :config
  (setq projectile-project-search-path '("~/x/gh/"))
  (rune/my-leader-key
    "pf" '(projectile--find-file :which-key "Find file")
    "pd" '(projectile-find-dir :which-key "Find dir")
    "ps" '(projectile-ag :which-key "Search in REGEXP")
    "pp" '(projectile-switch-project :which-key "Switch project")))

;; Currently, I don't use evil mode.
;; (Defun rune/evil-hook ()
;;   (dolist (mode '(custom-mode
;; 		  eshell-mode
;; 		  term-mode))
;;     (add-to-list 'evil-emacs-state-modes mode)))
;; 
;; (use-package evil
;;   :init
;;   (setq evil-want-integration t)
;;   (setq evil-want-keybinding t)
;;   (setq evil-want-C-u-scroll t)
;;   (setq evil-want-C-i-jump nil)
;;   :hook (evil-mode . rune/evil-hook)
;;   :config
;;   (evil-mode 1)
;;   (evil-set-initial-state 'message-buffer-mode 'normal)
;;   (evil-set-initial-state 'dashboard-mode 'normal))
