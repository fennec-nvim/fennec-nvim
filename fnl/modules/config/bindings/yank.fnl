(import-macros {: set! : augroup! : autocmd! : clear! : map! : let!} :macros)
(local {: setup} (require :core.lib.setup))

;; TODO: figure out why I need to (let mapleader " ") when I've already done it in config.fnl
(let! mapleader " ")
; ╭──────────────────────────────────────────────────────────╮
; │                          yanky                           │
; ╰──────────────────────────────────────────────────────────╯
(setup :yanky {:highlight {:timer 150}})

(map! [nx] :y "<Plug>(YankyYank)" {:desc :yank})
(map! [nx] :p "<Plug>(YankyPutAfter)" {:desc "Put after"})
(map! [nx] :P "<Plug>(YankyPutBefore)" {:desc "Put before"})
(map! [nx] :gp "<Plug>(YankyGPutAfter)" {:desc "gput after"})
(map! [nx] :gP "<Plug>(YankyGPutBefore)" {:desc "gput before"})
(map! [n] :<A-n> "<Plug>(YankyCycleForward)" {:desc "Cycle kill ring forward"})
(map! [n] :<A-p> "<Plug>(YankyCycleBackward)"
      {:desc "Cycle kill ring backward"})

(map! [n] :<leader>P "<cmd>Telescope yank_history<cr>" {:desc "Kill ring"})
