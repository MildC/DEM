(defun cc-mode-settings ()
  "Settings for `cc-mode'."
  (defun c-mode-common-hook-settings ()
    "Settings for `c-mode-common-hook'."
    (c-set-style "awk")
    ;; 饥饿的删除键
    (c-toggle-hungry-state)
    ;; 对subword进行操作，而不是整个word
    (subword-mode t))

  (setq-default c-default-style "linux"		;缩进风格为Linux内核开发风格
			  tab-width 4		;tab大小设置
			  c-basic-offset 4	;自动缩进大小
			  indent-tabs-mode t)	;自动缩进使用的是tab而非空格

  (setq indent-tabs-mode t)

  (add-hook 'c-mode-common-hook 'c-mode-common-hook-settings)

  (add-to-list 'auto-mode-alist '("\\.h$" . c++-mode))

  ;; 高亮显示C/C++中的可能的错误(CWarn mode)
  (global-cwarn-mode 1)

  ;;F11编译
  (define-key c-mode-base-map [(f11)] 'compile)
  '(compile-command "make")

  ;;gdb-many-windows
  (setq gdb-many-windows t)
  (load-library "multi-gud.el")
  (load-library "multi-gdb-ui.el")

  (defalias 'cpp-mode 'c++-mode))

(eval-after-load "cc-mode"
  `(cc-mode-settings))

(provide 'c-settings)


