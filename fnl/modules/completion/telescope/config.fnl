(import-macros {: map! : let!} :macros)
(local {: autoload} (require :core.lib.autoload))
(local {: setup} (require :core.lib.setup))
(local {: load_extension} (autoload :telescope))

(setup :telescope {:defaults {:prompt_prefix "   "
                              :selection_caret "  "
                              :entry_prefix "  "
                              :sorting_strategy :ascending
                              :layout_strategy :flex
                              :layout_config {:horizontal {:prompt_position :top
                                                           :preview_width 0.55}
                                              :vertical {:mirror false}
                                              :width 0.87
                                              :height 0.8
                                              :preview_cutoff 120}
                              :set_env {:COLORTERM :truecolor}
                              :dynamic_preview_title true}})

;; Load extensions

;; (packadd! telescope-ui-select.nvim)
(load_extension :ui-select)
;; (packadd! telescope-file-browser.nvim)
(load_extension :file_browser)
;; (packadd! telescope-project.nvim)
(load_extension :project)
;; (packadd! telescope-tabs)
(setup :telescope-tabs)
;; only install native if the flag is there
(load_extension :fzf)
;; load zoxide only if their executables exist
(load_extension :zoxide)

(local {:lsp_implementations open-impl-float!
        :lsp_references open-ref-float!
        :lsp_document_symbols open-local-symbol-float!
        :lsp_workspace_symbols open-workspace-symbol-float!}
       (autoload :telescope.builtin))

;; TODO: figure out why I need to (let mapleader " ") when I've already done it in config.fnl
(let! mapleader " ")

(map! [n] :<leader>ci open-impl-float! {:desc "LSP Find implementations"})
(map! [n] :<leader>cD open-ref-float! {:desc "LSP Jump to references"})
(map! [n] :<leader>cj open-local-symbol-float!
      {:desc "LSP Jump to symbol in file"})

(map! [n] :<leader>cJ open-workspace-symbol-float!
      {:desc "LSP Jump to symbol in workspace"})

(map! [n] :<leader>* open-workspace-symbol-float!
      {:desc "Search symbols"})

(local {:diagnostics open-diag-float!} (autoload :telescope.builtin))

(map! [n] :<leader>cx `(open-diag-float! {:bufnr 0})
      {:desc "Local diagnostics"})

(map! [n] :<leader>cX open-diag-float! {:desc "Project diagnostics"})

(map! [n] :<leader>ca `(vim.lsp.buf.code_action) {:desc "LSP Code actions"})
(map! [n] :<leader>cf `(vim.lsp.buf.format {:async true})
      {:desc "Format buffer"})

(map! [v] :<leader>cf `(vim.lsp.buf.range_formatting)
      {:desc "LSP Format region"})
