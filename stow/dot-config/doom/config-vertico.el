(setq vertico-multiform-commands
      '((describe-symbol (vertico-sort-function . vertico-sort-alpha))))

(setq vertico-multiform-categories
      '((symbol (vertico-sort-function . vertico-sort-alpha))
        (file (vertico-sort-function . sort-directories-first))))

;; Sort directories before files
(defun sort-directories-first (files)
  (setq files (vertico-sort-history-length-alpha files))
  ;; I could do some custom sorting here... find and them sort by the git project, or something
  (nconc (seq-filter (lambda (x) (string-suffix-p "/" x)) files)
         (seq-remove (lambda (x) (string-suffix-p "/" x)) files)))

;; we still need to ENABLE multiform-mode for our configuration to apply
;; multiform mode allows different sorting algorithms etc for each type of buffer
(vertico-multiform-mode 1)
