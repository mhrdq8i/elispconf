;; ============================================================
;; markdown.el - Markdown Editing
;; ============================================================

(use-package markdown-mode
  :mode (("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode)
         ("README\\.md\\'" . gfm-mode))
  :hook ((markdown-mode . flycheck-mode)
         (markdown-mode . visual-line-mode))
  :bind (:map markdown-mode-map
              ("C-c C-e" . markdown-export)
              ("C-c C-v" . markdown-preview))
  :config
  (setq markdown-fontify-code-blocks-natively t)
  (setq markdown-enable-wiki-links t)
  (setq markdown-italic-underscore t)
  (setq markdown-make-gfm-checkboxes-buttons t)
  (setq markdown-gfm-uppercase-checkbox t)
  (setq markdown-header-scaling t)
  (setq markdown-command "pandoc -f gfm -t html5"))

;; === Markdown TOC Generator ===
(use-package markdown-toc
  :after markdown-mode
  :bind (:map markdown-mode-map
              ("C-c C-t" . markdown-toc-generate-toc)))

(provide 'markdown)
