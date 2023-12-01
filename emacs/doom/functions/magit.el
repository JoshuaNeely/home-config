;; I am overwriting the original function.
;; You call this function through magit- "l o"
;; The original function is designed to take a LIST of refs by name.
;; I find a selection much easier and faster to use, and never have a need to select multple refs anyway.
(defun magit-log-other--custom ()
  "Display the log of a specified branch."
  (interactive)
  (let* (
    (user-prompt "Show commit log for")
    (branch (magit-read-local-branch-or-ref user-prompt))
    (log-arguments (car (magit-log-arguments)))
    (files nil)
  )
    (magit-log-setup-buffer (list branch) log-arguments files)
  ))

(advice-add 'magit-log-other :override 'magit-log-other--custom)

