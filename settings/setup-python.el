;; AttributeError and KeyError randomly happens
;; 
;; These kinds of problems were reported with jedi 0.9 version. (This error may occur in Spacemacs or any other usage). You can try to downgrade jedi version down to 0.8.
;; 
;; M-: (dired (anaconda-mode-server-directory)) RET
;; M-! rm -rf jedi* RET
;; M-! pip install "jedi<0.9" -t . RET
;; After you saw the jedi version changed to 0.8 in the dired window, you have to refresh Emacs to make it work right away. You can either restart Emacs or kill the *anaconda-mode* buffer.

(install-packages '(anaconda-mode company-anaconda))

(require 'setup-company-mode)

(eval-after-load "company"
  '(add-to-list 'company-backends '(company-anaconda :with company-capf)))

(add-hook 'python-mode-hook 'anaconda-mode)

(provide 'setup-python)
