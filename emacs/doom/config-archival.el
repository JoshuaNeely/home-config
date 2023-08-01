;;; config-archival.el -*- lexical-binding: t; -*-

(require 'org-archive)


;; cycle visibility of archived headers on tab
(setq org-cycle-open-archived-trees t)

(setq org-archive-reversed-order t)

;; This is overwritten by PROPERTY drawer settings.
;; At the moment i'm doing this to specify headers that match the parent header for a few different categories in task_inbox.org
(setq org-archive-location "~/org-files/task_archive.org::datetree/* Misc")
