(setq load-path (cons "~/.emacs.d/extension/emacs-rails" load-path))
(add-to-list 'load-path (concat emacs-path "extension/rhtml-mode"))

(require 'rails)
(require 'two-mode-mode)
(require 'rhtml-mode)
     (add-hook 'rhtml-mode-hook
     	  (lambda () (rinari-launch)))

(define-key rhtml-mode-map [(return)] 'newline-and-indent)
(define-key rhtml-mode-map (kbd "TAB") 'complete-or-indent-for-ruby)

(autoload 'rhtml-minor-mode "rhtml-minor-mode"
  "Minor mode for .rhtml files"
  t)
(defun rhtml-modes ()
  (two-mode-mode)
  (rhtml-minor-mode))
(setq auto-mode-alist (cons '("\\.rhtml$" . rhtml-modes) auto-mode-alist))

(setq auto-mode-alist (cons '("\\.jsp$" . java-mode) auto-mode-alist))

(autoload 'css-mode "css-mode"
  "Major mode for editing CSS style sheets.
\\{cssm-mode-map}"
  t)
(setq auto-mode-alist (cons '("\\.css\\'" . css-mode) auto-mode-alist))

(provide 'rails-settings)
