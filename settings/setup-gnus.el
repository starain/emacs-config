;; http://www.gnus.org/manual/gnus_toc.html
;; https://www.emacswiki.org/emacs/GnusGmail
;; http://chrisdone.com/posts/emacs-mail
;; http://www.sanityinc.com/articles/read-mailing-lists-in-emacs-over-imap/

;; sudo apt-get install dovecot-imapd offlineimap

;; ~/.gnus
;; (require 'nnmaildir)
;; (require 'nnir)

;; (setq gnus-select-method
;;       '(nnimap "Mail"
;;                (nnimap-address "localhost")
;;                (nnimap-stream network)
;;                (nnimap-authenticator login)))

;; (gnus-registry-initialize)

;; (setq user-mail-address "zhangyi@google.com")
;; (setq user-full-name "Yi Zhang")

;; /etc/dovecot/conf.d/10-mail
;; mail_location = maildir:~/maildir:LAYOUT=fs
;; $ sudo start dovecot
;; $ sudo netstat -n -p -l | grep dovecot
;; should see something like
;; tcp        0      0 0.0.0.0:143             0.0.0.0:*               LISTEN      30879/dovecot
;; tcp        0      0 0.0.0.0:993             0.0.0.0:*               LISTEN      30879/dovecot
;; tcp6       0      0 :::143                  :::*                    LISTEN      30879/dovecot
;; tcp6       0      0 :::993                  :::*                    LISTEN      30879/dovecot
;; $ telnet localhost imap2  # should also work

;; ~/.offlineimaprc
;; [general]
;; ui = TTY.TTYUI
;; accounts = Starain
;; maxsyncaccounts = 2

;; [Account Starain]
;; localrepository = StarainLocal
;; remoterepository = StarainRemote

;; autorefresh = 15
;; quick = 10

;; [Repository StarainLocal]
;; type = Maildir
;; localfolders = ~/maildir

;; [Repository StarainRemote]
;; type = Gmail
;; remotehost = imap.gmail.com
;; remoteuser = <>
;; remotepass = <>
;; folderfilter = lambda foldername: 'All Mail' not in foldername and foldername != 'list'
;; realdelete = no
;; ssl = yes
;; sslcacertfile = /etc/ssl/certs/ca-certificates.crt
;; maxconnections = 4
