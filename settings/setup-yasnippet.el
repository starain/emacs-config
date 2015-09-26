;; yasnippet
(add-to-list 'load-path (concat yi-thirdparty-dir "yasnippet"))
(require 'yasnippet)
(add-to-list 'yas-snippet-dirs (concat yi-settings-dir "/snippets"))
(yas-global-mode t)
;; Remove Yasnippet's default tab key binding
;(define-key yas-minor-mode-map (kbd "<tab>") nil)
;(define-key yas-minor-mode-map (kbd "TAB") nil)
;; Set Yasnippet's key binding to shift+tab
;(define-key yas-minor-mode-map (kbd "<backtab>") 'yas-expand)

(provide 'setup-yasnippet)
