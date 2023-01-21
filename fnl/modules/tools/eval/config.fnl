(import-macros {: let! : map!} :macros)

(let! conjure#mapping#doc_word false)
(let! conjure#extract#tree_sitter#enabled true)

;; TODO: figure out why I need to (let mapleader " ") when I've already done it in config.fnl
(let! mapleader " ")

(map! [n] "<leader>;" :<cmd>ConjureEvalCurrentForm<cr>
      {:desc "Eval expression"})

(map! [v] "<leader>;" :<cmd>ConjureEval<cr> {:desc "Eval region"})

(map! [n] :<leader>ee :<cmd>ConjureEval<cr> {:desc "Eval expression"})
(map! [n] :<leader>er :<cmd>ConjureEvalRootForm<cr> {:desc "Eval root form"})
(map! [v] :<leader>ee :<cmd>ConjureEval<cr> {:desc "Eval region"})
(map! [nv] :<leader>eb :<cmd>ConjureEvalBuf<cr> {:desc "Eval buffer"})
