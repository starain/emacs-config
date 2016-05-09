(require 'semantic)
(require 'semantic/bovine/gcc)

;;(global-semanticdb-minor-mode 1)
;;(global-semantic-idle-scheduler-mode 1)

(add-to-list 'semantic-default-submodes 'global-semanticdb-minor-mode)
(add-to-list 'semantic-default-submodes 'global-semantic-idle-local-symbol-highlight-mode)
(add-to-list 'semantic-default-submodes 'global-semantic-idle-scheduler-mode)
(add-to-list 'semantic-default-submodes 'global-semantic-idle-summary-mode)

(semantic-mode 1)
(global-ede-mode t)
(ede-enable-generic-projects)

(provide 'setup-cedet)
