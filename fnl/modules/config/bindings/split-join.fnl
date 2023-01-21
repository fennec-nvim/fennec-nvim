(import-macros {: map! : let! : autocmd!} :macros)
(local {: autoload} (require :core.lib.autoload))
(local {: setup} (require :core.lib.setup))
(local treesj-langs (autoload :treesj.langs))

(setup :treesj {:use_default_keymaps false})

(local langs (. (require :treesj.langs) :presets))
(autocmd! FileType *
          `(when (. langs vim.bo.filetype)
             (map! [n] :J :<cmd>TSJToggle<cr>
                   {:buffer true :desc "Join toggle"})))
