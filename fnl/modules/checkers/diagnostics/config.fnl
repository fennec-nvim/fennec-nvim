(import-macros {: map! : let!} :macros)
(local {: autoload} (require :core.lib.autoload))
(local {: on-attach} (autoload :modules.tools.lsp.config))
(local {: diagnostic-icons} (autoload :core.shared))
(local null-ls (autoload :null-ls))
(local null-ls-sources [])

(let [{: config : severity} vim.diagnostic
      {: sign_define} vim.fn]
  (config {:underline {:severity {:min severity.INFO}}
           :signs {:severity {:min severity.INFO}}
           ;; lsp_lines handles this
           :virtual_text false
           :update_in_insert true
           :severity_sort true
           :float {:show_header false :border :rounded}})
  (sign_define :DiagnosticSignError
               {:text (. diagnostic-icons 1) :texthl :DiagnosticSignError})
  (sign_define :DiagnosticSignWarn
               {:text (. diagnostic-icons 2) :texthl :DiagnosticSignWarn})
  (sign_define :DiagnosticSignInfo
               {:text (. diagnostic-icons 3) :texthl :DiagnosticSignInfo})
  (sign_define :DiagnosticSignHint
               {:text (. diagnostic-icons 4) :texthl :DiagnosticSignHint}))

(local {:open_float open-line-diag-float!
        :goto_prev goto-diag-prev!
        :goto_next goto-diag-next!} vim.diagnostic)

;; TODO: figure out why I need to (let mapleader " ") when I've already done it in config.fnl
(let! mapleader " ")

(map! [n] :<leader>d open-line-diag-float! {:desc "Open diagnostics at line"})

(map! [n] "[d" goto-diag-prev! {:desc "Goto previous diagonstics"})
(map! [n] "]d" goto-diag-next! {:desc "Goto next diagnostics"})

(table.insert null-ls-sources null-ls.builtins.formatting.fnlfmt)
(table.insert null-ls-sources null-ls.builtins.formatting.stylua)
(table.insert null-ls-sources null-ls.builtins.formatting.markdownlint)
(table.insert null-ls-sources null-ls.builtins.formatting.black)
(table.insert null-ls-sources null-ls.builtins.formatting.isort)
(table.insert null-ls-sources null-ls.builtins.formatting.shfmt)

(table.insert null-ls-sources null-ls.builtins.diagnostics.selene)

(null-ls.setup {:sources null-ls-sources
                ;; #{m}: message
                ;; #{s}: source name (defaults to null-ls if not specified)
                ;; #{c}: code (if available
                :diagnostics_format "[#{c}] #{m} (#{s})"
                :debug true
                :on_attach on-attach})
