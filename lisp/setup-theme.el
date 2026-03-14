;; ============================================================
;; theme.el - Theme & Font Settings
;; ============================================================

;; === Font ===
(set-face-attribute 'default nil :family "JetBrains Mono" :height 110)

;; === Ligatures ===
(use-package ligature
  :config
  (ligature-set-ligatures 'prog-mode
                          '("==" "!=" ">=" "<=" "=>" "->" "<-" "::"
                            "&&" "||" "++" "--" "<<" ">>" ".." "..."
                            "/*" "*/" "//" "/**"))
  (global-ligature-mode t))

;; === Doom Themes ===
(use-package doom-themes)

;; === Modeline ===
(use-package doom-modeline
  :hook (after-init . doom-modeline-mode))

;; === Icons ===
(use-package nerd-icons)

;; === Theme Persistence ===
(defvar my-theme-file
  (expand-file-name "last-theme.el" user-emacs-directory)
  "File to store the last used theme.")

(defun my-save-theme ()
  "Save current theme to file."
  (when (car custom-enabled-themes)
    (with-temp-file my-theme-file
      (insert (format "(load-theme '%s t)\n"
                      (car custom-enabled-themes))))))

(defun my-load-saved-theme ()
  "Load the saved theme, or doom-one as fallback."
  (if (file-exists-p my-theme-file)
      (load my-theme-file)
    (load-theme 'doom-one t)))

(my-load-saved-theme)

;; === Dark Theme Detection ===
(defvar my-obsolete-themes '(light-blue)
  "Themes to skip.")

(defvar my-dark-themes nil
  "Cached list of dark themes.")

(defun my-dark-theme-p (theme)
  "Check if THEME is a dark theme by loading it temporarily."
  (when (not (memq theme my-obsolete-themes))
    (let ((bg (ignore-errors
                (load-theme theme t)
                (prog1 (face-background 'default)
                  (disable-theme theme)))))
      (when bg
        (let* ((rgb (color-name-to-rgb bg))
               (luminance (+ (* 0.299 (nth 0 rgb))
                             (* 0.587 (nth 1 rgb))
                             (* 0.114 (nth 2 rgb)))))
          (< luminance 0.4))))))

(defun my-available-dark-themes ()
  "Get all installed dark themes."
  (or my-dark-themes
      (setq my-dark-themes
            (sort
             (cl-remove-if-not #'my-dark-theme-p (custom-available-themes))
             (lambda (a b)
               (string< (symbol-name a) (symbol-name b)))))))

;; === Theme Switcher ===
(defun my-cycle-theme ()
  "Cycle to the next dark theme."
  (interactive)
  (let* ((themes (my-available-dark-themes))
         (current (car custom-enabled-themes))
         (pos (cl-position current themes))
         (next (if (and pos (< (1+ pos) (length themes)))
                   (nth (1+ pos) themes)
                 (car themes))))
    (mapc #'disable-theme custom-enabled-themes)
    (load-theme next t)
    (my-save-theme)
    (message "Theme: %s (%d/%d)" next
             (1+ (cl-position next themes))
             (length themes))))

(defun my-select-theme ()
  "Pick any installed theme with completion."
  (interactive)
  (let* ((themes (mapcar #'symbol-name (custom-available-themes)))
         (choice (completing-read "Theme: " themes nil t)))
    (mapc #'disable-theme custom-enabled-themes)
    (load-theme (intern choice) t)
    (my-save-theme)
    (message "Theme: %s" choice)))

(defun my-refresh-dark-themes ()
  "Rebuild the dark themes cache."
  (interactive)
  (setq my-dark-themes nil)
  (my-available-dark-themes)
  (message "Found %d dark themes" (length my-dark-themes)))

;; === Keybindings ===
(global-set-key (kbd "<f6>") 'my-cycle-theme)
(global-set-key (kbd "<f7>") 'my-select-theme)
(global-set-key (kbd "<f8>") 'my-refresh-dark-themes)

(provide 'setup-theme)

