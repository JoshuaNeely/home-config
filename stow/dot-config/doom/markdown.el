;; make markdown-mode look more like org mode

;; (use-package markdown-mode
;;   :hook ((markdown-mode . visual-line-mode)
;;          (markdown-mode . mixed-pitch-mode)
;;          (markdown-mode . olivetti-mode))
;;   :config
;;   (setq markdown-hide-markup t)
;;   (setq markdown-hide-urls t)
;;   (setq markdown-fontify-code-blocks-natively t)
;;   (set-face-attribute 'markdown-header-face-1 nil :height 1.8 :weight 'bold)
;;   (set-face-attribute 'markdown-header-face-2 nil :height 1.5 :weight 'bold)
;;   (set-face-attribute 'markdown-header-face-3 nil :height 1.3 :weight 'semi-bold)
;;   (set-face-attribute 'markdown-header-face-4 nil :height 1.1 :weight 'semi-bold))


;; (custom-set-faces!
;;   '(markdown-header-face-1 :height 1.8 :weight bold :inherit markdown-header-face)
;;   '(markdown-header-face-2 :height 1.5 :weight bold :inherit markdown-header-face)
;;   '(markdown-header-face-3 :height 1.3 :weight semi-bold :inherit markdown-header-face)
;;   '(markdown-header-face-4 :height 1.1 :weight semi-bold :inherit markdown-header-face))
(custom-set-faces!
  '(markdown-header-face-1 :inherit org-level-1)
  '(markdown-header-face-2 :inherit org-level-2)
  '(markdown-header-face-3 :inherit org-level-3)
  '(markdown-header-face-4 :inherit org-level-4))

;; (after! markdown-mode
;;   ;;(setq markdown-hide-markup t)
;;   ;;(setq markdown-hide-urls t)
;;   (setq markdown-fontify-code-blocks-natively t))

(add-hook! markdown-mode
  (markdown-toggle-markup-hiding 0)
  (markdown-toggle-url-hiding 1)
  #'mixed-pitch-mode
  #'visual-line-mode)

;; Swap it on and off to see the difference- it makes the text look like "pretty" text instead
;; of monospace code text.
;; I'm not sure about it so far. It's prettier but less "nerdy" feeling, which I enjoy.
(use-package! mixed-pitch
  :hook (markdown-mode . mixed-pitch-mode))
