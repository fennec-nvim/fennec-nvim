(module dotfiles.plugin.lint
  {autoload {nvim aniseed.nvim
             lint nvim-lint}})

(lint.linters_by_ft {:python [:mypy]})
