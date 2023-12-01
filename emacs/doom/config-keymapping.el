;; (map! :leader
;;       (:prefix-map ("j" . "Josh Things")
;;       :desc "test1" "j" #'ls
;;       :desc "test2" "k" #'ls))

(map! :leader
      (:prefix-map ("j" . "Josh Smerge Things MAGIT")
      :desc "smerge keep lower" "J" #'smerge-keep-lower
      :desc "smerge keep upper" "K" #'smerge-keep-upper
      :desc "smerge goto next" "j" #'smerge-next
      :desc "smerge goto previous" "k" #'smerge-prev))
