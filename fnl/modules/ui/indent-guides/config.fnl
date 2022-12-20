(import-macros {: autocmd!} :macros)
(local {: setup} (require :core.lib.setup))

(setup :mini.indentscope {:symbol "│"})

(autocmd! FileType alpha "lua vim.b.miniindentscope_disable = true")
(autocmd! FileType lazy "lua vim.b.miniindentscope_disable = true")
(autocmd! FileType help "lua vim.b.miniindentscope_disable = true")
(autocmd! FileType terminal "lua vim.b.miniindentscope_disable = true")
(autocmd! FileType lspinfo "lua vim.b.miniindentscope_disable = true")
(autocmd! FileType TelescopePrompt "lua vim.b.miniindentscope_disable = true")
(autocmd! FileType TelescopeResults "lua vim.b.miniindentscope_disable = true")
(autocmd! FileType mason "lua vim.b.miniindentscope_disable = true")
