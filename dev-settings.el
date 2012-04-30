;; 语法高亮
(global-font-lock-mode t)

;; 回车后indent
(eal-define-keys
 `(lisp-mode-map emacs-lisp-mode-map lisp-interaction-mode-map sh-mode-map
                 awk-mode-map java-mode-map
                 ruby-mode-map c-mode-base-map tcl-mode-map org-mode-map
                 python-mode-map perl-mode-map)
 `(("RET" newline-and-indent)))



(defun generate-tag-table ()
  "Generate tag tables under current directory(Linux)."
  (interactive)
  (let ((exp "") (dir ""))
    (setq dir (read-from-minibuffer "generate tags in: " default-directory)
          exp (read-from-minibuffer "suffix: "))
    (with-temp-buffer
      (shell-command
       (concat "find " dir " -name \"" exp "\" | xargs etags ")
       (buffer-name)))))

;;自动补全引号括号
(defun my-common-mode-auto-pair () 
(interactive) 
(make-local-variable 'skeleton-pair-alist) 
(setq skeleton-pair-alist '( 
(? ? _ "''")
(? ? _ """")
(? ? _ "()")
(? ? _ "[]")
;(?{ \n > _ \n ?} >)))
(? ? _ "{}")))
(setq skeleton-pair t)
(local-set-key (kbd "(") 'skeleton-pair-insert-maybe) 
(local-set-key (kbd "\"") 'skeleton-pair-insert-maybe) 
(local-set-key (kbd "{") 'skeleton-pair-insert-maybe) 
(local-set-key (kbd "\'") 'skeleton-pair-insert-maybe) 
(local-set-key (kbd "[") 'skeleton-pair-insert-maybe)) 

(am-add-hooks
 `(c-mode-common-hook lisp-mode-hook emacs-lisp-mode-hook java-mode-hook ruby-mode-hook ess-mode-hook perl-mode-hook cperl-mode-hook ruby-mode-hook sh-mode-hook)
 'my-common-mode-auto-pair)

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
(am-add-hooks
 `(c-mode-common-hook lisp-mode-hook emacs-lisp-mode-hook java-mode-hook perl-mode-hook cperl-mode-hook ruby-mode-hook)
 'hs-minor-mode)
(defun hs-minor-mode-settings ()
  "settings of `hs-minor-mode'."
  (setq hs-isearch-open t)
  (define-key hs-minor-mode-map [(f8)] 'hs-toggle-hiding)
)

(eval-after-load "hideshow"
  '(hs-minor-mode-settings))

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
(require 'flymake-settings)

;; 始终打开which-func-mode
(which-func-mode 1)

;; cedet 强大的开发工具, 包括代码浏览, 补全, 类图生成
;; 用CEDET浏览和编辑C++代码 http://emacser.com/cedet.htm
;; Emacs才是世界上最强大的IDE － cedet的安装 http://emacser.com/install-cedet.htm
(require 'cedet-settings)

;; ecb配置
(add-to-list 'load-path (concat emacs-path "extension/ecb"))
;; ecb
(require 'ecb-autoloads nil 'noerror)
(unless (boundp 'stack-trace-on-error)
  (defvar stack-trace-on-error nil))
(when (fboundp 'ecb-minor-mode)
  (defvar ecb-minor-mode nil)
  (setq ecb-primary-secondary-mouse-buttons 'mouse-1--C-mouse-1
        ecb-source-path '("/")
        ecb-layout-name 'left3
        ecb-toggle-layout-sequence '("left3"
                                     "left8"
                                     "left-analyse"
                                     "left-symboldef")
        ;; ecb-windows-width 0.25
        ecb-compile-window-height 0.15
        ecb-compile-window-width 'edit-window
        ecb-compile-window-temporally-enlarge 'after-selection
        ;; ecb-enlarged-compilation-window-max-height 0.8
        ecb-tip-of-the-day nil
        ecb-auto-compatibility-check nil))
(eval-after-load "ecb"
  '(progn
     (setq ecb-compilation-buffer-names
           (append ecb-compilation-buffer-names '(("*Process List*")
                                                  ("*Proced*")
                                                  (".notes")
                                                  ("*appt-buf*")
                                                  ("*Compile-Log*")
                                                  ("*etags tmp*")
                                                  (" *svn-process*")
                                                  ("*svn-info-output*")
                                                  ("*Python Output*")
                                                  ("*Org Agenda*")
                                                  (" *EMMS Playlist*")
                                                  ("*Moccur*")
                                                  ("*Directory"))))
     (setq ecb-compilation-major-modes
           (append ecb-compilation-major-modes '(change-log-mode
                                                 calendar-mode
                                                 diary-mode
                                                 diary-fancy-display-mode
                                                 xgtags-select-mode
                                                 svn-status-mode
                                                 svn-info-mode
                                                 svn-status-diff-mode
                                                 svn-log-view-mode
                                                 svn-log-edit-mode
                                                 erc-mode
                                                 gud-mode)))))
;;imenu-tree
(add-to-list 'load-path (concat emacs-path "extension/imenu-tree"))
(require 'imenu-tree)

(defun imenu-tree-settings ()
  "Settings for `imenu-tree'."
  (global-set-key (kbd "C-c i") 'imenu-tree)
  (setq tags-table-list '("./TAGS" "../TAGS" "../../TAGS"))
  (setq imenu-tree-auto-update t))

(eval-after-load "imenu-tree"
  `(imenu-tree-settings))

;;c/c++设置
(require 'c-settings)

;; ruby
(require 'ruby-settings)

;; rails
;(require 'rails-settings)

;; perl
(require 'perl-settings)

;; 所有的自动补全的配置
(require 'all-auto-complete-settings)

(provide 'dev-settings)
