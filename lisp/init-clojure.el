;;; init-clojure.el --- Clojure support -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

;; See also init-clojure-cider.el
(require-package 'clj-refactor)

(defun clojure-refactor-setup ()
  (clj-refactor-mode 1)
  (yas-minor-mode 1) ;; for adding require/use/import statements
  ;; This choice of keybinding leaves cider-macroexpand-1 unbound
  (cljr-add-keybindings-with-prefix "C-c C-m"))

(when (maybe-require-package 'clojure-mode)
  (require-package 'cljsbuild-mode)
  (require-package 'elein)

  (with-eval-after-load 'clojure-mode
    (add-hook 'clojure-mode-hook 'sanityinc/lisp-setup)
    (add-hook 'clojure-mode-hook 'subword-mode)
    (add-hook 'clojure-mode-hook 'enable-paredit-mode)))

(add-hook 'clojure-mode-hook #'clojure-refactor-setup)

(provide 'init-clojure)
;;; init-clojure.el ends here
