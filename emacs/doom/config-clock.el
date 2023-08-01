;;; config-clock.el -*- lexical-binding: t; -*-

(setq org-clock-clocked-in-display 'mode-line)
(setq org-clock-idle-time nil)

;; continuous clocking is nice; you clock in from the last-clocked-out... useful during the day
;; I want to combine with auto-clocking out for idleness... then when you return from lunch or whatever, you say what you've been doing all that time.
;; HOWEVER, it meshes badly with with the first clock-in of the day. That will resume the previous day's clock out. Undesirable.
;; To combat all this, I DO NOT enable continuous clocking... but instead leverage clock-in parameter to acheive the same thing.
;; Now I control when I use the default behaviour or from-last-clocked-out-time behaviour
(setq org-clock-continuously nil)
(defun org-clock-in-from-last-clock-out()
  "Clock in to a task from the last clocked-out time of ANY task. Contrast with org-clock-in-last, which clocks that same task back-in."
  (interactive)
  (org-clock-in nil org-clock-out-time)
  )

;; SECONDS until a clocked in task auto clocks out
;; mutually exclusive with org-clock-idle-time and asking the user for resolution
(setq org-clock-auto-clockout-timer (* 20 60))
;; this command sets up a hook to the org-clock-in command to auto clock out after a number of seconds
(org-clock-auto-clockout-insinuate)

;; print the current idle time as a display in the modeline.
;; replaces the clock-resolve workflow, which didn't seem to accept input properly.
;; Now I can manually account for time when useful and ignore it the rest of the time.
(defun idle-full-seconds () (nth 1 (current-idle-time)))
(defun idle-full-minutes () (/ (idle-full-seconds) 60))
(defun idle-display-seconds () (% (idle-full-seconds) 60))
(defun idle-display-minutes () (% (idle-full-minutes) 60))
(defun idle-display-hours () (/ (idle-full-minutes) 60))
(defun modeline-idle-time() (message (format "Idle for %d hours %d minutes" (idle-display-hours) (idle-display-minutes))))

;; (defun recursively-update-idle-time-display ()
;;     (modeline-idle-time)
;;     (if (< (idle-full-seconds) 60)
;;       ()
;;       (run-with-timer 60 nil (lambda () (recursively-update-idle-time-display)))
;;     )
;;   )

;; (run-with-idle-timer 60 t (lambda () (recursively-update-idle-time-display)))


(setq org-clock-persist t)
(setq org-clock-in-resume t)
(setq org-clock-persist-query-resume nil)
(setq org-clock-report-include-clocking-task t)
(setq org-agenda-clockreport-parameter-plist
        '(:maxlevel 6 :link t :stepskip0 t :fileskip0 t :hidefiles t :compact t :narrow 60 :score 0))
