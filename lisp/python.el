;; ============================================================
;; python.el - Python Development
;; ============================================================

(use-package python
  :ensure nil
  :mode ("\\.py\\'" . python-mode)
  :hook ((python-mode . eglot-ensure)
         (python-mode . company-mode)
         (python-mode . flycheck-mode))
  :config
  (setq python-indent-offset 4))

(with-eval-after-load 'eglot
  (add-to-list 'eglot-server-programs
               '(python-mode . ("pyright-langserver" "--stdio"))))

(use-package pyvenv
  :config
  (pyvenv-mode 1)
  :bind (("C-c v a" . pyvenv-activate)
         ("C-c v d" . pyvenv-deactivate)
         ("C-c v w" . pyvenv-workon)))

(defun python-run ()
  (interactive)
  (compile (concat "python3 " (buffer-file-name))))

(defun python-run-tests ()
  (interactive)
  (compile "pytest -v"))

(with-eval-after-load 'python
  (define-key python-mode-map (kbd "C-c r") 'python-run)
  (define-key python-mode-map (kbd "C-c t") 'python-run-tests))

(provide 'python)
