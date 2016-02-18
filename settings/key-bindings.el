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
;; instant search across all buffers with helm
(defun instant-search-using-helm ()
  "Multi-occur in all buffers backed by files."
  (interactive)
  (helm-multi-occur
   (delq nil
         (mapcar (lambda (b)
                   (when (buffer-file-name b) (buffer-name b)))
                 (buffer-list)))))
(global-set-key (kbd "C-c h f") 'instant-search-using-helm)
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

;; org mode
(define-prefix-command 'org-map)
(global-set-key (kbd "C-o") 'org-map)
(global-set-key (kbd "C-o c") 'org-capture)
(global-set-key (kbd "C-o a") 'org-agenda)

(provide 'key-bindings)
