;; From: http://puntoblogspot.blogspot.com.es/2014/01/evil-exact-amount-of-vim-in-emacs-but.html

(add-to-list 'load-path (concat yi-thirdparty-dir "evil"))
(require 'evil)

(add-to-list 'load-path (concat yi-thirdparty-dir "evil-leader"))
(require 'evil-leader)
(global-evil-leader-mode)

;; remove all keybindings from insert-state keymap
(setcdr evil-insert-state-map nil)

;; Use jk as escape to normal state
(add-to-list 'load-path (concat yi-thirdparty-dir "evil-escape"))
(require 'evil-escape)
(evil-escape-mode)

(add-to-list 'load-path (concat yi-thirdparty-dir "evil-textobj-anyblock"))
(require 'evil-textobj-anyblock)
(define-key evil-inner-text-objects-map "b" 'evil-textobj-anyblock-inner-block)
(define-key evil-outer-text-objects-map "b" 'evil-textobj-anyblock-a-block)

(add-to-list 'load-path (concat yi-thirdparty-dir "evil-args"))
(require 'evil-args)
(define-key evil-inner-text-objects-map "a" 'evil-inner-arg)
(define-key evil-outer-text-objects-map "a" 'evil-outer-arg)

(add-to-list 'load-path (concat yi-thirdparty-dir "evil-indent-plus"))
(require 'evil-args)
(define-key evil-inner-text-objects-map "i" 'evil-indent-plus-i-indent)
(define-key evil-outer-text-objects-map "i" 'evil-indent-plus-a-indent)
(define-key evil-inner-text-objects-map "I" 'evil-indent-plus-i-indent-up)
(define-key evil-outer-text-objects-map "I" 'evil-indent-plus-a-indent-up)
(define-key evil-inner-text-objects-map "J" 'evil-indent-plus-i-indent-up-down)
(define-key evil-outer-text-objects-map "J" 'evil-indent-plus-a-indent-up-down)

(add-to-list 'load-path (concat yi-thirdparty-dir "evil-surround"))
(require 'evil-surround)
(global-evil-surround-mode 1)

(evil-mode 1)

(provide 'setup-evil)
