(add-to-list 'load-path (concat emacs-path "extension/ruby-mode"))

(require 'ruby-mode)

(setq auto-mode-alist
      (append '(("//.rb$" . ruby-mode)) auto-mode-alist))
(setq interpreter-mode-alist (append '(("ruby" . ruby-mode))
                                     interpreter-mode-alist))
(autoload 'run-ruby "inf-ruby"
  "Run an inferior Ruby process")
(autoload 'inf-ruby-keys "inf-ruby"
  "Set local key defs for inf-ruby in ruby-mode")
(add-hook 'ruby-mode-hook
          '(lambda ()
            (inf-ruby-keys)))
(add-hook 'ruby-mode-hook 'turn-on-font-lock)

(define-key global-map (kbd "C-x r") 'run-ruby)

(autoload 'run-ruby
  "Run an inferior Ruby process, input and output via buffer *ruby*.
If there is a process already running in `*ruby*', switch to that buffer.
With argument, allows you to edit the command line (default is value
of `ruby-program-name').  Runs the hooks `inferior-ruby-mode-hook'
\(after the `comint-mode-hook' is run).
\(Type \\[describe-mode] in the process buffer for a list of commands.)" t)

(defun ruby-settings ()
  "Settings for `ruby'."
  (defun complete-or-indent-for-ruby (arg)
    (interactive "P")
    (complete-or-indent arg nil 'ruby-indent-command))

(define-key ruby-mode-map (kbd "TAB") 'complete-or-indent-for-ruby)
(define-key ruby-mode-map (kbd "C-j") 'goto-line)
(define-key ruby-mode-map (kbd "C-c C-c") 'comment)
(define-key ruby-mode-map (kbd "{") 'self-insert-command)
(define-key ruby-mode-map (kbd "}") 'self-insert-command)

  (defun ruby-keys ()
    "Ruby keys definition."
    (local-set-key (kbd "<return>") 'newline-and-indent))
  (add-hook 'ruby-mode-hook
            (lambda ()
              (setq ruby-indent-level 4)
              (ruby-electric-mode nil)
              (ruby-keys)) t)

  (defun ruby-mark-defun ()
    "Put mark at end of this Ruby function, point at beginning."
    (interactive)
    (push-mark (point))
    (ruby-end-of-defun)
    (push-mark (point) nil t)
    (ruby-beginning-of-defun))
)

(provide 'ruby-settings)
