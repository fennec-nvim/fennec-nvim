(import-macros {: map! : let!} :macros)
(local {: setup} (require :core.lib.setup))
(local {: autoload} (require :core.lib.autoload))
(local smart-splits (autoload :smart-splits))

(setup :smart-splits {})

;; TODO: figure out why I need to (let mapleader " ") when I've already done it in config.fnl
(let! mapleader " ")

(map! [n] :<leader>wr smart-splits.start_resize_mode {:desc "win-resize mode"})
