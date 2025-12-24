;;; init-ui.el --- initialize UI.                    -*- lexical-binding: t; -*-

;; Copyright (C) 2025  Xing Guo

;; Author: Xing Guo <higuoxing@gmail.com>
;; Keywords: lisp, ui

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <https://www.gnu.org/licenses/>.

;;; Commentary:

;; 

;;; Code:

;; doom-modeline requires nerd-fonts.
;; To install run:
;; (nerd-icons-install-fonts)
(use-package doom-modeline
  :straight t
  :hook (after-init . doom-modeline-mode)
  :config
  (setq doom-modeline-project-detection 'project))

;; If Emacs is running in terminal, load modus-vivendi-tritanopia theme.
(unless (display-graphic-p)
  (load-theme 'modus-vivendi-tritanopia))

;; Display bell in the echo area.
(use-package echo-bell
  :straight t
  :config
  ;; The alignment seems incorrect under MacOS terminal, fix it with advice-add.
  (defun my/echo-bell-update ()
    "Customized `echo-bell-update' for `echo-bell-mode'."
    (setq echo-bell-propertized-string
          (propertize
           (concat (propertize
                    " "			; Space char
                    'display `(space :align-to (- right ,(string-width echo-bell-string) 1)))
                   echo-bell-string)
           'face `(:background ,(if (boundp 'echo-bell-background) ; For first use only.
                                    echo-bell-background
                                  "Aquamarine"))))
    (setq echo-bell-cached-string  echo-bell-string))
  (advice-add 'echo-bell-update :override #'my/echo-bell-update)
  ;; Set echo-bell-cached-string to nil to force update.
  (setq echo-bell-cached-string nil)
  (echo-bell-mode))

(provide 'init-ui)
;;; init-ui.el ends here
