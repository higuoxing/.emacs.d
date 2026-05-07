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

;; Scale fonts according to physical dpi detection.
(defun my/apply-font-size-by-resolution (&optional frame)
  "Adjust font height based on monitor width. Safety checked for nil values."
  (let* ((f (or frame (selected-frame)))
         (monitor-attrs (frame-monitor-attributes f))
         (geometry (assoc 'geometry monitor-attrs))
         ;; Use 0 as fallback if width is nil to prevent the 'number-or-marker-p' error
         (width (or (nth 3 geometry) 0))
         ;; 140 (14pt) for 4K/Ultrawide, 110 (11pt) for standard
         (font-size (if (>= width 2500) 160 150)))
    ;; Only apply if we actually got a valid width > 0
    (when (> width 0)
      (set-face-attribute 'default f :height font-size))))
;; Apply to every new frame created
(add-hook 'after-make-frame-functions #'my/apply-font-size-by-resolution)
;; Re-check when Emacs gains focus (useful when dragging between monitors)
(add-hook 'focus-in-hook #'my/apply-font-size-by-resolution)

;; Scale frame according to physical dpi detection.
(defun my/set-initial-frame-size (&optional frame)
  "Set the frame width and height based on monitor resolution."
  (let* ((f (or frame (selected-frame)))
         (monitor-attrs (frame-monitor-attributes f))
         (geometry (assoc 'geometry monitor-attrs))
         (width (or (nth 3 geometry) 0)))
    (when (> width 0)
      (if (>= width 2500)
          ;; Settings for 4K / Large Displays
          (progn
            (set-frame-width f 120)  ; 120 columns wide
            (set-frame-height f 50)) ; 50 rows tall
        ;; Settings for Standard Displays
        (progn
          (set-frame-width f 100)
          (set-frame-height f 40))))))
;; Hook it into frame creation
(add-hook 'after-make-frame-functions #'my/set-initial-frame-size)
;; Apply to the very first frame
(add-hook 'window-setup-hook (lambda () (my/set-initial-frame-size)))

(provide 'init-ui)
;;; init-ui.el ends here
