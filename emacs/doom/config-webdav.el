;;; ../../home-config/emacs_configs/doom/config-web-dav.el -*- lexical-binding: t; -*-


;; WebDAV + org-mobile
(setq org-mobile-directory (format "/home/%s/data/data" user-login-name))
(setq org-mobile-inbox-for-pull (format "/home/%s/data/data/inbox-file.org" user-login-name))
