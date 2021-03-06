;; Amazing productivity package with zillions of useful things.
;; More detail tutorial: http://tuhdo.github.io/helm-intro.html

(install-packages '(helm helm-ag projectile helm-projectile))
(require 'helm)
(require 'helm-config)

;; Enable fuzzy matching for helm-mini
(setq helm-buffers-fuzzy-matching t
      helm-recentf-fuzzy-match t)

;; Enable fuzzy matching for sematic matching
(require 'imenu)
(setq helm-semantic-fuzzy-match t
      helm-imenu-fuzzy-match t)

(helm-mode 1)

(require 'helm-ag)

;; Project file management
;; More detail tutorial: http://tuhdo.github.io/helm-projectile.html
(require 'helm-projectile)
(projectile-global-mode)
(setq projectile-completion-system 'helm)
(setq projectile-enable-caching t)
(helm-projectile-on)

(provide 'setup-helm)
