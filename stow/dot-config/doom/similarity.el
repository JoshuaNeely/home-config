(use-package! org-similarity
  :config
  (setq org-similarity-directory "~/org-files")   ; point at your notes folder
  (setq org-similarity-file-extension "md")       ; "org" if using org files
  (setq org-similarity-number-of-documents 10)    ; how many similar docs to show
  (setq org-similarity-min-chars 0)               ; minimum file size to index
  (setq org-similarity-recursive t))              ; search subdirectories
