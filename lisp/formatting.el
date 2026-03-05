;; ============================================================
;; formatting.el - Code Formatters & Linters
;; ============================================================

;; === Apheleia (Async Formatting) ===
;; Formats code without blocking Emacs
(use-package apheleia
  :config
  (apheleia-global-mode +1)
  
  ;; Add/override formatters
  (setf (alist-get 'rustfmt apheleia-formatters)
        '("rustfmt" "--edition" "2021" "--quiet" "--emit" "stdout"))
  
  (setf (alist-get 'prettier-markdown apheleia-formatters)
        '("prettier" "--parser" "markdown"))
  
  (setf (alist-get 'shfmt apheleia-formatters)
        '("shfmt" "-i" "4" "-ci"))
  
  ;; Associate modes with formatters
  (setf (alist-get 'rust-mode apheleia-mode-alist) 'rustfmt)
  (setf (alist-get 'python-mode apheleia-mode-alist) 'ruff)
  (setf (alist-get 'python-ts-mode apheleia-mode-alist) 'ruff)
  (setf (alist-get 'js-mode apheleia-mode-alist) 'prettier-javascript)
  (setf (alist-get 'js2-mode apheleia-mode-alist) 'prettier-javascript)
  (setf (alist-get 'typescript-mode apheleia-mode-alist) 'prettier-typescript)
  (setf (alist-get 'json-mode apheleia-mode-alist) 'prettier-json)
  (setf (alist-get 'yaml-mode apheleia-mode-alist) 'prettier-yaml)
  (setf (alist-get 'markdown-mode apheleia-mode-alist) 'prettier-markdown)
  (setf (alist-get 'gfm-mode apheleia-mode-alist) 'prettier-markdown)
  (setf (alist-get 'sh-mode apheleia-mode-alist) 'shfmt)
  (setf (alist-get 'php-mode apheleia-mode-alist) 'php-cs-fixer)
  (setf (alist-get 'c-mode apheleia-mode-alist) 'clang-format)
  (setf (alist-get 'c++-mode apheleia-mode-alist) 'clang-format)
  (setf (alist-get 'css-mode apheleia-mode-alist) 'prettier-css)
  (setf (alist-get 'html-mode apheleia-mode-alist) 'prettier-html)
  (setf (alist-get 'xml-mode apheleia-mode-alist) 'xmllint)
  (setf (alist-get 'nxml-mode apheleia-mode-alist) 'xmllint)
  (setf (alist-get 'terraform-mode apheleia-mode-alist) 'terraform))

;; === Flycheck (Linting) ===
(use-package flycheck
  :init (global-flycheck-mode)
  :config
  (setq flycheck-indication-mode 'right-fringe)
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  
  ;; Better fringe indicator
  (define-fringe-bitmap 'flycheck-fringe-bitmap-double-arrow
    [16 48 112 240 112 48 16] nil nil 'center))

;; === Flycheck inline errors ===
(use-package flycheck-inline
  :hook (flycheck-mode . flycheck-inline-mode))

;; === Markdown Linter (markdownlint) ===
;; Install: npm install -g markdownlint-cli
(flycheck-define-checker markdown-markdownlint
  "A Markdown linter using markdownlint-cli."
  :command ("markdownlint" "--config" (eval (expand-file-name "~/.markdownlint.json")) source)
  :error-patterns
  ((error line-start (file-name) ":" line " " (message) line-end)
   (error line-start (file-name) ":" line ":" column " " (message) line-end))
  :modes (markdown-mode gfm-mode))

(with-eval-after-load 'flycheck
  (add-to-list 'flycheck-checkers 'markdown-markdownlint))

;; === EditorConfig Support ===
(use-package editorconfig
  :config
  (editorconfig-mode 1))

;; === Whitespace Cleanup on Save ===
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; === Format Keybindings ===
(global-set-key (kbd "C-c f") 'apheleia-format-buffer)
(global-set-key (kbd "C-c F") 'eglot-format-buffer)

;; === Toggle Format on Save ===
(defun toggle-format-on-save ()
  "Toggle apheleia format on save."
  (interactive)
  (if apheleia-mode
      (progn
        (apheleia-mode -1)
        (message "Format on save disabled"))
    (progn
      (apheleia-mode +1)
      (message "Format on save enabled"))))

(global-set-key (kbd "C-c T f") 'toggle-format-on-save)

(provide 'formatting)
