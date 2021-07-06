(module plugin
  {autoload {nvim aniseed.nvim
             a aniseed.core
             util util
             packer packer}})

; TODO: require the configs inside packer instead (make sure no more :mod keys are required to safely delete this function)
(defn safe-require-plugin-config [name]
  (let [(ok? val-or-err) (pcall require (.. :plugin. name))]
    (when (not ok?)
      (print (.. "dotfiles error: " val-or-err)))))

(defn- use [...]
  "Iterates through the arguments as pairs and calls packer's use function for
  each of them. Works around Fennel not liking mixed associative and sequential
  tables as well."
  (let [pkgs [...]]
    (packer.startup
      (fn [use]
        (for [i 1 (a.count pkgs) 2]
          (let [name (. pkgs i)
                opts (. pkgs (+ i 1))]
            (-?> (. opts :mod) (safe-require-plugin-config))
            (use (a.assoc opts 1 name))))))))

; TODO: lazyload everything. do the local M = {}, require"foo".config() trick for every file.
(defn- req [name]
  "A shortcut to building a require string for your plugin
  configuration. Intended for use with packer's config or setup
  configuration options. Will prefix the name with `plugin.`
  before requiring."
  (.. "require('plugin." name "')"))

(var disable-modules {:completion true
                      :ui true
                      :telescope true
                      :comment true
                      :git true
                      :checkers true
                      :lsp true
                      :format true
                      :snippets true
                      :terminal true
                      :debug true
                      :motion true
                      :sessions true
                      :notes true
                      :lisps true})

(defn- set-modules [modules]
  (each [index value (ipairs modules)]
    (tset disable-modules value false)))

(set-modules fennec.modules)

