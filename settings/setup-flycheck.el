;; Dev env setup, heavily based on http://tuhdo.github.io/c-ide.html

(install-packages '(flycheck))
(require 'flycheck)
(global-flycheck-mode)

(provide 'setup-flycheck)
