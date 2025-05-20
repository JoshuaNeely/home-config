;;; ../home-config/emacs_configs/doom/config-roam.el -*- lexical-binding: t; -*-

(setq org-directory "~/org-files/")
(setq org-roam-directory "~/org-files/")


(setq org-roam-capture-templates
        '(("d" "default" plain "%?" :target
        (file+head "${slug}.org" "#+title: ${title}\n")
        :unnarrowed t)))


;; ;; setting up org-roam-ui
;; ;; https://github.com/org-roam/org-roam-ui
;; (use-package! websocket
;;  :after org-roam)

;; (use-package! org-roam-ui
;;    :after org ;; or :after org
;;         ;; normally we'd recommend hooking orui after org-roam, but since org-roam does not have
;;         ;; a hookable mode anymore, you're advised to pick something yourself
;;         ;; if you don't care about startup time, use
;;  ;; :hook (after-init . org-roam-ui-mode)
;;    :config
;;    (setq org-roam-ui-sync-theme t
;;          org-roam-ui-follow t
;;          org-roam-ui-update-on-save t
;;          org-roam-ui-open-on-start t))


;; (after! org
;;   (setq org-agenda-files '("~/org-files/task_inbox.org" "~/org-files/task_inbox_work.org" "~/org-files/calendar.org"))
;;   (setq org-roam-server-host "0.0.0.0")
;;   (setq +org-roam-open-buffer-on-find-file nil)
;; )


;; use only both ROAM_TAGS (prop) for roam file searches
;; ( I use vanilla FILETAGS for agenda classification of TODOs, NOT for file tagging )
;; (setq org-roam-tag-sources '(prop))
