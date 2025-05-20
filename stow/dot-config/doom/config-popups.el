
;; see help for `set-popup-rule` for documentation.
;; details what commands and options exist
;;
;; see 'popup-raise' for promoting a popup into a normal buffer.

;; these defaults only seem to apply if one of the below rules catches the buffer.
(setq +popup-defaults '(:side bottom :height 0.16 :width 40
                        :quit nil
                        :select t
                        :modeline t
                        :ttl 5))

(set-popup-rules!
 '(("^ \\*" :slot -1 :modeline t) ; fallback rule for special buffers
   ("^\\*Flycheck errors*" :select t :quit nil :size 0.3 :side bottom)
   ("^\\*helpful*" :select t :quit nil :side bottom)
   ))
