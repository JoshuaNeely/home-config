(use-package! gptel
    :config
    (require 'gptel-integrations)
    (require 'gptel-org)
    (setq
        gptel-api-key "sk-aa1069dde64d4e95aaa3994d847a7bba"
        gptel-default-mode 'org-mode
        gptel-use-curl t
        gptel-use-tools t
        gptel-confirm-tool-calls 'always
        gptel-include-tool-results 'auto
        gptel-backend (gptel-make-openai "OpenWebUI"
                 :host "10.0.32.104:3000"
                 :protocol "http"
                 :key "sk-aa1069dde64d4e95aaa3994d847a7bba"
                 :endpoint "/api/chat/completions"
                 :stream t
                 :models '("is4s-code"))))

(use-package! mcp
  :ensure t
  :after gptel
  :custom
  (mcp-hub-servers
     `(
        ("localdev" . (:url "http://localhost:7777/mcp"))
      )
  )
  :config (require 'mcp-hub)
)

;;   `(("duckduckgo" . (:command "uvx" :args ("duckduckgo-mcp-server")))
;;     ("fetch" . (:command "uvx" :args ("mcp-server-fetch")))
;;     ("filesystem" . (:command "npx" :args ("-y" "@modelcontextprotocol/server-filesystem" ,(getenv "home"))))
;;     ("sequential-thinking" . (:command "npx" :args ("-y" "@modelcontextprotocol/server-sequential-thinking")))
;;     ("context7" . (:command "npx" :args ("-y" "@upstash/context7-mcp") :env (:default_minimum_tokens "6000")))
;;     ))
;;  :config (require 'mcp-hub)
;;  :hook (after-init . mcp-hub-start-all-server))
;;  

;; I rely on ~/.aider.conf.yml instead of configuration here
(use-package aider)

;; (use-package aider
;;   :config
;;   ;; For latest claude sonnet model
;;   ;; (setq aider-args '("--model" "sonnet" "--no-auto-accept-architect")) ;; add --no-auto-commits if you don't want it
;;   ;; (setenv "ANTHROPIC_API_KEY" anthropic-api-key)
;;   ;; Or chatgpt model
;;   (setq aider-args '("--model" "openai/is4s-general"))
;;   (setenv "OPENAI_API_BASE" "http://10.0.32.104:3000/api")
;;   (setenv "OPENAI_API_KEY" "sk-aa1069dde64d4e95aaa3994d847a7bba")
  
;;   ;; Or use your personal config file
;;   ;; (setq aider-args `("--config" ,(expand-file-name "~/.aider.conf.yml")))
;;   ;; ;;
;;   ;; Optional: Set a key binding for the transient menu
;;   ;;(global-set-key (kbd "C-c a") 'aider-transient-menu) ;; for wider screen
;;   ;; or use aider-transient-menu-2cols / aider-transient-menu-1col, for narrow screen
;;   ;;(aider-magit-setup-transients) ;; add aider magit function to magit menu
;;   ;; auto revert buffer
;;   (global-auto-revert-mode 1)
;;   (auto-revert-mode 1))
 


;; (use-package! aider-emacs
;;  :config)
