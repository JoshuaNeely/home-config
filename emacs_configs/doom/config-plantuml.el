;;; config-plantuml.el -*- lexical-binding: t; -*-

(setq plantuml-default-exec-mode 'jar)
;; wherever it defaults to installing to. Should be local to emacs install.
;; see  (plantuml-download-jar)
;; (setq plantuml-jar-path "/usr/share/plantuml/plantuml.jar")
;; (setq org-plantuml-jar-path (expand-file-name "/usr/share/plantuml/plantuml.jar"))
(setq org-startup-with-inline-images t)

(add-to-list 'org-src-lang-modes '("plantuml" . plantuml))
(org-babel-do-load-languages 'org-babel-load-languages '((plantuml . t)))
