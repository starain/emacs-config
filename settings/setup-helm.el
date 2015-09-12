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

(load-file (concat yi-thirdparty-dir "emacs-helm-ag/helm-ag.el"))
(require 'helm-ag)

;; Project file management
;; More detail tutorial: http://tuhdo.github.io/helm-projectile.html
;;
;; To make helm-projectile-ag use .projectile whitelist, need to change the following things:
;; in helm-ag.el (emacs-helm-ag):
;; -         (helm-ag--default-target (cond (this-file (list this-file))
;; +         (helm-ag--default-target (cond (this-file (cond ((listp this-file)
;; +                                                          this-file)
;; +                                                         (t
;; +                                                          (list this-file))))
;; in helm-projectile.el (projectile):
;; - (helm-do-ag (projectile-project-root)
;; + (helm-do-ag (projectile-project-root) (or (car (projectile-parse-dirconfig-file)) nil))
(add-to-list 'load-path (concat yi-thirdparty-dir "dash.el"))
(add-to-list 'load-path (concat yi-thirdparty-dir "pkg-info.el"))
(add-to-list 'load-path (concat yi-thirdparty-dir "projectile"))
(require 'helm-projectile)
(projectile-global-mode)
(setq projectile-completion-system 'helm)
(setq projectile-enable-caching t)
(helm-projectile-on)

(provide 'setup-helm)
