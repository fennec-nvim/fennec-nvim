(local {: autoload} (require :core.lib.autoload))
(local {: setup} (require :core.lib.setup))
(local {: register} (autoload :which-key))

(setup :which-key
       {:icons {:breadcrumb "»" :separator "->" :group "+"}
        :popup_mappings {:scroll_down :<c-d> :scroll_up :<c-u>}
        :window {:border :single
                 :position :bottom
                 :margin [1 1 1 1]
                 :padding [0 0 0 0]
                 :winblend 0}
        :layout {:height {:min 4 :max 25}
                 :width {:min 20 :max 50}
                 :spacing 3
                 :align :left}
        :hidden [:<silent> :<cmd> :<Cmd> :<CR> :call :lua "^:" "^ "]
        :triggers_blacklist {:i [:j :k] :v [:j :k]}
        :key_labels {:<space> :<SPC> :<tab> :<TAB>}})

;; rename groups to mimick doom

(register {:<leader><tab> {:name :+workspace}})
(register {:<leader>a {:name :+actions}})
(register {:<leader>b {:name :+buffers}})
(register {:<leader>c {:name :+code}})
(register {:<leader>cl {:name :+LSP}})
(register {:<leader>f {:name :+file}})
(register {:<leader>g {:name :+git}})
(register {:<leader>h {:name :+help}})
(register {:<leader>hn {:name :+nyoom}})
(register {:<leader>i {:name :+insert}})
(register {:<leader>n {:name :+notes}})
(register {:<leader>o {:name :+open}})
(register {:<leader>oa {:name :+agenda}})
(register {:<leader>p {:name :+project}})
(register {:<leader>q {:name :+quit/session}})
(register {:<leader>r {:name :+remote}})
(register {:<leader>s {:name :+search}})
(register {:<leader>t {:name :+toggle}})
(register {:<leader>w {:name :+window}})
(register {:<leader>m {:name :+localleader}})
(register {:<leader>d {:name :+debug}})
(register {:<leader>v {:name :+visual}})
