(import-macros {: set! : augroup! : autocmd! : clear! : map! : let!} :macros)
(local {: setup} (require :core.lib.setup))

(setup :comment-box)

;; TODO: figure out why I need to (let mapleader " ") when I've already done it in config.fnl
(let! mapleader " ")

(map! [nv] :<leader>Cj :<cmd>CBlbox<cr> {:desc "Comment left aligned box"})
(map! [nv] :<leader>CJ :<cmd>CBalbox<cr>
      {:desc "Comment adapted left aligned box"})

(map! [nv] :<leader>Ck :<cmd>CBcbox<cr> {:desc "Comment centered box"})
(map! [nv] :<leader>CK :<cmd>CBacbox<cr> {:desc "Comment adapted centered box"})
(map! [n] :<leader>Cl :<cmd>CBline<cr> {:desc "Comment left aligned line"})

(setup :Comment {:padding true
                 :sticky true
                 :ignore "^$"
                 :mappings {:basic true :extra true}
                 :toggler {:line :gcc :block :gbc}
                 :opleader {:line :gc :block :gb}
                 :extra {:above :gcO :below :gco :eol :gcA}})

(map! [n] :<leader>Ca
      "<cmd>lua require('Comment.api').insert.linewise.eol()<cr>"
      {:desc "comment end of line"})

(map! [n] :<leader>Cb
      "<cmd>lua require('Comment.api').toggle.blockwise.current()<cr>"
      {:desc "comment block"})

(map! [n] :<leader>Cc
      "<cmd>lua require('Comment.api').toggle.linewise.current()<cr>"
      {:desc "comment line"})

(map! [n] :<leader>Co
      "<cmd>lua require('Comment.api').insert.linewise.below()<cr>"
      {:desc "comment below"})

(map! [n] :<leader>CO
      "<cmd>lua require('Comment.api').insert.linewise.above()<cr>"
      {:desc "comment above"})

(map! [v] :<leader>Cc
      "<ESC><CMD>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>"
      {:desc "visual comment line"})

(map! [v] :<leader>Cb
      "<ESC><CMD>lua require('Comment.api').toggle.blockwise(vim.fn.visualmode())<cr>"
      {:desc "visual comment block"})
