;; This file contains configuration for file tree browser.

(use-package neotree
  :ensure t)
(global-set-key (kbd "C-x f") 'neotree-toggle)

;; Display icons
(setq neo-theme (if (display-graphic-p) 'icons 'arrow))
(setq neo-smart-open t)
