;;; .emacs -*-Emacs-Lisp-*-         created:  Tue Jan 31 21:56:41 PST 2012
; $Id: start.el,v 0.01 2012/02/01 00:27:41 starain.zhang Exp $

;; Set up base dir
(setq gc-cons-threshold 100000000)
(add-hook 'after-init-hook (lambda () (setq gc-cons-threshold 800000)))
(setq yi-current-dir
      (file-name-directory (or load-file-name buffer-file-name)))

(setq yi-thirdparty-dir
      (concat yi-current-dir "thirdparty/"))

(setq yi-settings-dir
      (concat yi-current-dir "settings"))

;; Set up load path
(add-to-list 'load-path yi-settings-dir)
(add-to-list 'load-path yi-thirdparty-dir)

(require 'package)

(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)
(defun install-packages (packages &optional package-archive-list)
  "Install all required packages."
  (interactive)
  (unless package-archive-contents
    (package-refresh-contents))
  (dolist (package packages)
    (unless (package-installed-p package)
      (package-install package))))

(install-packages '(better-defaults))
(require 'better-defaults)

;; golang mode
(install-packages '(go-mode))
(load "go-mode-autoloads.el")
(add-hook 'before-save-hook 'gofmt-before-save)

;; Set up grep to do recursive search by default
(setq grep-command "grep -nH -R -e ")

(menu-bar-mode 0)

;; Not all of emacs has tool-bar-mode - for example, emacs on mac.
;;(tool-bar-mode 0)

;; Show column number
(setq column-number-mode t)

;; Show line number
(setq linum-format "%d ")
(global-linum-mode 1)

;; Tab as 4 space
(setq default-tab-width 4)

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

;; display time in the minibar
(display-time-mode 1)
;; display time and date
(setq display-time-day-and-date t)

;; Default column width
(setq default-fill-column 80)

;; Auto reload file, works better with git
(global-auto-revert-mode t)

(setq inhibit-startup-message t)

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

(install-packages '(zenburn-theme))
(load-theme 'zenburn t)

(install-packages '(smooth-scrolling))
(require 'smooth-scrolling)

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

;; expand-region
(install-packages '(expand-region))
(require 'expand-region)

;; Remove text in active region if inserting text
(delete-selection-mode 1)

;; Code block folding
(add-hook 'c-mode-common-hook   'hs-minor-mode)

;; Functions (load all files in defuns-dir)
(setq defuns-dir (expand-file-name "defuns" yi-current-dir))
(dolist (file (directory-files defuns-dir t "\\w+"))
  (when (file-regular-p file)
    (load file)))

(require 'setup-ace-jump-mode)
;; (require 'setup-cedet)
(require 'setup-company-mode)
(require 'setup-ess)
(require 'setup-flycheck)
(require 'setup-helm)
(require 'setup-yasnippet)
(require 'setup-magit)
(require 'setup-multi-term)
(require 'setup-multiple-cursors)
(require 'setup-orgmode)
(require 'setup-swbuff)
(require 'setup-which-key)
(require 'setup-evil)
(require 'setup-evil-keybindings)
(require 'key-bindings)
(require 'experimental)
;; Start with a nice clean environment:
(garbage-collect)
