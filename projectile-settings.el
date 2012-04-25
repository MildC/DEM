(add-to-list 'load-path
    		 (concat emacs-path "extension/helm"))

(add-to-list 'load-path
    		 (concat emacs-path "extension/projectile"))

(require 'helm-config)

(require 'projectile)
(require 'helm-projectile)
(projectile-global-mode) ;; to enable in all buffers

(setq projectile-enable-caching t)

(global-set-key (kbd "C-c h") 'helm-projectile)

(provide 'projectile-settings)
