(require-macros :zest.macros)
(module dotfiles.plugin.nvimtree
  {autoload {nvim aniseed.nvim
             nvimtree-config nvim-tree.config}})

(let [tree_cb nvimtree-config.nvim_tree_callback]
   (g- nvim_tree_bindings {:l (tree_cb "close_node")
                           ";" (tree_cb "edit")}))

(g- nvim_tree_icons {:default ""
                     :symlink ""
                     :git {:unstaged ""
                           :staged "✓"
                           :unmerged ""
                           :renamed "➜"
                           :untracked ""}
                     :folder {:default ""
                              :open ""
                              :empty ""
                              :empty_open ""
                              :symlink ""}})
