(import-macros {: use-package!} :macros)

;; interactive lisp evaluation
(use-package! :Olical/conjure {:fennec-module tools.eval :branch :develop})
;; (use-package! :Olical/conjure {:fennec-module tools.eval
;;                                :config (fn []
;;                                          (require :modules.tools.eval.config))
;;                                :branch :develop})

;; (print "hello from eval module")
