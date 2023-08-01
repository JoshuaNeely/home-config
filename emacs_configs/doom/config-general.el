;;; ../../home-config/emacs_configs/doom/config-general.el -*- lexical-binding: t; -*-


(setq display-line-numbers-type t)

(setq evil-shift-width 2)

(visual-line-mode t)

(toggle-truncate-lines nil)

(display-time-mode)


;; customize default emacs font
;; only relevant for the GUI?
(add-to-list 'default-frame-alist
             '(font . "DejaVu Sans Mono-12"))


;; open help buffers in permanent windows
;; did help buffers change naming conventions? doesn't seem to work
;; (add-to-list 'display-buffer-alist '("*Help*" display-buffer-same-window))
