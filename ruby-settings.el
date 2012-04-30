(add-to-list 'load-path (concat emacs-path "extension/ruby-mode"))

(add-to-list 'load-path (concat emacs-path "extension/flymake-ruby"))
(require 'flymake-ruby)
(add-hook 'ruby-mode-hook 'flymake-ruby-load)

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

(autoload 'run-ruby
  "Run an inferior Ruby process, input and output via buffer *ruby*.
If there is a process already running in `*ruby*', switch to that buffer.
With argument, allows you to edit the command line (default is value
of `ruby-program-name').  Runs the hooks `inferior-ruby-mode-hook'
\(after the `comint-mode-hook' is run).
\(Type \\[describe-mode] in the process buffer for a list of commands.)" t)

(defun ruby-settings ()
  "Settings for `ruby'."

  ;; flymake settings
  (set-face-background 'flymake-errline "red4")
  (set-face-background 'flymake-warnline "dark slate blue")

  (define-key global-map (kbd "<f11>") 'run-ruby)

)

(eval-after-load "ruby-mode"
  `(ruby-settings))

(provide 'ruby-settings)
