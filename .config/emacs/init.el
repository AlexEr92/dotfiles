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
    magit
    rg
    rust-mode
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

(use-package eglot
  :ensure nil
  :bind (:map eglot-mode-map
              ("<f6>" . eglot-format-buffer)
              ("C-c a" . eglot-code-action))
  :hook
  ((rust-ts-mode . eglot-ensure)
   (c-ts-mode . eglot-ensure)
   (cpp-ts-mode . eglot-ensure)
   )
  :config
  (add-to-list 'eglot-server-programs
               '(rust-ts-mode . ("rust-analyzer")))
  (add-to-list 'eglot-server-programs
               '(cpp-ts-mode . ("clangd" "--clang-tidy")))
  (add-to-list 'eglot-server-programs
               '(c-ts-mode . ("clangd" "--clang-tidy"))))

(use-package company
  :hook ((prog-mode . company-mode))
  :bind
  (:map company-active-map
   ("C-n" . company-select-next)
   ("C-p" . company-select-previous)
   ("<tab>" . company-complete-common-or-cycle)
   :map company-search-map
   ("C-p" . company-select-previous)
   ("C-n" . company-select-next))
  :config
  (setq company-idle-delay 0.1)
  (setq company-minimum-prefix-length 2))

;; ==== Treesitter ====

(use-package treesit
  :init
  (setq treesit-extra-load-path '("~/.config/emacs/tree-sitter"))
  (setq treesit-language-source-alist
    '((bash "https://github.com/tree-sitter/tree-sitter-bash")
	  (cmake "https://github.com/uyha/tree-sitter-cmake")
	  (cpp "https://github.com/tree-sitter/tree-sitter-cpp")
	  (python "https://github.com/tree-sitter/tree-sitter-python")
	  (rust "https://github.com/tree-sitter/tree-sitter-rust")
	  (elisp "https://github.com/Wilfred/tree-sitter-elisp")
	  (c "https://github.com/tree-sitter/tree-sitter-c")))
  :config
  (add-to-list 'major-mode-remap-alist '(c-mode . c-ts-mode))
  (add-to-list 'major-mode-remap-alist '(c++-mode . c++-ts-mode))
  (add-to-list 'major-mode-remap-alist '(c-or-c++-mode . c-or-c++-ts-mode))
  (add-to-list 'major-mode-remap-alist '(sh-mode . bash-ts-mode))
  (add-to-list 'major-mode-remap-alist '(rust-mode . rust-ts-mode))
  (add-to-list 'major-mode-remap-alist '(python-mode . python-ts-mode)))

