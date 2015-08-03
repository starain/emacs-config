(load-file (concat yi-thirdparty-dir "multi-term.el"))
(require 'multi-term)
(setq multi-term-program "/bin/zsh")
;; yanking / pasting text into a terminal buffer
;;(add-hook 'term-mode-hook
;;  (lambda ()
;;    (define-key term-raw-map (kbd "C-y") 'term-paste)))
;; cycle through terminals with M-[ and M-]
;; Applies everywhere

;; Only applies to term mode
;; (add-hook 'term-mode-hook
;;   (lambda ()
;;     (add-to-list 'term-bind-key-alist '("M-[" . multi-term-prev))
;;     (add-to-list 'term-bind-key-alist '("M-]" . multi-term-next))))
;; set buffer size. 0 means no limit.
(add-hook 'term-mode-hook
  (lambda ()
    (setq term-buffer-maximum-size 10000)))
(when (require 'term nil t) ; only if term can be loaded..
  (setq term-bind-key-alist
        (list (cons "C-c C-c" 'term-interrupt-subjob)
;;              (cons "C-p" 'previous-line)
;;              (cons "C-n" 'next-line)
              (cons "M-f" 'term-send-forward-word)
              (cons "M-b" 'term-send-backward-word)
              (cons "C-c C-j" 'term-line-mode)
              (cons "C-c C-k" 'term-char-mode)
              (cons "M-DEL" 'term-send-backward-kill-word)
              (cons "M-d" 'term-send-forward-kill-word)
              (cons "<C-left>" 'term-send-backward-word)
              (cons "<C-right>" 'term-send-forward-word)
              (cons "C-r" 'term-send-reverse-search-history)
              (cons "M-p" 'term-send-raw-meta)
              (cons "M-y" 'term-send-raw-meta)
              (cons "C-y" 'term-send-raw))))

(provide 'setup-multi-term)
