(install-packages '(shackle))


(setq helm-display-function 'pop-to-buffer) ; make helm play nice
(setq shackle-default-alignment 'below
      shackle-default-size 8
      shackle-rules
      '(("\\`\\*helm.*?\\*\\'" :regexp t :align t :size 0.4)
        ("^\\*magit" :regexp t :size 0.5 :align t :noesc t :autokill t)))
(shackle-mode)

(provide 'setup-shackle)
