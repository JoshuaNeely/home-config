;;; ../../home-config/emacs/doom/config-persp.el -*- lexical-binding: t; -*-


;; Prevent emacsclient from creating a new doom emacs workspace on connect
;; https://www.reddit.com/r/emacs/comments/10w677y/launch_emacsclient_without_create_new_workspace/
(after! persp-mode
  (setq persp-emacsclient-init-frame-behaviour-override "main")
  )
