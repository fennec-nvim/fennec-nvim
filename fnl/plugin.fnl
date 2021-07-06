(module plugin
  {autoload {nvim aniseed.nvim
             a aniseed.core
             util util
             packer packer}})

; TODO: require the configs inside packer instead
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

  ;; -----[[------------]]-----
  ;; ---         UI         ---
  ;; -----]]------------[[-----

  ; TODO make optional
  ; :tzachar/compe-tabnine {:run :./install.sh
  ;                         :requires :hrsh7th/nvim-compe}
  :tami5/compe-conjure {}

  ; "~/repos/Olical/conjure" {:mod :conjure}
  ; "~/repos/Olical/aniseed" {}
  ; "~/repos/Olical/nvim-local-fennel" {}

  :HerringtonDarkholme/yats.vim {}
  :LnL7/vim-nix {}
  :Olical/AnsiEsc {}
  :Olical/aniseed {:branch :develop}
  :Olical/conjure {:branch :develop :mod :conjure}
  :Olical/nvim-local-fennel {}
  :Olical/vim-enmasse {}
  :PeterRincker/vim-argumentative {}
  :airblade/vim-gitgutter {}
  :clojure-vim/clojure.vim {}
  :clojure-vim/vim-jack-in {}
  :dag/vim-fish {}
  :easymotion/vim-easymotion {:mod :easymotion}
  :guns/vim-sexp {:mod :sexp}
  :hashivim/vim-terraform {}
  :hylang/vim-hy {}
  :itchyny/lightline.vim {:mod :lightline}
  :janet-lang/janet.vim {}
  :junegunn/fzf {:mod :fzf}
  :junegunn/fzf.vim {}
  :lambdalisue/suda.vim {}
  ; :liuchengxu/vim-better-default {:mod :better-default}
  :maxmellon/vim-jsx-pretty {}
  :mbbill/undotree {:mod :undotree}
  :norcalli/nvim-colorizer.lua {:mod :colorizer}
  :pangloss/vim-javascript {}
  :prettier/vim-prettier {:ft :javascript}
  :radenling/vim-dispatch-neovim {}
  :srcery-colors/srcery-vim {:mod :srcery}
  :tpope/vim-abolish {}
  :tpope/vim-commentary {}
  :tpope/vim-dadbod {}
  :tpope/vim-dispatch {}
  :tpope/vim-eunuch {}
  :tpope/vim-fugitive {:mod :fugitive}
  :tpope/vim-repeat {}
  :tpope/vim-sexp-mappings-for-regular-people {}
  :tpope/vim-sleuth {}
  :tpope/vim-surround {}
  :tpope/vim-unimpaired {}
  :tpope/vim-vinegar {}
  :tweekmonster/startuptime.vim {}
  :w0rp/ale {:mod :ale}
  :wbthomason/packer.nvim {}
  :wlangstroth/vim-racket {}
  )
