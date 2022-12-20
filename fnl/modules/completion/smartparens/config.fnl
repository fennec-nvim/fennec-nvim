(local {: setup} (require :core.lib.setup))

(local lisp-ft [:fennel :clojure :lisp :racket :scheme])
(setup :nvim-autopairs {:check_ts true
                        :disable_in_macro false
                        :map_bs true
                        :disable_filetype lisp-ft})
(setup :matchparen {})
