;;; init-plantuml.el --- Support for working with PlantUML -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

;; Sample jar configuration
(when (maybe-require-package 'plantuml-mode)
  (setq plantuml-jar-path "/Users/lucas.mafra/plantuml/plantuml-1.2022.2.jar")
  (setq plantuml-default-exec-mode 'jar))

;;; init-plantuml.el ends here
