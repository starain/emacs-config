(defun yi-mc-skip-next-like-this (args)
  (interactive "p")
  (mc/mark-next-like-this args)
  (mc/skip-to-next-like-this))

(defun yi-mc-skip-previous-like-this (args)
  (interactive "p")
  (mc/mark-previous-like-this args)
  (mc/skip-to-previous-like-this))

(provide 'setup-multiple-cursors)
