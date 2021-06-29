/;; TODO fix lsp support
(module dotfiles.plugin.lsp {autoload {nvim aniseed.nvim
                              core aniseed.core
                              which-key which-key
                              lspinstall lspinstall
                              lspconfig lspconfig
                              nvim-lsp-ts-utils nvim-lsp-ts-utils}})

; ;; These servers get automatically setup
(local auto-setup-servers [:lua :python])

(fn server-installed [server]
  "Checks if the server is installed"
  (core.some (partial = server) (lspinstall.installed_servers)))

(defn- document-highlight [client bufnr]
  (when client.resolved_capabilities.document_highlight
    (vim.api.nvim_exec "      hi LspReferenceRead cterm=bold ctermbg=red guibg=#464646
      hi LspReferenceText cterm=bold ctermbg=red guibg=#464646
      hi LspReferenceWrite cterm=bold ctermbg=red guibg=#464646
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    " false)))

(defn- common_on_attach [client bufnr]
  (document-highlight client bufnr))

(local general-config {})
; 
; (fn general-config.on_attach [client buffer]
;   (which-key.register {:<leader>l {:name "Language Server Provider"
;                                    :d [vim.lsp.buf.definition
;                                        "Go to definition"]
;                                    :D [vim.lsp.buf.type_definition
;                                        "Type definition"]
;                                    :r [vim.lsp.buf.references
;                                        "Go to references"]
;                                    :i [vim.lsp.buf.implementation
;                                        "Go to implementation"]
;                                    :h [vim.lsp.buf.hover "Hover doc"]
;                                    :k [vim.lsp.buf.signiture_help
;                                        "Signiture help"]
;                                    :a [vim.lsp.buf.code_action "Code action"]}
;                        :<leader>t {:name :Trouble
;                                    :t [trouble.toggle "Trouble Toggle"]
;                                    :w [(partial trouble.toggle
;                                                 :lsp_workspace_diagnostics)
;                                        "LSP Workspace Diagnostics"]
;                                    :d [(partial trouble.toggle
;                                                 :lsp_document_diagnostics)
;                                        "LSP Document Diagnostics"]
;                                    :q [(partial trouble.toggle :quickfix)
;                                        "Quickfix List"]
;                                    :l [(partial trouble.toggle :loclist)
;                                        "Location List"]}}
;                       {: buffer}))
; 
; ;; START typescript
; ;; The typescript config
; (local typescript-config {})
; 
; ;; Typescript handlers
; (set typescript-config.handlers
;      {:textDocument/publishDiagnostics (vim.lsp.with vim.lsp.diagnostic.on_publish_diagnostics
;                                                      {:virtual_text true
;                                                       :signs true
;                                                       :underline true
;                                                       :update_in_insert true})})
; 
; (fn typescript-config.on_attach [client buffer]
;   "On attach function for the typescript server"
;   (set client.resolved_capabilities.document_formatting false)
;   ;; Set up lsp-ts-utils
;   (nvim-lsp-ts-utils.setup {:disable_commands true :enable_formatting false})
;   ;; Set up common bindings
;   (general-config.on_attach client buffer)
;   ;; Register bindings for lsp-ts-utils
;   (which-key.register {:<leader>uo [nvim-lsp-ts-utils.organize_imports
;                                     "LSP Organize"]
;                        :<leader>ur [nvim-lsp-ts-utils.rename_file
;                                     "LSP Rename File"]
;                        :<leader>ua [nvim-lsp-ts-utils.import_all
;                                     "LSP Import All"]
;                        :<leader>uc [nvim-lsp-ts-utils.fix_current
;                                     "LSP Fix Current"]}
;                       {: buffer}))
; 
; (fn setup-typescript-server []
;   "Sets up the typescript server"
;   (lspconfig.typescript.setup typescript-config))
; ;; END typescript
; 
;; START lua
; (local sumneko_root_path (.. DATA_PATH "/lspinstall/lua"))
; (local sumneko_binary (.. sumneko_root_path "/sumneko-lua-language-server"))
; (local lua-server-cmd [sumneko-binary "-E" (.. sumneko_root_path "/main.lua")])

(local lua-server-settings
       {:Lua {:runtime {:version :LuaJIT :path (vim.split package.path ";")}
              :diagnostics {:globals {1 :vim}}
              :workspace {:library {(vim.fn.expand :$VIMRUNTIME/lua) true
                                    (vim.fn.expand :$VIMRUNTIME/lua/vim/lsp) true}}}})
(fn setup-lua-server []
  "Sets up the lua server"
  (lspconfig.sumneko_lua.setup {:on_attach common_on_attach
                                :settings lua-server-settings}))
;; END lua

;; START python
; (local pyright-binary (.. DATA_PATH "/lspinstall/python/node_modules/.bin/pyright-langserver"))
; (local python-server-cmd [pyright-binary "--stdio"])

(local python-server-settings
  {:python {:analysis {:typeCheckingMode "off"
                       :autoSearchPaths true
                       :useLibraryCodeForTypes true}}})

(local python-server-handlers
     {:textDocument/publishDiagnostics (vim.lsp.with 
                                         vim.lsp.diagnostic.on_publish_diagnostics {:virtual_text true
                                                                                    :signs true
                                                                                    :underline true
                                                                                    :update_in_insert true})})

(fn setup-python-server []
  "Sets up the python server"
  (lspconfig.pyright.setup {:on_attach common_on_attach
                            :handlers python-server-handlers
                            :settings python-server-settings}))
;; END python

;; START efm

(local lua-arguments {})
(local lua_fmt {:formatCommand "luafmt --indent-count 2 --line-width 120 --stdin"
                :formatStdin true})
(table.insert lua-arguments lua_fmt)

(local python-arguments {})
(local flake8 {:LintCommand "flake8 --ignore=E501 --stdin-display-name ${INPUT} -"
               :lintStdin true
               :lintFormats ["%f:%l:%c: %m"]})
(table.insert python-arguments flake8)

(local efm-server-init_options {:documentFormatting true
                                :codeAction false})
(local efm-server-filetypes ["python" "lua"])

(local efm-server-settings
  {:rootMarkers [:.git/]
   :languages {:python python-arguments
               :lua lua-arguments}})

; (fn setup-efm-server []
  ; (lspconfig.efm.setup {:filtypes efm-server-filetypes
                        ; :settings efm-server-settings}))

; (fn setup-csharp-server []
;   "Sets up the csharp server"
;   (lspconfig.csharp.setup {}))
; 
(fn setup-lsp-servers []
  "Sets up all lsp servers, installing & auto configuring ones that are 'auto-setup'"

  ;; Set up lspinstall
  (lspinstall.setup)

  ;; Register a post install hook
  (fn lspinstall.post_install_hook []
    "Register a post install hook that calls this setup servers function"
    (setup-lsp-servers)
    (vim.cmd "bufdo e"))

  ;; Auto set up certain servers and install them if they aren't yet installed
  (each [_ server (ipairs auto-setup-servers)]
    (if (server-installed server)
        ((. (. lspconfig server) :setup) general-config)
        (lspinstall.install_server server)))
  ;; If the lua server is installed then set it up
  (when (server-installed :lua)
    (setup-lua-server))
  ;; If the typescript server is installed then set it up
  ; (when (server-installed :typescript)
    ; (setup-typescript-server))
  ;; If the csharp server is installed then set it up
  ; (when (server-installed :csharp)
    ; (setup-csharp-server))
  ;; If the python server is installed then set it up
  (when (server-installed :python)
    (setup-python-server)))
  ;; If the efm server is installed then set it up
  ; (when (server-installed :efm)
    ; (setup-efm-server)))

;; Set up all the servers
(setup-lsp-servers)
;; Define new signs for lsp
(vim.fn.sign_define :LspDiagnosticsSignError
                    {:texthl :LspDiagnosticsSignError
                     :text ""
                     :numhl :LspDiagnosticsSignError})

(vim.fn.sign_define :LspDiagnosticsSignWarning
                    {:texthl :LspDiagnosticsSignWarning
                     :text ""
                     :numhl :LspDiagnosticsSignWarning})

(vim.fn.sign_define :LspDiagnosticsSignHint
                    {:texthl :LspDiagnosticsSignHint
                     :text ""
                     :numhl :LspDiagnosticsSignHint})

(vim.fn.sign_define :LspDiagnosticsSignInformation
                    {:texthl :LspDiagnosticsSignInformation
                     :text ""
                     :numhl :LspDiagnosticsSignInformation})

(vim.cmd "nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>")
(vim.cmd "nnoremap <silent> gD <cmd>lua vim.lsp.buf.declaration()<CR>")
(vim.cmd "nnoremap <silent> gr <cmd>lua vim.lsp.buf.references()<CR>")
(vim.cmd "nnoremap <silent> gi <cmd>lua vim.lsp.buf.implementation()<CR>")
(vim.cmd "nnoremap <silent> ca :Lspsaga code_action<CR>")
(vim.cmd "nnoremap <silent> K :Lspsaga hover_doc<CR>")
(vim.cmd "nnoremap <silent> <C-p> :Lspsaga diagnostic_jump_prev<CR>")
(vim.cmd "nnoremap <silent> <C-n> :Lspsaga diagnostic_jump_next<CR>")
(vim.cmd "nnoremap <silent> <C-f> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>")
(vim.cmd "nnoremap <silent> <C-b> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>")
(vim.cmd "command! -nargs=0 LspVirtualTextToggle lua require(\"lsp/virtual_text\").toggle()")

; Set default prefix
(tset vim.lsp.handlers :textDocument/publishDiagnostics
      (vim.lsp.with vim.lsp.diagnostic.on_publish_diagnostics
                    {:virtual_text {:prefix "" :spacing 0}
                     :signs true
                     :underline true}))
;; Symbols for autocomplete
(set vim.lsp.protocol.CompletionItemKind ["   (Text) "
                                          "   (Method)"
                                          "   (Function)"
                                          "   (Constructor)"
                                          " ﴲ  (Field)"
                                          "[] (Variable)"
                                          "   (Class)"
                                          " ﰮ  (Interface)"
                                          "   (Module)"
                                          " 襁 (Property)"
                                          "   (Unit)"
                                          "   (Value)"
                                          " 練 (Enum)"
                                          "   (Keyword)"
                                          "   (Snippet)"
                                          "   (Color)"
                                          "   (File)"
                                          "   (Reference)"
                                          "   (Folder)"
                                          "   (EnumMember)"
                                          " ﲀ  (Constant)"
                                          " ﳤ  (Struct)"
                                          "   (Event)"
                                          "   (Operator)"
                                          "   (TypeParameter)"])

