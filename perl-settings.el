;;; cperl-mode is preferred to perl-mode                                        
;;; "Brevity is the soul of wit" <foo at acm.org>                               
(defalias 'perl-mode 'cperl-mode)

;;自动缩进
;(define-key perl-mode-map [(return)] 'newline-and-indent)

(add-hook 'cperl-mode-hook
    (lambda ()
        (local-set-key (kbd "C-h f") 'cperl-perldoc)))

(defalias 'perl-mode 'cperl-mode)
(defun pde-perl-mode-hook ()
  (abbrev-mode t)
  (add-to-list 'cperl-style-alist
               '("PDE"
                 (cperl-auto-newline                         . t)
                 (cperl-brace-offset                         . 0)
                 (cperl-close-paren-offset                   . -4)
                 (cperl-continued-brace-offset               . 0)
                 (cperl-continued-statement-offset           . 4)
                 (cperl-extra-newline-before-brace           . nil)
                 (cperl-extra-newline-before-brace-multiline . nil)
                 (cperl-indent-level                         . 4)
                 (cperl-indent-parens-as-block               . t)
                 (cperl-label-offset                         . -4)
                 (cperl-merge-trailing-else                  . t)
                 (cperl-tab-always-indent                    . t)))
  (cperl-set-style "PDE"))

(defun perl-eval () "Run selected region as Perl code" (interactive)
   (shell-command-on-region (mark) (point) "perl "))
(global-set-key (kbd "<f11>") 'perl-eval)

(provide 'perl-settings)
