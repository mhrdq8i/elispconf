;; ============================================================
;; Mehrdad's Emacs Configuration
;; https://github.com/mhrdq8i/elispconf
;; ============================================================

(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))

;; ============================================================
;; Package Manager Setup
;; ============================================================
(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("gnu" . "https://elpa.gnu.org/packages/")))
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

;; ============================================================
;; Load Modular Configs
;; ============================================================
(require 'setup-common)
(require 'setup-theme)
(require 'setup-font)
(require 'setup-git)
(require 'setup-vim-keys)
(require 'lang-rust)
(require 'lang-markdown)
(require 'setup-devops)

;; ============================================================
;; Custom variables in separate file
;; ============================================================
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file))

(message "Emacs configuration loaded successfully!")
