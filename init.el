;;;;
;; Packages
;;;;

;; Define package repositories
(require 'package)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/") t)
(add-to-list 'package-archives
             '("tromey" . "http://tromey.com/elpa/") t)
(add-to-list 'package-archives
             '("melpa-stable" . "http://stable.melpa.org/packages/") t)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)

;; (setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
;;                          ("marmalade" . "http://marmalade-repo.org/packages/")
;;                          ("melpa" . "http://melpa.org/packages/")))


;; Load and activate emacs packages. Do this first so that the
;; packages are loaded before you start trying to modify them.
;; This also sets the load path.
(package-initialize)

;; Download the ELPA archive description if needed.
;; This informs Emacs about the latest versions of all packages, and
;; makes them available for download.
(when (not package-archive-contents)
  (package-refresh-contents))

;; The packages you want installed. You can also install these
;; manually with M-x package-install
;; Add in your own as you wish:
(defvar my-packages
  '(;; makes handling lisp expressions much, much easier
    ;; Cheatsheet: http://www.emacswiki.org/emacs/PareditCheatsheet
    paredit

    ;; key bindings and code colorization for Clojure
    ;; https://github.com/clojure-emacs/clojure-mode
    clojure-mode

    ;; extra syntax highlighting for clojure
    clojure-mode-extra-font-locking

    ;; integration with a Clojure REPL
    ;; https://github.com/clojure-emacs/cider
    cider

    ;; allow ido usage in as many contexts as possible. see
    ;; customizations/navigation.el line 23 for a description
    ;; of ido
    ido-completing-read+

    ;; Enhances M-x to allow easier execution of commands. Provides
    ;; a filterable list of possible commands in the minibuffer
    ;; http://www.emacswiki.org/emacs/Smex
    smex

    ;; project navigation
    projectile

    ;; colorful parenthesis matching
    rainbow-delimiters

    ;; edit html tags like sexps
    tagedit

    ;; git integration
    magit

    ;; evil, evil, evil
    evil))

;; On OS X, an Emacs instance started from the graphical user
;; interface will have a different environment than a shell in a
;; terminal window, because OS X does not run a shell during the
;; login. Obviously this will lead to unexpected results when
;; calling external utilities like make from Emacs.
;; This library works around this problem by copying important
;; environment variables from the user's shell.
;; https://github.com/purcell/exec-path-from-shell
(if (eq system-type 'darwin)
    (add-to-list 'my-packages 'exec-path-from-shell))

(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))


;; Place downloaded elisp files in ~/.emacs.d/vendor. You'll then be able
;; to load them.
;;
;; For example, if you download yaml-mode.el to ~/.emacs.d/vendor,
;; then you can add the following code to this file:
;;
;; (require 'yaml-mode)
;; (add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))
;; 
;; Adding this code will make Emacs enter yaml mode whenever you open
;; a .yml file
(add-to-list 'load-path "~/.emacs.d/vendor")


;;;;
;; Customization
;;;;

;; Modifier keys for Mac
;; (defvar use-mac-modifiers t
;;   "Use Mac modifier keys? t if yes; nil if no.")

;; (defun mac-mod-keys ()
;;     "Set modifier keys on a Mac."
    ;; (interactive)
;;     (if use-mac-modifiers
;;            (when (eq system-type 'darwin)
;;              (setq mac-control-modifier 'super)
;;              (setq mac-option-modifier 'control)
;;              (setq mac-command-modifier 'meta)
;;              (setq mac-right-option-modifier 'control)
;;              (setq mac-right-command-modifier 'meta))
;;          (when (eq system-type 'darwin)
;;            (setq mac-control-modifier 'super)
;;            (setq mac-option-modifier 'control)
;;            (setq mac-command-modifier 'meta)
;;            (setq mac-right-option-modifier 'control)
;;            (setq mac-right-command-modifier 'meta))
;;           ))

;; (mac-mod-keys)

;; "Change the modifier keys on the Mac."
(defun change-mac-mod-keys ()
  "Set modifier keys on a Mac."
  (interactive)
  (when (eq system-type 'darwin)
    (setq mac-control-modifier 'super)
    (setq mac-option-modifier 'control)
    (setq mac-command-modifier 'meta)
    (setq mac-right-option-modifier 'control)
    (setq mac-right-command-modifier 'meta)))

;; "Restore the modifier keys on the Mac."
(defun unchange-mac-mod-keys ()
  "Restore the modifier keys on the Mac."
  (interactive)
  (when (eq system-type 'darwin)
    (setq mac-control-modifier 'control)
    (setq mac-option-modifier 'meta)
    (setq mac-command-modifier 'super)
    (setq mac-right-option-modifier 'meta)
    (setq mac-right-command-modifier 'super)))

;; Add a directory to our load path so that when you `load` things
;; below, Emacs knows where to look for the corresponding file.
(add-to-list 'load-path "~/.emacs.d/customizations")

;; Sets up exec-path-from-shell so that Emacs will use the correct
;; environment variables
(load "shell-integration.el")

;; These customizations make it easier for you to navigate files,
;; switch buffers, and choose options from the minibuffer.
(load "navigation.el")

;; These customizations change the way emacs looks and disable/enable
;; some user interface elements
(load "ui.el")

;; These customizations make editing a bit nicer.
(load "editing.el")

;; Hard-to-categorize customizations
(load "misc.el")

;; For editing lisps
(load "elisp-editing.el")

;; Langauage-specific
(load "setup-clojure.el")
(load "setup-js.el")

;; Load evil-mode
(require 'evil)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(blink-cursor-mode nil)
 '(coffee-tab-width 2)
 '(package-selected-packages
   (quote
    (sequences matlab-mode cider clj-refactor typed-clojure-mode cider-decompile ac-clang evil-anzu evil-visual-mark-mode evil tagedit smex rainbow-delimiters projectile paredit markdown-mode+ magit ido-ubiquitous feature-mode exec-path-from-shell clojure-mode-extra-font-locking)))
 '(scroll-bar-mode nil)
 '(show-paren-mode t)
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "#000000" :foreground "#eaeaea" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 108 :width normal :foundry "outline" :family "Consolas")))))
