;;; pde-load.el --- Configuration for PDE

;; Copyright (C) 2007 Free Software Foundation, Inc.
;;
;; Author: Ye Wenbin <wenbinye@gmail.com>
;; Maintainer: Ye Wenbin <wenbinye@gmail.com>
;; Created: 22 Dec 2007
;; Version: 0.01
;; Keywords: tools, convenience, languages

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2, or (at your option)
;; any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with this program; if not, write to the Free Software
;; Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.

;;; Commentary:

;; 

;; Put this file into your load-path and the following into your ~/.emacs:
;;   (require 'pde-load)

;;; Code:

(eval-when-compile
  (require 'cl))
(require 'pde-vars)
(require 'template-simple)
(add-to-list 'load-path
             (concat (file-name-as-directory pde-load-path) "contrib"))
(add-to-list 'template-directory-list
             (expand-file-name "templates" pde-load-path))

(defcustom pde-extra-setting t
  "*Non-nil means more settings."
  :type 'boolean
  :group 'pde)

;; autoloads
(load "pde-loaddefs")
(autoload 'pde-perl-mode-hook "pde" "Hooks run when enter perl-mode")

(require 'help-dwim)
(help-dwim-register
 '(perldoc . [ "0-9a-zA-Z_:." perldoc-obarray nil perldoc ])
 nil
 '((require 'perldoc)
   (perldoc-recache-everyday)))

(help-dwim-register
 '(perlapi . [ "a-zA-Z0-9_" perlapi-obarray nil perlapi ])
 nil
 '((require 'perlapi)))

(defalias 'perl-mode 'cperl-mode)

(setq ffap-url-regexp
      (concat
       "\\`\\("
       "news\\(post\\)?:\\|mailto:\\|file:" ; no host ok
       "\\|"
       "\\(ftp\\|https?\\|telnet\\|gopher\\|www\\|wais\\)://" ; needs host
       "\\)[^:]"             ; require one more character that not ":"
       ))
(eval-after-load "ffap"
  '(add-to-list 'ffap-alist '("." . pde-ffap-locate)))
(add-hook 'cperl-mode-hook 'pde-perl-mode-hook)

;; Extra setting that run only once
(when pde-extra-setting
  (require 'pde-patch)
  (require 'pde-abbv)
  ;; set it before load cperl-mode
  (setq cperl-invalid-face nil)
  (setq cperl-lazy-help-time 2)

  (setq completion-ignore-case t)
  ;; many DWIM commands work only in transient-mark-mode
  (transient-mark-mode t)

  (add-hook 'perldoc-mode-hook 'pde-tabbar-register)
  (autoload 'comint-dynamic-complete "comint" "Complete for file name" t)
  (autoload 're-builder "re-builder-x" "Construct a regexp interactively." t)
  (setq comint-completion-addsuffix '("/" . ""))
  (setq tags-table-list '("./TAGS" "../TAGS" "../../TAGS"))

  (global-set-key "\C-ch" 'help-dwim)
  (global-set-key "\C-xan" 'tempo-forward-mark)
  (global-set-key "\C-xap" 'tempo-backward-mark)
  (global-set-key "\C-xam" 'tempo-complete-tag)
  (global-set-key " " 'tempo-x-space)
  )

(provide 'pde-load)
;;; pde-load.el ends here
