(require-macros :zest.macros)
(module plugin.which-key {autoload {which-key which-key
                                    nvim aniseed.nvim}})

(which-key.setup {:plugins {:marks true ; shows a list of your marks on ' and `
                            :registers true ; shows your registers on " in NORMAL or <C-r> in INSERT mode
                                    ; the presets plugin, adds help for a bunch of default keybindings in Neovim
                                    ; No actual key bindings are created
                            :presets {:operators false ; adds help for operators like d, y, ...
                                      :motions false ; adds help for motions
                                      :text-objects false ; help for text objects triggered after entering an operator
                                      :windows true ; default bindings on <c-w>
                                      :nav true ; misc bindings to work with windows
                                      :z true ;  bindings for folds, spelling and others prefixed with z
                                      :g true}} ; bindings for prefixed with g
                  :icons {:breadcrumb "»" ; symbol used in the command line area that shows your active key combo
                          :separator "➜" ; symbol used between a key and it's label
                          :group "+"} ; symbol prepended to a group
                  :window {:border "single" ; none, single, double, shadow
                           :position "bottom" ; bottom, top
                           :margin [0 0 0 0] ; extra window margin [top, right, bottom, left]
                           :padding [0 0 0 0]} ; extra window padding [top, right, bottom, left]
                  :layout {:height {:min 4 ; min and max height of the columns
                                    :max 25} 
                           :width {:min 20 ; min and max width of the columns
                                   :max 50}
                           :spacing 3} ; spacing between columns
                  :hidden ["<silent>" "<cmd>" "<Cmd>" "<CR>" "call" "lua" "^:" "^ "] ; hide mapping boilerplate
                  :show_help true}) ; show help message on the command line when the popup is visible
