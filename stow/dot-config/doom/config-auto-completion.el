;;; ../../home-config/emacs/doom/config-auto-completion.el -*- lexical-binding: t; -*-

;; Latest version of doom-emacs includes popups that suggest context aware completion (eg spelling in txt, variables in program languages, etc)
;; This is a cool feature, but pops up very fast. I find it annoying. This variable should slow it down.
(setq company-idle-delay 1.0)
