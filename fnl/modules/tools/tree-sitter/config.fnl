(import-macros {: packadd! : fennec-module-p! : map!} :macros)

(local {: autoload} (require :core.lib.autoload))
(local {: setup} (require :core.lib.setup))
;; Conditionally enable leap-ast

(local treesitter-filetypes [:comment :help :fennel :vim :regex :query])
;; conditionally install parsers

(table.insert treesitter-filetypes :clojure)

(table.insert treesitter-filetypes :commonlisp)

(table.insert treesitter-filetypes :lua)

(table.insert treesitter-filetypes :python)

(table.insert treesitter-filetypes :bash)

(table.insert treesitter-filetypes :toml)

(table.insert treesitter-filetypes :markdown)
(table.insert treesitter-filetypes :markdown_inline)

(table.insert treesitter-filetypes :git_rebase)
(table.insert treesitter-filetypes :gitattributes)
(table.insert treesitter-filetypes :gitcommit)
(table.insert treesitter-filetypes :gitignore)

;; (table.insert treesitter-filetypes :tsx)
;; (table.insert treesitter-filetypes :typescript)
;; (table.insert treesitter-filetypes :javascript)
;; (table.insert treesitter-filetypes :json)

; the usual

(setup :nvim-treesitter.configs
       {:ensure_installed treesitter-filetypes
        ;; :build (pcall ((. (require :nvim-treesitter.install) :update) {:with_sync true}))
        :sync_install true
        :highlight {:enable true :use_languagetree true}
        :indent {:enable true}
        :context_commentstring {:enable true :enable_autocmd true}
        :rainbow {:enable true
                  :extended_mode true
                  :disable [:jsx :tsx]
                  :colors ["#878d96"
                           "#a8a8a8"
                           "#8d8d8d"
                           "#a2a9b0"
                           "#8f8b8b"
                           "#ada8a8"
                           "#878d96"]}
        :incremental_selection {:enable true
                                :keymaps {:init_selection :<Tab>
                                          :node_incremental :<Tab>
                                          :scope_incremental :<M-Tab>
                                          :node_decremental :<S-Tab>}}
        :textobjects {:select {:enable true
                               :lookahead true
                               :keymaps {:af "@function.outer"
                                         :if "@function.inner"
                                         :ac "@class.outer"
                                         :ic {:query "@class.inner"
                                              :desc "Select inner part of a class region."}}}
                      :move {:enable true
                             :set_jumps true
                             :goto_next_start {"]m" "@function.outer"
                                               "]]" "@class.outer"}
                             :goto_next_end {"]M" "@function.outer"
                                             "][" "@class.outer"}
                             :goto_previous_start {"[m" "@function.outer"
                                                   "[[" "@class.outer"}
                             :goto_previous_end {"[M" "@function.outer"
                                                 "[]" "@class.outer"}}}})

(setup :treesitter-context)
