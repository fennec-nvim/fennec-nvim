(import-macros {: use-package!
                : unpack!
                : fennec!
                : fennec-init-modules!
                : fennec-compile-modules!} :macros)

;; Core packages
(use-package! :folke/lazy.nvim
              {:opts {:defaults {:lazy true}}
               :config (fn [_ opts]
                         (local lazy (require :lazy))
                         (lazy.setup opts))})

(use-package! :rktjmp/hotpot.nvim
              {:config (fn []
                         (require :modules.editor.hotpot.config))})

;; libraries
(use-package! :nvim-lua/plenary.nvim)
(use-package! :MunifTanjim/nui.nvim)

;; Include modules
;; (include :test.fnl)
;; (fennec! :tools eval)
;; (fennec-init-modules!)
;; (include :modules.tools.pastebin)
;; (use-package! :rktjmp/paperplanes.nvim)

;; colorschemes
(use-package! :luisiacc/gruvbox-baby
              {:branch :main
               :config (fn []
                         (require :modules.ui.fennec.gruvbox))})

(use-package! :nyoom-engineering/oxocarbon.nvim)
(use-package! :fennec-nvim/fennec-themes {:dev true :lazy false})

; ╭──────────────────────────────────────────────────────────╮
; │                        :checkers                         │
; ╰──────────────────────────────────────────────────────────╯

; diagnostics
; ────────────────────────────────────────────────────────────
(use-package! :folke/trouble.nvim)
(use-package! :jose-elias-alvarez/null-ls.nvim
              {:config (fn []
                         (require :modules.checkers.diagnostics.config))})

; ╭──────────────────────────────────────────────────────────╮
; │                       :completion                        │
; ╰──────────────────────────────────────────────────────────╯

; cmp
; ────────────────────────────────────────────────────────────
;; TDOD: event when entering command mode?
(use-package! :hrsh7th/nvim-cmp
              {:event :InsertEnter
               :dependencies [:onsails/lspkind.nvim
                              :hrsh7th/cmp-path
                              :hrsh7th/cmp-buffer
                              :hrsh7th/cmp-cmdline
                              :hrsh7th/cmp-nvim-lsp
                              :hrsh7th/cmp-nvim-lsp-signature-help
                              :PaterJason/cmp-conjure
                              :saadparwaiz1/cmp_luasnip
                              :rafamadriz/friendly-snippets
                              :L3MON4D3/LuaSnip]
               :config (fn []
                         (require :modules.completion.cmp.config))})

; smartparens
; ────────────────────────────────────────────────────────────
(use-package! :monkoose/matchparen.nvim)
(use-package! :windwp/nvim-autopairs
              {:config (fn []
                         (require :modules.completion.smartparens.config))})

; telescope
; ────────────────────────────────────────────────────────────
(use-package! :nvim-telescope/telescope-fzf-native.nvim {:build :make})
(use-package! :nvim-telescope/telescope.nvim
              {:event :VeryLazy
               :dependencies [:nvim-telescope/telescope-ui-select.nvim
                              :nvim-telescope/telescope-file-browser.nvim
                              :nvim-telescope/telescope-project.nvim
                              :LukasPietzschmann/telescope-tabs
                              :jvgrootveld/telescope-zoxide]
               :config (fn []
                         (require :modules.completion.telescope.config))})

; ╭──────────────────────────────────────────────────────────╮
; │                         :config                          │
; ╰──────────────────────────────────────────────────────────╯

; bindings
; ────────────────────────────────────────────────────────────
;; ( +which-key )
(use-package! :folke/which-key.nvim
              {:config (lambda []
                         (require :modules.config.which-key.config))})

;; legendary.nvim
(use-package! :mrjones2014/legendary.nvim
              {:config (lambda []
                         (require :modules.config.bindings.legendary))})

;; window-resize
(use-package! :mrjones2014/smart-splits.nvim
              {:config (lambda []
                         (require :modules.config.bindings.window-resize))})

;; window-movement
(use-package! :declancm/windex.nvim
              {:event :BufReadPost
               :config (lambda []
                         (require :modules.config.bindings.window-movement))})

;; window-shift
(use-package! :sindrets/winshift.nvim
              {:event :BufReadPost
               :config (lambda []
                         (require :modules.config.bindings.window-shift))})

;; close-buffers
(use-package! :kazhala/close-buffers.nvim
              {:event :BufReadPost
               :config (lambda []
                         (require :modules.config.bindings.close-buffers))})

;; jump-buffers
(use-package! :kwkarlwang/bufjump.nvim
              {:event :BufReadPost
               :config (lambda []
                         (require :modules.config.bindings.jump-buffers))})

;; leap
(use-package! :ggandor/flit.nvim)
(use-package! :ggandor/leap-ast.nvim)
(use-package! :tpope/vim-repeat)
(use-package! :ggandor/leap.nvim
              {:config (lambda []
                         (require :modules.config.bindings.leap))})

;; comment
(use-package! :LudoPinelli/comment-box.nvim)
(use-package! :numToStr/Comment.nvim
              {:config (lambda []
                         (require :modules.config.bindings.comment))})

;; yank-ring
(use-package! :gbprod/yanky.nvim
              {:event :BufReadPost
               :config (lambda []
                         (require :modules.config.bindings.yank))})

;; surround
(use-package! :kylechui/nvim-surround
              {:config (lambda []
                         (require :modules.config.bindings.surround))})

