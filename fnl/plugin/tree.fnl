; TODO: fix the font overlap issue in nvim-tree
(module plugin.tree
  {autoload {nvim aniseed.nvim
             tree-config nvim-tree.config
             wk which-key}})

(local g vim.g)
(set vim.o.termguicolors true)
(set g.nvim_tree_side :left)
(set g.nvim_tree_width 30)
(set g.nvim_tree_ignore {1 :.git 2 :node_modules 3 :.cache})
(set g.nvim_tree_auto_open 1)
(set g.nvim_tree_auto_close 0)
(set g.nvim_tree_quit_on_open 0)
(set g.nvim_tree_follow 1)
(set g.nvim_tree_indent_markers 1)
(set g.nvim_tree_hide_dotfiles 1)
(set g.nvim_tree_git_hl 1)
(set g.nvim_tree_root_folder_modifier ":t")
(set g.nvim_tree_tab_open 0)
(set g.nvim_tree_allow_resize 1)
(set g.nvim_tree_lsp_diagnostics 1)
(set g.nvim_tree_auto_ignore_ft {1 :startify 2 :dashboard})
(set g.nvim_tree_show_icons {:git 1 :folders 1 :files 1 :folder_arrows 1})

(set vim.g.nvim_tree_icons
     {:default ""
      :symlink ""
      :git {:unstaged ""
            :staged "✓"
            :unmerged ""
            :renamed "➜"
            :deleted ""
            :untracked :U
            :ignored "◌"}
      :folder {:default ""
               :open ""
               :empty ""
               :empty_open ""
               :symlink ""}})

(local tree-cb (. (require :nvim-tree.config) :nvim_tree_callback))
(set vim.g.nvim_tree_bindings
       [{:key [";" :<CR> :o]
         :cb (tree-cb :edit)}
        {:key :l
         :cb (tree-cb :close_node)}
        {:key :v
         :cb (tree-cb :vsplit)}])

(wk.register {:e [":NvimTreeToggle<CR>" "Explorer"]} {:mode :n
                                                      :prefix :<leader>})
