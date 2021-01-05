;; this file should be imported by config.el
;; just a nice way to split off some related config that is likely to grow independant of the main config


(setq org-agenda-custom-commands
  '(("w" "work agenda" todo ""

     (
      (org-super-agenda-groups '(
          (
           :discard(
             :not( :tag("work"))
           )
          )
          (
           :name "Overdue"
           :face (:underline t :foreground "red")
           :deadline past
           :tag ("now" "today")
          )
          (
           :name "Due Today"
           :deadline today
          )
        ))
      )

     )

  ("p" "personal agenda" todo ""

     (
      (org-feed-update-all)
      (org-super-agenda-date-format "%A %e %B %Y")
      (org-super-agenda-groups '(
          (
           :discard(
             :tag ("work")
           )
          )
          (
           :name "Overdue"
           :face (:underline t :foreground "red")
           :deadline past
          )
          (
           :name "Due Today"
           :deadline today
          )
          (
           :name "Household"
           :tag "household"
          )
          (
           :name "Research"
           :tag "research"
          )
          (
           :name "Trivial"
           :tag "trivial"
          )
          (
           :auto-planning t
           :order 100
          )
        ))
      )

     )

  ("c" "combined personal + work agenda" todo ""

     (
      (org-feed-update-all)
      (org-super-agenda-date-format "%A %e %B %Y")
      (org-super-agenda-groups '(
          (
           :name "Overdue"
           :face (:underline t :foreground "red")
           :deadline past
          )
          (
           :name "Due Today"
           :deadline today
          )
          (
           :name "Work"
           :tag "work"
          )
          (
           :name "Household"
           :tag "household"
          )
          (
           :name "Research"
           :tag "research"
          )
          (
           :name "Trivial"
           :tag "trivial"
          )
          (
           :auto-planning t
           :order 100
          )
        ))
      )

     )
   ))


;; Customize the agenda mode line format.
;; the default included lots of junk I don't need. Namely, the file name the TODO came from.
;; The whole point of the disagregated TODOs is that I don't care where they came from. I can always follow the link if I care.
;; What's more, using org-mode my file names are LONG and mostly garbage to parse. No bueno.
;; There is SOME value in seeing TODOs grouped by file... but not nearly enough to justify the bad UX.
(setq org-agenda-prefix-format "%t %s")


;; configure org-super-agenda
;; see the above custom commands, which overwrite this
(use-package! org-super-agenda
  :after org-agenda
  :config
  (setq org-super-agenda-groups
        '(
          (
           :name "Personal"
           :and(
             :tag "personal"
             :not(:tag "research")
             :not(:tag "household")
           )
          )
          (
           :name "Household"
           :tag "household"
          )
          (
           :name "Research"
           :tag "research"
          )
          (
           :name "Work"
           :tag "work"
          )
        )
  )
  (org-super-agenda-mode)
)

;; super-agenda messed up hjkl movement on the headers it adds.
;; there might be a "real" solution. But this workaround is okay for now.
;; see https://github.com/alphapapa/org-super-agenda/issues/50
(setq org-super-agenda-header-map (make-sparse-keymap))
