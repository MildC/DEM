;(require 'util)
;(require 'ahei-misc)

;; 语法高亮
(global-font-lock-mode t)

;;自动补全括号
(defun my-common-mode-auto-pair () 
(interactive) 
(make-local-variable 'skeleton-pair-alist) 
(setq skeleton-pair-alist '( 
(? ? _ "''")
(? ? _ """")
))
(setq skeleton-pair t)
(local-set-key (kbd "\"") 'skeleton-pair-insert-maybe) 
(local-set-key (kbd "\'") 'skeleton-pair-insert-maybe))

(add-hook 'c-mode-hook 'my-common-mode-auto-pair)
(add-hook 'c++-mode-hook 'my-common-mode-auto-pair)
(add-hook 'ruby-mode-hook 'my-common-mode-auto-pair)
(add-hook 'lisp-mode-hook 'my-common-mode-auto-pair)
(add-hook 'emacs-lisp-mode-hook 'my-common-mode-auto-pair)
(add-hook 'java-mode-hook       'my-common-mode-auto-pair)
(add-hook 'ess-mode-hook       'my-common-mode-auto-pair)
(add-hook 'perl-mode-hook       'my-common-mode-auto-pair)
(add-hook 'cperl-mode-hook       'my-common-mode-auto-pair)
(add-hook 'sh-mode-hook         'my-common-mode-auto-pair)

;; 绑定括号转跳到%，和vi相同
(global-set-key "%" 'match-paren)
;;定义在括号上按下时，那么匹配括号，否则输入一个 %
(defun match-paren (arg)
  "Go to the matching paren if on a paren; otherwise insert %."
  (interactive "p")
  (cond ((looking-at "\\s\(") (forward-list 1) (backward-char 1))
 ((looking-at "\\s\)") (forward-char 1) (backward-list 1))
 (t (self-insert-command (or arg 1)))))

;; hs-minor-mode,折叠代码
(add-hook 'lisp-mode-hook 'hs-minor-mode)
(add-hook 'c-mode-common-hook   'hs-minor-mode)
(add-hook 'emacs-lisp-mode-hook 'hs-minor-mode)
(add-hook 'java-mode-hook       'hs-minor-mode)
(add-hook 'ess-mode-hook       'hs-minor-mode)
(add-hook 'perl-mode-hook       'hs-minor-mode)
(add-hook 'sh-mode-hook         'hs-minor-mode)
;;设置F10为代码折叠快捷键
(global-set-key [f10] 'hs-toggle-hiding)

;;======================			拷贝代码自动格式化		  =====================
;;Emacs 里对代码的格式化支持的非常好，不但可以在编辑的时候自动帮你格式化，还可以选中一块代码，
;;按 Ctrl-Alt-\ 对这块代码重新进行格式化.如果要粘贴一块代码的话，粘贴完了紧接着按 Ctrl-Alt-\,
;;就可以把新加入的代码格式化好。可是，对于这种粘贴加上重新格式化的机械操作，Emacs 应该可以将
;;它自动化才能配得上它的名气，把下面的代码加到配置文件里，你的 Emacs 就会拥有这种能力了
(dolist (command '(yank yank-pop))
  (eval
   `(defadvice ,command (after indent-region activate)
	  (and (not current-prefix-arg)
		   (member major-mode
				   '(
					 c-mode
					 c++-mode
					 clojure-mode
					 emacs-lisp-mode
					 haskell-mode
					 js-mode
					 latex-mode
						lisp-mode
					 objc-mode
					 perl-mode
					 cperl-mode
					 plain-tex-mode
					 python-mode
					 rspec-mode
						ruby-mode
					 scheme-mode))
		   (let ((mark-even-if-inactive transient-mark-mode))
			 (indent-region (region-beginning) (region-end) nil))))))

;; 动态检查语法错误
;;flymake配置，需要Makefile支持
;;;;check-syntax:
;;;;	$(CXXCOMPILE) -Wall -Wextra -pedantic -fsyntax-only $(CHK_SOURCES)
;;不需要ahei的eval函数调用
;;基本配置
(autoload 'flymake-find-file-hook "flymake" "" t)
(add-hook 'find-file-hook 'flymake-find-file-hook)
(setq flymake-gui-warnings-enabled nil)
(setq flymake-log-level 0)
;;minibuffer显示错误信息
(defun flymake-display-current-error ()
  "Display errors/warnings under cursor."
  (interactive)
  (let ((ovs (overlays-in (point) (1+ (point)))))
    (catch 'found
      (dolist (ov ovs)
        (when (flymake-overlay-p ov)
          (message (overlay-get ov 'help-echo))
          (throw 'found t))))))
(defun flymake-goto-next-error-disp ()
  "Go to next error in err ring, then display error/warning."
  (interactive)
  (flymake-goto-next-error)
  (flymake-display-current-error))
(defun flymake-goto-prev-error-disp ()
  "Go to previous error in err ring, then display error/warning."
  (interactive)
  (flymake-goto-prev-error)
  (flymake-display-current-error))
;;函数按键绑定
(defvar flymake-mode-map (make-sparse-keymap))
(define-key flymake-mode-map (kbd "C-c N") 'flymake-goto-next-error-disp)
(define-key flymake-mode-map (kbd "C-c P") 'flymake-goto-prev-error-disp)
(define-key flymake-mode-map (kbd "C-c M-w")
  'flymake-display-err-menu-for-current-line)
(or (assoc 'flymake-mode minor-mode-map-alist)
    (setq minor-mode-map-alist
          (cons (cons 'flymake-mode flymake-mode-map)
                minor-mode-map-alist)))

;; 始终打开which-func-mode
(which-func-mode 1)

;; cedet 强大的开发工具, 包括代码浏览, 补全, 类图生成
;; 用CEDET浏览和编辑C++代码 http://emacser.com/cedet.htm
;; Emacs才是世界上最强大的IDE － cedet的安装 http://emacser.com/install-cedet.htm
(require 'cedet-settings)

;; ecb配置
(add-to-list 'load-path (concat emacs-path "extension/ecb"))
(require 'ecb)

;;c/c++设置
(require 'c-settings)

;; ruby
(require 'ruby-settings)

;; rails
(require 'rails-settings)

;; perl
(require 'perl-settings)

;; 所有的自动补全的配置
(require 'all-auto-complete-settings)

(provide 'dev-settings)
