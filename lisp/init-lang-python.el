;;; init-lang-python.el --- initialize python language.  -*- lexical-binding: t; -*-

;; Copyright (C) 2025  Xing Guo

;; Author: Xing Guo <higuoxing@gmail.com>
;; Keywords: python

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

(with-eval-after-load 'eglot
    (add-to-list 'eglot-server-programs '(python-ts-mode . ("ty" "server"))))

;; python-ts-mode is defined in python.el
(use-package python
  :defer t
  :init
  (add-hook 'python-ts-mode-hook 'eglot-ensure)
  :hook (python-mode . python-ts-mode))

(provide 'init-lang-python)
;;; init-lang-python.el ends here
