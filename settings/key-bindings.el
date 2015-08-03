;; Smart M-x
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

;; Use C-x C-m to do M-x per Steve Yegge's advice
(global-set-key (kbd "C-x C-m") 'smex)

;; Browse the kill ring
(global-set-key (kbd "C-c k") 'browse-kill-ring)

;; swbuff
(global-set-key (kbd "M-9") 'swbuff-switch-to-previous-buffer)
(global-set-key (kbd "M-0") 'swbuff-switch-to-next-buffer)

;; switch terms
(global-set-key (kbd "M-[") 'multi-term-prev)
(global-set-key (kbd "M-]") 'multi-term-next)

(global-set-key (kbd "C-c g") 'goto-line)
(global-set-key (kbd "C-c f") 'grep)
(global-set-key [up] 'go-up)
(global-set-key [down] 'go-down)
(global-set-key (kbd "C-t") 'multi-term)

;; development
(global-set-key (kbd "C-c c") 'zhangyi-default-compile)
(global-set-key (kbd "C-c t") 'zhangyi-default-test)
(global-set-key (kbd "C-c C-t d") 'zhangyi-default-test-dir)
(global-set-key (kbd "C-c C-t p") 'zhangyi-default-test-project)
(global-set-key (kbd "C-c o") 'zhangyi-open-header-file)

;; multi cursors
(global-set-key (kbd "C-c m") 'mc/edit-lines)
(global-set-key (kbd "C-c n") 'mc/mark-next-like-this)
(global-set-key (kbd "C-c p") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c a") 'mc/mark-all-like-this)
(global-set-key (kbd "C-c l") 'set-rectangular-region-anchor)
(global-set-key (kbd "C-c C-n") 'yi-mc-skip-next-like-this)
(global-set-key (kbd "C-c C-p") 'yi-mc-skip-previous-like-this)

;; ACE jump
;; you can select the key you prefer to
(define-key global-map (kbd "C-c SPC") 'ace-jump-mode)
(define-key global-map (kbd "C-x SPC") 'ace-jump-mode-pop-mark)

(define-key global-map (kbd "C-c i") 'ido-imenu)

(define-key global-map (kbd "C-c r") 'er/expand-region)

;; Keyboard marco
(global-set-key (kbd "C-c d") 'kmacro-start-macro)
(global-set-key (kbd "C-c e") 'kmacro-end-or-call-macro)

(provide 'key-bindings)
