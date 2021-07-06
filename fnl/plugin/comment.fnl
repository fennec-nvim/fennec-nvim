(module plugin.comment
  {autoload {nvim-comment nvim_comment
             nvim aniseed.nvim
             wk which-key}})

(nvim-comment.setup)

; (nvim.set_keymap :n :<leader>/ ":CommentToggle<CR>"
;                          {:noremap true :silent true})
; (nvim.set_keymap :x :<leader>/ ":CommentToggle<CR>"
;                          {:noremap true :silent true})	

(wk.register {:/ [":CommentToggle<CR>" "Comment"]} {:mode :n
                                                    :prefix :<leader>})
(wk.register {:/ [":CommentToggle<CR>" "Comment"]} {:mode :x
                                                    :prefix :<leader>})
