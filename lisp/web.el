;; ============================================================
;; web.el - Web Development
;; ============================================================

(use-package typescript-mode
  :mode "\\.ts\\'"
  :hook ((typescript-mode . eglot-ensure)
         (typescript-mode . company-mode)
         (typescript-mode . flycheck-mode))
  :config
  (setq typescript-indent-level 2))

(use-package js2-mode
  :mode "\\.js\\'"
  :hook ((js2-mode . eglot-ensure)
         (js2-mode . flycheck-mode))
  :config
  (setq js2-basic-offset 2))

(use-package json-mode
  :mode "\\.json\\'"
  :config
  (setq js-indent-level 2))

(use-package web-mode
  :mode (("\\.html\\'" . web-mode)
         ("\\.tsx\\'" . web-mode)
         ("\\.jsx\\'" . web-mode))
  :config
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-css-indent-offset 2)
  (setq web-mode-code-indent-offset 2))

(with-eval-after-load 'eglot
  (add-to-list 'eglot-server-programs
               '(typescript-mode . ("typescript-language-server" "--stdio")))
  (add-to-list 'eglot-server-programs
               '(js2-mode . ("typescript-language-server" "--stdio"))))

(provide 'web)
