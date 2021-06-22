(module dotfiles.plugin.treesitter
  {autoload {nvim aniseed.nvim
             treesitter nvim-treesitter.configs}})

(treesitter.setup
  {:ensure_installed "all"
   :ignore_install ["haskell"]
   :matchup {:enable true}
   :highlight {:enable true}
   :autotag {:enable true}})
