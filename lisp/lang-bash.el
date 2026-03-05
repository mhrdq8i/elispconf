;; ============================================================
;; bash.el - Shell Scripting
;; ============================================================

(use-package sh-script
  :ensure nil
  :mode (("\\.sh\\'" . sh-mode)
         ("\\.bash\\'" . sh-mode)
         ("\\.zsh\\'" . sh-mode)
         ("bashrc\\'" . sh-mode)
         ("zshrc\\'" . sh-mode))
  :hook ((sh-mode . eglot-ensure)
         (sh-mode . company-mode)
         (sh-mode . flycheck-mode))
  :config
  (setq sh-basic-offset 4)
  (setq sh-indentation 4))

(with-eval-after-load 'eglot
  (add-to-list 'eglot-server-programs
               '(sh-mode . ("bash-language-server" "start"))))

(use-package flymake-shellcheck
  :hook (sh-mode . flymake-shellcheck-load))

(defun bash-run ()
  (interactive)
  (compile (concat "bash " (buffer-file-name))))

(defun bash-check ()
  (interactive)
  (compile (concat "shellcheck " (buffer-file-name))))

(with-eval-after-load 'sh-script
  (define-key sh-mode-map (kbd "C-c r") 'bash-run)
  (define-key sh-mode-map (kbd "C-c c") 'bash-check))

(provide 'lang-bash)
