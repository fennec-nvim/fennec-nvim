(module plugin.treesitter
  {autoload {nvim aniseed.nvim
             treesitter-configs nvim-treesitter.configs}})

(treesitter-configs.setup {:highlight {:enable true}
                           :matchup {:enable true}
                           :autotag {:enable true}})

; (treesitter-configs.setup {:ensure})
; ((. (require :nvim-treesitter.configs) :setup) {:ensure_installed :all
;                                                 :ignore_install ["haskell"]
;                                                 :matchup {:enable true}
;                                                 :highlight {:enable true}
;                                                 ; TODO: might need to disable for python
;                                                 :indent {:enable {1 :javascriptreact}}
;                                                 :autotag {:enable true}})
