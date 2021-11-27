;;; init-javascript.el --- Support for Javascript and derivatives -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(maybe-require-package 'rjsx-mode)
(maybe-require-package 'typescript-mode)
(maybe-require-package 'web-mode)
(maybe-require-package 'tide)
(maybe-require-package 'company)
(maybe-require-package 'yasnippet)
(maybe-require-package 'import-js)
(maybe-require-package 'prettier-js)

(require 'rjsx-mode)
(require 'typescript-mode)
(require 'web-mode)
(require 'tide)
(require 'import-js)
(require 'prettier-js)

;;; Configure web-mode
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tsx\\'" . web-mode))

;;; Configure TIDE
(defun setup-tide-mode ()
  (interactive)
  (tide-setup)
  (eldoc-mode)
  (run-import-js)
  (tide-hl-identifier-mode +1)
  (setq web-mode-enable-auto-quoting nil)
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-code-indent-offset 2)
  (setq web-mode-attr-indent-offset 2)
  (setq web-mode-attr-value-indent-offset 2)
  (set (make-local-variable 'company-backends)
       '((company-tide company-files :with company-yasnippet)
         (company-dabbrev-code company-dabbrev)))
  (flycheck-mode +1)
  (setq flycheck-check-syntax-automatically '(save mode-enabled)))

;; aligns annotation to the right hand side
(setq company-tooltip-align-annotations t)

;; formats the buffer before saving
(add-hook 'before-save-hook 'tide-format-before-save)

;; use rjsx-mode for .js* files except json and use tide with rjsx
(add-to-list 'auto-mode-alist '("\\.js.*$" . rjsx-mode))
(add-to-list 'auto-mode-alist '("\\.json$" . json-mode))
(add-hook 'rjsx-mode-hook 'tide-setup-hook)

(add-hook 'typescript-mode-hook #'setup-tide-mode)

(add-hook 'web-mode-hook
          (lambda ()
            (when (string-equal "tsx" (file-name-extension buffer-file-name))
              (setup-tide-mode))))

(flycheck-add-mode 'typescript-tslint 'web-mode)
(add-hook 'web-mode-hook 'company-mode)
(add-hook 'web-mode-hook 'prettier-js-mode)
(add-hook 'typescript-mode-hook 'prettier-js-mode)

(defun pk-web-mode-hook ()
  "Customize web-mode colors."
  (set-face-attribute 'web-mode-html-tag-bracket-face nil :foreground "White")
  (set-face-attribute 'web-mode-html-tag-face nil :foreground "#7aa6da")
  (set-face-attribute 'web-mode-html-attr-name-face nil :foreground "#e7c547")
  )
(add-hook 'web-mode-hook  'pk-web-mode-hook)

(provide 'init-javascript)
;;; init-javascript.el ends here
