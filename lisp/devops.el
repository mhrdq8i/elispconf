;; ============================================================
;; devops.el - Docker, Kubernetes, Ansible
;; ============================================================

(use-package dockerfile-mode
  :mode "Dockerfile\\'")

(use-package docker
  :bind ("C-c D" . docker))

(use-package docker-compose-mode
  :mode "docker-compose.*\\.yml\\'")

(use-package kubernetes
  :commands (kubernetes-overview)
  :bind ("C-c K" . kubernetes-overview))

(use-package k8s-mode
  :mode "\\.k8s\\'")

(use-package ansible
  :hook (yaml-mode . ansible))

(use-package ansible-doc
  :after ansible)

(use-package terraform-mode
  :mode "\\.tf\\'"
  :hook (terraform-mode . eglot-ensure)
  :config
  (setq terraform-indent-level 2))

(with-eval-after-load 'eglot
  (add-to-list 'eglot-server-programs
               '(terraform-mode . ("terraform-ls" "serve"))))

(provide 'devops)
