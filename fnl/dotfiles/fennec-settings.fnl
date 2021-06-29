(module dotfiles.fennec-settings)

(fennec! :colorscheme "fennec-gruvbox"
         :modules [:lsp :treesitter :git :lisps :explorer :lightspeed])

; (local auto-formatters {})
; 
; ; (local python-autoformat {1 :BufWritePre 2 :*.py 3 "lua vim.lsp.buf.formatting_sync(nil, 1000)"})
; ; (table.insert auto-formatters python-autoformat)
; 
; ; (local lua-autoformat {1 :BufWritePre 2 :*.lua 3 "lua vim.lsp.buf.formatting_sync(nil, 1000)"})
; ; (table.insert auto-formatters lua-autoformat)
; ; 
; (defn- define_augroups [definitions]
;   (each [group-name definition (pairs definitions)]
;     (vim.cmd (.. "augroup " group-name))
;     (vim.cmd :autocmd!)
;     (each [_ def (pairs definition)]
;       (local command (table.concat (vim.tbl_flatten [:autocmd def]) " "))
;       (vim.cmd command))
;     (vim.cmd "augroup END")))
; 
; ; ; TODO require utils.define_augroups
;  (define_augroups {:_general_settings [ [:TextYankPost "*" "lua require('vim.highlight').on_yank({higroup = 'Search', timeout = 200})"]
;                                         [:BufWinEnter "*" "setlocal formatoptions-=c formatoptions-=r formatoptions-=o"]
;                                         [:BufRead "*" "setlocal formatoptions-=c formatoptions-=r formatoptions-=o"]
;                                         [:BufNewFile "*" "setlocal formatoptions-=c formatoptions-=r formatoptions-=o"]
;                                         [:VimLeavePre "*" "set title set titleold="]
;                                         [:FileType "*" "set nobuflisted"]]
;                    :_buffer_bindings [ [:FileType :dashboard "nnoremap <silent> <buffer> q :q<CR>"]
;                                        [:FileType :lspinfo "nnoremap <silent> <buffer> q :q<CR>"]]
;                    :_auto_formatters auto-formatters})