;; Plugins to be managed by packer.
(use
  ;; -----[[------------]]-----
  ;; ---        Core        ---
  ;; -----]]------------[[-----
  :wbthomason/packer.nvim {}
  :Olical/aniseed {:branch :develop}

  ;; -----[[------------]]-----
  ;; ---      Comments      ---
  ;; -----]]------------[[-----
  :terrortylor/nvim-comment {; :cmd :CommentToggle
                             :disable (. disable-modules :comment)
                             :config (req :comment)}
  ; TODO make this optional
  :folke/todo-comments.nvim {; :event :BufRead
                             :disable (. disable-modules :comment)
                             :config (req :todo-comments)}

  ;; -----[[------------]]-----
  ;; ---     Completion     ---
  ;; -----]]------------[[-----
  :jiangmiao/auto-pairs {; :event :InsertEnter
                         ; :after [:telescope.nvim :nvim-compe]
                         :disable (. disable-modules :completion)
                         :config (req :auto-pairs)}

  :hrsh7th/nvim-compe {; :event :InsertEnter
                       :disable (. disable-modules :completion)
                       :config (req :compe)}
  ; TODO make optional
  ; :tzachar/compe-tabnine {:run :./install.sh
  ;                         :requires :hrsh7th/nvim-compe}

  :tami5/compe-conjure {}

  ;; -----[[------------]]-----
  ;; ---         UI         ---
  ;; -----]]------------[[-----
  :folke/which-key.nvim {:disable (. disable-modules :ui)
                         :config (req :which-key)}

  :ChristianChiarulli/dashboard-nvim {:event :BufWinEnter
                                      :cmd [:Dashboard :DashboardNewFile :DashboardJumpMarks]
                                      :disable (. disable-modules :ui)
                                      :config (req :dashboard)}

  :kyazdani42/nvim-web-devicons {:disable (. disable-modules :ui)}

  :kyazdani42/nvim-tree.lua {:disable (. disable-modules :ui)
                             :config (req :tree)}

  :glepnir/galaxyline.nvim {:disable (. disable-modules :ui)
                            :config (req :galaxyline)}

  ; :romgrk/barbar.nvim {:disable (. disable-modules :ui)
  ;                      :config (req :barbar)}

  :norcalli/nvim-colorizer.lua {:disable (. disable-modules :ui)
                                :config (req :colorizer)}

  :rktjmp/lush.nvim {:disable (. disable-modules :ui)}
  :npxbr/gruvbox.nvim {}
  :srcery-colors/srcery-vim {:mod :srcery}

  ; :karb94/neoscroll.nvim {:disable (. disable-modules :ui)
  ;                         :config (req :neoscroll)}

  ;; -----[[------------]]-----
  ;; ---      Telescope     ---
  ;; -----]]------------[[-----
  :nvim-lua/popup.nvim {}
  :nvim-lua/plenary.nvim {}
  :nvim-telescope/telescope.nvim {:cmd :Telescope
                                  :disable (. disable-modules :telescope)
                                  :config (req :telescope)}

  :nvim-telescope/telescope-fzy-native.nvim {:event :BufRead
                                             :disable (. disable-modules :telescope)}

  :nvim-telescope/telescope-project.nvim {:event :BufRead
                                          :after :telescope.nvim
                                          :disable (. disable-modules :telescope)}
  ;; -----[[------------]]-----
  ;; ---      Checkers      ---
  ;; -----]]------------[[-----
  ; TODO: snipe some more treesitter configs from LunarVim
  :nvim-treesitter/nvim-treesitter {:disable (. disable-modules :checkers)
                                    :config (req :treesitter)
                                    :run ":TSUpdate"}
  ; :romgrk/nvim-treesitter-context {}
  ; :lewis6991/spellsitter.nvim

  ;; -----[[------------]]-----
  ;; ---         Git        ---
  ;; -----]]------------[[-----
  :airblade/vim-gitgutter {}
  :tpope/vim-fugitive {:mod :fugitive}
  ; :lewis6991/gitsigns.nvim {}
  ; :f-person/git-blame.nvim {}
  ; :ruifm/gitlinker.nvim {}
  ; :TimUntersberger/neogit {}
  ; :pwntester/octo.nvim {}
  ; :sindrets/diffview.nvim {}
  ; :mattn/vim-gist {}
  ; :kdheepak/lazygit.nvim {}


  ;; -----[[------------]]-----
  ;; ---         LSP        ---
  ;; -----]]------------[[-----
  ; :neovim/nvim-lspconfig {}
  ; :kabouzeid/nvim-lspinstall {}
  ; :tjdevries/astronauta.nvim {}
  ; :folke/trouble.nvim {}
  ; :ahmedkhalf/lsp-rooter.nvim {}
  ; :ray-x/navigator.lua {}
  ; :ray-x/guihua.lua {}
  ; :ray-x/lsp_signature.nvim {}
  ; :simrat39/symbols-outline.nvim {}
  :w0rp/ale {:mod :ale}

  ;; -----[[------------]]-----
  ;; ---       Format       ---
  ;; -----]]------------[[-----
  ; :sbdchd/neoformat {}
  ; :mhartington/formatter.nvim {}

  ;; -----[[------------]]-----
  ;; ---      Snippets      ---
  ;; -----]]------------[[-----
  ; :hrsh7th/vim-vsnip {:event "InsertEnter" }
  ; :rafamadriz/friendly-snippets {:event "InsertEnter" }

  ;; -----[[------------]]-----
  ;; ---      Terminal      ---
  ;; -----]]------------[[-----
  ; :numToStr/Navigator.nvim {}
  ; :akinsho/nvim-toggleterm.lua {}
  :tpope/vim-eunuch {}

  ;; -----[[------------]]-----
  ;; ---        Debug       ---
  ;; -----]]------------[[-----
  ; :mfussenegger/nvim-dap {}
  ; :rcarriga/nvim-dap-ui {}
  ; :Pocco81/DAPInstall.nvim {}

  ;; -----[[------------]]-----
  ;; ---       Motion       ---
  ;; -----]]------------[[-----
  ; :chaoren/vim-wordmotion {}
  ; :mg979/vim-visual-multi {}
  ; :ggandor/lightspeed.nvim {}
  ; :blackCauldron7/surround.nvim {}
  ; :mizlan/iswap.nvim {}
  :PeterRincker/vim-argumentative {}

  ;; -----[[------------]]-----
  ;; ---      Sessions      ---
  ;; -----]]------------[[-----
  ; :rmagatti/auto-session {}
  ; :rmagatti/session-lens {}

  ;; -----[[------------]]-----
  ;; ---        Notes       ---
  ;; -----]]------------[[-----
  ; :vimwiki/vimwiki {:branch :dev}
  ; :plasticboy/vim-markdown {}

  ;; -----[[------------]]-----
  ;; ---        Lisps       ---
  ;; -----]]------------[[-----
  :Olical/conjure {:branch :develop :mod :conjure}
  :Olical/nvim-local-fennel {}
  :clojure-vim/clojure.vim {}
  :clojure-vim/vim-jack-in {}
  :guns/vim-sexp {:mod :sexp}
  :hylang/vim-hy {}
  :janet-lang/janet.vim {}
  :tpope/vim-dispatch {}
  :radenling/vim-dispatch-neovim {}
  :tpope/vim-sexp-mappings-for-regular-people {}
  :wlangstroth/vim-racket {}

  ;; -----[[------------]]-----
  ;; ---        Extras      ---
  ;; -----]]------------[[-----
  ; :mbbill/undotree {:mod :undotree}
  ; :tweekmonster/startuptime.vim {}
  )
