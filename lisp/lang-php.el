;; ============================================================
;; php.el - PHP Development
;; ============================================================

(use-package php-mode
  :mode "\\.php\\'"
  :hook ((php-mode . eglot-ensure)
         (php-mode . company-mode)
         (php-mode . flycheck-mode))
  :config
  (setq php-mode-coding-style 'psr2))

(with-eval-after-load 'eglot
  (add-to-list 'eglot-server-programs
               '(php-mode . ("intelephense" "--stdio"))))

(defun php-run ()
  (interactive)
  (compile (concat "php " (buffer-file-name))))

(defun php-lint ()
  (interactive)
  (compile (concat "php -l " (buffer-file-name))))

(with-eval-after-load 'php-mode
  (define-key php-mode-map (kbd "C-c r") 'php-run)
  (define-key php-mode-map (kbd "C-c l") 'php-lint))

(provide 'lang-php)
