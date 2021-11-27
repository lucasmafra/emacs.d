;;; init-dart.el --- Dart support
;;; Commentary:
;;; Code:

(setq package-selected-packages
      '(dart-mode lsp-mode lsp-dart lsp-treemacs flycheck company
                  ;; Optional packages
                  lsp-ui company hover))

(when (cl-find-if-not #'package-installed-p package-selected-packages)
  (package-refresh-contents)
  (mapc #'package-install package-selected-packages))

(add-hook 'dart-mode-hook 'lsp)

(setq gc-cons-threshold (* 100 1024 1024)
      read-process-output-max (* 1024 1024)
      company-minimum-prefix-length 1
      lsp-lens-enable t
      lsp-signature-auto-activate nil)

;; Make sure projectile recognizes Flutter projects
(with-eval-after-load 'projectile
  (add-to-list 'projectile-project-root-files-bottom-up "pubspec.yaml")
  ;;(add-to-list 'projectile-project-root-files-bottom-up "BUILD")
  )

(with-eval-after-load 'lsp-dart
  (global-set-key (kbd "C-c .") 'lsp-ui-sideline-apply-code-actions)
  (global-set-key (kbd "C-c C-d t") 'lsp-dart-run-test-at-point)
  (global-set-key (kbd "C-c C-d l") 'lsp-dart-run-last-test)
  (global-set-key (kbd "C-c C-d n") 'lsp-dart-run-test-file)
  (global-set-key (kbd "C-c C-d a") 'lsp-dart-run-all-tests))

(provide 'init-dart)
;;; init-dart.el ends here
