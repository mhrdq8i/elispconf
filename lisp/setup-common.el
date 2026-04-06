;; ============================================================
;; common.el - General Settings
;; ============================================================

;; === UI Settings ===
(setq inhibit-startup-message t)
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(global-display-line-numbers-mode 1)
(column-number-mode 1)
(global-hl-line-mode 1)                  ; Highlight current line

;; === Editor Behavior ===
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq make-backup-files nil)
(setq auto-save-default t)
(setq create-lockfiles nil)
(setq require-final-newline t)           ; Newline at end of file
(setq-default show-trailing-whitespace t) ; Show trailing whitespace

;; === Scrolling ===
(setq scroll-margin 3)
(setq scroll-conservatively 100)

;; === Quality of Life ===
(save-place-mode 1)
(show-paren-mode 1)
(electric-pair-mode 1)
(global-auto-revert-mode 1)
(setq ring-bell-function 'ignore)
(delete-selection-mode 1)
(setq-default fill-column 80)

;; === Encoding ===
(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)

;; === Which-Key ===
(use-package which-key
  :config
  (which-key-mode)
  (setq which-key-idle-delay 0.3))

;; === Company (completion) ===
(use-package company
  :hook (after-init . global-company-mode)
  :bind (:map company-active-map
              ("C-n" . company-select-next)
              ("C-p" . company-select-previous)
              ("<tab>" . company-complete-selection)
              ("TAB" . company-complete-selection))
  :config
  (setq company-idle-delay 0.1)
  (setq company-minimum-prefix-length 1)
  (setq company-selection-wrap-around t)
  (setq company-tooltip-align-annotations t))

;; === Eglot (LSP) ===
(use-package eglot
  :ensure nil
  :bind (:map eglot-mode-map
              ("C-c l r" . eglot-rename)
              ("C-c l f" . eglot-format)
              ("C-c l a" . eglot-code-actions)
              ("C-c l d" . eldoc-doc-buffer)))

;; === Project Management ===
(use-package projectile
  :config
  (projectile-mode +1)
  :bind-keymap
  ("C-c p" . projectile-command-map))

;; === File Tree ===
(use-package treemacs
  :bind ("C-c T" . treemacs))

;; === Minimap (code overview sidebar) ===
(use-package minimap
  :bind ("C-c m" . minimap-mode)
  :config
  (setq minimap-window-location 'right)
  (setq minimap-width-fraction 0.1)
  (setq minimap-minimum-width 15))

;; === Undo Tree (visual undo) ===
(use-package undo-tree
  :config
  (global-undo-tree-mode)
  (setq undo-tree-history-directory-alist '(("." . "~/.emacs.d/undo"))))

;; === Multiple Cursors ===
(use-package multiple-cursors
  :bind (("C-S-c C-S-c" . mc/edit-lines)
         ("C->" . mc/mark-next-like-this)
         ("C-<" . mc/mark-previous-like-this)
         ("C-c C-<" . mc/mark-all-like-this)))

;; === Expand Region ===
(use-package expand-region
  :bind ("C-=" . er/expand-region))

;; === Move Text ===
(use-package move-text
  :bind (("M-S-<up>" . move-text-up)
         ("M-S-<down>" . move-text-down)))

;; === Avy (jump to char) ===
(use-package avy
  :bind (("C-;" . avy-goto-char-2)
         ("C-'" . avy-goto-line)))

;; === Ripgrep ===
(use-package rg
  :config
  (rg-enable-default-bindings))

;; === Window Navigation ===
(windmove-default-keybindings)
(use-package ace-window
  :bind ("M-o" . ace-window))

;; === Terminal ===
(use-package vterm
  :bind ("C-c v" . vterm))

;; === Global Keybindings ===
(global-set-key (kbd "<f5>") 'compile)
(global-set-key (kbd "C-x C-b") 'ibuffer)
(global-set-key (kbd "C-c w") 'whitespace-cleanup)

;; === Duplicate Line ===
(defun duplicate-line ()
  "Duplicate current line without touching kill ring."
  (interactive)
  (let ((line (buffer-substring
               (line-beginning-position)
               (line-end-position))))
    (end-of-line)
    (newline)
    (insert line)))
(global-set-key (kbd "C-c d") 'duplicate-line)

;; === Delete Line ===
(global-set-key (kbd "C-c k") 'kill-whole-line)

;; === Comment Line ===
(global-set-key (kbd "C-c /") 'comment-line)

(provide 'setup-common)

