(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(column-number-mode 1)

(delete-selection-mode 1)

(setq display-line-numbers-type 'relative)
(setq display-line-numbers-width 1)
(global-display-line-numbers-mode 1)

(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")

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

