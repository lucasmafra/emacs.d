;;; init-dart.el --- Dart support
;;; Commentary:
;;; Code:

(condition-case nil
    (require 'use-package)
  (file-error
   (require 'package)
   (add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
   (package-refresh-contents)
   (package-install 'use-package)
   (require 'use-package)))

(use-package lsp-mode :ensure t)
(use-package lsp-dart
             :ensure t
             :hook (dart-mode . lsp))

;; Optional packages
(use-package projectile :ensure t) ;; project management
(use-package yasnippet
             :ensure t
             :config (yas-global-mode)) ;; snipets
(use-package lsp-ui :ensure t) ;; UI for LSP
(use-package company :ensure t) ;; Auto-complete

;; Optional Flutter packages
(use-package hover :ensure t) ;; run app from desktop without emulator

; Make sure projectile recognizes Flutter projects
(with-eval-after-load 'projectile
  (add-to-list 'projectile-project-root-files-bottom-up "pubspec.yaml")
  (add-to-list 'projectile-project-root-files-bottom-up "BUILD"))

(with-eval-after-load 'lsp-dart
  (global-set-key (kbd "C-c .") 'lsp-ui-sideline-apply-code-actions)
  (global-set-key (kbd "C-c C-d t") 'lsp-dart-run-test-at-point)
  (global-set-key (kbd "C-c C-d l") 'lsp-dart-run-last-test)
  (global-set-key (kbd "C-c C-d n") 'lsp-dart-run-test-file)
  (global-set-key (kbd "C-c C-d a") 'lsp-dart-run-all-tests))

(provide 'init-dart)
;;; init-dart.el ends here