;; split-join
(use-package! :Wansmer/treesj
              {:keys [:J]
               :config (lambda []
                         (require :modules.config.bindings.split-join))})

;; (require :modules.config.bindings.config)

; default
; ────────────────────────────────────────────────────────────
;; text-case.nvim
;; neogen

(require :modules.config.default.config)

; ╭──────────────────────────────────────────────────────────╮
; │                         :editor                          │
; ╰──────────────────────────────────────────────────────────╯

; parinfer
; ────────────────────────────────────────────────────────────
(use-package! :eraserhd/parinfer-rust
              {:build "cargo build --release"
               :ft [:fennel :clojure :lisp :racket :scheme]})

(use-package! :harrygallagher4/nvim-parinfer-rust
              {:ft [:fennel :clojure :lisp :racket :scheme]})

; ╭──────────────────────────────────────────────────────────╮
; │                         :neovim                          │
; ╰──────────────────────────────────────────────────────────╯

; file-manager
; ────────────────────────────────────────────────────────────
(use-package! :is0n/fm-nvim
              {:config (fn []
                         (require :modules.neovim.file-manager.config))})

; ╭──────────────────────────────────────────────────────────╮
; │                          :lang                           │
; ╰──────────────────────────────────────────────────────────╯

; org
; ────────────────────────────────────────────────────────────
(use-package! :akinsho/org-bullets.nvim {:ft [:org]})
(use-package! :lukas-reineke/headlines.nvim {:ft [:org]})
(use-package! :nvim-orgmode/orgmode
              {:ft [:org]
               :config (fn []
                         (require :modules.lang.org.config))})

; ╭──────────────────────────────────────────────────────────╮
; │                          :tools                          │
; ╰──────────────────────────────────────────────────────────╯

;eval
; ────────────────────────────────────────────────────────────
(use-package! :Olical/conjure {:config (fn []
                                         (require :modules.tools.eval.config))
                               :branch :develop})

; lsp
; ────────────────────────────────────────────────────────────
(use-package! :williamboman/mason.nvim
              {:cmd [:Mason :MasonLog]
               :config (fn []
                         (require :modules.tools.mason.config))})

(use-package! :williamboman/mason-lspconfig.nvim)
(use-package! :smjonas/inc-rename.nvim {:cmd [:IncRename]})
(use-package! :folke/neodev.nvim)
(use-package! :petertriho/nvim-scrollbar)
(use-package! :neovim/nvim-lspconfig
              {:config (fn []
                         (require :modules.tools.lsp.config))
               :defer nvim-lspconfig})

; neogit
; ────────────────────────────────────────────────────────────
(use-package! :TimUntersberger/neogit
              {:config (fn []
                         (require :modules.tools.neogit.config))
               :cmd [:Neogit]})

; rgb
; ────────────────────────────────────────────────────────────
(use-package! :uga-rosa/ccc.nvim
              {:config (fn []
                         (require :modules.tools.rgb.config))})

; tree-sitter
; ────────────────────────────────────────────────────────────
(use-package! :nvim-treesitter/playground {:cmd [:TSPlayground]})
(use-package! :p00f/nvim-ts-rainbow)
(use-package! :nvim-treesitter/nvim-treesitter-textobjects)
(use-package! :nvim-treesitter/nvim-treesitter
              {:config (fn []
                         (require :modules.tools.tree-sitter.config))})

; ╭──────────────────────────────────────────────────────────╮
; │                           :ui                            │
; ╰──────────────────────────────────────────────────────────╯

; context ; to not get lost in your spaghetti code, but sticky
; ────────────────────────────────────────────────────────────
(use-package! :nvim-treesitter/nvim-treesitter-context {:event :BufReadPre})

; dashboard ; a nifty splash screen for Neovim
; ────────────────────────────────────────────────────────────
(use-package! :goolord/alpha-nvim
              {:config (fn []
                         (require :modules.ui.dashboard.config))})

; fennec ; what makes fennec look the way it does
; ────────────────────────────────────────────────────────────
(use-package! :mvllow/modes.nvim {:lazy true})
(use-package! :DaikyXendo/nvim-material-icon)
(use-package! :nvim-tree/nvim-web-devicons
              {:config (fn []
                         (require :modules.ui.fennec.config))})

; indent-guides ; highlight indent columns
; ────────────────────────────────────────────────────────────
(use-package! :echasnovski/mini.indentscope
              {:event :BufReadPre
               :branch :stable
               :config (fn []
                         (require :modules.ui.indent-guides.config))})

; modeline ; snazzy, Doom Emacs inspired modeline
; ────────────────────────────────────────────────────────────
(use-package! :nvim-lualine/lualine.nvim
              {:event :VeryLazy
               :config (fn []
                         (require :modules.ui.modeline.config))})

;; TODO: fold noice module into fennec module
; noice
; ────────────────────────────────────────────────────────────
;; (use-package! :rcarriga/nvim-notify)
(use-package! :folke/noice.nvim
              {:event :VeryLazy
               :config (fn []
                         (require :modules.ui.noice.config))})

; vc-gutter ; vcs diff in the fringe
; ────────────────────────────────────────────────────────────
(use-package! :lewis6991/gitsigns.nvim
              {:event :BufReadPre
               :config (fn []
                         (require :modules.ui.vc-gutter.config))})

(unpack!)

;; (fennec-compile-modules!)
