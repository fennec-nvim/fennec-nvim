(local {: setup} (require :core.lib.setup))
(local {: autoload} (require :core.lib.autoload))

(local lisp-ft [:fennel :clojure :lisp :racket :scheme])
(setup :nvim-autopairs {:check_ts true
                        :disable_in_macro false
                        ;; :disable_filetype lisp-ft
                        :map_bs true})

(setup :matchparen {})
