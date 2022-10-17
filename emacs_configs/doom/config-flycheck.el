;;; config-flycheck.el -*- lexical-binding: t; -*-

(require 'flycheck)
(flycheck-add-mode 'javascript-eslint 'web-mode)

(setq-default flycheck-disabled-checkers '(lsp python-mypy))
