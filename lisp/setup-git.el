;; ============================================================
;; git.el - Git Integration
;; ============================================================

(defun git-status ()
  (interactive)
  (magit-status))

(defun git-add-all ()
  (interactive)
  (shell-command "git add .")
  (message "git add . done"))

(defun git-commit ()
  (interactive)
  (magit-commit-create))

(defun git-push ()
  (interactive)
  (magit-push-current-to-upstream nil))

(defun git-pull ()
  (interactive)
  (magit-pull-from-upstream nil))

(defun git-checkout ()
  (interactive)
  (magit-branch-checkout))

(defun git-branches ()
  (interactive)
  (shell-command "git branch -a"))

(defun git-remotes ()
  (interactive)
  (shell-command "git remote -v"))

(defun git-config ()
  (interactive)
  (magit-edit-thing))

(use-package magit
  :bind (
         ("C-x M-g" . magit-dispatch)
         ("C-c M-g" . magit-file-dispatch)
         ("C-c g b" . magit-blame)
         ("C-c g l" . magit-log-current)
         ("C-c g d" . magit-diff-buffer-file)
	)
:config
  (setq magit-bury-buffer-function 'magit-restore-window-configuration)
)

(use-package diff-hl
  :config
  (global-diff-hl-mode)
  (add-hook 'magit-post-refresh-hook 'diff-hl-magit-post-refresh)
)

(global-set-key (kbd "C-c g s") 'git-status)
(global-set-key (kbd "C-c g a") 'git-add-all)
(global-set-key (kbd "C-c g c") 'git-commit)
(global-set-key (kbd "C-c g p") 'git-push)
(global-set-key (kbd "C-c g l") 'git-pull)
(global-set-key (kbd "C-c g o") 'git-checkout)
(global-set-key (kbd "C-c g B") 'git-branches)
(global-set-key (kbd "C-c g r") 'git-remotes)
(global-set-key (kbd "C-c g C") 'git-config)

(provide 'setup-git)
