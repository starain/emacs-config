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

(evil-mode 1)

(provide 'setup-evil)
