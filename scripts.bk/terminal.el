;; This file contains configuration for terminal.

(use-package shell-pop
  :ensure t
  :bind (("C-x t" . shell-pop))
  :config
  (setq shell-pop-shell-type (quote ("ansi-term" "*ansi-term*" (lambda nil (ansi-term shell-pop-term-shell)))))
  (setq shell-pop-term-shell "/bin/bash")
  (setq shell-pop-window-size 30)
  (setq shell-pop-window-position "bottom")
  ;; Must add this line. Magic!
  (shell-pop--set-shell-type 'shell-pop-shell-type shell-pop-shell-type))
