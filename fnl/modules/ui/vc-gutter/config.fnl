(local {: setup} (require :core.lib.setup))
(local {: git-icons} (require :core.shared))

(setup :gitsigns {:signs {:add {:hl :diffAdded
                                :text git-icons.gutter
                                :numhl :GitSignsAddNr
                                :linehl :GitSignsAddLn}
                          :change {:hl :diffChanged
                                   :text git-icons.gutter
                                   :numhl :GitSignsChangeNr
                                   :linehl :GitSignsChangeLn}
                          :delete {:hl :diffRemoved
                                   :text git-icons.gutter-removed
                                   :numhl :GitSignsDeleteNr
                                   :linehl :GitSignsDeleteLn}
                          :changedelete {:hl :diffChanged
                                         :text git-icons.gutter
                                         :numhl :GitSignsChangeNr
                                         :linehl :GitSignsChangeLn}
                          :topdelete {:hl :diffRemoved
                                      :text git-icons.gutter-top-removed
                                      :numhl :GitSignsDeleteNr
                                      :linehl :GitSignsDeleteLn}
                          :untracked {:hl :diffAdded
                                      :text git-icons.gutter
                                      :numhl :GitSignsAddNr
                                      :linehl :GitSignsAddLn}}
                  :signcolumn true
                  :attach_to_untracked true})
