;;; .emacs -*-Emacs-Lisp-*-         created:  Tue Jan 31 21:56:41 PST 2012
; $Id: start.el,v 0.01 2012/02/01 00:27:41 starain.zhang Exp $

;; Set up base dir
(setq yi-current-dir
      (file-name-directory (or load-file-name buffer-file-name)))

(setq yi-thirdparty-dir
      (concat yi-current-dir "thirdparty/"))

(setq yi-settings-dir
      (concat yi-current-dir "settings"))

;; Set up load path
(add-to-list 'load-path yi-settings-dir)
(add-to-list 'load-path yi-thirdparty-dir)

(load-file (concat yi-thirdparty-dir "better-defaults/better-defaults.el"))
(require 'better-defaults)

;; golang mode
(add-to-list 'load-path (concat yi-thirdparty-dir "go-mode.el"))
(require 'go-mode-autoloads)
(add-hook 'before-save-hook 'gofmt-before-save)

;; Set up grep to do recursive search by default
(setq grep-command "grep -nH -R -e ")

(menu-bar-mode 0)

;; Not all of emacs has tool-bar-mode - for example, emacs on mac.
;;(tool-bar-mode 0)

;; Show column number
(setq column-number-mode t)

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

(add-to-list 'custom-theme-load-path (concat yi-thirdparty-dir "zenburn-emacs"))
(load-theme 'zenburn t)

(load-file (concat yi-thirdparty-dir "smooth-scrolling/smooth-scrolling.el"))
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

(defun zhangyi-base-dir(base-dir-substring)
  (substring (buffer-file-name) 0 (+ (string-match base-dir-substring buffer-file-name) (length base-dir-substring)))
)

(defun zhangyi-target-name(base-dir)
  (substring buffer-file-name (+ 1 (length base-dir)) (string-match "\\.[^\\./]*$" buffer-file-name))
)

(defun zhangyi-test-target-name(base-dir test-suffix)
  (let (target-name test-suffix-pattern)
    (setq target-name (zhangyi-target-name base-dir))
    (setq test-suffix-pattern (concat test-suffix "$"))
    (if (string-match test-suffix-pattern target-name)
        (substring target-name 0 (string-match test-suffix-pattern target-name))
        target-name)
  )
)

(defun zhangyi-compile(compile-command base-dir-substring)
  (let (current-dir base-dir target-name)
    (setq current-dir default-directory)
    (setq base-dir (zhangyi-base-dir base-dir-substring))
    (setq target-name (zhangyi-target-name base-dir))
    (cd base-dir)
    (compile (concat compile-command " " target-name))
    (cd current-dir)
  )
)

(defun zhangyi-test(test-command base-dir-substring test-suffix)
  (let (current-dir base-dir target-name)
    (setq current-dir default-directory)
    (setq base-dir (zhangyi-base-dir base-dir-substring))
    (setq target-name (zhangyi-test-target-name base-dir test-suffix))
    (cd base-dir)
    (compile (concat test-command " " target-name test-suffix))
    (cd current-dir)
  )
)

(defun zhangyi-target-dir-name(base-dir)
  (substring buffer-file-name (+ 1 (length base-dir)) (string-match "/[^/]*$" buffer-file-name))
)

(defun zhangyi-test-dir(test-command base-dir-substring test-suffix)
  (let (current-dir base-dir target-name)
    (setq current-dir default-directory)
    (setq base-dir (zhangyi-base-dir base-dir-substring))
    (setq target-name (concat (zhangyi-target-dir-name base-dir) "/" test-suffix))
    (cd base-dir)
    (compile (concat test-command " " target-name))
    (cd current-dir)
  )
)

(defun zhangyi-test-project(test-command base-dir-substring project-dir test-suffix)
  (let (current-dir base-dir)
    (setq current-dir default-directory)
    (setq base-dir (zhangyi-base-dir base-dir-substring))
    (cd base-dir)
    (compile (concat test-command " " project-dir "/" test-suffix))
    (cd current-dir)
  )
)

(defun zhangyi-default-compile()
  (interactive)
  (zhangyi-compile "make" "project")
)

(defun zhangyi-default-test()
  (interactive)
  (zhangyi-test "make" "project" "_test")
)

(defun zhangyi-default-test-dir()
  (interactive)
  (zhangyi-test-dir "make" "project" "")
)

(defun zhangyi-default-test-project()
  (interactive)
  (zhangyi-test-project "make" "project" "")
)

;; Open header file. Actually it can open any filename between quotes.
;; TODO(zhangyi): Need to handle file-not-found
(defun zhangyi-open-header-file ()
  (interactive)
  ;; Save the original pointer
  (setq original-point (point))
  ;; Get left boundary after quote
  (skip-chars-backward "^\"")
  (setq p1 (point))
  ;; Get right boundary before quote
  (skip-chars-forward "^\"")
  (setq p2 (point))
  ;; Go back to cursor
  (goto-char original-point)
  ;; Grab & expand filename
  (setq filename (concat (zhangyi-base-dir) "/" (buffer-substring-no-properties p1 p2)))
  ;; Open the file
  (switch-to-buffer (find-file-noselect filename nil))
  (message filename)
)

;; expand-region
(add-to-list 'load-path (concat yi-thirdparty-dir "expand-region.el"))
(require 'expand-region)

;; Remove text in active region if inserting text
(delete-selection-mode 1)

;; Functions (load all files in defuns-dir)
(setq defuns-dir (expand-file-name "defuns" yi-current-dir))
(dolist (file (directory-files defuns-dir t "\\w+"))
  (when (file-regular-p file)
    (load file)))

(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://stable.melpa.org/packages/") t)
(package-initialize)
(defun install-packages (packages)
  "Install all required packages."
  (interactive)
  (unless package-archive-contents
    (package-refresh-contents))
  (dolist (package packages)
    (unless (package-installed-p package)
      (package-install package))))

(install-packages '(flycheck))

(require 'setup-ace-jump-mode)
(require 'setup-cedet)
(require 'setup-company-mode)
(require 'setup-flycheck)
(require 'setup-helm)
(require 'setup-yasnippet)
(require 'setup-magit)
(require 'setup-multi-term)
(require 'setup-multiple-cursors)
(require 'setup-orgmode)
(require 'setup-swbuff)

(require 'key-bindings)
(require 'experimental)
;; Start with a nice clean environment:
(garbage-collect)
