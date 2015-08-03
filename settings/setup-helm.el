;; Amazing productivity package with zillions of useful things.
;; More detail tutorial: http://tuhdo.github.io/helm-intro.html

(add-to-list 'load-path (concat yi-thirdparty-dir "emacs-async"))
(add-to-list 'load-path (concat yi-thirdparty-dir "helm"))
(require 'helm)
(require 'helm-config)

;; Enable fuzzy matching for helm-mini
(setq helm-buffers-fuzzy-matching t
      helm-recentf-fuzzy-match)

;; Enable fuzzy matching for sematic matching
(require 'imenu)
(setq helm-semantic-fuzzy-match t
      helm-imenu-fuzzy-match t)

(helm-mode 1)

(provide 'setup-helm)
