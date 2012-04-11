;; Use cperl-mode instead of the default perl-mode
(add-to-list 'auto-mode-alist '("\\.\\([pP][Llm]\\|al\\)\\'" . cperl-mode))
(add-to-list 'interpreter-mode-alist '("perl" . cperl-mode))
(add-to-list 'interpreter-mode-alist '("perl5" . cperl-mode))
(add-to-list 'interpreter-mode-alist '("miniperl" . cperl-mode))

(add-to-list 'load-path
    		 (concat emacs-path "extension/PDE/lisp/"))
(load "pde-load")

(defun perl-settings ()
  "Settings for `perl'."
  (setq cperl-hairy t)

  (custom-set-faces
     '(cperl-array-face ((t (:foreground "green" :weight bold))))
     '(cperl-hash-face ((t (:foreground "yellow" :slant italic :weight bold))))
  )

  (defun cperl-eldoc-documentation-function ()
    "Return meaningful doc string for `eldoc-mode'."
    (car
     (let ((cperl-message-on-help-error nil))
       (cperl-get-help))))
  (add-hook 'cperl-mode-hook
            (lambda ()
              (set (make-local-variable 'eldoc-documentation-function)
                   'cperl-eldoc-documentation-function)))

  (setq-default indent-tabs-mode nil)

  ;;F11编译
  (defun perl-eval () "Run selected region as Perl code" (interactive)
     (shell-command-on-region (mark) (point) "perl "))
  (global-set-key (kbd "<f11>") 'perl-eval)
)

(eval-after-load "cperl-mode"
  `(perl-settings))

(provide 'perl-settings)
