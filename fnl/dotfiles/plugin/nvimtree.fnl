(require-macros :zest.macros)
(module dotfiles.plugin.nvimtree
  {autoload {nvim aniseed.nvim
             nvimtree nvim-tree}})

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
