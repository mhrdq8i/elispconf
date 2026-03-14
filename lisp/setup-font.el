;; ============================================================
;; font.el - Font Settings & Switcher
;; ============================================================

;; === Font List (add/remove fonts you have installed) ===
(defvar my-fonts
  '(;; Nerd Font variants (with icons)
    "JetBrainsMono Nerd Font"
    "FiraCode Nerd Font"
    "Iosevka Nerd Font"
    "CascadiaCode Nerd Font"
    "VictorMono Nerd Font"
    "SauceCodePro Nerd Font"
    "Inconsolata Nerd Font"
    "UbuntuMono Nerd Font"
    ;; Standard variants (without icons)
    "JetBrains Mono"
    "Fira Code"
    "Source Code Pro"
    "Cascadia Code"
    "Hack"
    "Iosevka"
    "Ubuntu Mono"
    "Inconsolata"
    "Victor Mono"
    "IBM Plex Mono")
  "List of preferred programming fonts.")

(defvar my-font-size 120
  "Font size in 1/10 pt units (120 = 12pt).")

;; === Font Persistence ===
(defvar my-font-file
  (expand-file-name "last-font.el" user-emacs-directory)
  "File to store the last used font.")

(defun my-save-font ()
  "Save current font to file."
  (let ((font (face-attribute 'default :family)))
    (with-temp-file my-font-file
      (insert (format "(set-face-attribute 'default nil :family \"%s\" :height %d)\n"
                      font my-font-size)))))

(defun my-load-saved-font ()
  "Load the saved font, or JetBrains Mono as fallback."
  (if (file-exists-p my-font-file)
      (load my-font-file)
    (set-face-attribute 'default nil :family "JetBrains Mono" :height my-font-size)))

(my-load-saved-font)

;; === Filter to only installed fonts ===
(defun my-available-fonts ()
  "Return fonts from my-fonts that are installed on the system."
  (cl-remove-if-not
   (lambda (font)
     (find-font (font-spec :family font)))
   my-fonts))

;; === Font Switcher ===
(defun my-cycle-font ()
  "Cycle to the next font in the list."
  (interactive)
  (let* ((fonts (my-available-fonts))
         (current (face-attribute 'default :family))
         (pos (cl-position current fonts :test #'string=))
         (next (if (and pos (< (1+ pos) (length fonts)))
                   (nth (1+ pos) fonts)
                 (car fonts))))
    (set-face-attribute 'default nil :family next :height my-font-size)
    (my-save-font)
    (message "Font: %s (%d/%d)" next
             (1+ (cl-position next fonts :test #'string=))
             (length fonts))))

(defun my-select-font ()
  "Pick a font from the list with completion."
  (interactive)
  (let* ((fonts (my-available-fonts))
         (choice (completing-read "Font: " fonts nil t)))
    (set-face-attribute 'default nil :family choice :height my-font-size)
    (my-save-font)
    (message "Font: %s" choice)))

(defun my-increase-font-size ()
  "Increase font size by 10 (1pt)."
  (interactive)
  (setq my-font-size (+ my-font-size 10))
  (set-face-attribute 'default nil :height my-font-size)
  (my-save-font)
  (message "Font size: %spt" (/ my-font-size 10)))

(defun my-decrease-font-size ()
  "Decrease font size by 10 (1pt)."
  (interactive)
  (setq my-font-size (max 80 (- my-font-size 10)))
  (set-face-attribute 'default nil :height my-font-size)
  (my-save-font)
  (message "Font size: %spt" (/ my-font-size 10)))

;; === Keybindings ===
(global-set-key (kbd "<f9>")  'my-cycle-font)
(global-set-key (kbd "<f10>") 'my-select-font)
(global-set-key (kbd "C-+")  'my-increase-font-size)
(global-set-key (kbd "C--")  'my-decrease-font-size)

(provide 'setup-font)

