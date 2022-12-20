(local {: setup} (require :core.lib.setup))

(setup :gitsigns {:signs {:add {:hl :diffAdded
                                :text "▎"
                                :numhl :GitSignsAddNr
                                :linehl :GitSignsAddLn}
                          :change {:hl :diffChanged
                                   :text "▎"
                                   :numhl :GitSignsChangeNr
                                   :linehl :GitSignsChangeLn}
                          :delete {:hl :diffRemoved
                                   :text "契"
                                   :numhl :GitSignsDeleteNr
                                   :linehl :GitSignsDeleteLn}
                          :changedelete {:hl :diffChanged
                                         :text "▎"
                                         :numhl :GitSignsChangeNr
                                         :linehl :GitSignsChangeLn}
                          :topdelete {:hl :diffRemoved
                                      :text "契"
                                      :numhl :GitSignsDeleteNr
                                      :linehl :GitSignsDeleteLn}
                          :untracked {:hl :diffAdded
                                      :text "▎"
                                      :numhl :GitSignsAddNr
                                      :linehl :GitSignsAddLn}}
                  :signcolumn true
                  :attach_to_untracked true})
