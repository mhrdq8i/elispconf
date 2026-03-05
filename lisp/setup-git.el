;; ============================================================
;; git.el - Git Integration
;; ============================================================

(use-package magit
  :bind (("C-x g" . magit-status)
         ("C-x M-g" . magit-dispatch)
         ("C-c M-g" . magit-file-dispatch)
         ("C-c g s" . magit-status)
         ("C-c g b" . magit-blame)
         ("C-c g l" . magit-log-current)
         ("C-c g d" . magit-diff-buffer-file)))

(provide 'setup-git)
