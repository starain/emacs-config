(load-file (concat yi-thirdparty-dir "swbuff.el"))
(require 'swbuff)
(setq swbuff-exclude-buffer-regexps
      '("^ " "\\*.*\\*"))(setq swbuff-status-window-layout 'scroll)
(setq swbuff-clear-delay 1)
(setq swbuff-separator "|")
(setq swbuff-window-min-text-height 1)

(provide 'setup-swbuff)
