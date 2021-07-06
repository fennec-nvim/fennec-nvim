(module plugin.comment
  {autoload {nvim-comment nvim_comment
             nvim aniseed.nvim}})

(nvim-comment.setup)

(vim.api.nvim_set_keymap :n :<leader>/ ":CommentToggle<CR>"
                         {:noremap true :silent true})
(vim.api.nvim_set_keymap :v :<leader>/ ":CommentToggle<CR>"
                         {:noremap true :silent true})	
