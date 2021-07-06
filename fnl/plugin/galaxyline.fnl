(module plugin.galaxyline {autoload {wk which-key
                                     nvim aniseed.nvim}})

(local gl (require :galaxyline))
(local colors {:bg "#2E2E2E"
               :yellow "#DCDCAA"
               :dark_yellow "#D7BA7D"
               :cyan "#4EC9B0"
               :green "#608B4E"
               :light_green "#B5CEA8"
               :string_orange "#CE9178"
               :orange "#FF8800"
               :purple "#C586C0"
               :magenta "#D16D9E"
               :grey "#858585"
               :blue "#569CD6"
               :vivid_blue "#4FC1FF"
               :light_blue "#9CDCFE"
               :red "#D16969"
               :error_red "#F44747"
               :info_yellow "#FFCC66"})
(local condition (require :galaxyline.condition))
(local gls gl.section)
(set gl.short_line_list {1 :NvimTree 2 :vista 3 :dbui 4 :packer})
(table.insert gls.left
              {:ViMode {:provider (fn []
                                    (local mode-color
                                           {:n colors.blue
                                            :i colors.green
                                            :v colors.purple
                                            "\022" colors.purple
                                            :V colors.purple
                                            :c colors.magenta
                                            :no colors.blue
                                            :s colors.orange
                                            :S colors.orange
                                            "\019" colors.orange
                                            :ic colors.yellow
                                            :R colors.red
                                            :Rv colors.red
                                            :cv colors.blue
                                            :ce colors.blue
                                            :r colors.cyan
                                            :rm colors.cyan
                                            :r? colors.cyan
                                            :! colors.blue
                                            :t colors.blue})
                                    (vim.api.nvim_command (.. "hi GalaxyViMode guifg="
                                                              (. mode-color
                                                                 (vim.fn.mode))))
                                    "▊")
                        :highlight :StatusLineNC}})
(vim.fn.getbufvar 0 :ts)
(table.insert gls.left
              {:GitIcon {:provider (fn []
                                     "  ")
                         :condition condition.check_git_workspace
                         :separator " "
                         :separator_highlight :StatusLineSeparator
                         :highlight :StatusLineGit}})
(table.insert gls.left
              {:GitBranch {:provider :GitBranch
                           :condition condition.check_git_workspace
                           :separator " "
                           :separator_highlight :StatusLineSeparator
                           :highlight :StatusLineNC}})
(table.insert gls.left
              {:DiffAdd {:provider :DiffAdd
                         :condition condition.hide_in_width
                         :icon "  "
                         :highlight :StatusLineGitAdd}})
(table.insert gls.left
              {:DiffModified {:provider :DiffModified
                              :condition condition.hide_in_width
                              :icon " 柳"
                              :highlight :StatusLineGitChange}})
(table.insert gls.left
              {:DiffRemove {:provider :DiffRemove
                            :condition condition.hide_in_width
                            :icon "  "
                            :highlight :StatusLineGitDelete}})
(table.insert gls.right
              {:DiagnosticError {:provider :DiagnosticError
                                 :icon "  "
                                 :highlight :StatusLineLspDiagnosticsError}})
(table.insert gls.right
              {:DiagnosticWarn {:provider :DiagnosticWarn
                                :icon "  "
                                :highlight :StatusLineLspDiagnosticsWarning}})
(table.insert gls.right
              {:DiagnosticInfo {:provider :DiagnosticInfo
                                :icon "  "
                                :highlight :StatusLineLspDiagnosticsInformation}})
(table.insert gls.right
              {:DiagnosticHint {:provider :DiagnosticHint
                                :icon "  "
                                :highlight :StatusLineLspDiagnosticsHint}})
(table.insert gls.right
              {:TreesitterIcon {:provider (fn []
                                            (when (not= (next vim.treesitter.highlighter.active)
                                                        nil)
                                              (lua "return \"  \""))
                                            "")
                                :separator " "
                                :separator_highlight :StatusLineSeparator
                                :highlight :StatusLineTreeSitter}})
(fn get-lsp-client [msg]
  (set-forcibly! msg (or msg "No Active LSP Client"))
  (local buf-ft (vim.api.nvim_buf_get_option 0 :filetype))
  (local clients (vim.lsp.get_active_clients))
  (when (= (next clients) nil)
    (lua "return msg"))
  (var lsps "")
  (each [_ client (ipairs clients)]
    (local filetypes client.config.filetypes)
    (when (and filetypes (not= (vim.fn.index filetypes buf-ft) 1))
      (if (= lsps "") (set lsps client.name)
          (set lsps (.. lsps ", " client.name)))))
  (if (= lsps "") msg lsps))
(table.insert gls.right
              {:ShowLspClient {:provider get-lsp-client
                               :condition (fn []
                                            (local tbl
                                                   {:dashboard true " " true})
                                            (when (. tbl vim.bo.filetype)
                                              (lua "return false"))
                                            true)
                               :icon "  "
                               :highlight :StatusLineNC}})
(table.insert gls.right
              {:LineInfo {:provider :LineColumn
                          :separator "  "
                          :separator_highlight :StatusLineSeparator
                          :highlight :StatusLineNC}})
(table.insert gls.right
              {:PerCent {:provider :LinePercent
                         :separator " "
                         :separator_highlight :StatusLineSeparator
                         :highlight :StatusLineNC}})
(table.insert gls.right
              {:Tabstop {:provider (fn []
                                     (.. "Spaces: "
                                         (vim.api.nvim_buf_get_option 0
                                                                      :shiftwidth)
                                         " "))
                         :condition condition.hide_in_width
                         :separator " "
                         :separator_highlight :StatusLineSeparator
                         :highlight :StatusLineNC}})
(table.insert gls.right
              {:BufferType {:provider :FileTypeName
                            :condition condition.hide_in_width
                            :separator " "
                            :separator_highlight :StatusLineSeparator
                            :highlight :StatusLineNC}})
(table.insert gls.right
              {:FileEncode {:provider :FileEncode
                            :condition condition.hide_in_width
                            :separator " "
                            :separator_highlight :StatusLineSeparator
                            :highlight :StatusLineNC}})
(table.insert gls.right
              {:Space {:provider (fn []
                                   " ")
                       :separator " "
                       :separator_highlight :StatusLineSeparator
                       :highlight :StatusLineNC}})
(table.insert gls.short_line_left
              {:BufferType {:provider :FileTypeName
                            :separator " "
                            :separator_highlight :StatusLineSeparator
                            :highlight :StatusLineNC}})
(table.insert gls.short_line_left
              {:SFileName {:provider :SFileName
                           :condition condition.buffer_not_empty
                           :highlight :StatusLineNC}})	
