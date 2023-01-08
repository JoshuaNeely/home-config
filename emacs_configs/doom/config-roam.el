;;; ../home-config/emacs_configs/doom/config-roam.el -*- lexical-binding: t; -*-

(setq org-roam-capture-templates
        '(("d" "default" plain "%?" :target
        (file+head "${slug}.org" "#+title: ${title}\n")
        :unnarrowed t)))
