;;; config-midnight.el -*- lexical-binding: t; -*-

;; midnight mode for periodic tasks
;; https://www.emacswiki.org/emacs/MidnightMode

;; remove every existing hook first
;;
;; I had a problem with old hook sticking around and duplicate hooks accumulating. I was getting spammed with events.
;; I'm not sure what was causing it... ssh sessions maybe? multiple sessions opening emacs without closing it?
(if (boundp 'midnight-hook)
        (mapc (lambda (hook) (remove-hook 'midnight-hook hook)) midnight-hook)
  nil)

;; it is possible to have mulitple hooks registered. Just call this function again.
;; The only limitation is that they can not be duplicates. No reason for that anyway right?
(add-hook 'midnight-hook
          (lambda ()
                (send-email "joshua.a.neely@gmail.com" "daily briefing" "TODO: My Agenda Here")
                ))

;; this is the period, in seconds, that the hook triggers
(setq midnight-period (* 60 60 24))

;; this is initializing the hook(?) and configuring what time 'midnight' is.
;; I am NOT aware of a way to set more than one 'midnight' time. This isn't cron.
(midnight-delay-set 'midnight-delay "5:00am")
