;; this file should be imported by config.el
;; just a nice way to split off some related config that is likely to grow independant of the main config


;; check out the custom agenda functions in ./functions/agenda.el


(let* (
       (one-day-seconds (time-add nil (* 3600 24)))
       (one-day-seconds (time-add nil (* 3600 24)))
       (three-day-seconds (time-add nil (* 3600 24 3)))
       (seven-day-seconds (time-add nil (* 3600 24 7)))

       (one-day-date-string (format-time-string "%Y-%m-%d" one-day-seconds))
       (three-day-date-string (format-time-string "%Y-%m-%d" three-day-seconds))
       (seven-day-date-string (format-time-string "%Y-%m-%d" seven-day-seconds))

      (due-one-day `(:name "Daily Forecast" :deadline (before ,one-day-date-string)))
      (due-three-days `(:name "Three Day Forecast" :deadline (before ,three-day-date-string)))
      (due-seven-days`(:name "Seven Day Forecast" :deadline (before ,seven-day-date-string)))

      (overdue '(
                 :name "Overdue"
                 :face (:underline t :foreground "red")
                 :deadline past
                 ))

      (discard-not-work '(
                          :discard( :not( :tag("work") ) )
                          ))

      (discard-work '(
                      :discard( :tag "work" )
                      ))

      (discard-all '(
                      :discard( :anything t)
                      ))

      (work-priority-a '(
                         :name "Work P1"
                         :and (:tag "work" :priority "A")
                         ))

      (work-priority-b '(
                         :name "Work P2"
                         :and (:tag "work" :priority "B")
                         ))

      (work-priority-c '(
                         :name "Work P3"
                         :and (:tag "work" :priority "C")
                         ))

      (work '(
              :name "Work"
              :tag("work")
              ))

      (reading '(
                 :name "Reading"
                 :tag("reading")
                 :order 99
                 ))

      (household '(
                   :name "Household"
                   :tag "household"
                   ))

      (research '(
                  :name "Research"
                  :tag "research"
                  :order 98
                  ))

      (date-associated '(
                     :auto-planning t
                     :order 100
                     ))

      (by-header '(:auto-parent t))

      (by-tag '(:auto-tags t))


      (work-groups `(
                     ,discard-not-work
                     ,overdue
                     ,due-one-day
                     ,due-three-days
                     ,due-seven-days
                     ;;,work-priority-a
                     ;;,work-priority-b
                     ;;,work-priority-c
                     ,by-tag
                     ,work
                     ))
      (personal-groups `(
                         ,discard-work
                         ,overdue
                         ,due-one-day
                         ,due-three-days
                         ,due-seven-days
                         ,household
                         ,reading
                         ,research
                         ,date-associated
                         ,by-tag
                         ))
      (combined-groups `(
                         ,overdue
                         ,due-one-day
                         ,due-three-days
                         ,due-seven-days
                         ,work
                         ,household
                         ,by-tag
                         ,research
                         ,reading
                         ,date-associated
                         ))
      (briefing-groups `(
                         ,overdue
                         ,due-one-day
                         ,due-three-days
                         ,due-seven-days
                         ,discard-all
                         ))
      )

  ;; make the local variables global, so later when agenda reads them, they have the latest
  (setq p-groups personal-groups)
  (setq w-groups work-groups)
  (setq c-groups combined-groups)
  (setq b-groups briefing-groups)

  ;; default value for normal-agenda. if you don't use the functions
  (setq org-super-agenda-groups c-groups)

  (defun work-agenda ()
    "Configure work super-agenda groups, and open the \"todo\" agenda"
    (interactive)
    (let ((org-super-agenda-groups w-groups))
      (org-agenda nil "t")))

  (defun personal-agenda ()
    "Configure personal super-agenda groups, and open the \"todo\" agenda"
    (interactive)
    (let ((org-super-agenda-groups p-groups))
      (org-agenda nil "t")))

  (defun combined-agenda ()
    "Configure combined super-agenda groups, and open the \"todo\" agenda"
    (interactive)
    (let ((org-super-agenda-groups c-groups))
      (org-agenda nil "t")))

  (defun briefing-agenda ()
    "Configure daily briefing super-agenda groups, and open the \"todo\" agenda"
    (interactive)
    (let ((org-super-agenda-groups b-groups))
      (org-agenda nil "t")))
)

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
  (org-super-agenda-mode)
)

;; super-agenda messed up hjkl movement on the headers it adds.
;; there might be a "real" solution. But this workaround is okay for now.
;; see https://github.com/alphapapa/org-super-agenda/issues/50
(setq org-super-agenda-header-map (make-sparse-keymap))
