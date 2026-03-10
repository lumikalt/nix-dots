;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "lumi"
      user-mail-address "lumi.mia.kalt@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))

(setq doom-font (font-spec :family "JetBrainsMono Nerd Font" :size 16))

;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-vibrant-brighter-comments t
      doom-theme 'doom-vibrant)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)

;; Auto-save
;; oh the misery
(setq auto-save-visited-interval 15)
(auto-save-visited-mode +1)

;; org-mode configs

(setq org-directory "~/org/")

;; this has some weird effect on everything and lumi does not like it
;; (add-hook! org-mode :append #'variable-pitch-mode)



;; LaTeX

;; (after! org
;;   (setq org-preview-latex-process-alist
;;         '((dvipng :programs ("latex" "dvipng")
;;            :description "dvi > png"
;;            :message "you need to install the programs: latex and dvipng."
;;            :image-input-type "dvi"
;;            :image-output-type "png"
;;            :image-size-adjust (1.0 . 1.0)
;;            :latex-compiler ("latex -interaction nonstopmode -output-directory %o %F")
;;            :image-converter ("dvipng -D %D -T tight -o %O %F")))))

(use-package! org-fragtog
  :after org
  :hook (org-mode . org-fragtog-mode))

;; ox-hugo export

(after! org
  (setq time-stamp-active t
        time-stamp-start "#\\+hugo_lastmod:[ \t]*"
        time-stamp-end "$"
        time-stamp-format "\[%Y-%m-%d\]")
  (add-hook 'before-save-hook 'time-stamp))

;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

(setq shell-file-name (executable-find "bash"))
(setq-default explicit-shell-file-name "/bin/fish")

(use-package! websocket
  :after org-roam)

(use-package! org-roam-ui
  :after org-roam
  :config
  (setq org-roam-ui-sync-theme t
        org-roam-ui-follow t
        org-roam-ui-update-on-save t
        org-roam-ui-open-on-start t))

(after! org-roam
  ;; Only sync when an org-roam file is saved (much faster than global hooks)
  (defun lumi/org-roam-sync-on-save ()
    (when (and (boundp 'org-roam-directory)
               (string-prefix-p
                (expand-file-name org-roam-directory)
                (file-name-directory (or buffer-file-name ""))))
      (org-roam-db-sync)))

  (add-hook 'after-save-hook #'lumi/org-roam-sync-on-save))

(setq ispell-program-name "aspell"
      ispell-dictionary "en_US")

(after! lsp-mode
  (setq lsp-ltex-language "en-US"
        lsp-ltex-enabled-grammars '("org" "latex" "markdown")
        lsp-ltex-dictionary
        (make-hash-table :test 'equal)))
