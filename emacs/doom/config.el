;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying these files!


(load "~/.config/doom/config-org.el")

(load "~/.config/doom/config-doom.el")

(load "~/.config/doom/config-keymapping.el")

(load "~/.config/doom/config-agenda.el")

(load "~/.config/doom/config-rss.el")

(load "~/.config/doom/custom-functions.el")

(load "~/.config/doom/config-publishing.el")

(load "~/.config/doom/config-ctags.el")
(load "~/.config/doom/config-clock.el")

(load "~/.config/doom/config-archival.el")

(load "~/.config/doom/config-popups.el")

;; breaking something after doom upgrade...
;;(load "~/.config/doom/config-dired.el")

(load "~/.config/doom/config-python.el")

(load "~/.config/doom/config-flycheck.el")

(load "~/.config/doom/config-lsp.el")

(load "~/.config/doom/config-uniquify.el")

(load "~/.config/doom/config-wsl.el")

(load "~/.config/doom/config-plantuml.el")

(load "~/.config/doom/config-gui.el")

(load "~/.config/doom/config-roam.el")

(load "~/.config/doom/config-ibuffer.el")

(load "~/.config/doom/config-forge.el")

(load "~/.config/doom/config-crypt.el")

;;(load "~/.config/doom/config-d2.el")

;;(load "~/.config/doom/config-deck.el")

;; (load "~/.config/doom/config-webdav.el")

(load "~/.config/doom/config-reveal.el")

(load "~/.config/doom/config-pass.el")

(load "~/.config/doom/config-ditaa.el")

(load "~/.config/doom/config-eshell.el")

(load "~/.config/doom/config-general.el")



;; somehow this was getting un-set... links were being written in the expanded form
(setq org-link-descriptive t)

(display-time-mode)




