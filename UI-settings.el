;; 去掉欢迎屏幕
(custom-set-variables
 '(ecb-options-version "2.40")
 '(inhibit-startup-screen t))
(custom-set-faces
 )

;; scratch初始无字符
(setq initial-scratch-message "")

;; 启动时大小位置
(setq default-frame-alist 
'((height . 40)(width . 160)(top . 120) (left . 180) (menu-bar-lines . 20) (tool-bar-lines . 0)))

;; 设置标题栏显示文件的完整路径名 
(setq frame-title-format 
'("%S" (buffer-file-name "%f" 
        (dired-directory dired-directory "%b"))))

;; mode-line时间格式设置
(setq display-time-24hr-format t)
;; mode-line显示日期与时间
(display-time)
(global-set-key "\M-o" 'other-window)
(global-set-key "\M-k" 'kill-this-buffer)

;; 设置color-theme
(add-to-list 'load-path (concat emacs-path "color-theme"))
(require 'color-theme)
(color-theme-initialize)
(require 'color-theme-awesome)
(color-theme-awesome)

;; 显示列号
(setq column-number-mode t)
(setq line-number-mode t)
(global-linum-mode t)

;; 显示配对括号
(setq show-paren-delay 0)
(show-paren-mode t)

;; whitespace-mode
;;; To insert a literal tab char, press 【Ctrl+q Tab】.
;;; To type a newline char, type 【Ctrl+q Ctrl+j】.
(global-whitespace-mode t)
(setq whitespace-style (quote
  ( spaces tabs newline space-mark tab-mark newline-mark)))
(setq whitespace-display-mappings
 '(
   ;(space-mark 32 [183] [46]) ; normal space, ·
   (space-mark 160 [164] [95])
   (space-mark 2208 [2212] [95])
   (space-mark 2336 [2340] [95])
   (space-mark 3616 [3620] [95])
   (space-mark 3872 [3876] [95])
   (newline-mark 10 [8629 10]) ; newlne, ↵
   (tab-mark 9 [8614 9] [92 9]) ; tab, ↦
))
(global-set-key (kbd "s-SPC") 'delete-trailing-whitespace)

(provide 'UI-settings)
