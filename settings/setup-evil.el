;; From: http://puntoblogspot.blogspot.com.es/2014/01/evil-exact-amount-of-vim-in-emacs-but.html

(add-to-list 'load-path (concat yi-thirdparty-dir "evil"))

(require 'evil)
(evil-mode 1)

;; remove all keybindings from insert-state keymap
(setcdr evil-insert-state-map nil)

;; Use jk as escape to normal state
(install-packages '(key-chord))
(require 'key-chord)
(key-chord-mode 1)
(key-chord-define evil-insert-state-map  "jk" 'evil-normal-state)

(provide 'setup-evil)
