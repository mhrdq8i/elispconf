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

(use-package git-gutter
  :hook (prog-mode . git-gutter-mode)
  :bind (("C-c g n" . git-gutter:next-hunk)
         ("C-c g p" . git-gutter:previous-hunk)
         ("C-c g r" . git-gutter:revert-hunk)
         ("C-c g S" . git-gutter:stage-hunk))
  :config
  (setq git-gutter:update-interval 0.5))

(use-package git-timemachine
  :bind ("C-c g t" . git-timemachine))

(use-package blamer
  :bind ("C-c g B" . blamer-mode)
  :config
  (setq blamer-idle-time 0.5)
  (setq blamer-min-offset 40))

(use-package git-modes)

(use-package forge
  :after magit)

(provide 'git)
