(module dotfiles.plugin.colorizer)

(vim.schedule
  (fn []
    (local colorizer (require :colorizer))
    (colorizer.setup {"*" {:RGB true
                           :RRGGBB true
                           :RRGGBBAA true
                           :rgb_fn true
                           :hsl_fn true
                           :css true
                           :css_fn true}})))

;(module dotfiles.plugin.colorizer
;  {autoload {nvim aniseed.nvim
;             colorizer colorizer}})

;(colorizer.setup)

;(treesitter.setup
;  {:ensure_installed "all"
;   :ignore_install ["haskell"]
;   :matchup {:enable true}
;   :highlight {:enable true}
;   :autotag {:enable true}})
