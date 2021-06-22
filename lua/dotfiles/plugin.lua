local _2afile_2a = "plugin.fnl"
local _0_
do
  local name_0_ = "dotfiles.plugin"
  local module_0_
  do
    local x_0_ = package.loaded[name_0_]
    if ("table" == type(x_0_)) then
      module_0_ = x_0_
    else
      module_0_ = {}
    end
  end
  module_0_["aniseed/module"] = name_0_
  module_0_["aniseed/locals"] = ((module_0_)["aniseed/locals"] or {})
  do end (module_0_)["aniseed/local-fns"] = ((module_0_)["aniseed/local-fns"] or {})
  do end (package.loaded)[name_0_] = module_0_
  _0_ = module_0_
end
local autoload
local function _1_(...)
  return (require("aniseed.autoload")).autoload(...)
end
autoload = _1_
local function _2_(...)
  local ok_3f_0_, val_0_ = nil, nil
  local function _2_()
    return {autoload("aniseed.core"), autoload("aniseed.nvim"), autoload("packer"), autoload("dotfiles.util")}
  end
  ok_3f_0_, val_0_ = pcall(_2_)
  if ok_3f_0_ then
    _0_["aniseed/local-fns"] = {autoload = {a = "aniseed.core", nvim = "aniseed.nvim", packer = "packer", util = "dotfiles.util"}}
    return val_0_
  else
    return print(val_0_)
  end
end
local _local_0_ = _2_(...)
local a = _local_0_[1]
local nvim = _local_0_[2]
local packer = _local_0_[3]
local util = _local_0_[4]
local _2amodule_2a = _0_
local _2amodule_name_2a = "dotfiles.plugin"
do local _ = ({nil, _0_, nil, {{}, nil, nil, nil}})[2] end
local safe_require_plugin_config
do
  local v_0_
  do
    local v_0_0
    local function safe_require_plugin_config0(name)
      local ok_3f, val_or_err = pcall(require, ("dotfiles.plugin." .. name))
      if not ok_3f then
        return print(("dotfiles error: " .. val_or_err))
      end
    end
    v_0_0 = safe_require_plugin_config0
    _0_["safe-require-plugin-config"] = v_0_0
    v_0_ = v_0_0
  end
  local t_0_ = (_0_)["aniseed/locals"]
  t_0_["safe-require-plugin-config"] = v_0_
  safe_require_plugin_config = v_0_
end
local use
do
  local v_0_
  local function use0(...)
    local pkgs = {...}
    local function _3_(use1)
      for i = 1, a.count(pkgs), 2 do
        local name = pkgs[i]
        local opts = pkgs[(i + 1)]
        do
          local _4_ = opts.mod
          if _4_ then
            safe_require_plugin_config(_4_)
          else
          end
        end
        use1(a.assoc(opts, 1, name))
      end
      return nil
    end
    return packer.startup(_3_)
  end
  v_0_ = use0
  local t_0_ = (_0_)["aniseed/locals"]
  t_0_["use"] = v_0_
  use = v_0_
end
return use("HerringtonDarkholme/yats.vim", {}, "LnL7/vim-nix", {}, "Olical/AnsiEsc", {}, "Olical/aniseed", {branch = "develop"}, "Olical/conjure", {branch = "develop", mod = "conjure"}, "Olical/nvim-local-fennel", {}, "Olical/vim-enmasse", {}, "PeterRincker/vim-argumentative", {}, "airblade/vim-gitgutter", {}, "clojure-vim/clojure.vim", {}, "clojure-vim/vim-jack-in", {}, "dag/vim-fish", {}, "easymotion/vim-easymotion", {mod = "easymotion"}, "guns/vim-sexp", {mod = "sexp"}, "hashivim/vim-terraform", {}, "hrsh7th/nvim-compe", {mod = "compe"}, "hylang/vim-hy", {}, "itchyny/lightline.vim", {mod = "lightline"}, "janet-lang/janet.vim", {}, "jiangmiao/auto-pairs", {mod = "auto-pairs"}, "junegunn/fzf", {mod = "fzf"}, "junegunn/fzf.vim", {}, "lambdalisue/suda.vim", {}, "liuchengxu/vim-better-default", {mod = "better-default"}, "maxmellon/vim-jsx-pretty", {}, "mbbill/undotree", {mod = "undotree"}, "norcalli/nvim-colorizer.lua", {mod = "colorizer"}, "pangloss/vim-javascript", {}, "prettier/vim-prettier", {ft = "javascript"}, "radenling/vim-dispatch-neovim", {}, "srcery-colors/srcery-vim", {mod = "srcery"}, "tami5/compe-conjure", {}, "tpope/vim-abolish", {}, "tpope/vim-commentary", {}, "tpope/vim-dadbod", {}, "tpope/vim-dispatch", {}, "tpope/vim-eunuch", {}, "tpope/vim-fugitive", {mod = "fugitive"}, "tpope/vim-repeat", {}, "tpope/vim-sexp-mappings-for-regular-people", {}, "tpope/vim-sleuth", {}, "tpope/vim-surround", {}, "tpope/vim-unimpaired", {}, "tpope/vim-vinegar", {}, "tweekmonster/startuptime.vim", {}, "w0rp/ale", {mod = "ale"}, "wbthomason/packer.nvim", {}, "wlangstroth/vim-racket", {}, "navarasu/onedark.nvim", {}, "christianchiarulli/nvcode-color-schemes.vim", {}, "rktjmp/lush.nvim", {}, "svitax/gruvbox.nvim", {}, "nvim-treesitter/nvim-treesitter", {mod = "treesitter", run = ":TSUpdate"}, "kyazdani42/nvim-web-devicons", {}, "kyazdani42/nvim-tree.lua", {mod = "nvimtree"}, "tsbohc/zest.nvim", {})