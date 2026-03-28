;;; setup-keys.el --- Mehrdad's custom keybindings

;; ============================================================
;; Hydra: Vim-style navigation
;; Press C-c SPC to enter, then tap keys freely
;; Press q or any unmapped key to exit
;; ============================================================
(use-package hydra
  :config
  (defhydra hydra-navigate (:hint nil)
  "
  ──────────────────────────────────────────────────
   Char     ←/;   ↓/j   ↑/k   →/l
   Word     b ←   → w
   Line     0/^   /$
   Buffer   gg    G
   Page     u     d
   Goto     :     line-no
  ──────────────────────────────────────────────────
   [q] quit
  "
    ;; ---- char-level ----
    ("j" next-line)
    ("k" previous-line)
    ("l" forward-char)
    (";" backward-char)

    ;; ---- word-level ----
    ("w" forward-word)
    ("b" backward-word)

    ;; ---- line ----
    ("0" move-beginning-of-line)
    ("^" move-beginning-of-line)
    ("$" move-end-of-line)

    ;; ---- buffer ----
    ("g" beginning-of-buffer)
    ("G" end-of-buffer)

    ;; ---- page ----
    ("d" scroll-up-command)
    ("u" scroll-down-command)

    ;; ---- goto line ----
    (":" goto-line)

    ("q" nil :exit t)
  )
)

(global-set-key (kbd "C-c SPC") 'hydra-navigate/body)

(provide 'setup-keys)
;;; setup-keys.el ends here
