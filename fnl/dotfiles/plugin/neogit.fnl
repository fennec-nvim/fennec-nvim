(module dotfiles.plugin.neogit
  {autoload {nvim aniseed.nvim
             neogit neogit}})

; can't seem to stage selections with neogit, possible bug or am I doing it wrong?
(neogit.setup {:mappings {:status {:s "Stage"}}})
