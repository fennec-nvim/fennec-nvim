(import-macros {: let! : set!} :macros)

;; add mason binaries

(set vim.env.PATH (.. vim.env.PATH ":" (vim.fn.stdpath :data) :/mason/bin))
(set vim.env.PATH (.. vim.env.PATH ":" (vim.fn.stdpath :config) :/bin))

(set! updatetime 250)
(set! timeoutlen 400)
;; visual options
(set! conceallevel 2)
(set! shortmess+ :sWcI)
(set! signcolumn "yes:1")
(set! formatoptions [:q :j])
(set! nowrap)
;; just good defaults
(set! splitright)
(set! splitbelow)
;; tab options
(set! tabstop 4)
(set! shiftwidth 4)
(set! softtabstop 4)
(set! expandtab)
;; clipboard and mouse
(set! clipboard :unnamedplus)
(set! mouse :a)
;; backups are annoying
(set! undofile)
(set! nowritebackup)
(set! noswapfile)
;; search and replace
(set! ignorecase)
(set! smartcase)
(set! gdefault)
;; better grep
(set! grepprg "rg --vimgrep")
(set! grepformat "%f:%l:%c:%m")
(set! path ["." "**"])
;; nightly only options
;; (set! diffopt+ "linematch:60")
;; (set! splitkeep :screen)
;; set cmp popup height
(set! pumheight 10)
;; numbers
(set! relativenumber)

;; gui options
(set! list)
(set! fillchars {:eob " "
                 :vert " "
                 :horiz " "
                 :diff "╱"
                 :foldclose ""
                 :foldopen ""
                 :fold " "
                 :msgsep "─"})

(set! listchars {:tab " ──"
                 :trail "·"
                 :nbsp "␣"
                 :precedes "«"
                 :extends "»"})
                 ;; :eol ""})

(set! scrolloff 4)
(set! guifont "Liga SFMono Nerd Font:h14")
(let! neovide_padding_top 45)
(let! neovide_padding_left 38)
(let! neovide_padding_right 38)
(let! neovide_padding_bottom 20)

(require :packages)
(require :config)
