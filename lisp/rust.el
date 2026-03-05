;; ============================================================
;; rust.el - Rust Development
;; ============================================================

(use-package rust-mode
  :mode "\\.rs\\'"
  :hook ((rust-mode . eglot-ensure)
         (rust-mode . company-mode)
         (rust-mode . flycheck-mode))
  :config
  (setq rust-format-on-save nil))  ; Using apheleia instead

(with-eval-after-load 'eglot
  (add-to-list 'eglot-server-programs
               '(rust-mode . ("rust-analyzer"))))

(use-package toml-mode
  :mode "\\.toml\\'")

;; === Cargo Commands ===
(defun cargo-run ()
  (interactive)
  (compile "cargo run"))

(defun cargo-build ()
  (interactive)
  (compile "cargo build"))

(defun cargo-check ()
  (interactive)
  (compile "cargo check"))

(defun cargo-test ()
  (interactive)
  (compile "cargo test"))

(defun cargo-clippy ()
  (interactive)
  (compile "cargo clippy"))

(defun cargo-fmt ()
  (interactive)
  (shell-command "cargo fmt"))

(with-eval-after-load 'rust-mode
  (define-key rust-mode-map (kbd "C-c r") 'cargo-run)
  (define-key rust-mode-map (kbd "C-c b") 'cargo-build)
  (define-key rust-mode-map (kbd "C-c c") 'cargo-check)
  (define-key rust-mode-map (kbd "C-c t") 'cargo-test)
  (define-key rust-mode-map (kbd "C-c l") 'cargo-clippy)
  (define-key rust-mode-map (kbd "C-c C-f") 'cargo-fmt))

(provide 'rust)
