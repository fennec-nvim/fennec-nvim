(import-macros {: let! : set!} :macros)

;; add mason binaries
(set vim.env.PATH (.. vim.env.PATH ":" (vim.fn.stdpath :data) :/mason/bin))
(set vim.env.PATH (.. vim.env.PATH ":" (vim.fn.stdpath :config) :/bin))

(set! updatetime 250)
;; time to wait for a mapped sequence to complete (in milliseconds)
(set! timeoutlen 400)
;; visual options
(set! conceallevel 2)
(set! shortmess+ :sWcI)
(set! signcolumn "yes:1")
(set! formatoptions [:q :j])
;; display lines as one long line
(set! nowrap)
;; forces all vertical splits to go to the right of current window
(set! splitright)
;; forces  all horizontal splits to go below current window
(set! splitbelow)
;; insert 4 spaces for a tab
(set! tabstop 4)
(set! softtabstop 4)
;; the number of spaces inserted for each indentation
(set! shiftwidth 4)
;; convert tabs to spaces
(set! expandtab)
;; allows neovim to access the system clipboard
(set! clipboard :unnamedplus)
;; allow the mouse to be used in neovim
(set! mouse :a)
;; enable persistent undo
(set! undofile)
;; if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
(set! nowritebackup)
;; don't create swapfiles
(set! noswapfile)
;; smart search case
(set! ignorecase)
(set! smartcase)
(set! gdefault)
;; highlight all matches on previous search pattern
(set! hlsearch)
;; better grep
(set! grepprg "rg --vimgrep")
(set! grepformat "%f:%l:%c:%m")
(set! path ["." "**"])
;; popup menu height
(set! pumheight 10)
;; set number column width to 2 {default 4}
(set! numberwidth 2)

;; gui options
(set! list)
(set! fillchars {:eob " "
                 ;; :vert " "
                 ;; :horiz " "
                 :diff "╱"
                 :foldclose ""
                 :foldopen ""
                 :fold " "
                 :msgsep "─"})

(set! listchars {:trail "·"
                 :nbsp "␣"
                 :tab " ──"
                 ;; :tab "  "
                 ;; :eol ""
                 :precedes "«"
                 :extends "»"})

;; minimal number of screen lines to keep above current and below the cursor
(set! scrolloff 8)
;; minimal number of screen lines to keep left and right of the cursor
(set! sidescrolloff 8)
(set! guifont "Liga SFMono Nerd Font:h14")
(let! neovide_padding_top 45)
(let! neovide_padding_left 38)
(let! neovide_padding_right 38)
(let! neovide_padding_bottom 20)

(require :packages)
(require :config)

;; nightly only options
;; (set! diffopt+ "linematch:60")
;; (set! splitkeep :screen)

;; required to keep multiple buffers and open multiple buffers
;; (set! hidden)
