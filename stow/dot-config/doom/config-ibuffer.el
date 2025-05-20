 (setq ibuffer-saved-filter-groups
	  (quote (("default"
		  ("dired" (mode . dired-mode))
		  ("org" (mode . org-mode))
		  ("terminals" (or
                             (mode . vterm-mode)
                             (mode . term-mode)))
		  ("magit" (name . "^magit"))
		  ("code" (directory . "git"))
		  ("emacs" (or
			     (name . "^\\*scratch\\*$")
			     (name . "^\\*Messages\\*$")))))))

(add-hook 'ibuffer-mode-hook
	  (lambda ()
	    (ibuffer-switch-to-saved-filter-groups "default")))
