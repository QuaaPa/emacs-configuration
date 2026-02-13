;;; init.el --- Emacs Configuration -*- lexical-binding: t -*-

;;; Commentary:
;; Personal Emacs configuration with LSP, completion, and navigation enhancements

;;; Code:

;; ============================================================================
;; Package Management
;; ============================================================================

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;; Uncomment for MELPA Stable if desired:
;; (add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)

;; ============================================================================
;; Window & Display Configuration
;; ============================================================================

(add-to-list 'display-buffer-alist
             '("\\*compilation\\*"
               (display-buffer-pop-up-frame)))

;; Scrolling behavior
(setq redisplay-dont-pause t
      scroll-margin 5
      scroll-step 1
      scroll-conservatively 10000
      scroll-preserve-screen-position 1)

;; ============================================================================
;; LSP Configuration
;; ============================================================================

(use-package lsp-mode
  :ensure t
  :hook (c++-mode . lsp))

(use-package lsp-ui
  :ensure t
  :after lsp-mode
  :custom
  (lsp-ui-doc-show-with-cursor t))

;; ============================================================================
;; Completion Framework
;; ============================================================================

(use-package company
  :ensure t
  :init (global-company-mode)
  :bind (:map company-active-map
              ("<tab>" . company-select-next)
              ("<backtab>" . company-select-previous))
  :custom
  (company-minimum-prefix-length 1)
  (company-idle-delay 0.01))

(use-package flycheck
  :ensure t
  :init (global-flycheck-mode))

;; ============================================================================
;; Navigation & Search (Consult + Vertico)
;; ============================================================================

(use-package consult
  :ensure t
  :bind (;; C-c bindings
         ("C-c h" . consult-history)
         ("C-c k" . consult-kmacro)
         ("C-c m" . consult-man)
         ("C-c i" . consult-info)
         ([remap Info-search] . consult-info)
         
         ;; C-x bindings
         ("C-x M-:" . consult-complex-command)
         ("C-x b" . consult-buffer)
         ("C-x 4 b" . consult-buffer-other-window)
         ("C-x 5 b" . consult-buffer-other-frame)
         ("C-x t b" . consult-buffer-other-tab)
         ("C-x r b" . consult-bookmark)
         ("C-x p b" . consult-project-buffer)
         
         ;; Register bindings
         ("M-#" . consult-register-load)
         ("M-'" . consult-register-store)
         ("C-M-#" . consult-register)
         ("C-c M-x" . consult-mode-command)
         
         ;; Other custom bindings
         ("M-y" . consult-yank-pop)
         
         ;; M-g bindings (goto-map)
         ("M-g e" . consult-compile-error)
         ("M-g f" . consult-flymake)
         ("M-g g" . consult-goto-line)
         ("M-g M-g" . consult-goto-line)
         ("M-g o" . consult-outline)
         ("M-g m" . consult-mark)
         ("M-g k" . consult-global-mark)
         ("M-g i" . consult-imenu)
         ("M-g I" . consult-imenu-multi)
         
         ;; M-s bindings (search-map)
         ("M-s d" . consult-find)
         ("M-s c" . consult-locate)
         ("M-s g" . consult-grep)
         ("M-s G" . consult-git-grep)
         ("M-s r" . consult-ripgrep)
         ("M-s l" . consult-line)
         ("M-s L" . consult-line-multi)
         ("M-s k" . consult-keep-lines)
         ("M-s u" . consult-focus-lines)
         ("M-s e" . consult-isearch-history)
         
         ;; Isearch integration
         :map isearch-mode-map
         ("M-e" . consult-isearch-history)
         ("M-s e" . consult-isearch-history)
         ("M-s l" . consult-line)
         ("M-s L" . consult-line-multi)
         
         ;; Minibuffer history
         :map minibuffer-local-map
         ("M-s" . consult-history)
         ("M-r" . consult-history))
  
  :hook (completion-list-mode . consult-preview-at-point-mode)
  
  :init
  ;; Register preview configuration
  (advice-add #'register-preview :override #'consult-register-window)
  (setq register-preview-delay 0.5)
  
  ;; Xref integration
  (setq xref-show-xrefs-function #'consult-xref
        xref-show-definitions-function #'consult-xref)
  
  :config
  ;; Preview customization
  (consult-customize
   consult-theme :preview-key '(:debounce 0.2 any)
   consult-ripgrep consult-git-grep consult-grep consult-man
   consult-bookmark consult-recent-file consult-xref
   consult--source-bookmark consult--source-file-register
   consult--source-recent-file consult--source-project-recent-file
   :preview-key '(:debounce 0.4 any))
  
  ;; Narrowing configuration
  (setq consult-narrow-key "<"))

(use-package vertico
  :ensure t
  :init
  (vertico-mode))

(use-package savehist
  :ensure t
  :init
  (savehist-mode))

(use-package orderless
  :ensure t
  :custom
  (completion-styles '(orderless basic))
  (completion-category-defaults nil)
  (completion-category-overrides '((file (styles partial-completion)))))

;; ============================================================================
;; Minibuffer Configuration
;; ============================================================================

(use-package emacs
  :ensure t
  :custom
  (context-menu-mode t)
  (enable-recursive-minibuffers t)
  (read-extended-command-predicate #'command-completion-default-include-p)
  (minibuffer-prompt-properties
   '(read-only t cursor-intangible t face minibuffer-prompt)))

;; ============================================================================
;; Editing Configuration
;; ============================================================================

;; C/C++ indentation
(add-hook 'c-mode-common-hook
          (lambda ()
            (setq c-basic-offset 4
                  tab-width 4
                  indent-tabs-mode nil)))

;; Move text bindings
(move-text-default-bindings)

;; ============================================================================
;; Custom Key Bindings
;; ============================================================================

(global-set-key (kbd "C-x C-g") 'recentf-open-files)

;; ============================================================================
;; Process & Buffer Management
;; ============================================================================

(setq kill-buffer-query-functions
      (remq 'process-kill-buffer-query-function
            kill-buffer-query-functions))

;; ============================================================================
;; Custom Variables (auto-generated)
;; ============================================================================

(custom-set-variables
 '(compilation-always-kill t)
 '(custom-enabled-themes '(atom-one-dark))
 '(custom-safe-themes
   '("a5c590aeb7dc5c2b8d36601a4c94a1145e46bd2291571af02807dd7a8552630c"
     "75eef60308d7328ed14fa27002e85de255c2342e73275173a14ed3aa1643d545"
     default))
 '(electric-pair-mode t)
 '(global-display-line-numbers-mode t)
 '(lsp-clients-clangd-args '("--header-insertion-decorators=0"))
 '(make-backup-files nil)
 '(menu-bar-mode nil)
 '(package-selected-packages
   '(atom-one-dark-theme cmake-mode company consult flycheck lsp-ui magit
                         move-text orderless use-package vertico))
 '(recentf-mode t)
 '(scroll-bar-mode nil)
 '(tab-bar-mode t)
 '(tool-bar-mode nil))

(custom-set-faces)

;;; init.el ends here
