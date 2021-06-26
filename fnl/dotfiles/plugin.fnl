(module dotfiles.plugin
  {autoload {nvim aniseed.nvim
             a aniseed.core
             util dotfiles.util
             packer packer}})

(defn safe-require-plugin-config [name]
  (let [(ok? val-or-err) (pcall require (.. :dotfiles.plugin. name))]
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

; TODO refactor this disable_modules business to be neater
; initially everything is disabled
(var disable_modules {:lightspeed true
                      :lsp true
                      :treesitter true
                      :autocomplete true
                      :snippets true
                      :explorer true
                      :commands true
                      :comments true
                      :telescope true
                      :ui true
                      :git true
                      :terminal true
                      :debug true
                      :notes true
                      :jupyter true
                      :lisps true
                      :sessions true
                      :color true })

;; func to ennable modules from (fennec.modules)
(defn- set-modules [modules]
  (each [index value (ipairs modules)]
    (tset disable_modules value false)))

(set-modules fennec.modules)

;; Plugins to be managed by packer.
(use
  ;; TODO make these into modules
  ;; -----[[------------]]-----
  ;; ---     Essentials     ---
  ;; -----]]------------[[-----
  :wbthomason/packer.nvim {}
  :Olical/aniseed {:branch :develop}

  ;; -----[[------------]]-----
  ;; ---        LSP         ---
  ;; -----]]------------[[-----
  :kabouzeid/nvim-lspinstall { :opt true }
  :neovim/nvim-lspconfig { :opt true }
  :folke/trouble.nvim { :opt true}
  ; :glepnir/lspsaga.nvim { :opt true }
  ; :simrat39/symbols-outline.nvim { :opt true }
  ; TODO only works if you add require"lsp_signature".on_attach() to an lsp config you want it to appear in
  ; :ray-x/lsp_signature.nvim {:opt true}
  ; TODO replace vim-argumentative with iswap
  ; :mizlan/iswap.nvim
  :PeterRincker/vim-argumentative {:disable (. disable_modules :lsp)} ;; manipulate and move function arguments
  ; TODO: try use navigator to replace a lot of lspsaga functionality?
  ; :ray-x/navigator.lua {}
  ; :bmatcuk/stylelint-lsp {}
  ; :rmagatti/goto-preview {}
  ; :manicmaniac/coconut.vim {}

  ;; -----[[------------]]-----
  ;; ---     Telescope      ---
  ;; -----]]------------[[-----
  ; :nvim-lua/popup.nvim {:opt true :disable (. disable_modules :telescope)}
  :nvim-lua/plenary.nvim {}
  ; :nvim-telescope/telescope.nvim {}
  ; :nvim-telescope/telescope-project.nvim {}
  ; :nvim-telescope/telescope-fzy-native.nvim {}

  ;; -----[[------------]]-----
  ;; ---     Debugging      ---
  ;; -----]]------------[[-----
  ; :mfussenegger/nvim-dap {}
  ; :nvim-telescope/telescope-dap.nvim {}
  ; :theHamsta/nvim-dap-virtual-text {}
  ; :Pocco81/DAPInstall.nvim {}
  ; :rcarriga/nvim-dap-ui {}

  ;; -----[[------------]]-----
  ;; ---     Autocomplete   ---
  ;; -----]]------------[[-----
  :hrsh7th/nvim-compe {:mod :compe}
  :tami5/compe-conjure {}
  ; :hrsh7th/vim-vsnip {}
  ; TODO replace jiangmiao/auto-pairs with windwp/nvim-autopairs
  ; :windwp/nvim-autopairs {}
  :jiangmiao/auto-pairs {:mod :auto-pairs}
  ; :rafamadriz/friendly-snippets {}

  ;; -----[[------------]]-----
  ;; ---     Treesitter     ---
  ;; -----]]------------[[-----
  :nvim-treesitter/nvim-treesitter {:run ":TSUpdate" :mod :treesitter}
  ; :windwp/nvim-ts-autotag {}
  ; :andymass/vim-matchup {}
  ; :lukas-reineke/indent-blankline.nvim {:brach :lua}

  ;; -----[[-------------]]-----
  ;; ---    Code Editing     ---
  ;; -----]]-------------[[-----
  ; :Pocco81/TrueZen.nvim {}
  ; :kevinhwang91/nvim-bqf {}
  ; :chaoren/vim-wordmotion {}
  ; :mg979/vim-visual-multi {}
  ; TODO replace vim-easymotion with lightspeed
  :ggandor/lightspeed.nvim {:disable (. disable_modules :lightspeed)}
  :easymotion/vim-easymotion {:mod :easymotion}
  ; TODO spectre doesn't seem to work
  ; use {'windwp/nvim-spectre', requires = {"nvim-lua/plenary.nvim", "nvim-lua/popup.nvim"}, opt = true}
  ; TODO is blackCauldron7/surround.nvim better than tpope vim-surround
  ;; :blackCauldron7/surround.nvim {}
  :tpope/vim-surround {}
  ;; :kevinhwang91/nvim-hlslens {}

  ;; -----[[-------------]]-----
  ;; ---        Notes        ---
  ;; -----]]-------------[[-----
  ; use {'iamcco/markdown-preview.nvim', run = 'cd app && npm install', opt = true}
  ; :vimwiki/vimwiki' {:branch :deb}
  ; :plasticboy/vim-markdown {}
  ;; :shurcooL/markdownfmt {}
  ;; :jbyuki/nabla.nvim {}
  ;; :lewis6991/spellsitter.nvim {}
  ;; :ferrine/md-img-paste.vim {}
  ; TODO add telescope support when merged to main
  ; TODO create mapping for zk.create_note_link that works for my jupyter group
  ;; :megalithic/zk.nvim {}
  ; NOTE: check if it has adequate link creation and following
  ;; :lervag/wiki.vim {}

  ;;-----[[------------]]-----
  ;;---      Terminal      ---
  ;;-----]]------------[[-----
  ;;use {'numToStr/FTerm.nvim', opt = true}
  ;;use {"numToStr/Navigator.nvim", opt = true}
  ;;-- TODO maybe replace FTerm with nvim-toggleterm
  ;;use {"akinsho/nvim-toggleterm.lua", opt = true}
  ;;-- use {"nikvdp/neomux", opt = true}

  ;;-----[[------------]]-----
  ;;---       Jupyter      ---
  ;;-----]]------------[[-----
  ;;use {"hkupty/iron.nvim"}
  ;;use {"GCBallesteros/jupytext.vim"}
  ;;use {"kana/vim-textobj-user"}
  ;;use {"kana/vim-textobj-line"}
  ;;use {'GCBallesteros/vim-textobj-hydrogen'}

  ;;-----[[------------]]-----
  ;;---        Lisps       ---
  ;;-----]]------------[[-----
  :Olical/conjure {:branch :develop :mod :conjure :disable (. disable_modules :lisps)}
  :clojure-vim/clojure.vim {:disable (. disable_modules :lisps)}
  :clojure-vim/vim-jack-in {:disable (. disable_modules :lisps)}
  :hylang/vim-hy {:disable (. disable_modules :lisps)}
  :Olical/nvim-local-fennel {:disable (. disable_modules :lisps)} ;; Run Fennel inside Neovim on startup with Aniseed
  :janet-lang/janet.vim {:disable (. disable_modules :lisps)}
  :wlangstroth/vim-racket {:disable (. disable_modules :lisps)}
  :guns/vim-sexp {:mod :sexp :disable (. disable_modules :lisps)}
  :tpope/vim-sexp-mappings-for-regular-people {:disable (. disable_modules :lisps)}

  ;;-----[[------------]]-----
  ;;---      Explorer      ---
  ;;-----]]------------[[-----
  :kyazdani42/nvim-tree.lua {:mod :nvimtree :disable (. disable_modules :explorer)}
  :ahmedkhalf/lsp-rooter.nvim {:opt true :disable (. disable_modules :explorer)} ; with this nvim-tree will follow you
  ;;-- TODO remove when open on dir is supported by nvimtree
  ;;-- TODO make rnvimr optional
  ;;use "kevinhwang91/rnvimr"
  ;;-- use {"jvgrootveld/telescope-zoxide"}

  ;;-----[[--------]]-----
  ;;---      Git       ---
  ;;-----]]--------[[-----
  ;; TODO replace vim-gitgutter with gitsigns
  ;;use {"lewis6991/gitsigns.nvim", opt = true}
  :airblade/vim-gitgutter {:disable (. disable_modules :git)}
  :tpope/vim-fugitive {:mod :fugitive :disable (. disable_modules :git)}
  ;;-- use {'tpope/vim-rhubarb', opt = true}
  ;;-- use {"pwntester/octo.nvim", opt = true}
  :TimUntersberger/neogit {:disable (. disable_modules :git)}
  ;;-- use {'mattn/vim-gist', opt = true}
  ;;-- use {"ThePrimeagen/git-worktree.nvim"}

  ;;-----[[------------]]-----
  ;;---      Commands      ---
  ;;-----]]------------[[-----
  :folke/which-key.nvim {:mod :which-key}
  ;;-- TODO look more into adding commands to cheatsheet
  ;;-- use {"sudormrfbin/cheatsheet.nvim", opt = true}
  ;;-- use {"famiu/nvim-reload"}

  ;;-----[[------------]]-----
  ;;---      Comments      ---
  ;;-----]]------------[[-----
  ;;use {"terrortylor/nvim-comment", opt = true}
  :terrortylor/nvim-comment {:mod :nvim_comment}
  ;;use {'JoosepAlviste/nvim-ts-context-commentstring', opt = true}
  ;;-- use {"folke/todo-comments.nvim", opt = true}

  ;;-----[[------------]]-----
  ;;---      Sessions      ---
  ;;-----]]------------[[-----
  ;;-- use {"rmagatti/auto-session"}
  ;;-- use {"rmagatti/session-lens"}

  ;;-----[[---------]]-----
  ;;---       UI        ---
  ;;-----]]---------[[-----
  :rktjmp/lush.nvim {}
  ;;use {"christianchiarulli/nvcode-color-schemes.vim", opt = true}
  ; :eddyekofo94/gruvbox-flat.nvim {}
  :svitax/fennec-gruvbox.nvim {}
  :srcery-colors/srcery-vim {:mod :srcery}

  :norcalli/nvim-colorizer.lua {:mod :colorizer}
  :kyazdani42/nvim-web-devicons {}
  ;; TODO replace lightline with galaxyline
  ;;use {"glepnir/galaxyline.nvim", opt = true}
  :itchyny/lightline.vim {:mod :lightline}
  ;;use {"romgrk/barbar.nvim", opt = true}
  ;;use {"ChristianChiarulli/dashboard-nvim", opt = true}

  ;;-----[[------------]]-----
  ;;---       Extras       ---
  ;;-----]]------------[[-----
  :tsbohc/zest.nvim {} ; macros
  ;;-- use {"karb94/neoscroll.nvim"}
  ;;-- use {"andweeb/presence.nvim", opt = true}
  ;;use {'ianding1/leetcode.vim', opt = true}

  :junegunn/fzf {:mod :fzf}
  :junegunn/fzf.vim {}
  :liuchengxu/vim-better-default {:mod :better-default}
  :mbbill/undotree {:mod :undotree}
  :prettier/vim-prettier {:ft :javascript}
  :radenling/vim-dispatch-neovim {}
  :tpope/vim-abolish {}
  :tpope/vim-commentary {}
  :tpope/vim-dadbod {}
  :tpope/vim-dispatch {}
  :tpope/vim-eunuch {}
  :tpope/vim-repeat {}
  :tweekmonster/startuptime.vim {}
  :w0rp/ale {:mod :ale}
  )
