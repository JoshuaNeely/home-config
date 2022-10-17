;;; config-lsp.el -*- lexical-binding: t; -*-

;;(use-package lsp-mode
;;  :hook
;;((python-mode . lsp)))

(setq lsp-pyls-plugins-flake8-config "/home/josh/tox.ini")

(setq lsp-pylsp-plugins-flake8-enabled nil)
(setq lsp-pylsp-plugins-pycodestyle-enabled nil)
(setq lsp-pylsp-plugins-pydocstyle-enabled nil)


(setq lsp-pyls-plugins-pycodestyle-ignore '("D101"))
(setq lsp-pyls-plugins-pydocstyle-ignore '("D101"))
(setq lsp-pyls-plugins-flake8-ignore '("D101"))

(setq lsp-pylsp-plugins-pycodestyle-ignore '("D101", "302"))
(setq lsp-pylsp-plugins-pydocstyle-ignore '("D101", "302"))
(setq lsp-pylsp-plugins-flake8-ignore '("D101", "302"))

;;(setq lsp-pylsp-plugins-flake8-config "/home/josh/tox.ini")
