(defun yank-absolute-link-to-current-file()
  (interactive)
  (let* (
    (file-abs-path (file-relative-name buffer-file-name "/"))
    (link-str (format "[[/%s][/%s]]" file-abs-path file-abs-path))
  )
  (kill-new link-str)))

(defun yank-project-link-to-current-file()
  (interactive)
  (let* (
    (project-path (file-name-directory (directory-file-name (doom-project-root))))
    (file-abs-path (file-relative-name buffer-file-name "/"))
    (file-project-path (file-relative-name buffer-file-name project-path))
    (link-str (format "[[/%s][%s]]" file-abs-path file-project-path))
  )
  (kill-new link-str)))

(defun yank-link-to-current-file()
  (interactive)
  (let* (
    (directory-name-only (file-name-directory buffer-file-name))
    (file-name-only (file-relative-name buffer-file-name directory-name-only))
    (file-abs-path (file-relative-name buffer-file-name "/"))
    (link-str (format "[[/%s][%s]]" file-abs-path file-name-only))
  )
  (kill-new link-str)))

(defun yank-link-to-current-file-line()
  (interactive)
  (let* (
    (directory-name-only (file-name-directory buffer-file-name))
    (file-name-only (file-relative-name buffer-file-name directory-name-only))
    (file-abs-path (file-relative-name buffer-file-name "/"))
    (line-number (line-number-at-pos))
    (link-str (format "[[/%s::%s][%s::%s]]" file-abs-path line-number file-name-only line-number))
  )
  (kill-new link-str)))
