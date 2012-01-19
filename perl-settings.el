;; Use cperl-mode instead of the default perl-mode
(add-to-list 'auto-mode-alist '("\\.\\([pP][Llm]\\|al\\)\\'" . cperl-mode))
(add-to-list 'interpreter-mode-alist '("perl" . cperl-mode))
(add-to-list 'interpreter-mode-alist '("perl5" . cperl-mode))
(add-to-list 'interpreter-mode-alist '("miniperl" . cperl-mode))

(add-to-list 'load-path
    		 (concat emacs-path "extension/pde/lisp/"))
(load "pde-load")

(defun perl-eval () "Run selected region as Perl code" (interactive)
   (shell-command-on-region (mark) (point) "perl "))
(global-set-key (kbd "<f11>") 'perl-eval)

(provide 'perl-settings)