
;; see https://titan-c.gitlab.io/org-cv/
;; I need to make this interactive or based on the name of the buffer it is operating on, or something
;;
(defun modern-cv-latex-export ()
  "Use modern-cv to export an org file into .tex and then to a .pdf"
  (interactive)
  (org-export-to-file 'moderncv "moderncv.tex")
  (org-latex-compile "moderncv.tex")
  )


;; all of this is my attempt to commit when I save, and make one commit per day.
;; I am stuck on the check-if-timestamps-are-the-same and if so amend, step.
;; It seems to work here, but when I run it from an org file (and thus in the org repo) it fails with a useless error :/

(defun today ()
  (format-time-string "%A-%B-%e-%Y"))

(defun get-file-path ()
  (buffer-file-name (window-buffer (minibuffer-selected-window))))

(defun git-workflow ()
  "Stage all changes and commit as current timestamp, amending if identical timestamp"
  (interactive)

  (magit-stage-file (get-file-path))

  (setq gpg-off "commit.gpgsign=false")
  (setq commit (format "commit -m %s" (today)))
  (setq git-commit (format "\"git -c %s %s\"" gpg-off commit))

  ;;(shell-command (format "\"%s\"" git-commit))

  (setq previous-commit-message (shell-command "git show -s --format=%s"))
  (setq todaystr (today))

  ;;(if (eq (today) previous-commit-message)
  ;;    (message "they are equal")
  ;;  (message "NOT equal"))
  )

(defun clock-report ()
  (interactive)
  ;;(setq clock-report-buffer "20221018154502-ephemeral_clock_report.org")
  (setq clock-report-buffer "clock_report")
  (setq selected-time-string (org-read-date))
  (setq clock-report-template
        (setq clock-report-template (format
                "#+BEGIN: clocktable :scope agenda-with-archives :block %s :maxlevel 5 :link t :stepskip0 t :fileskip0 t :hidefiles t :match \"-personal\"\n#+END:"
                selected-time-string)))

  ;; ephemeral buffer broke after newested updates
  ;; couldn't rebuild clock report without tossing the buffer
  ;; saving to a file works okay though, so I have dedicated a file to it
  (get-buffer-create clock-report-buffer)
  (persp-add-buffer clock-report-buffer)
  (with-current-buffer clock-report-buffer
        (org-mode)
        (erase-buffer)
        (insert clock-report-template)
        (org-clock-report))
  (switch-to-buffer clock-report-buffer))


(defun insert-publishing-template ()
  "Insert the template for publishing an org page."
  (interactive)
  (let ((publishing-keywords "
#+BLOG_PUBLISH: t
#+SETUPFILE: /home/josh/blog/blog-publish-settings.org
"))
    (insert publishing-keywords)
    ))


(defun yank-absolute-link-to-current-file()
  (interactive)
  (setq file-abs-path (file-relative-name buffer-file-name "/"))
  (kill-new (format "[[%s][%s]]" file-abs-path file-abs-path)))

(defun yank-project-link-to-current-file()
  (interactive)
  (setq project-path (file-name-directory (directory-file-name (doom-project-root))))
  (setq file-abs-path (file-relative-name buffer-file-name "/"))
  (setq file-project-path (file-relative-name buffer-file-name project-path))
  (kill-new (format "[[%s][%s]]" file-abs-path file-project-path)))

(defun yank-link-to-current-file()
  (interactive)
  (setq directory-name-only (file-name-directory buffer-file-name))
  (setq file-name-only (file-relative-name buffer-file-name directory-name-only))
  (setq file-abs-path (file-relative-name buffer-file-name "/"))
  (kill-new (format "[[%s][%s]]" file-abs-path file-name-only)))


;; [[file:~/git/USSF/tnc/openc3/openc3-cmd-tlm-api/app/channels/limits_events_channel.rb][openc3-cmd-tlm-api/app/channels/limits_events_channel.rb]]

;; insert a TODO item due today
;; * TODO test123
;;   DEADLINE: <2021-15-01 Fri>
(defun todo-today ()
  "Insert the template for a daily-tasks outline."
  (interactive)
  (setq today-time-string (format-time-string "<%Y-%d-%m %a>"))
  (setq raw-headline (read-string "Enter Headline:  "))
  (setq todo-headline (format "* TODO %s" raw-headline))
  (insert todo-headline ?\n "DEADLINE: " today-time-string)
)

;; turn on hide-show minor mode by default, and bind toggling to tab
(defun toggle-selective-display (column)
      (interactive "P")
      (set-selective-display
       (or column
           (unless selective-display
             (1+ (current-column))))))


(defun toggle-hiding (column)
       (interactive "P")
       (if hs-minor-mode
          (if (condition-case nil
                  (hs-toggle-hiding)
                (error t))
              (hs-show-all))
        (toggle-selective-display column)))


;; not sure if this worked...
(add-hook 'scala-mode-hook 'hs-minor-mode)


;; a minor mode for defining my own key maps
;; the minor mode helps make sure other minor / major modes wont overwrite it. probably
(defvar my-keys-minor-mode-map
  (let ((map (make-sparse-keymap)))
    ;; this is doom emacs magic. the "default" way google tells me doesn't seem to work
    ;; maybe that's doom emacs trampling the default way in favor of its own?
    (map! "C-j" #'toggle-hiding)
    map)
  "my-keys-minor-mode keymap.")

(define-minor-mode my-keys-minor-mode
  "A minor mode so that my key settings override annoying major modes."
  :init-value t
  :lighter " my-keys")

(my-keys-minor-mode 1)

(defun my-minibuffer-setup-hook ()
  (my-keys-minor-mode 0))

(add-hook 'minibuffer-setup-hook 'my-minibuffer-setup-hook)


;; custom "ls" function
(defun ls ()
  "Convenient access to ls-like functionality"
  (interactive)
  (shell-command "ls"))


(defun insert-timestamp ()
  "Insert a timestamp of the current time and date without further prompting."
  (interactive)
  (setq current-prefix-arg '(16)) ;; this is the same as =C-u C-u= for some reason
  (call-interactively 'org-time-stamp))

;; makes life easier

(defun new-terminal-buffer ()
  "Create a new terminal and register it with the workspace system"
  (interactive)
  (setq new-terminal-name (read-string "Enter new terminal name:  "))
  (ansi-term "/bin/bash" new-terminal-name)
  (persp-add-buffer (format "*%s*" new-terminal-name)))


(defun insert-code-block ()
  "Insert a code block."
  (interactive)
  (setq code-src-type (read-string "Enter the src language:  "))
  (insert (format "#+BEGIN_SRC %s\n#+END_SRC" code-src-type)))


(defun send-email (recipient subject body)
    "Send an email from you with a given recipient, subject, and message"
    (interactive)

    (progn
        (mail)
        (mail-to) (insert recipient)
        (mail-subject) (insert subject)
        (mail-text) (insert (format "<#part type=\"text/html\" disposition=inline>%s<#/part>" body))
        (mail-send-and-exit)))

(defun send-test-email ()
  "reduce some typing. TEMP!"
  (interactive)
  (send-email "joshua.a.neely@gmail.com" "subject here" "this is the body!")
  )


(defun send-email-interactive ()
    "Send an email from you with a given recipient, subject, and message"
    (interactive)

    (setq recipient (read-string "enter email recipient:  "))
    (setq subject (read-string "enter email subject:  "))
    (setq body (read-string "enter email body:  "))

    (send-email recipient subject body))


(defun open-task-inbox ()
  "Open my ongoing tasks inbox. Combine with archiving workflow."
  (interactive)
  (let ((inboxdir (format "/home/%s/org-files/task_inbox.org" user-login-name)))
        (find-file inboxdir)))

(defun open-work-task-inbox ()
  "Open my ongoing tasks inbox. Combine with archiving workflow."
  (interactive)
  (let ((inboxdir (format "/home/%s/org-files/task_inbox_work.org" user-login-name)))
        (find-file inboxdir)))



(defun magit-graph ()
  "Open a magit log buffer with decorated graph."
  (interactive)
  (magit-log-current (magit-log-read-revs t) (list "--decorate" "--color" "--graph")))
