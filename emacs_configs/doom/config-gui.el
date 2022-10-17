(defun is-in-terminal()
    (not (display-graphic-p)))

(defun is-in-gui()
    (display-graphic-p))

(defun gui-specific-customization()
  ;;(doom/decrease-font-size 0.5)
  ;;(doom/reset-font-size)
  (set-background-color "black"))

(defun terminal-specific-customization())

(if (is-in-gui)
  (gui-specific-customization)
  (terminal-specific-customization))
