(add-to-list 'load-path (concat yi-thirdparty-dir "git-modes"))
(add-to-list 'load-path (concat yi-thirdparty-dir "magit"))
(eval-after-load 'info
  '(progn (info-initialize)
          (add-to-list 'Info-directory-list (concat yi-thirdparty-dir "magit"))))
(require 'magit)

(provide 'setup-magit)
