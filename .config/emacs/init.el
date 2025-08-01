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

;; Start every frame maximized
(add-to-list 'default-frame-alist '(fullscreen . maximized))

;; Font settings
(set-face-attribute 'default nil
  :family "Fira Code Retina"
  :height 120
  :weight 'normal)

;; Disable toolbar, menubar, scrollbar
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)

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
    company
    diminish
    doom-modeline
    doom-themes
    git-gutter
    lsp-mode
    lsp-ui
    magit
    rg
    rust-mode
    tree-sitter
    which-key
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

;; Colorscheme
(use-package doom-themes
  :config
  (load-theme 'doom-one))

;; Modeline
(use-package doom-modeline
  :hook (after-init . doom-modeline-mode))

;; avy
(use-package avy
  :bind ("C-;" . avy-goto-char))

;; ==== Git ====

(use-package magit
  :bind (("C-x g" . magit-status)
         ("C-x M-g" . magit-dispatch)))

(use-package git-gutter
  :diminish git-gutter-mode
  :hook (prog-mode . git-gutter-mode)
  :config
  (setq git-gutter:update-interval 0.02))

;; ripgrep
(use-package rg
  :config
  (rg-enable-default-bindings))

;; which-key
(use-package which-key
  :diminish which-key-mode
  :hook (after-init . which-key-mode))

;; ==== LSP ====

(use-package lsp-mode
  :init
  (setq lsp-keymap-prefix "C-c l"
        lsp-enable-on-type-formatting nil
        lsp-enable-indentation t
        lsp-enable-relative-indentation t)
  :hook
  ((c-ts-mode . lsp)
   (c++-ts-mode . lsp)
   (rust-ts-mode . lsp)
   (lsp-mode . lsp-enable-which-key-integration))
  :commands lsp)

(use-package lsp-ui
  :after lsp-mode
  :hook
  (lsp-mode . lsp-ui-mode)
  :init
  (setq lsp-ui-doc-position 'at-point
        lsp-ui-doc-show-with-mouse nil
        lsp-ui-doc-show-with-cursor nil)
  :bind
  (("C-c d" . lsp-ui-doc-show)
   ("C-c i" . lsp-ui-imenu))
  :config
  ;; Create custom variable to store position
  (defvar-local my/lsp-ui-doc--last-pos nil
                      "Last position where documentation was shown.")
  ;; Update position when showing documentation
  (advice-add 'lsp-ui-doc-show :after
    (lambda (&rest _)
      (setq my/lsp-ui-doc--last-pos (point))))
  ;; Function to hide doc when cursor move
  (defun my/lsp-ui-doc-close-on-move ()
    (when (and my/lsp-ui-doc--last-pos
            (not (equal (point) my/lsp-ui-doc--last-pos))
      (lsp-ui-doc-hide)
      (setq my/lsp-ui-doc--last-pos nil))))
  ;; Add tracking hook
  (add-hook 'post-command-hook #'my/lsp-ui-doc-close-on-move))

(use-package company
  :bind
  (:map company-active-map
   ("C-n" . company-select-next)
   ("C-p" . company-select-previous)
   ("<tab>" . company-complete-common-or-cycle)
   :map company-search-map
   ("C-p" . company-select-previous)
   ("C-n" . company-select-next)))

;; ==== Treesitter ====

(setq treesit-extra-load-path '("~/.config/emacs/tree-sitter"))

(setq treesit-language-source-alist
  '((bash "https://github.com/tree-sitter/tree-sitter-bash")
    (cmake "https://github.com/uyha/tree-sitter-cmake")
    (cpp "https://github.com/tree-sitter/tree-sitter-cpp")
    (python "https://github.com/tree-sitter/tree-sitter-python")
    (rust "https://github.com/tree-sitter/tree-sitter-rust" "v0.23.3")
    (elisp "https://github.com/Wilfred/tree-sitter-elisp")
    (c "https://github.com/tree-sitter/tree-sitter-c")))

(setq major-mode-remap-alist
  '((bash-mode . bash-ts-mode)
    (c-mode . c-ts-mode)
    (cpp-mode . cpp-ts-mode)
    (rust-mode . rust-ts-mode)
    (python-mode . python-ts-mode)))

(global-tree-sitter-mode)
