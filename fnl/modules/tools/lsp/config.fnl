(import-macros {: fennec-module-p!} :macros)
(local {: autoload} (require :core.lib.autoload))
(local {: deep-merge} (autoload :core.lib.tables))
(local {: setup} (require :core.lib.setup))
(local lsp (autoload :lspconfig))
(local lsp-servers {})

(setup :fidget {})

(set vim.lsp.handlers.textDocument/signatureHelp
     (vim.lsp.with vim.lsp.handlers.signature_help {:border :solid}))

(set vim.lsp.handlers.textDocument/hover
     (vim.lsp.with vim.lsp.handlers.hover {:border :solid}))

(fn on-attach [client bufnr]
  (import-macros {: buf-map! : autocmd! : augroup! : clear!} :macros)
  (local {: contains?} (autoload :core.lib))
  (local {:hover open-doc-float!
          :declaration goto-declaration!
          :definition goto-definition!
          :type_definition goto-type-definition!
          :references goto-references!} vim.lsp.buf)
  (buf-map! [n] :K open-doc-float!)
  (buf-map! [n] :<leader>gD goto-declaration!)
  (buf-map! [n] :gD goto-declaration!)
  (buf-map! [n] :<leader>gd goto-definition!)
  (buf-map! [n] :gd goto-definition!)
  (buf-map! [n] :<leader>gt goto-type-definition!)
  (buf-map! [n] :gt goto-type-definition!)
  (buf-map! [n] :<leader>gr goto-references!)
  (buf-map! [n] :gr goto-references!))

(local capabilities (vim.lsp.protocol.make_client_capabilities))
(set capabilities.textDocument.completion.completionItem
     {:documentationFormat [:markdown :plaintext]
      :snippetSupport true
      :preselectSupport true
      :insertReplaceSupport true
      :labelDetailsSupport true
      :deprecatedSupport true
      :commitCharactersSupport true
      :tagSupport {:valueSet {1 1}}
      :resolveSupport {:properties [:documentation
                                    :detail
                                    :additionalTextEdits]}})

;;; Setup servers

(local defaults {:on_attach on-attach
                 : capabilities
                 :flags {:debounce_text_changes 150}})

(tset lsp-servers :sumneko_lua
      {:settings {:Lua {:diagnostics {:globals [:vim]}
                        :workspace {:library (vim.api.nvim_list_runtime_paths)
                                    :maxPreload 100000}}}})

(let [servers lsp-servers]
  (each [server server_config (pairs servers)]
    ((. (. lsp server) :setup) (deep-merge defaults server_config))))

{: on-attach}
