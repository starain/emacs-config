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

;; display time in the minibar
(display-time-mode 1)
;; display time and date
(setq display-time-day-and-date t)

;; Default column width
(setq default-fill-column 80)

;; golang mode
(load-file (concat yi-thirdparty-dir "go-mode.el"))

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
;;(color-theme-dark-laptop)

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

;; Very handy mode
(require 'ido)
(ido-mode)

(global-set-key (kbd "C-c g") 'goto-line)
(global-set-key (kbd "C-c f") 'grep)
(global-set-key [up] 'go-up)
(global-set-key [down] 'go-down)
(global-set-key (kbd "C-t") 'multi-term)
(global-set-key (kbd "C-c s") 'search-forward-regexp)
(global-set-key (kbd "C-c r") 'search-backward-regexp)

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

(global-set-key (kbd "C-c c") 'zhangyi-default-compile)

(defun zhangyi-default-test()
  (interactive)
  (zhangyi-test "make" "project" "_test")
)

(global-set-key (kbd "C-c t") 'zhangyi-default-test)

(defun zhangyi-default-test-dir()
  (interactive)
  (zhangyi-test-dir "make" "project" "")
)

(global-set-key (kbd "C-c C-t d") 'zhangyi-default-test-dir)

(defun zhangyi-default-test-project()
  (interactive)
  (zhangyi-test-project "make" "project" "")
)

(global-set-key (kbd "C-c C-t p") 'zhangyi-default-test-project)

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

(global-set-key (kbd "C-c o") 'zhangyi-open-header-file)

;; Start with a nice clean environment:
(garbage-collect)
