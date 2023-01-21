(import-macros {: map! : let!} :macros)
(local {: setup} (require :core.lib.setup))
(local {: autoload} (require :core.lib.autoload))

(local bufjump (autoload :bufjump))

(setup :bufjump)

(let! mapleader " ")

;; jump back and forth between buffers (mirror C-o/C-i for moving in the jumplist))
(map! [n] "<leader>`" bufjump.backward {:desc "Switch to last buffer"})
(map! [n] :<A-o> bufjump.backward {:desc "Switch to last buffer"})
(map! [n] :<A-i> bufjump.forward {:desc "Switch to next buffer"})
