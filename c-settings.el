(require 'cc-mode)
(setq-default c-default-style "linux"		;缩进风格为Linux内核开发风格
			  tab-width 4		;tab大小设置
			  c-basic-offset 4	;自动缩进大小
			  indent-tabs-mode t)	;自动缩进使用的是tab而非空格

;;自动缩进
(define-key c-mode-base-map [(return)] 'newline-and-indent)

;;F11编译
(define-key c-mode-base-map [(f11)] 'compile)
'(compile-command "make")

;;gdb-many-windows
(setq gdb-many-windows t)
(load-library "multi-gud.el")
(load-library "multi-gdb-ui.el")

;;Cpp/h文件跳转
(require 'eassist nil 'noerror)
(setq eassist-header-switches
      '(("h" . ("cpp" "cxx" "c++" "CC" "cc" "C" "c" "mm" "m"))
        ("hh" . ("cc" "CC" "cpp" "cxx" "c++" "C"))
        ("hpp" . ("cpp" "cxx" "c++" "cc" "CC" "C"))
        ("hxx" . ("cxx" "cpp" "c++" "cc" "CC" "C"))
        ("h++" . ("c++" "cpp" "cxx" "cc" "CC" "C"))
        ("H" . ("C" "CC" "cc" "cpp" "cxx" "c++" "mm" "m"))
        ("HH" . ("CC" "cc" "C" "cpp" "cxx" "c++"))
        ("cpp" . ("hpp" "hxx" "h++" "HH" "hh" "H" "h"))
        ("cxx" . ("hxx" "hpp" "h++" "HH" "hh" "H" "h"))
        ("c++" . ("h++" "hpp" "hxx" "HH" "hh" "H" "h"))
        ("CC" . ("HH" "hh" "hpp" "hxx" "h++" "H" "h"))
        ("cc" . ("hh" "HH" "hpp" "hxx" "h++" "H" "h"))
        ("C" . ("hpp" "hxx" "h++" "HH" "hh" "H" "h"))
        ("c" . ("h"))
        ("m" . ("h"))
        ("mm" . ("h"))))
(define-key c-mode-base-map [M-f12] 'eassist-switch-h-cpp)

;;函数声明/实现跳转
(define-key c-mode-base-map [M-S-f12] 'semantic-analyze-proto-impl-toggle)

(provide 'c-settings)


