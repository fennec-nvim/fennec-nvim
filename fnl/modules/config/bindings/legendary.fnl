(import-macros {: map! : let!} :macros)
(local {: setup} (require :core.lib.setup))
(local {: autoload} (require :core.lib.autoload))
(local legendary (autoload :legendary))

;; TODO: this should be a core plugin because my map! macro depends on it
(setup :legendary)

;; TODO: figure out why I need to (let mapleader " ") when I've already done it in config.fnl
(let! mapleader " ")

(map! [n] "<leader>:" "<cmd>Legendary commands<CR>" {:desc :Commands})
