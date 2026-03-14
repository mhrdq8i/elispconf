;; lang-bash.el - Bash/Shell Development

(use-package sh-mode
  :ensure nil  ; built into Emacs
  :mode (("\\.sh\\'" . sh-mode)
         ("\\.bash\\'" . sh-mode)
         ("bashrc\\'" . sh-mode)
         ("bash_profile\\'" . sh-mode))
  :hook ((sh-mode . eglot-ensure)
         (sh-mode . company-mode)))

(with-eval-after-load 'eglot
  (add-to-list 'eglot-server-programs
               '(sh-mode . ("bash-language-server" "start"))))

(defun shell-run ()
  (interactive)
  (compile (concat "bash " (buffer-file-name))))

(defun shell-check ()
  (interactive)
  (compile (concat "shellcheck " (buffer-file-name))))

(with-eval-after-load 'sh-script
  (define-key sh-mode-map (kbd "C-c r") 'shell-run)
  (define-key sh-mode-map (kbd "C-c c") 'shell-check))

(provide 'lang-bash)

