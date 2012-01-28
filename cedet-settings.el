;; CEDET
(add-to-list 'load-path (concat emacs-path "extension/cedet/common"))
(require 'cedet)

;; semantic
(require 'semantic-ia)
(semantic-load-enable-code-helpers)
(semantic-load-enable-excessive-code-helpers)

;; (setq semanticdb-project-roots (list (expand-file-name "/")))
(defconst cedet-user-include-dirs
  (list ".." "../include" "../inc" "../common" "../public"
        "../.." "../../include" "../../inc" "../../common" "../../public"))
(require 'semantic-c nil 'noerror)
(let ((include-dirs cedet-user-include-dirs))
  (when (eq system-type 'windows-nt)
    (setq include-dirs (append include-dirs cedet-win32-include-dirs)))
  (mapc (lambda (dir)
          (semantic-add-system-include dir 'c++-mode)
          (semantic-add-system-include dir 'c-mode))
        include-dirs))

;;semantic-tag-folding
(when window-system
  (global-semantic-tag-folding-mode 1))

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

