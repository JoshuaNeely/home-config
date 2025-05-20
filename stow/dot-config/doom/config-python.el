;; this is old; no idea if it's still useful
;; (setq pyvenv-post-activate-hooks
;;         (list (lambda ()
;;                 (setq python-shell-interpreter (concat pyvenv-virtual-env "bin/python3")))))

;; (setq pyvenv-post-deactivate-hooks
;;         (list (lambda ()
;;                 (setq python-shell-interpreter "python3"))))

;; (elpy-enable)

;; ;; disable flyMAKE in favor of the more modern flyCHECK
;; (when (load "flycheck" t t)
;;   (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
;;   (add-hook 'elpy-mode-hook 'flycheck-mode))
