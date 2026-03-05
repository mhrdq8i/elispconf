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
(require 'common)
(require 'formatting)    ; Code formatters & linters
(require 'git)
(require 'rust)
(require 'python)
(require 'markdown)
(require 'web)
(require 'php)
(require 'bash)
(require 'devops)
(require 'data-formats)
(require 'cpp)

;; ============================================================
;; Custom variables in separate file
;; ============================================================
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file))

(message "Emacs configuration loaded successfully!")
