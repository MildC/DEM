;; hippie expand

(global-set-key [(control tab)] 'hippie-expand)

;;;hippie的自动补齐策略，优先调用了senator的分析结果：
(defun hippie-expand-settings ()
  "Settings for `hippie-expand'."
  (setq hippie-expand-try-functions-list
        '(try-expand-dabbrev
          try-expand-dabbrev-visible
          try-expand-dabbrev-all-buffers
          try-expand-dabbrev-from-kill
          try-complete-file-name-partially
          try-complete-file-name
          try-expand-all-abbrevs
          try-expand-list
          try-expand-line
          try-complete-lisp-symbol-partially
          try-complete-lisp-symbol
          try-expand-whole-kill))

  (am-add-hooks
   `(emacs-lisp-mode-hook lisp-interaction-mode-hook)
   '(lambda ()
      (make-local-variable 'hippie-expand-try-functions-list)
      (setq hippie-expand-try-functions-list
            '(try-expand-dabbrev
              try-expand-dabbrev-visible
              try-expand-dabbrev-all-buffers
              try-expand-dabbrev-from-kill
              try-complete-file-name-partially
              try-complete-file-name
              try-expand-all-abbrevs
              try-expand-list
              try-expand-line
              try-expand-whole-kill)))))

(eval-after-load "hippie-exp"
  `(hippie-expand-settings))

;;yasnippet配置
(add-to-list 'load-path
			 (concat emacs-path "extension/yasnippet/"))
(require 'yasnippet) ;; not yasnippet-bundle
(yas/global-mode t) 
(setq yas/snippet-dirs '(concat emacs-path "extension/yasnippet/snippets"))

;; 自动补全
(require 'auto-complete-settings)

(provide 'all-auto-complete-settings)
