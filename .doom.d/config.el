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
(setq doom-theme 'doom-nord)

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

(setq org-directory "~/org-files/")
(setq org-roam-directory "~/org-files/")


(after! org
  (setq org-agenda-files '("~/org-files" "~/org-files/daily"))
  (setq org-roam-server-host "0.0.0.0")
  (setq +org-roam-open-buffer-on-find-file nil)
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
(setq org-tags-column 0)

;; use only both ROAM_TAGS (prop) for roam file searches
;; ( I use vanilla FILETAGS for agenda classification of TODOs, NOT for file tagging )
(setq org-roam-tag-sources '(prop))


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

;; clocking
(setq org-clock-idle-time 5)
;; (setq org-clock-persist-insinuate t) ;; apparently this is not a variable... maybe it is outdated?
(setq org-clock-persist t)
(setq org-clock-in-resume t)
(setq org-clock-persist-query-resume nil)
(setq org-clock-report-include-clocking-task t)
(setq org-agenda-clockreport-parameter-plist
        '(:maxlevel 6 :link t :stepskip0 t :fileskip0 t :hidefiles t :compact t :narrow 60 :score 0))


;; doom emacs customizations
(setq doom-modeline-buffer-file-name-style 'file-name)
;; see https://github.com/seagle0128/doom-modeline
(setq doom-modeline-major-mode-color-icon nil)
(setq doom-modeline-unicode-fallback t)
(setq doom-modeline-buffer-encoding nil)

;; yasnippets
(setq yas-global-mode t)

;; ditaa exporting
(org-babel-do-load-languages
 'org-babel-load-languages
 '(
   (emacs-lisp . t)
   (plantuml . t)
   (dot . t)
   )
 )

(setq org-ditaa-jar-path "/usr/share/ditaa/ditaa.jar")


;; allow individually-hidden code blocks on file-open
;; (instead of hiding or showing all of them)
(defun individual-visibility-source-blocks ()
  "Fold some blocks in the current buffer."
  (interactive)
  (org-show-block-all)
  (org-block-map
   (lambda ()
     (let ((case-fold-search t))
       (when (and
              (save-excursion
                (beginning-of-line 1)
                (looking-at org-block-regexp))
              (cl-assoc
               ':hidden
               (cl-third
                (org-babel-get-src-block-info))))
         (org-hide-block-toggle))))))

(add-hook
 'org-mode-hook
 (function individual-visibility-source-blocks))


;; eshell config
(setq eshell-prefer-lisp-functions t)
(setq password-cache-expiry 60)
;;(add-to-list 'eshell-modules-list 'eshell-tramp)


;; visual line wrap
(visual-line-mode t)
(toggle-truncate-lines nil)


;; open help buffers in permanent windows
(add-to-list 'display-buffer-alist '("*Help*" display-buffer-same-window))


;; WebDAV + org-mobile
(setq org-mobile-directory "/home/josh/data/data")
(setq org-mobile-inbox-for-pull "/home/josh/data/data/inbox-file.org")


;; cycle visibility of archived headers on tab
(setq org-cycle-open-archived-trees t)

;; heading archival settings
(setq org-archive-location "~/org-files/task_archive.org::datetree/")

;; todoist integation
(setq todoist-token "8e476a4df526d9ec82bf85ac01ca686e79590571")
