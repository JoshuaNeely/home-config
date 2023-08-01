;; Make dired open in the same window when using RET or ^

; disables warning
(put 'dired-find-alternate-file 'disabled nil)

; was dired-advertised-find-file
(define-key dired-mode-map (kbd "RET") 'dired-find-alternate-file)

; was dired-up-director
(define-key dired-mode-map (kbd "<") (lambda () (interactive) (find-alternate-file "..")))
(define-key dired-mode-map (kbd "^") (lambda () (interactive) (find-alternate-file "..")))
