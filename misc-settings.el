;; 个人信息
(setq user-mail-address "kevin.xizhu@gmail.com")
(setq user-full-name    "Kevin Zhu")

(setq-default default-directory "~")

;; 支持emacs和外部程序的粘贴
(setq x-select-enable-clipboard t)

;; Emacs找不到合适的模式时，缺省使用text-mode
(setq default-major-mode 'text-mode)

;; 用 y/n 代替yes or no
(fset 'yes-or-no-p 'y-or-n-p)

;; 设置书签文件
(setq bookmark-default-file (concat emacs-path ".emacs.bmk"))

;; ido模式默认开启
;;要在Buffers中循环选择，则要用上C-s(next)或是C-r(previous)这两个命令
;;用C-f直接退出到打开文件的环境。
(require 'ido)
(ido-mode t)
(setq ido-save-directory-list-file nil)

;; F9切换窗口
(global-set-key [(f9)] 'other-window)

;; 在行首 C-k 时，同时删除该行
(setq-default kill-whole-line t)

;; 设置pinbar
;;M-0 加标签
;;M-- M-0 移除所有标签
;;M - 1~9 访问标签
(require 'pinbar)
(global-set-key "\M-0" 'pinbar-add)
(pinbar-mode t)

;; 设置文件备份
(setq make-backup-files t)
(setq version-control t)
(setq kept-old-versions 1)
(setq kept-new-versions 3)
(setq delete-old-versions t)
(setq backup-directory-alist '(("." . "~/.emacs.d/backups/")))
;;不生成#F#文件
(setq auto-save-default nil)

;; 可以保存你上次光标所在的位置
(require 'saveplace)
(setq-default save-place t)

;; 光标靠近鼠标指针时，让鼠标指针自动让开，别挡住视线。
(mouse-avoidance-mode 'animate)

;; 不保存连续的重复的kill
(setq kill-do-not-save-duplicates t)

;; 先格式化再补全
(setq tab-always-indent 'complete)

;; 把C-x C-u也定义成undo
(define-key global-map "\C-x\C-u" 'undo)

;; 重新绑定C-z到undo
(global-set-key (kbd "C-z") 'undo)

;; 密码不显示明文
(add-hook 'comint-output-filter-functions 'comint-watch-for-password-prompt)

;; set-mark-command 绑定C-2，原来是C-@
(if window-system
    (define-key global-map (kbd "C-2") 'set-mark-command))

;;智能标记绑定在 C-3 上。就是根据光标的所在位置，智能的选择一块区域，也就
;;是设置成为当前的 point 和 mark。这样就可以方便的拷贝或者剪切，或者交换他们的位
;;置。
;;如果当前光标在一个单词上，那么区域就是这个单词的开始和结尾分别。
;;如果当前光标在一个连字符上，那么就选择包含连字符的一个标识符。
;;这个两个的是有区别的，而且根据不同的 mode 的语法定义，连字符和单词的定义也不一样。
;;例如 C mode 下， abc_def_xxx , 如果光标停在 abc 上，那么就会选择 abc 这个单
;;词。 如果停在下划线上，那么就会选择 abc_def_xxx 。
;;如果当前光标在一个双引号,单引号，一个花括号，方括号，圆括号，小于号，或者大于号，
;;等等，那么就会选择他们对应的另一个括号之间的区域。 引号中的 escape 字符也是可以
;;自动识别的。嵌套关系也是可以识别的。这一点可以和 VIM 中的 % 的功能类比。

(defun wcy-mark-some-thing-at-point()
  (interactive)
  (let* ((from (point))
         (a (mouse-start-end from from 1))
         (start (car a))
         (end (cadr a))
         (goto-point (if (= from start )
                            end
                       start)))
    (if (eq last-command 'wcy-mark-some-thing-at-point)
        (progn
          ;; exchange mark and point
          (goto-char (mark-marker))
          (set-marker (mark-marker) from))
      (push-mark (if (= goto-point start) end start) nil t)
      (when (and (interactive-p) (null transient-mark-mode))
        (goto-char (mark-marker))
        (sit-for 0 500 nil))
      (goto-char goto-point))))
(define-key global-map (kbd "C-3") 'wcy-mark-some-thing-at-point)

;; C-w 绑定向前删除一个word
(defmacro wcy-define-2bind-transient-mode (funname cmd-mark-active
                                                   cmd-mark-no-active)
  `(defun ,funname ()
     (interactive)
     (if mark-active
         (call-interactively ,cmd-mark-active)
       (call-interactively ,cmd-mark-no-active))))
;; 和 bash 中的类似的快键，不用再按 backspace 了。
(global-set-key "\C-w"     'wcy-backward-kill-word-or-kill-region)
(wcy-define-2bind-transient-mode
 wcy-backward-kill-word-or-kill-region
 'kill-region
 'backward-kill-word)

;;快速复制一行
(defun copy-line (&optional arg)
  "Save current line into Kill-Ring without mark the line "
   (interactive "P")
   (let ((beg (line-beginning-position)) 
  (end (line-end-position arg)))
     (copy-region-as-kill beg end))
 )
(global-set-key (kbd "C-c l") (quote copy-line))

(eal-define-keys-commonly
 global-map
 `(;; 使终端支持鼠标
   ("C-x T"            xterm-mouse-mode)))

(provide 'misc-settings)
