;; LOCAL PACKAGES -------------------------------------------------------------------------

(add-to-list 'load-path "~/.emacs.local/")

(require 'simpc-mode)
(require 'simpson-mode) ; simple meson mode
(add-to-list 'auto-mode-alist '("\\.[hc]\\(pp\\)?\\'" . simpc-mode))
(add-to-list 'auto-mode-alist '("meson\\.build\\'" . simpson-mode))

;; MELPA/ELPA --------------------------------------------------------------------

(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(unless package-archive-contents
  (package-refresh-contents))

(require 'use-package)

(setq use-package-always-ensure t)

;; Packages:
(use-package smex)
(smex-initialize)

(use-package multiple-cursors)


;; STYLING --------------------------------------------------------------------------------

(add-to-list 'custom-theme-load-path "~/.emacs.themes/")
(load-theme 'naysayer t)

;; editor bg
(set-face-attribute 'default nil
		    :background "#000000")

;; gutter bg
(set-face-attribute 'line-number nil
                    :background "#111111")

;; selection
(set-face-attribute 'region nil
                    :background "#999999"
                    :foreground "#000000")

(set-face-attribute 'default nil
                    :family "IosevkaNerdFont"
                    :height 120
                    :weight 'regular)

(setq inhibit-startup-screen t)

(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(column-number-mode 1)

(setq display-line-numbers-type 'relative)
(setq display-line-numbers-width 1)
(global-display-line-numbers-mode 1)

;; Formatting -------------------------------------------------------------------------

(defun astyle-buffer ()
  (interactive)
  (let ((saved-line-number (line-number-at-pos)))
    (shell-command-on-region
     (point-min)
     (point-max)
     "astyle --style=kr"
     nil
     t)
    (goto-line saved-line-number)))

;; QoL --------------------------------------------------------------------------------

(delete-selection-mode 1)

;; ido
(ido-mode 1)
(ido-everywhere 1)

;; dont touch this file emacs
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(load custom-file 'noerror)

;; dont litter the codebase with backups
(dolist (dir '("tmp/backups" "tmp/autosaves" "tmp/lock-files"))
  (make-directory (expand-file-name dir user-emacs-directory) t))

;; redirect backups: filename~
(setq backup-directory-alist
      `(("." . ,(expand-file-name "tmp/backups/" user-emacs-directory))))

;; redirect autosave: #filename#
(setq auto-save-file-name-transforms
      `((".*" ,(expand-file-name "tmp/autosaves/" user-emacs-directory) t)))

;; redirect lock files: .#filename
(setq lock-file-name-transforms
      `((".*" ,(expand-file-name "tmp/lock-files/" user-emacs-directory) t)))

;; from https://github.com/rexim/dotfiles/blob/master/.emacs.rc/misc-rc.el
(defun rc/duplicate-line ()
  "Duplicate current line"
  (interactive)
  (let ((column (- (point) (point-at-bol)))
        (line (let ((s (thing-at-point 'line t)))
                (if s (string-remove-suffix "\n" s) ""))))
    (move-end-of-line 1)
    (newline)
    (insert line)
    (move-beginning-of-line 1)
    (forward-char column)))

(defun insert-dash-80 ()
  "Inserts dashes til column 80"
  (interactive)
  (dotimes (_ (max 0 (- 80 (current-column))))
    (insert "-")))


;; ORGMODE CONFIG  -----------------------------------------------------------------------

(setq org-agenda-files '("~/org/"))

;; KEYBINDS ------------------------------------------------------------------------------

;; Orgmode
(global-set-key (kbd "C-c l") #'org-store-link)
(global-set-key (kbd "C-c a") #'org-agenda)
(global-set-key (kbd "C-c c") #'org-capture)

;; Formatting
(global-set-key (kbd "C-c f") #'astyle-buffer)

;; Smex
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
;; This is your old M-x.
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

;; Multiple Cursors
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C->")         'mc/mark-next-like-this)
(global-set-key (kbd "C-<")         'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<")     'mc/mark-all-like-this)
(global-set-key (kbd "C-\"")        'mc/skip-to-next-like-this)
(global-set-key (kbd "C-:")         'mc/skip-to-previous-like-this)

;; Duplicate line
(global-set-key (kbd "C-,") #'rc/duplicate-line)

;; Dash 80
(global-set-key (kbd "C-c -") #'insert-dash-80)
