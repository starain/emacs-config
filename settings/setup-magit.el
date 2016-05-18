(install-packages '(magit))

(eval-after-load 'info
  '(progn (info-initialize)
          (add-to-list 'Info-directory-list (concat yi-thirdparty-dir "magit"))))
(require 'magit)
(setq magit-last-seen-setup-instructions "1.4.0")

(provide 'setup-magit)
