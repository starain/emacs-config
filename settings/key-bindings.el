;; Helm bindings
;; The default "C-x c" is quite close to "C-x C-c", which quits Emacs.
;; Changed to "C-c h". Note: We must set "C-c h" globally, because we
;; cannot change `helm-command-prefix-key' once `helm-config' is loaded.
(global-set-key (kbd "C-c h") 'helm-command-prefix)
(global-unset-key (kbd "C-x c"))
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "C-c k") 'helm-show-kill-ring)
(global-set-key (kbd "C-x b") 'helm-mini)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
(global-set-key (kbd "C-c h o") 'helm-occur)
(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action) ; rebind tab to run persistent action
(define-key helm-map (kbd "C-i") 'helm-execute-persistent-action) ; make TAB works in terminal
(define-key helm-map (kbd "C-z")  'helm-select-action) ; list actions using C-z

;; swbuff
(global-set-key (kbd "M-9") 'swbuff-switch-to-previous-buffer)
(global-set-key (kbd "M-0") 'swbuff-switch-to-next-buffer)

;; switch terms
(global-set-key (kbd "M-(") 'multi-term-prev)
(global-set-key (kbd "M-)") 'multi-term-next)

(global-set-key (kbd "C-c g") 'goto-line)
(global-set-key (kbd "C-c f") 'grep)
(global-set-key [up] 'go-up)
(global-set-key [down] 'go-down)
(global-set-key (kbd "C-t") 'multi-term)

;; development
(define-prefix-command 'dev-map)
(global-set-key (kbd "C-c d") 'dev-map)
(define-prefix-command 'dev-fold-map)
(global-set-key (kbd "C-c d h") 'dev-fold-map)
(global-set-key (kbd "C-c d h h") 'hs-toggle-hiding)
(global-set-key (kbd "C-c d h a") 'hs-hide-all)
(global-set-key (kbd "C-c d h s") 'hs-show-all)
(global-set-key (kbd "M-n") #'next-error)
(global-set-key (kbd "M-p") (lambda() (interactive) (next-error -1)))

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
(define-key global-map (kbd "C-c SPC") 'avy-goto-char)
(define-key global-map (kbd "C-x SPC") 'avy-pop-mark)
(define-key global-map (kbd "C-x o") 'ace-window)

(define-key global-map (kbd "C-c i") 'ido-imenu)

(define-key global-map (kbd "C-c r") 'er/expand-region)

;; Keyboard marco
(global-set-key (kbd "C-c s") 'kmacro-start-macro)
(global-set-key (kbd "C-c e") 'kmacro-end-or-call-macro)

;; org mode
(define-prefix-command 'org-map)
(global-set-key (kbd "C-o") 'org-map)
(global-set-key (kbd "C-o c") 'org-capture)
(global-set-key (kbd "C-o a") 'org-agenda)
(global-set-key (kbd "C-o b") 'org-iswitchb)
(global-set-key (kbd "C-o i") 'bh/punch-in)
(global-set-key (kbd "C-o o") 'bh/punch-out)
(global-set-key (kbd "C-o j") 'org-clock-goto)
(global-set-key (kbd "C-o SPC") 'bh/clock-in-last-task)

(provide 'key-bindings)
