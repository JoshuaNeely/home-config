(when
        (and (eq system-type 'gnu/linux)
                (string-match
                "Linux.*Microsoft.*Linux"
                (shell-command-to-string "uname -a")))

        (setq
                browse-url-generic-program  "/mnt/c/Windows/System32/cmd.exe"
                browse-url-generic-args     '("/c" "start")
                browse-url-browser-function 'browse-url-generic))



