(setq mylsl-font-lock-keywords
      (let* (
            ;; define several category of keywords
            ;; space delimited strings, eg  (x-keywords '("if" "else" "break"))
            (x-keywords '("UNITS" "META" "ID" "APID" "HAZARDOUS" "STATE"))
            (x-types '("UINT" "BIG_ENDIAN" "UNSINGTEGER"))
            (x-constants '())
            (x-events '())
            (x-functions '("COMMAND" "PARAMETER"))

            ;; generate regex string for each category of keywords
            (x-keywords-regexp (regexp-opt x-keywords 'words))
            (x-types-regexp (regexp-opt x-types 'words))
            (x-constants-regexp (regexp-opt x-constants 'words))
            (x-events-regexp (regexp-opt x-events 'words))
            (x-functions-regexp (regexp-opt x-functions 'words)))

        `(
          (,x-types-regexp . 'font-lock-type-face)
          (,x-constants-regexp . 'font-lock-constant-face)
          (,x-events-regexp . 'font-lock-builtin-face)
          (,x-functions-regexp . 'font-lock-function-name-face)
          (,x-keywords-regexp . 'font-lock-keyword-face)
          ;; note: order above matters, because once colored, that part won't change.
          ;; in general, put longer words first
          )))

(define-derived-mode openc3-mode fundamental-mode "openc3"
  "Major mode for editing openc3 cmd tlm files."
  (setq font-lock-defaults '((mylsl-font-lock-keywords))))
