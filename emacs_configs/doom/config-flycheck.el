;; (require 'flycheck)
;; (flycheck-add-mode 'javascript-eslint 'web-mode)

;; (setq-default flycheck-disabled-checkers '(lsp python-mypy))

(setq flycheck-flake8rc '(".flake8" "flake8"))
(setq flycheck-python-mypy-config '("mypy.ini"))
(setq flycheck-pylintrc '("pylintrc" ".pylintrc"))
