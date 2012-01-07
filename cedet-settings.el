;; CEDET
(add-to-list 'load-path (concat emacs-path "extension/cedet/common"))
(require 'cedet)

;; semantic
(require 'semantic-ia)
(semantic-load-enable-code-helpers)
(semantic-load-enable-excessive-code-helpers)

(semantic-load-enable-semantic-debugging-helpers)
;; Enable SRecode (Template management) minor-mode.
(global-srecode-minor-mode 1)

;;代码跳转
;;函数/定义跳转
(global-set-key [f12] 'semantic-ia-fast-jump)
(global-set-key [S-f12]
                (lambda ()
                  (interactive)
                  (if (ring-empty-p (oref semantic-mru-bookmark-ring ring))
                      (error "Semantic Bookmark ring is currently empty"))
                  (let* ((ring (oref semantic-mru-bookmark-ring ring))
                         (alist (semantic-mrub-ring-to-assoc-list ring))
                         (first (cdr (car alist))))
                    (if (semantic-equivalent-tag-p (oref first tag)
                                                   (semantic-current-tag))
                        (setq first (cdr (car (cdr alist)))))
                    (semantic-mrub-switch-tags first))))


;;代码补全
;;;配置Semantic的检索范围:
(setq semanticdb-project-roots 
(list
(expand-file-name "/")))
(global-set-key (kbd "M-N") 'semantic-ia-complete-symbol-menu)

;; Enable EDE (Project Management) features
(global-ede-mode t)

;; 配置可视化书签
;;F2 在当前行设置或取消书签
;;C-F2 查找下一个书签
;;S-F2 查找上一个书签
;;C-S-F2 清空当前文件的所有书签
(enable-visual-studio-bookmarks)

;; speedbar设置
(require 'sr-speedbar)
(setq sr-speedbar-right-side nil)
(setq sr-speedbar-width 24)
(setq speedbar-show-unknown-files t)
(setq dframe-update-speed t)        ; prevent the speedbar to update the current state, since it is always changing
(global-set-key (kbd "<f5>") (lambda()
          (interactive)
          (sr-speedbar-toggle)))

(provide 'cedet-settings)

