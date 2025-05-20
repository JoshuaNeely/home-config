;; maginalia is a package that decorates the "results-minibuffer" we get with buffer/file/help searches.
;; as of the newest doom emacs, we use vertico to generate our search results, then marginalia to annotate those results with more contextual information.

;; (marginalia--git-project-column (get-buffer "blah.text"))
;;(magit-toplevel (buffer-local-value 'default-directory (get-buffer "blah.text")))

(defun marginalia--git-project-column (buffer)
  (file-name-nondirectory (directory-file-name
    (or
        (magit-toplevel (buffer-local-value 'default-directory buffer))
        "/"))))

(defun marginalia--first-dir-column (buffer)
  (setq current-directory (buffer-local-value 'default-directory buffer))
  (setq last-directory-in-path (car (last (split-string current-directory "\\/") 2)))
  (format "%s/" last-directory-in-path))

(defun marginalia--buffer-mode (buffer)
  (format-mode-line '(
                      (20 (-20 (:propertize mode-name face marginalia-mode))))
                    nil nil buffer))

;; this function is used in marginalia-annotator-registry
;; I used the "Customize" interface to include it, but we should probably so something more permanent
(defun marginalia-josh-annotate-buffer (cand)
  "Annotate buffer CAND with josh custom stuff."
  (when-let (buffer (get-buffer cand))
    (marginalia--fields
     ((marginalia--git-project-column buffer) :truncate 0.20 :face 'outline-1)
     ((marginalia--first-dir-column buffer) :truncate  0.13)
     ((marginalia--buffer-mode buffer))
     ((marginalia--buffer-file buffer) :truncate 1.5 :face 'marginalia-file-name))))
