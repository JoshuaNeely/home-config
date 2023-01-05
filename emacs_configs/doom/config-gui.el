(defun is-in-terminal()
    (not (display-graphic-p)))

(defun is-in-gui()
    (display-graphic-p))

(defun gui-specific-customization())

(defun terminal-specific-customization())

(if (is-in-gui)
  (gui-specific-customization)
  (terminal-specific-customization))
