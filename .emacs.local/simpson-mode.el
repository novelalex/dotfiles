(defvar simpson-mode-syntax-table
  (let ((table (make-syntax-table)))
    (modify-syntax-entry ?# "<" table)
    (modify-syntax-entry ?\n ">" table)
    (modify-syntax-entry ?' "\"" table)
    table)
  "Syntax table for `simpson-mode'.")

(defconst simpson-mode-font-lock-keywords
  `((,(regexp-opt '("true" "false") 'symbols) . font-lock-keyword-face)
    ("\\_<\\([[:alnum:]_]+\\)\\_>\\s-*[(]" . (1 font-lock-function-name-face)))
  "Font-lock rules for `simpson-mode'.")

(define-derived-mode simpson-mode prog-mode "Simple Meson"
  "Simple major mode for Meson build files."
  :syntax-table simpson-mode-syntax-table
  (setq-local font-lock-defaults '(simpson-mode-font-lock-keywords))
  (setq-local comment-start "# ")
  (setq-local comment-end ""))

(provide 'simpson-mode)

