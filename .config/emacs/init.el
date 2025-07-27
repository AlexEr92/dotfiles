;; === Common Emacs settings ===

;; User name and user email
(setq user-full-name "Alexander Eremenchuk")
(setq user-mail-address "alexer92@yandex.ru")

;; Setting up customization file
(setq custom-file "~/.config/emacs/custom.el")
(load custom-file 'noerror)

;; Quiet Startup
(setq inhibit-startup-screen t)

;; Disable autosave and backup files
(setq make-backup-files nil)
(setq auto-save-default nil)
(setq create-lockfiles nil)

;; Default coding system
(set-language-environment "UTF-8")
(prefer-coding-system       'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)

;; Highlight brackets
(show-paren-mode t)

;; === MELPA Package Support ===

;; Enables basic packaging support
(require 'package)

;; Adds the Melpa archive to the list of available repositories
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)

;; Initializes the package infrastructure
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

;; Packages to install via package-install-selected-packages
(setq package-selected-packages
  '(avy
    magit
    )
  )

(package-install-selected-packages t)

;; === GDB Settings ===

;; GDB User Interface Layout
(setq gdb-many-windows t)

;; === Plugins ===

;; Basic Edit Toolkit
(use-package basic-edit-toolkit
  :ensure nil
  :load-path "~/.config/emacs/elisp")

;; avy
(use-package avy
  :bind ("C-;" . avy-goto-char))

;; magit
(use-package magit
  :bind (("C-x g" . magit-status)
         ("C-x M-g" . magit-dispatch)))
