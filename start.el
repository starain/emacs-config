;;; .emacs -*-Emacs-Lisp-*-         created:  Tue Jan 31 21:56:41 PST 2012
; $Id: start.el,v 0.01 2012/02/01 00:27:41 starain.zhang Exp $

;; Set up base dir
(setq yi-current-dir
      (file-name-directory (or load-file-name buffer-file-name)))

(setq yi-thirdparty-dir
      (concat yi-current-dir
              "/thirdparty/"))

;; Set up grep to do recursive search by default
(setq grep-command "grep -nH -R -e ")

(menu-bar-mode 0)

;; Not all of emacs has tool-bar-mode - for example, emacs on mac.
;;(tool-bar-mode 0)

;; Show column number
(setq column-number-mode t)

;; Tab as 4 space
(setq default-tab-width 4)

;; Scroll page at the last 3 line of the page
(setq scroll-margin 3
      scroll-conservatively 10000)

;; High light the matched parentheses.
(show-paren-mode t)
(setq show-paren-style 'parentheses)

;; enable visual feedback on selections
(setq-default transient-mark-mode t)

;; always end a file with a newline
(setq require-final-newline t)

;; stop at the end of the file, not just add lines
(setq next-line-add-newlines nil)

;; turn on font-lock mode, highlighted defined or reserved keywords.
(global-font-lock-mode t)

;; Highlighted tab and trailing spaces.
;; (custom-set-faces
;;   '(my-tab-face ((((class color)) (:background "white"))) t)
;;   '(my-trailing-space-face ((((class color)) (:background "red"))) t))

;; (add-hook 'font-lock-mode-hook
;;   (function
;;     (lambda ()
;;       (setq font-lock-keywords
;;         (append font-lock-keywords
;;           '(("\t+" (0 'my-tab-face t))
;;            ("[ \t]+$" (0 'my-trailing-space-face t))))))))

;; TODO: Highlighted is extreamly annonying in term mode. Should figure
;; out how to turn it off.
;; (add-hook 'term-mode-hook
;;   (lambda ()
;;     (font-lock-mode 0)))

;; Setup color theme.
(load-file (concat yi-thirdparty-dir "color-theme.el"))
(require 'color-theme)
(color-theme-dark-laptop)

;; Replace buffer mode by ibuffer
(require 'ibuffer)
(global-set-key (kbd "C-x C-b") 'ibuffer)

;; Browse kill ring, bind to C-c k
(load-file (concat yi-thirdparty-dir "browse-kill-ring.el"))
(require 'browse-kill-ring)
(global-set-key [(control c)(k)] 'browse-kill-ring)
(browse-kill-ring-default-keybindings)

;; swbuff setting.
(load-file (concat yi-thirdparty-dir "swbuff.el"))
(require 'swbuff)
(global-set-key (kbd "M-9") 'swbuff-switch-to-previous-buffer)
(global-set-key (kbd "M-0") 'swbuff-switch-to-next-buffer)
(setq swbuff-exclude-buffer-regexps
      '("^ " "\\*.*\\*"))(setq swbuff-status-window-layout 'scroll)
(setq swbuff-clear-delay 1)
(setq swbuff-separator "|")
(setq swbuff-window-min-text-height 1)

;; Scroll screen directly, no matter where the pointer is.
(defun go-up ()
  (interactive)
  (and (not (pos-visible-in-window-p (point-min)))
       (scroll-down 1))
  (next-line -1))

(defun go-down ()
  (interactive)
  (let ((old-point (point)))
    (scroll-down -1)
    (and (pos-visible-in-window-p old-point)
         (next-line 1))))

(load-file (concat yi-thirdparty-dir "multi-term.el"))
(require 'multi-term)
(setq multi-term-program "/bin/bash")

(global-set-key [f2] 'goto-line)
(global-set-key [f4] 'grep)
(global-set-key [up] 'go-up)
(global-set-key [down] 'go-down)
(global-set-key (kbd "C-t") 'multi-term)

;; Start with a nice clean environment:
(garbage-collect)

