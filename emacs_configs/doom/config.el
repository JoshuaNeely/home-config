;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


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

;; setting up org-roam-ui
;; https://github.com/org-roam/org-roam-ui
(use-package! websocket
 :after org-roam)

(use-package! org-roam-ui
   :after org ;; or :after org
        ;; normally we'd recommend hooking orui after org-roam, but since org-roam does not have
        ;; a hookable mode anymore, you're advised to pick something yourself
        ;; if you don't care about startup time, use
 ;; :hook (after-init . org-roam-ui-mode)
   :config
   (setq org-roam-ui-sync-theme t
         org-roam-ui-follow t
         org-roam-ui-update-on-save t
         org-roam-ui-open-on-start t))


(after! org
  (setq org-agenda-files '("~/org-files/task_inbox.org" "~/org-files/task_inbox_work.org"))
  (setq org-roam-server-host "0.0.0.0")
  (setq +org-roam-open-buffer-on-find-file nil)
)


;; used when exporting org files to html, latex, etc
(setq user-full-name "Joshua Neely")

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


(load "~/.doom.d/config-keymapping.el")

(load "~/.doom.d/config-agenda.el")

(load "~/.doom.d/config-rss.el")

(load "~/.doom.d/custom-functions.el")

(load "~/.doom.d/config-publishing.el")

(load "~/.doom.d/config-ctags.el")

(load "~/.doom.d/config-clock.el")

(load "~/.doom.d/config-archival.el")

(load "~/.doom.d/config-popups.el")

;; breaking something after doom upgrade...
;;(load "~/.doom.d/config-dired.el")

(load "~/.doom.d/config-flycheck.el")

(load "~/.doom.d/config-lsp.el")

(load "~/.doom.d/config-uniquify.el")

(load "~/.doom.d/config-wsl.el")

(load "~/.doom.d/config-plantuml.el")

(load "~/.doom.d/config-gui.el")


;; customize default emacs font
;; only relevant for the GUI?
(add-to-list 'default-frame-alist
             '(font . "DejaVu Sans Mono-12"))


;; remove a bunch of useless TODO items you have by default
;; info on syntax and stuff https://orgmode.org/manual/Workflow-states.html#Workflow-states
;; seems that maybe agenda was squashing this? I moved it below the agenda loading
(setq org-todo-keywords
   '((sequence "TODO(t)" "|" "DONE(d)" "CANCELLED(c)")
     (sequence "[ ](T)" "|" "[X](D)" "[-](C)"))
   )


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


(setq evil-shift-width 2)

;; visual line wrap
(visual-line-mode t)
(toggle-truncate-lines nil)


;; open help buffers in permanent windows
(add-to-list 'display-buffer-alist '("*Help*" display-buffer-same-window))


;; WebDAV + org-mobile
(setq org-mobile-directory "/home/josh/data/data")
(setq org-mobile-inbox-for-pull "/home/josh/data/data/inbox-file.org")


;; todoist integation
(setq todoist-token "8e476a4df526d9ec82bf85ac01ca686e79590571")


;; open my task inbox on emacs start
;;(add-hook 'emacs-startup-hook #'open-task-inbox)
;; i think i may prefer using the topmost link of the splash screen


;; doom dashboard config
(setq +doom-dashboard-menu-sections
  '(("Open Task Inbox"
     :face (:inherit (doom-dashboard-menu-title bold))
     :action open-task-inbox)
    ("Open Work Task Inbox"
     :face (:inherit (doom-dashboard-menu-title bold))
     :action open-work-task-inbox)
    ("Recently opened files"
     :action recentf-open-files)
    ("Open private configuration"
     :when (file-directory-p doom-private-dir)
     :action doom/open-private-config)
    ("Open documentation"
     :icon (all-the-icons-octicon "book" :face 'doom-dashboard-menu-title)
     :action doom/help)))

;;(use-package! org-pandoc-import :after org)
;;(use-package! ox-pandoc :after org)


(use-package auth-source-pass
  :init (auth-source-pass-enable))
