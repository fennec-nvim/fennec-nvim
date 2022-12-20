(import-macros {: use-package!
                : unpack!
                : fennec-init-modules!
                : fennec-compile-modules!} :macros)

;; Core packages
(use-package! :folke/lazy.nvim)
(use-package! :rktjmp/hotpot.nvim
              {:config (fn []
                         (require :modules.editor.hotpot.config))})

;; libraries
(use-package! :nvim-lua/plenary.nvim)
(use-package! :MunifTanjim/nui.nvim)

;; colorschemes
(use-package! :luisiacc/gruvbox-baby {:branch :main})
(use-package! :nyoom-engineering/oxocarbon.nvim)

;; Include modules
;; (include :fnl.modules)
;; (fennec-init-modules!)

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
(use-package! :onsails/lspkind.nvim)
(use-package! :hrsh7th/cmp-path)
(use-package! :hrsh7th/cmp-buffer)
(use-package! :hrsh7th/cmp-cmdline)
(use-package! :hrsh7th/cmp-nvim-lsp)
(use-package! :hrsh7th/cmp-nvim-lsp-signature-help)
(use-package! :PaterJason/cmp-conjure)
(use-package! :saadparwaiz1/cmp_luasnip)
(use-package! :rafamadriz/friendly-snippets)
(use-package! :L3MON4D3/LuaSnip)
(use-package! :hrsh7th/nvim-cmp
              {:config (fn []
                         (require :modules.completion.cmp.config))})

; ╭──────────────────────────────────────────────────────────╮
; │                         :config                          │
; ╰──────────────────────────────────────────────────────────╯

; default
; ────────────────────────────────────────────────────────────
(require :modules.config.default.config)

; smartparens
; ────────────────────────────────────────────────────────────
(use-package! :monkoose/matchparen.nvim)
(use-package! :windwp/nvim-autopairs
              {:config (fn []
                         (require :modules.completion.smartparens.config))})

; telescope
; ────────────────────────────────────────────────────────────
(use-package! :nvim-telescope/telescope-ui-select.nvim)
(use-package! :nvim-telescope/telescope-file-browser.nvim)
(use-package! :nvim-telescope/telescope-project.nvim)
(use-package! :LukasPietzschmann/telescope-tabs)
(use-package! :jvgrootveld/telescope-zoxide)
(use-package! :nvim-telescope/telescope-fzf-native.nvim {:build :make})
(use-package! :nvim-telescope/telescope.nvim
              {:config (fn []
                         (require :modules.completion.telescope.config))})

; ╭──────────────────────────────────────────────────────────╮
; │                         :editor                          │
; ╰──────────────────────────────────────────────────────────╯

; parinfer
; ────────────────────────────────────────────────────────────
(use-package! :eraserhd/parinfer-rust {:build "cargo build --release"})
(use-package! :harrygallagher4/nvim-parinfer-rust)

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
(use-package! :j-hui/fidget.nvim)
(use-package! :neovim/nvim-lspconfig
              {:config (fn []
                         (require :modules.tools.lsp.config))
               :defer nvim-lspconfig})

; neogit
; ────────────────────────────────────────────────────────────
(use-package! :TimUntersberger/neogit
              {:config (fn []
                         (require :modules.tools.neogit.config))})

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

; dashboard
; ────────────────────────────────────────────────────────────
(use-package! :goolord/alpha-nvim
              {:config (fn []
                         (require :modules.ui.dashboard.config))})

; indent-guides
; ────────────────────────────────────────────────────────────
(use-package! :echasnovski/mini.indentscope
              {:branch :stable
               :config (fn []
                         (require :modules.ui.indent-guides.config))})

; modeline
; ────────────────────────────────────────────────────────────
;; TODO: use lualine for statusline instead
(use-package! :b0o/incline.nvim
              {:config (fn []
                         (require :modules.ui.modeline.config))})

; noice
; ────────────────────────────────────────────────────────────
(use-package! :rcarriga/nvim-notify)
(use-package! :folke/noice.nvim
              {:event CmdlineEnter
               :config (fn []
                         (require :modules.ui.noice.config))})

; fennec
; ────────────────────────────────────────────────────────────
(use-package! :mvllow/modes.nvim)
(use-package! :DaikyXendo/nvim-material-icon)
(use-package! :nvim-tree/nvim-web-devicons
              {:config (fn []
                         (require :modules.ui.fennec.config))})

; vc-gutter
; ────────────────────────────────────────────────────────────
(use-package! :lewis6991/gitsigns.nvim
              {:config (fn []
                         (require :modules.ui.vc-gutter.config))})

; which-key
; ────────────────────────────────────────────────────────────
(use-package! :folke/which-key.nvim
              {:config (fn []
                         (require :modules.ui.which-key.config))})

(unpack!)

;; (fennec-compile-modules!)
