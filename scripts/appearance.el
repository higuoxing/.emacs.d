;; This file contains configuration for my Emacs configuration.
;; e.g. Theme, modeline, and so on ..

;; Use dracula theme.
(use-package dracula-theme
  :ensure t)
(load-theme 'dracula t)

;; Disable tool bar.
(tool-bar-mode -1)

;; Display line number.
(global-display-line-numbers-mode)

;; Set startup window size.
(if (display-graphic-p)
    (progn
      (setq initial-frame-alist
	    '((width . 100)
	      (height . 100)
	      (right . 50)
	      (font . "Hack 12")))
      (setq default-frame-alist
	    '((width . 100)
	      (height . 100)
	      (right . 50)
	      (font . "Hack 12"))))
  (progn
    (setq initial-frame-alist '())
    (setq default-frame-alist '())))

;; Use all-the-icons.
(use-package all-the-icons
  :ensure t)

;; Use doom-modeline.
;(use-package doom-modeline
;  :ensure t
;  :hook (after-init . doom-modeline-mode))
;(setq doom-modeline-icon (display-graphic-p))

;; Spaceline
(use-package spaceline-config
  :config
  (setq powerline-default-separator 'wave))
(spaceline-spacemacs-theme)

;; Use nyan-mode to display nyan-cat.
(use-package nyan-mode
  :ensure t
  ;; Enable at start
  :hook (after-init . nyan-mode)
  :hook (after-init . nyan-start-animation))
