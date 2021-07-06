(module plugin.dashboard
  {autoload {nvim aniseed.nvim}})

(set vim.g.dashboard_disable_at_vimenter 0)
(set vim.g.dashboard_custom_header fennec.dashboard.custom_header)
(set vim.g.dashboard_default_executive :telescope)
(set vim.g.dashboard_custom_section
     {:a {:description {1 "  Find File          "}
          :command "Telescope find_files"}
      :b {:description {1 "  Recently Used Files"}
          :command "Telescope oldfiles"}
      :c {:description {1 "  Load Last Session  "} :command :SessionLoad}
      :d {:description {1 "  Find Word          "}
          :command "Telescope live_grep"}
      ; :e {:description {1 "  Settings           "}
      ;     :command (.. ":e " CONFIG_PATH :/lv-config.lua)}
      ; :f {:description {1 "  Neovim Config Files"}
      ;     :command (.. "Telescope find_files cwd=" CONFIG_PATH)}
      })
(vim.cmd "let g:dashboard_session_directory = $HOME..'/.config/nvim/.sessions'")
(vim.cmd "let packages = len(globpath('~/.local/share/nvim/site/pack/packer/start', '*', 0, 1))")
(vim.api.nvim_exec "    let g:dashboard_custom_footer = ['LuaJIT loaded '..packages..' plugins']
" false)

; TODO: define_augroups for dashboard
