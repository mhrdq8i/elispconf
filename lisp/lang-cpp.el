;; ============================================================
;; cpp.el - C/C++, LLVM, Clang
;; ============================================================

(use-package cc-mode
  :ensure nil
  :mode (("\\.c\\'" . c-mode)
         ("\\.h\\'" . c-mode)
         ("\\.cpp\\'" . c++-mode)
         ("\\.hpp\\'" . c++-mode)
         ("\\.cc\\'" . c++-mode))
  :hook ((c-mode . eglot-ensure)
         (c++-mode . eglot-ensure)
         (c-mode . company-mode)
         (c++-mode . company-mode)
         (c-mode . flycheck-mode)
         (c++-mode . flycheck-mode))
  :config
  (setq c-default-style "linux")
  (setq c-basic-offset 4))

(with-eval-after-load 'eglot
  (add-to-list 'eglot-server-programs
               '((c-mode c++-mode) . ("clangd"
                                       "--background-index"
                                       "--clang-tidy"
                                       "--completion-style=detailed"))))

(use-package cmake-mode
  :mode (("CMakeLists\\.txt\\'" . cmake-mode)
         ("\\.cmake\\'" . cmake-mode)))

(use-package modern-cpp-font-lock
  :hook (c++-mode . modern-c++-font-lock-mode))

(defun cpp-compile ()
  (interactive)
  (compile "cmake --build build"))

(defun cpp-run ()
  (interactive)
  (compile "./build/main"))

(with-eval-after-load 'cc-mode
  (define-key c-mode-map (kbd "C-c b") 'cpp-compile)
  (define-key c++-mode-map (kbd "C-c b") 'cpp-compile)
  (define-key c-mode-map (kbd "C-c r") 'cpp-run)
  (define-key c++-mode-map (kbd "C-c r") 'cpp-run))

(provide 'lang-cpp)
