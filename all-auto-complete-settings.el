;; hippie expand
(global-set-key [(control tab)] 'hippie-expand)
;;;hippie的自动补齐策略，优先调用了senator的分析结果：
(autoload 'senator-try-expand-semantic "senator")
(setq hippie-expand-try-functions-list
      '(
        senator-try-expand-semantic
        try-expand-dabbrev
        try-expand-dabbrev-visible
        try-expand-dabbrev-all-buffers
        try-expand-dabbrev-from-kill
        try-expand-list
        try-expand-list-all-buffers
        try-expand-line
        try-expand-line-all-buffers
        try-complete-file-name-partially
        try-complete-file-name
        try-expand-whole-kill
        )
      )

;;yasnippet配置
(add-to-list 'load-path
			 (concat emacs-path "extension/yasnippet/"))
(require 'yasnippet) ;; not yasnippet-bundle
(yas/initialize)
(yas/load-directory (concat emacs-path "extension/yasnippet/snippets"))

;; 自动补全
(add-to-list 'load-path (concat emacs-path "extension/auto-complete"))
(require 'auto-complete+)
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories (concat emacs-path "extension/auto-complete/ac-dict"))
(ac-config-default)
(require 'auto-complete-yasnippet)
(ac-set-trigger-key "TAB")

(provide 'all-auto-complete-settings)
