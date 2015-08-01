(require 'key-chord)
(key-chord-mode t)
(key-chord-define-global "hj"     'undo)
(key-chord-define-global " d"     'kmacro-start-macro)
(key-chord-define-global " e"     'kmacro-end-or-call-macro)

(provide 'experimental)
