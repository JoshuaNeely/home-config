;;; ../../home-config/emacs_configs/doom/config-org.el -*- lexical-binding: t; -*-


;; used when exporting org files to html, latex, etc
(setq user-full-name "Joshua Neely")

;; right align tags
;; doesn't appear to be a simple way to get the LAST column; it's just... some arbitrary number
;; the negative makes it right-flush (vs left-flush by default) with the column
(setq org-tags-column 0)


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
;; (add-hook 'org-mode-hook
;;   (lambda () (add-hook 'after-save-hook #'org-babel-tangle
;;     :append :local)))


;; remove a bunch of useless TODO items you have by default
;; info on syntax and stuff https://orgmode.org/manual/Workflow-states.html#Workflow-states
;; seems that maybe agenda was squashing this? I moved it below the agenda loading
(setq org-todo-keywords
   '((sequence "TODO(t)" "|" "DONE(d)" "CANCELLED(c)")
     (sequence "[ ](T)" "|" "[X](D)" "[-](C)"))
   )


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


;;(use-package! org-pandoc-import :after org)
;;(use-package! ox-pandoc :after org)
