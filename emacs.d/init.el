;; -*- coding: utf-8; lexical-binding: t; -*-

;;; Code:

;; Without this comment emacs25 adds (package-initialize) here
;; (package-initialize)

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;; Comment/uncomment this line to enable MELPA Stable if desired.  See `package-archive-priorities`
;; and `package-pinned-packages`. Most users will not need or want to do this.
;;(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)

;; install use-package if it isn't already installed
(when (not (package-installed-p 'use-package))
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))

;; don't GC during startup to save time
(unless (bound-and-true-p my-computer-has-smaller-memory-p)
  (setq gc-cons-percentage 0.6)
  (setq gc-cons-threshold most-positive-fixnum))

(defconst *is-older-emacs* (version< emacs-version "29.0.50"))

(if *is-older-emacs*
    (progn
      (defun drsl/keymap-set (keymap key definition)
        "Workaround of keymap-set in older Emacs.

This does not check the validity of key string."
        (define-key keymap (kbd key) definition))

      (defun drsl/keymap-unset (keymap key &optional remove)
        "Workaround of keymap-unset in older Emacs.

This does not check the validity of key string."
        ;; Older `define-key' only accept 3 arguments.
        (define-key keymap (kbd key) nil))

      (defun drsl/keymap-global-set (key command)
        "Workaround of keymap-global-set in older Emacs.

This does not check the validity of key string."
        (drsl/keymap-set (current-global-map) key command))

      (defun drsl/keymap-global-unset (key &optional remove)
        "Workaround of keymap-global-unset in older Emacs.

This does not check the validity of key string."
        (drsl/keymap-unset (current-global-map) key remove))

      (defalias 'keymap-set #'drsl/keymap-set)
      (defalias 'keymap-unset #'drsl/keymap-unset)
      (defalias 'keymap-global-set #'drsl/keymap-global-set)
      (defalias 'keymap-global-unset #'drsl/keymap-global-unset))
  )

;; @see https://www.reddit.com/r/emacs/comments/3kqt6e/2_easy_little_known_steps_to_speed_up_emacs_start/
;; Normally file-name-handler-alist is set to
;; (("\\`/[^/]*\\'" . tramp-completion-file-name-handler)
;; ("\\`/[^/|:][^/|]*:" . tramp-file-name-handler)
;; ("\\`/:" . file-name-non-special))
;; Which means on every .el and .elc file loaded during start up, it has to runs those regexps against the filename.
(let* ((file-name-handler-alist nil))

  (use-package evil
    :ensure t
    :custom
    evil-disable-insert-state-bindings t
    :init
    (setq evil-want-integration t) ;; This is optional since it's already set to t by default.
    (setq evil-want-keybinding nil)
    :config
    (evil-mode 1))

  (use-package evil-collection
    :after evil
    :ensure t
    :config
    (evil-collection-init))
  
  (use-package helm
    :ensure t
    :config
    (keymap-global-set "M-x" 'helm-M-x)
    (keymap-global-set "C-x r b" 'helm-filtered-bookmarks)
    (keymap-global-set "C-x C-f" 'helm-find-files)
    (keymap-global-set "C-x b" 'helm-mini))

  (use-package helm-xref
    :ensure t)
  
  (use-package exec-path-from-shell
    :ensure t
    :defer t
    ;;:config
    ;;(when (memq window-system '(mac ns x))
    ;;  (exec-path-from-shell-initialize))
    )

  (use-package gitignore-templates
    :ensure t
    :defer t
    :config
    (setq gitignore-templates-api 'github))

  (use-package reverse-im
    :ensure t
    :custom
    (reverse-im-input-methods '("russian-computer"))
    :config
    (reverse-im-mode t))

  (use-package which-key
    :ensure t
    :config
    (which-key-mode))

  (use-package raku-mode
    :ensure t
    :defer t)

  (use-package dart-mode
    :ensure t
    :defer t)

  (use-package go-mode
    :ensure t
    :defer t
    :config
    (add-to-list 'exec-path "~/go/bin"))

  (use-package rust-mode
    :ensure t
    :init
    (setq rust-mode-treesitter-derive t)
    (add-hook 'rust-mode-hook #'lsp))

  (use-package hover
    :ensure t
    :defer t
    :after dart-mode
    :bind (:map hover-minor-mode-map
		("C-M-z" . #'hover-run-or-hot-reload)
		("C-M-x" . #'hover-run-or-hot-restart)
		("C-M-p" . #'hover-take-screenshot))
    :init
    (setq hover-flutter-sdk-path (concat (getenv "HOME") "/flutter") ; remove if `flutter` is already in $PATH
          hover-command-path (concat (getenv "GOPATH") "/go/bin/hover") ; remove if `hover` is already in $PATH
          hover-hot-reload-on-save t
          hover-screenshot-path (concat (getenv "HOME") "/Pictures")
          hover-screenshot-prefix "flutter-"
          hover-observatory-uri "http://my-custom-host:50300"
          hover-clear-buffer-on-hot-restart t)
    (hover-minor-mode 1))

  (use-package flycheck
    :ensure t
    :defer t
    :config
    (add-hook 'after-init-hook #'global-flycheck-mode))

  (use-package company
    :ensure t
    :defer t
    :config
    (add-hook 'after-init-hook #'global-company-mode))

  (use-package lsp-mode
    :ensure t
    :init
    (setq lsp-keymap-prefix "C-c l")
    :hook ((go-mode . lsp)
	   (js-mode . lsp)
	   (dart-mode . lsp)
           (lsp-mode . lsp-enable-which-key-integration)
	   (c-mode . lsp)
	   (c++-mode . lsp))
    :config
    (setq lsp-go-analyses '((shadow . t)
                            (simplifycompositelit . :json-false)))
    (defun lsp-go-install-save-hooks ()
      (add-hook 'before-save-hook #'lsp-format-buffer t t)
      (add-hook 'before-save-hook #'lsp-organize-imports t t))
    (add-hook 'go-mode-hook #'lsp-go-install-save-hooks)
    (lsp-register-custom-settings
     '(("gopls.completeUnimported" t t)
       ("gopls.staticcheck" t t)))
    :commands lsp)

  (use-package lsp-ui :commands lsp-ui-mode)

  (use-package dap-mode
    :ensure t
    :defer t)

  (use-package dap-dlv-go)

  (use-package dap-js)

  (use-package dap-node)

  (use-package dap-cpptools)

  (use-package perspective
    :ensure t
    :bind
    ("C-x C-b" . persp-list-buffers)         ; or use a nicer switcher, see below
    :custom
    (persp-mode-prefix-key (kbd "C-c M-p"))  ; pick your own prefix key here
    :init
    (persp-mode))
  
  (use-package treemacs
    :ensure t
    :defer t
    :init
    (with-eval-after-load 'winum
      (define-key winum-keymap (kbd "M-0") #'treemacs-select-window))
    :config
    (progn
      (setq treemacs-collapse-dirs                   (if treemacs-python-executable 3 0)
            treemacs-deferred-git-apply-delay        0.5
            treemacs-directory-name-transformer      #'identity
            treemacs-display-in-side-window          t
            treemacs-eldoc-display                   'simple
            treemacs-file-event-delay                2000
            treemacs-file-extension-regex            treemacs-last-period-regex-value
            treemacs-file-follow-delay               0.2
            treemacs-file-name-transformer           #'identity
            treemacs-follow-after-init               t
            treemacs-expand-after-init               t
            treemacs-find-workspace-method           'find-for-file-or-pick-first
            treemacs-git-command-pipe                ""
            treemacs-goto-tag-strategy               'refetch-index
            treemacs-header-scroll-indicators        '(nil . "^^^^^^")
            treemacs-hide-dot-git-directory          t
            treemacs-indentation                     2
            treemacs-indentation-string              " "
            treemacs-is-never-other-window           nil
            treemacs-max-git-entries                 5000
            treemacs-missing-project-action          'ask
            treemacs-move-files-by-mouse-dragging    t
            treemacs-move-forward-on-expand          nil
            treemacs-no-png-images                   nil
            treemacs-no-delete-other-windows         t
            treemacs-project-follow-cleanup          nil
            treemacs-persist-file                    (expand-file-name ".cache/treemacs-persist" user-emacs-directory)
            treemacs-position                        'left
            treemacs-read-string-input               'from-child-frame
            treemacs-recenter-distance               0.1
            treemacs-recenter-after-file-follow      nil
            treemacs-recenter-after-tag-follow       nil
            treemacs-recenter-after-project-jump     'always
            treemacs-recenter-after-project-expand   'on-distance
            treemacs-litter-directories              '("/node_modules" "/.venv" "/.cask")
            treemacs-project-follow-into-home        nil
            treemacs-show-cursor                     nil
            treemacs-show-hidden-files               t
            treemacs-silent-filewatch                nil
            treemacs-silent-refresh                  nil
            treemacs-sorting                         'alphabetic-asc
            treemacs-select-when-already-in-treemacs 'move-back
            treemacs-space-between-root-nodes        t
            treemacs-tag-follow-cleanup              t
            treemacs-tag-follow-delay                1.5
            treemacs-text-scale                      nil
            treemacs-user-mode-line-format           nil
            treemacs-user-header-line-format         nil
            treemacs-wide-toggle-width               70
            treemacs-width                           35
            treemacs-width-increment                 1
            treemacs-width-is-initially-locked       t
            treemacs-workspace-switch-cleanup        nil)

      ;; The default width and height of the icons is 22 pixels. If you are
      ;; using a Hi-DPI display, uncomment this to double the icon size.
      ;;(treemacs-resize-icons 44)

      (treemacs-follow-mode t)
      (treemacs-filewatch-mode t)
      (treemacs-fringe-indicator-mode 'always)
      (when treemacs-python-executable
	(treemacs-git-commit-diff-mode t))
      
      (pcase (cons (not (null (executable-find "git")))
                   (not (null treemacs-python-executable)))
	(`(t . t)
	 (treemacs-git-mode 'deferred))
	(`(t . _)
	 (treemacs-git-mode 'simple)))
      
      (treemacs-hide-gitignored-files-mode nil))
    :bind
    (:map global-map
          ("M-0"       . treemacs-select-window)
          ("C-x t 1"   . treemacs-delete-other-windows)
          ("C-x t t"   . treemacs)
          ("C-x t d"   . treemacs-select-directory)
          ("C-x t B"   . treemacs-bookmark)
          ("C-x t C-t" . treemacs-find-file)
          ("C-x t M-t" . treemacs-find-tag)))
  
  (use-package treemacs-projectile
    :after (treemacs projectile)
    :ensure t)

  (use-package treemacs-icons-dired
    :hook (dired-mode . treemacs-icons-dired-enable-once)
    :ensure t)

  (use-package treemacs-magit
    :after (treemacs magit)
    :ensure t)

  (use-package treemacs-persp
    :after (treemacs persp-mode)
    :ensure t
    :config (treemacs-set-scope-type 'Perspectives))

  (scroll-bar-mode nil)

  (cua-mode t)
  
  (keymap-global-set "M-o" 'other-window)
  (keymap-global-set "<f7>" 'toggle-truncate-lines))

(with-eval-after-load 'projectile
  (add-to-list 'projectile-project-root-files-bottom-up "pubspec.yaml")
  (add-to-list 'projectile-project-root-files-bottom-up "BUILD"))

(setq custom-file "~/.emacs.d/custom.el")
(load custom-file t nil)
