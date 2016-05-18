(install-packages '(company))

(require 'company)
(add-hook 'after-init-hook 'global-company-mode)

(add-to-list 'load-path (concat yi-thirdparty-dir "company-c-headers"))
(require 'company-c-headers)
(add-to-list 'company-backends 'company-c-headers)

(provide 'setup-company-mode)
