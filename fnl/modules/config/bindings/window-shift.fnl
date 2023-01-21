(import-macros {: map! : let!} :macros)
(local {: setup} (require :core.lib.setup))
(local {: autoload} (require :core.lib.autoload))
(local winshift (autoload :winshift))

(setup :winshift {})

;; TODO: figure out why I need to (let mapleader " ") when I've already done it in config.fnl
(let! mapleader " ")

(map! [n] :<leader>wa :<cmd>WinShift<cr> {:desc "shift window mode"})
(map! [n] :<leader>wL "<cmd>WinShift left<cr>" {:desc "shift window left"})
(map! [n] :<leader>wJ "<cmd>WinShift down<cr>" {:desc "shift window down"})
(map! [n] :<leader>wK "<cmd>WinShift up<cr>" {:desc "shift window up"})
(map! [n] "<leader>w:" "<cmd>WinShift right<cr>" {:desc "shift window right"})
