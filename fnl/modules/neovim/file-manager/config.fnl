(import-macros {: map! : let!} :macros)
(local {: setup} (require :core.lib.setup))

(setup :fm-nvim {})

;; TODO: figure out why I need to (let mapleader " ") when I've already done it in config.fnl
(let! mapleader " ")

(map! [n] :<leader>fl "<cmd>Lf %<cr>" {:desc "file manager"})
