;; ============================================================
;; data-formats.el - YAML, XML, TOML
;; ============================================================

(use-package yaml-mode
  :mode (("\\.yml\\'" . yaml-mode)
         ("\\.yaml\\'" . yaml-mode))
  :hook ((yaml-mode . eglot-ensure)
         (yaml-mode . company-mode)
         (yaml-mode . flycheck-mode))
  :config
  (setq yaml-indent-offset 2))

(with-eval-after-load 'eglot
  (add-to-list 'eglot-server-programs
               '(yaml-mode . ("yaml-language-server" "--stdio"))))

(use-package nxml-mode
  :ensure nil
  :mode (("\\.xml\\'" . nxml-mode)
         ("\\.xsd\\'" . nxml-mode)
         ("\\.xslt\\'" . nxml-mode)
         ("\\.svg\\'" . nxml-mode)
         ("\\.pom\\'" . nxml-mode))
  :config
  (setq nxml-child-indent 2)
  (setq nxml-attribute-indent 2)
  (setq nxml-slash-auto-complete-flag t))

(use-package toml-mode
  :mode "\\.toml\\'")

(use-package csv-mode
  :mode "\\.csv\\'")

(use-package protobuf-mode
  :mode "\\.proto\\'")

(provide 'data-formats)
