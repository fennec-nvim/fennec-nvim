local _2afile_2a = "plugin/fzf.fnl"
local _0_
do
  local name_0_ = "dotfiles.plugin.fzf"
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
    return {autoload("aniseed.nvim"), autoload("dotfiles.util")}
  end
  ok_3f_0_, val_0_ = pcall(_2_)
  if ok_3f_0_ then
    _0_["aniseed/local-fns"] = {autoload = {nvim = "aniseed.nvim", util = "dotfiles.util"}}
    return val_0_
  else
    return print(val_0_)
  end
end
local _local_0_ = _2_(...)
local nvim = _local_0_[1]
local util = _local_0_[2]
local _2amodule_2a = _0_
local _2amodule_name_2a = "dotfiles.plugin.fzf"
do local _ = ({nil, _0_, nil, {{}, nil, nil, nil}})[2] end
nvim.ex.command_("-bang -nargs=* Rg", "call fzf#vim#grep(\"", "rg --column --line-number --no-heading --color=always --smart-case --hidden --follow -g '!.git/'", "-- \".shellescape(<q-args>), 1, fzf#vim#with_preview(), <bang>0)")
local map
do
  local v_0_
  local function map0(from, to)
    return util.nnoremap(from, (":" .. to))
  end
  v_0_ = map0
  local t_0_ = (_0_)["aniseed/locals"]
  t_0_["map"] = v_0_
  map = v_0_
end
map("fg", "Rg")
map("*", "Rg <c-r><c-w>")
map("ff", "Files")
map("fb", "Buffers")
map("fw", "Windows")
map("fh", "History")
map("fc", "Commands")
map("fm", "Maps")
map("ft", "Filetypes")
map("fM", "Marks")
return map("fH", "Helptags")