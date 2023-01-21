(import-macros {: set! : fennec-module-p! : packadd!} :macros)
(local {: autoload} (require :core.lib.autoload))
(local {: setup} (require :core.lib.setup))
(local cmp (autoload :cmp))
(local luasnip (autoload :luasnip))
;; vim settings

;; TODO: don't show completion in Telescope

(set! completeopt [:menu :menuone :noselect])
;; add general cmp sources

(local cmp-sources [])

(table.insert cmp-sources {:name :luasnip :group_index 1})
(table.insert cmp-sources {:name :buffer :group_index 2})
(table.insert cmp-sources {:name :path :group_index 2})

(table.insert cmp-sources {:name :conjure :group_index 1})
(table.insert cmp-sources {:name :nvim_lsp :group_index 1})
(table.insert cmp-sources {:name :nvim_lsp_signature_help :group_index 1})

(local cmp-source-names {:nvim_lsp "(LSP)"
                         :conjure "(Conjure)"
                         :buffer "(Buffer)"
                         :path "(Path)"
                         :luasnip "(Snippet)"})

;; lsp icons

(local icons {:Text "  "
              :Method "  "
              :Function "  "
              :Constructor "  "
              :Field "  "
              :Variable "  "
              :Class "  "
              :Interface "  "
              :Module "  "
              :Property "  "
              :Unit "  "
              :Value "  "
              :Enum "  "
              :Keyword "  "
              :Snippet "  "
              :Color "  "
              :File "  "
              :Reference "  "
              :Folder "  "
              :EnumMember "  "
              :Constant "  "
              :Struct "  "
              :Event "  "
              :Operator "  "
              :Copilot "  "
              :TypeParameter "  "})

;; copilot uses lines above/below current text which confuses cmp, fix:

(fn has-words-before []
  (let [(line col) (unpack (vim.api.nvim_win_get_cursor 0))]
    (and (not= col 0) (= (: (: (. (vim.api.nvim_buf_get_lines 0 (- line 1) line
                                                              true)
                                  1) :sub col
                               col) :match "%s") nil))))

(setup :cmp {:experimental {:ghost_text true}
             :window {:documentation {:border :solid}
                      :completion {:col_offset (- 3)
                                   :side_padding 0
                                   :winhighlight "Normal:NormalFloat,NormalFloat:Pmenu,Pmenu:NormalFloat"}}
             :view {:entries {:name :custom :selection_order :near_cursor}}
             :enabled (fn []
                        (local context (autoload :cmp.config.context))
                        (if (= (. (vim.api.nvim_get_mode) :mode) :c) true
                            (= :prompt (vim.api.nvim_buf_get_option 0 :buftype)) false
                            (and (not (context.in_treesitter_capture :comment))
                                 (not (context.in_syntax_group :Comment)))))
             :preselect cmp.PreselectMode.None
             :snippet {:expand (fn [args]
                                 (luasnip.lsp_expand args.body))}
             :mapping {:<C-b> (cmp.mapping.scroll_docs -4)
                       :<C-f> (cmp.mapping.scroll_docs 4)
                       :<C-Space> (cmp.mapping.complete)
                       :<C-p> (cmp.mapping.select_prev_item)
                       :<C-k> (cmp.mapping.select_prev_item)
                       :<C-n> (cmp.mapping.select_next_item)
                       :<C-j> (cmp.mapping.select_next_item)
                       :<CR> (cmp.mapping.confirm {:behavior cmp.ConfirmBehavior.Insert
                                                   :select false})
                       :<C-e> (fn [fallback]
                                (if (cmp.visible)
                                    (do
                                      (cmp.mapping.close)
                                      (vim.cmd :stopinsert))
                                    (fallback)))
                       :<Tab> (cmp.mapping (fn [fallback]
                                             (if (cmp.visible)
                                                 (cmp.select_next_item)
                                                 (luasnip.expand_or_jumpable)
                                                 (luasnip.expand_or_jump)
                                                 (has-words-before)
                                                 (cmp.complete)
                                                 :else
                                                 (fallback)))
                                           [:i :s :c])
                       :<S-Tab> (cmp.mapping (fn [fallback]
                                               (if (cmp.visible)
                                                   (cmp.select_prev_item)
                                                   (luasnip.jumpable -1)
                                                   (luasnip.jump -1)
                                                   :else
                                                   (fallback)))
                                             [:i :s :c])}
             :sources cmp-sources
             :formatting {:fields {1 :kind 2 :abbr 3 :menu}
                          :format (fn [entry vim-item]
                                    (set vim-item.menu
                                         (. cmp-source-names entry.source.name))
                                    (set vim-item.kind (. icons vim-item.kind))
                                    vim-item)}})

;; Enable command-line completions

(cmp.setup.cmdline "/"
                   {:mapping (cmp.mapping.preset.cmdline)
                    :sources [{:name :buffer :group_index 1}]})

;; Enable search completions

(cmp.setup.cmdline ":"
                   {:mapping (cmp.mapping.preset.cmdline)
                    :sources [{:name :path} {:name :cmdline :group_index 1}]})

;; snippets

((. (autoload :luasnip.loaders.from_vscode) :lazy_load))
