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

;; === GDB Settings ===

;; GDB User Interface Layout
(setq gdb-many-windows t)

;; === Plugins ===

;; Basic Edit Toolkit
(use-package basic-edit-toolkit
  :ensure nil
  :load-path "~/.config/emacs/elisp")

