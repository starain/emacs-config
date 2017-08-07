(require 'setup-yasnippet)

(add-to-list 'yas-snippet-dirs (concat yi-settings-dir "/templates"))

(setq auto-insert-query nil  ; Don't prompt before insertion
      auto-insert-alist nil) ; Tabula rasa
(auto-insert-mode 1)

(defun +file-templates--expand (key &optional mode project-only)
    "Auto insert a snippet of yasnippet into new file."
    (when t
      (require 'yasnippet)
      (unless yas-minor-mode (yas-minor-mode-on))
      (when (and yas-minor-mode
                 (yas-expand-snippet (yas-lookup-snippet key mode t))
                 (and (featurep 'evil) evil-mode)
                 (and yas--active-field-overlay
                      (overlay-buffer yas--active-field-overlay)
                      (overlay-get yas--active-field-overlay 'yas--field)))
        (evil-initialize-state 'insert))))

(defun +file-templates-add (args)
    (cl-destructuring-bind (regexp trigger mode &optional project-only-p) args
      (define-auto-insert
        regexp
        (vector `(lambda () (+file-templates--expand ,trigger ',mode ,project-only-p))))))

(mapc #'+file-templates-add
      ;; General
      '(("\\.py$"                  "__"               python-mode)))

(provide 'setup-auto-insert)
