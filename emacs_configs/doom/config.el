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

(load "~/.config/doom/config-general.el")

;; somehow this was getting un-set... links were being written in the expanded form
(setq org-link-descriptive t)

(display-time-mode)

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




;; open help buffers in permanent windows
(add-to-list 'display-buffer-alist '("*Help*" display-buffer-same-window))


;; WebDAV + org-mobile
(setq org-mobile-directory (format "/home/%s/data/data" user-login-name))
(setq org-mobile-inbox-for-pull (format "/home/%s/data/data/inbox-file.org" user-login-name))


;; todoist integation
(setq todoist-token "8e476a4df526d9ec82bf85ac01ca686e79590571")


;; open my task inbox on emacs start
;;(add-hook 'emacs-startup-hook #'open-task-inbox)
;; i think i may prefer using the topmost link of the splash screen



;;(use-package! org-pandoc-import :after org)
;;(use-package! ox-pandoc :after org)


(use-package auth-source-pass
  :init (auth-source-pass-enable))


(setq org-reveal-root "file:///home/jneely/home-config/org-files/reveal.js")
