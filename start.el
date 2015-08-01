;;; .emacs -*-Emacs-Lisp-*-         created:  Tue Jan 31 21:56:41 PST 2012
; $Id: start.el,v 0.01 2012/02/01 00:27:41 starain.zhang Exp $

;; Set up base dir
(setq yi-current-dir
      (file-name-directory (or load-file-name buffer-file-name)))

(setq yi-thirdparty-dir
      (concat yi-current-dir "/thirdparty/"))

(setq settings-dir
      (concat yi-current-dir "/settings"))

;; Set up load path
(add-to-list 'load-path settings-dir)
(add-to-list 'load-path yi-thirdparty-dir)

(load-file (concat yi-thirdparty-dir "better-defaults/better-defaults.el"))
(require 'better-defaults)

(load-file (concat yi-thirdparty-dir "smex/smex.el"))
(require 'smex)

(add-to-list 'load-path yi-thirdparty-dir "go-mode.el")

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

;; golang mode
(load-file (concat yi-thirdparty-dir "go-mode.el"))
(require 'go-mode-load)
(add-hook 'before-save-hook 'gofmt-before-save)

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

;; Replace buffer mode by ibuffer (included in better-defaults)
; (require 'ibuffer)
; (global-set-key (kbd "C-x C-b") 'ibuffer)

;; Browse kill ring, bind to C-c k
(load-file (concat yi-thirdparty-dir "browse-kill-ring/browse-kill-ring.el"))
(require 'browse-kill-ring)
(browse-kill-ring-default-keybindings)

;; swbuff setting.
(load-file (concat yi-thirdparty-dir "swbuff.el"))
(require 'swbuff)
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
(setq multi-term-program "/bin/zsh")
;; yanking / pasting text into a terminal buffer
;;(add-hook 'term-mode-hook
;;  (lambda ()
;;    (define-key term-raw-map (kbd "C-y") 'term-paste)))
;; cycle through terminals with M-[ and M-]
;; Applies everywhere

;; Only applies to term mode
;; (add-hook 'term-mode-hook
;;   (lambda ()
;;     (add-to-list 'term-bind-key-alist '("M-[" . multi-term-prev))
;;     (add-to-list 'term-bind-key-alist '("M-]" . multi-term-next))))
;; set buffer size. 0 means no limit.
(add-hook 'term-mode-hook
  (lambda ()
    (setq term-buffer-maximum-size 10000)))
(when (require 'term nil t) ; only if term can be loaded..
  (setq term-bind-key-alist
        (list (cons "C-c C-c" 'term-interrupt-subjob)
;;              (cons "C-p" 'previous-line)
;;              (cons "C-n" 'next-line)
              (cons "M-f" 'term-send-forward-word)
              (cons "M-b" 'term-send-backward-word)
              (cons "C-c C-j" 'term-line-mode)
              (cons "C-c C-k" 'term-char-mode)
              (cons "M-DEL" 'term-send-backward-kill-word)
              (cons "M-d" 'term-send-forward-kill-word)
              (cons "<C-left>" 'term-send-backward-word)
              (cons "<C-right>" 'term-send-forward-word)
              (cons "C-r" 'term-send-reverse-search-history)
              (cons "M-p" 'term-send-raw-meta)
              (cons "M-y" 'term-send-raw-meta)
              (cons "C-y" 'term-send-raw))))

;; Very handy mode (included in better-default)
;(require 'ido)
;(ido-mode)

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

;; yasnippet
(add-to-list 'load-path (concat yi-thirdparty-dir "yasnippet"))
(require 'yasnippet)
(yas-global-mode t)
;; Remove Yasnippet's default tab key binding
;(define-key yas-minor-mode-map (kbd "<tab>") nil)
;(define-key yas-minor-mode-map (kbd "TAB") nil)
;; Set Yasnippet's key binding to shift+tab
;(define-key yas-minor-mode-map (kbd "<backtab>") 'yas-expand)

(add-to-list 'load-path (concat yi-thirdparty-dir "auto-complete-1.3.1"))
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories (concat yi-thirdparty-dir "auto-complete-1.3.1/dict"))
(ac-config-default)
;;; set the trigger key so that it can work together with yasnippet on tab key,
;;; if the word exists in yasnippet, pressing tab will cause yasnippet to
;;; activate, otherwise, auto-complete will
(ac-set-trigger-key "TAB")
(ac-set-trigger-key "<tab>")

;; multiple-cursors-mode
(add-to-list 'load-path (concat yi-thirdparty-dir "multiple-cursors.el"))
(require 'multiple-cursors)

;; ace-jump-mode
(load-file (concat yi-thirdparty-dir "ace-jump-mode/ace-jump-mode.el"))
(autoload
  'ace-jump-mode
  "ace-jump-mode"
  "Emacs quick move minor mode"
  t)
;;
;; enable a more powerful jump back function from ace jump mode
;;
(autoload
  'ace-jump-mode-pop-mark
  "ace-jump-mode"
  "Ace jump back:-)"
  t)
(eval-after-load "ace-jump-mode"
  '(ace-jump-mode-enable-mark-sync))

(require 'key-bindings)
(require 'experimental)
;; Start with a nice clean environment:
(garbage-collect)
