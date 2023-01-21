(import-macros {: map! : let!} :macros)
(local {: autoload} (require :core.lib.autoload))
(local {: setup} (require :core.lib.setup))
(local {: load_extension} (autoload :telescope))

(local theme (. (require :telescope.themes) :get_ivy))
(local actions (autoload :telescope.actions))

(local defaults (theme {:prompt_prefix "   "
                        :selection_caret "  "
                        :entry_prefix "  "
                        :sorting_strategy :ascending
                        :selection_strategy :reset
                        :vimgrep_arguments [:rg
                                            :--color=never
                                            :--no-heading
                                            :--with-filename
                                            :--line-number
                                            :--column
                                            :--smart-case
                                            :--hidden
                                            :--glob=!.git/]
                        :mappings {:i {:<C-n> :move_selection_next
                                       :<C-j> :move_selection_next
                                       :<C-p> :move_selection_previous
                                       :<C-k> :move_selection_previous
                                       :<C-c> :close
                                       :<Down> :cycle_history_next
                                       :<Up> :cycle_history_prev
                                       :<C-q> :smart_send_to_qflist
                                       :<Cr> :select_default}
                                   :n {:<C-n> :move_selection_next
                                       :<C-p> :move_selection_previous
                                       :<C-q> :smart_send_to_qflist}}
                        ;; :layout_strategy :flex
                        ;; :layout_config {:horizontal {:prompt_position :top
                        ;;                              :preview_width 0.55}
                        ;;                 :vertical {:mirror false}
                        ;;                 :width 0.87
                        ;;                 :height 0.8
                        ;;                 :preview_cutoff 120}
                        :set_env {:COLORTERM :truecolor}
                        :dynamic_preview_title true}))

(setup :telescope
       {: defaults
        :pickers {:find_files {:hidden true}
                  ;; @usage don't include the filename in the search results
                  :live_grep {:only_sort_text true}
                  :grep_string {:only_sort_text true}
                  :buffers {:initial_mode :normal}
                  :git_files {:hidden true :show_untracked true}}
        :extensions {:fzf {:fuzzy true
                           ;; override the generic sorter
                           :override_generic_sorter true
                           ;; override the file sorter
                           :override_file_sorter true
                           ;; or :ignore_case or :respect_case
                           :case_mode :smart_case}}})

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

(map! [n] :<leader><space> "<cmd>Telescope find_files<CR>"
      {:desc "Find file in project"})

(map! [n] :<leader>. "<cmd>Telescope find_files<CR>" {:desc "Find file"})
(map! [n] :<leader>< "<cmd>Telescope buffers<CR>" {:desc "Switch buffer"})
(map! [n] "<leader>'" "<cmd>Telescope resume<CR>" {:desc "Resume last search"})
(map! [n] :<leader>/ "<cmd>Telescope live_grep<CR>" {:desc "Search project"})

;; TODO: make an extension for a custom dotfiles picker
(map! [n] :<leader>f. "<cmd>Telescope dotfiles<cr>"
      {:desc "Find file in dotfiles"})

;; (map! [n] :<leader>fc "<cmd>Telescope editorconfig<cr>"
;;       {:desc "Open project editorconfig"})
;; (map! [n] :<leader>fd "<cmd><cr>"
;;       {:desc "Find directory"}) ;; Search for directories, on <cr> open dirvish

;; TODO: make an extension for a custom nvim files picker
(map! [n] :<leader>fe "<cmd>Telescope nvim_files<cr>"
      {:desc "Find file in .config/nvim"})

(map! [n] :<leader>fE "<cmd>Telescope browse_nvim_files<cr>"
      {:desc "Browse .config/nvim"})

(map! [n] :<leader>ff "<cmd>Telescope find_files<cr>" {:desc "Find file"})

;; TODO: make an extension for a custom fennec config picker
(map! [n] :<leader>fp "<cmd>Telescope fennec_config<cr>"
      {:desc "Find file in private config"})

;; (map! [n] :<leader>fP :<cmd><cr> {:desc "Browse private config"})
;; (map! [n] :<leader>fP :<cmd><cr> {:desc "Grep in private config"})

(map! [n] :<leader>fr "<cmd>Telescope oldfiles<cr>" {:desc "Recent files"})

(map! [n] :<leader>ci open-impl-float! {:desc "Find implementations"})
(map! [n] :<leader>cD open-ref-float! {:desc "Jump to references"})
(map! [n] :<leader>cj open-local-symbol-float!
      {:desc "LSP Jump to symbol in file"})

(map! [n] :<leader>cJ open-workspace-symbol-float!
      {:desc "LSP Jump to symbol in workspace"})

(map! [n] :<leader>* open-workspace-symbol-float! {:desc "Search symbols"})

(local {:diagnostics open-diag-float!} (autoload :telescope.builtin))

(map! [n] :<leader>cx `(open-diag-float! {:bufnr 0})
      {:desc "Local diagnostics"})

(map! [n] :<leader>cX open-diag-float! {:desc "Project diagnostics"})

(map! [n] :<leader>ca `(vim.lsp.buf.code_action) {:desc "Code actions"})
(map! [n] :<leader>cf `(vim.lsp.buf.format {:async true})
      {:desc "Format buffer"})

(map! [v] :<leader>cf `(vim.lsp.buf.range_formatting) {:desc "Format region"})
