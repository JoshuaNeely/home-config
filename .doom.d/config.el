;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "John Doe"
      user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

(use-package org-journal
  :bind
  ("C-c n j" . org-journal-new-entry)
  :custom
  (org-journal-dir "~/org/")
  (org-journal-date-prefix "#+TITLE: ")
  (org-journal-file-format "%Y-%m-%d.org")
  (org-journal-date-format "%A, %d %B %Y"))
(setq org-journal-enable-agenda-integration t)

(setq org-roam-directory "~/org/")

;; used with org-roam-server...... might be outdated?
(require 'simple-httpd)
(setq httpd-host "0.0.0.0")
(setq httpd-root "/var/www")
;;(httpd-start)

(use-package org-roam-server)
  :ensure nil
  :load-path "~/local/org-roam-server/"

(unless (server-running-p)
  ;;(org-roam-server-mode)
)

(after! org
  (setq org-agenda-files '("~/org" "~/org/daily"))
  (setq org-roam-server-host "0.0.0.0")
)

;; used when exporting org files to html, latex, etc
(setq user-full-name "Joshua Neely")


;; remove a bunch of useless TODO items you have by default
;; info on syntax and stuff https://orgmode.org/manual/Workflow-states.html#Workflow-states
(setq org-todo-keywords
   '((sequence "TODO(t)" "|" "DONE(d)" "CANCELLED(c)")
     (sequence "[ ](T)" "|" "[X](D)" "[-](C)"))
   )

;; right align tags
;; doesn't appear to be a simple way to get the LAST column; it's just... some arbitrary number
;; the negative makes it right-flush (vs left-flush by default) with the column
(setq org-tags-column -80)

;; use both ROAM_TAGS (prop) and vanilla FILETAGS (vanilla)
(setq org-roam-tag-sources '(vanilla prop))


;; creates a timestamp when closing a TO-DO
;; remove a redundant copy on transition state
;; this USED to work woth 'note but it broke out of the blue for some reason.
(setq org-log-done 'time)
(setq org-log-done-with-time 'nil)

;; this is an org mode hook- this means that this function (the lambda) is run after org mode is turned on
;; the function itself registers another hook, which links saving to tangling
;; Why? If we are editing something other than an .org file, this hook will not execute. Good!
;; I might be able to refine this some more, to check for a :blog tag or a :tangle tag or something
;; Not everything needs tangling...
;;
;; Why tangle?
;; Basically you are exporting an org file, which has both source code and prose documentation into other formats.
;; All of the code can be collected together into a source file. eg generate a bashscript file, or a .py file.
;; You can also export things like pdfs or pretty html, useful if this were a blog or similar.
(add-hook 'org-mode-hook
  (lambda () (add-hook 'after-save-hook #'org-babel-tangle
    :append :local)))


;; custom agenda config
(load "~/.doom.d/config-agenda.el")

;; latex config
(load "~/.doom.d/config-latex.el")

;; rss feed config
(load "~/.doom.d/config-rss.el")

;; custom functions
(load "~/.doom.d/custom-functions.el")

;; org publishing
(load "~/.doom.d/config-publishing.el")


;; customize default emacs font
;; only relevant for the GUI?
(add-to-list 'default-frame-alist
             '(font . "DejaVu Sans Mono-14"))
