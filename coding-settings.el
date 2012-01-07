;; 全局设置UTF-8防止乱码

(set-language-environment 'Chinese-GB)
(set-keyboard-coding-system 'utf-8)
(set-clipboard-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-buffer-file-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(modify-coding-system-alist 'process "*" 'utf-8)
(setq default-process-coding-system 
            '(utf-8 . utf-8))
(setq-default pathname-coding-system 'utf-8)
(set-file-name-coding-system 'utf-8)

;; 英文字体
(set-frame-font "Ubuntu Mono-12")
;;;(set-frame-font "Monaco-10")

;; 中文字体
(set-fontset-font "fontset-default" 'han '("文泉驿等宽微米黑"))

;; 配置ibus
(require 'ibus)
(add-hook 'after-init-hook 'ibus-mode-on)
;;设置C-Space toggle ibus
;(ibus-define-common-key (kbd "C-SPC") nil)
;(global-set-key (kbd "C-SPC") 'ibus-toggle)

;; shell-mode中防止乱码出现
(ansi-color-for-comint-mode-on)

(provide 'coding-settings)
