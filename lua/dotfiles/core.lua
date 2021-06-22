local _2afile_2a = "core.fnl"
local _0_
do
  local name_0_ = "dotfiles.module.core"
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
    return {require("aniseed.nvim")}
  end
  ok_3f_0_, val_0_ = pcall(_2_)
  if ok_3f_0_ then
    _0_["aniseed/local-fns"] = {require = {nvim = "aniseed.nvim"}}
    return val_0_
  else
    return print(val_0_)
  end
end
local _local_0_ = _2_(...)
local nvim = _local_0_[1]
local _2amodule_2a = _0_
local _2amodule_name_2a = "dotfiles.module.core"
do local _ = ({nil, _0_, nil, {{}, nil, nil, nil}})[2] end
nvim.o.termguicolors = true
nvim.o.mouse = "a"
nvim.o.updatetime = 500
nvim.o.timeoutlen = 500
nvim.o.sessionoptions = "blank,curdir,folds,help,tabpages,winsize"
nvim.o.inccommand = "split"
nvim.ex.set("spell")
nvim.ex.set("list")
vim.cmd("set iskeyword+=-")
vim.cmd("set shortmess+=c")
vim.cmd("set inccommand=split")
vim.o.hidden = true
vim.o.title = true
vim.o.titlestring = "%<%F%=%l/%L - nvim"
nvim.wo.wrap = false
vim.cmd("set whichwrap+=<,>,[,],h,l")
nvim.ex.syntax(doom.syntax)
vim.o.pumheight = 10
vim.o.fileencoding = "utf-8"
vim.o.cmdheight = 2
vim.cmd("set colorcolumn=99999")
vim.o.mouse = "a"
vim.o.splitbelow = true
vim.o.termguicolors = true
vim.o.splitright = true
vim.o.conceallevel = 0
vim.cmd("set ts=4")
vim.cmd("set sw=4")
vim.cmd("set expandtab")
vim.bo.smartindent = true
vim.wo.cursorline = true
vim.o.showtabline = 2
vim.o.showmode = false
vim.o.backup = false
vim.o.writebackup = false
vim.wo.signcolumn = "yes"
vim.o.updatetime = 300
vim.o.timeoutlen = 100
vim.o.clipboard = "unnamedplus"
vim.g.nvim_tree_disable_netrw = 0
vim.cmd("filetype plugin on")
nvim.o.guifont = "JetBrainsMono Nerd Font:h15"
return nvim.ex.colorscheme("gruvbox")