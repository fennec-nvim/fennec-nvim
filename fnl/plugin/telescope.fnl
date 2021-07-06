(module plugin.telescope
  {autoload {nvim aniseed.nvim}})

(local actions (require :telescope.actions))
((. (require :telescope) :setup) {:defaults {:find_command {1 :rg
                                                            2 :--no-heading
                                                            3 :--with-filename
                                                            4 :--line-number
                                                            5 :--column
                                                            6 :--smart-case}
                                             :prompt_prefix " "
                                             :selection_caret " "
                                             :entry_prefix "  "
                                             :initial_mode :insert
                                             :selection_strategy :reset
                                             :sorting_strategy :descending
                                             :layout_strategy :horizontal
                                             :layout_config {:width 0.75
                                                             :prompt_position :bottom
                                                             :preview_cutoff 120
                                                             :horizontal {:mirror false}
                                                             :vertical {:mirror false}}
                                             :file_sorter (. (require :telescope.sorters)
                                                             :get_fzy_sorter)
                                             :file_ignore_patterns {}
                                             :generic_sorter (. (require :telescope.sorters)
                                                                :get_generic_fuzzy_sorter)
                                             :shorten_path true
                                             :winblend 0
                                             :border {}
                                             :borderchars {1 "─"
                                                           2 "│"
                                                           3 "─"
                                                           4 "│"
                                                           5 "╭"
                                                           6 "╮"
                                                           7 "╯"
                                                           8 "╰"}
                                             :color_devicons true
                                             :use_less true
                                             :set_env {:COLORTERM :truecolor}
                                             :file_previewer (. (. (require :telescope.previewers)
                                                                   :vim_buffer_cat)
                                                                :new)
                                             :grep_previewer (. (. (require :telescope.previewers)
                                                                   :vim_buffer_vimgrep)
                                                                :new)
                                             :qflist_previewer (. (. (require :telescope.previewers)
                                                                     :vim_buffer_qflist)
                                                                  :new)
                                             :buffer_previewer_maker (. (require :telescope.previewers)
                                                                        :buffer_previewer_maker)
                                             :mappings {:i {:<C-c> actions.close
                                                            :<C-j> actions.move_selection_next
                                                            :<C-k> actions.move_selection_previous
                                                            :<C-q> (+ actions.smart_send_to_qflist
                                                                      actions.open_qflist)
                                                            :<CR> (+ actions.select_default
                                                                     actions.center)}
                                                        :n {:<C-j> actions.move_selection_next
                                                            :<C-k> actions.move_selection_previous
                                                            :<C-q> (+ actions.smart_send_to_qflist
                                                                      actions.open_qflist)}}}
                                  :extensions {:fzy_native {:override_generic_sorter false
                                                            :override_file_sorter true}}})	
