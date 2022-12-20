(import-macros {: let! : map!} :macros)

(let! conjure#mapping#doc_word false)
(let! conjure#extract#tree_sitter#enabled true)

;; TODO: figure out why I need to (let mapleader " ") when I've already done it in config.fnl
(let! mapleader " ")
(map! [n] :<leader>ee :<cmd>ConjureEval<cr> {:desc "Evaluate expression"})
(map! [v] :<leader>ee :<cmd>ConjureEval<cr> {:desc "Evaluate region"})
(map! [nv] :<leader>eb :<cmd>ConjureEvalBuf<cr> {:desc "Evaluate buffer"})
