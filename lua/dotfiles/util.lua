local _2afile_2a = "util.fnl"
local _0_
do
  local name_0_ = "dotfiles.util"
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
local _2amodule_name_2a = "dotfiles.util"
do local _ = ({nil, _0_, nil, {{}, nil, nil, nil}})[2] end
local expand
do
  local v_0_
  do
    local v_0_0
    local function expand0(path)
      return nvim.fn.expand(path)
    end
    v_0_0 = expand0
    _0_["expand"] = v_0_0
    v_0_ = v_0_0
  end
  local t_0_ = (_0_)["aniseed/locals"]
  t_0_["expand"] = v_0_
  expand = v_0_
end
local glob
do
  local v_0_
  do
    local v_0_0
    local function glob0(path)
      return nvim.fn.glob(path, true, true, true)
    end
    v_0_0 = glob0
    _0_["glob"] = v_0_0
    v_0_ = v_0_0
  end
  local t_0_ = (_0_)["aniseed/locals"]
  t_0_["glob"] = v_0_
  glob = v_0_
end
local exists_3f
do
  local v_0_
  do
    local v_0_0
    local function exists_3f0(path)
      return (nvim.fn.filereadable(path) == 1)
    end
    v_0_0 = exists_3f0
    _0_["exists?"] = v_0_0
    v_0_ = v_0_0
  end
  local t_0_ = (_0_)["aniseed/locals"]
  t_0_["exists?"] = v_0_
  exists_3f = v_0_
end
local lua_file
do
  local v_0_
  do
    local v_0_0
    local function lua_file0(path)
      return nvim.ex.luafile(path)
    end
    v_0_0 = lua_file0
    _0_["lua-file"] = v_0_0
    v_0_ = v_0_0
  end
  local t_0_ = (_0_)["aniseed/locals"]
  t_0_["lua-file"] = v_0_
  lua_file = v_0_
end
local config_path
do
  local v_0_
  do
    local v_0_0 = nvim.fn.stdpath("config")
    do end (_0_)["config-path"] = v_0_0
    v_0_ = v_0_0
  end
  local t_0_ = (_0_)["aniseed/locals"]
  t_0_["config-path"] = v_0_
  config_path = v_0_
end
local nnoremap
do
  local v_0_
  do
    local v_0_0
    local function nnoremap0(from, to)
      return nvim.set_keymap("n", ("<leader>" .. from), (":" .. to .. "<cr>"), {noremap = true})
    end
    v_0_0 = nnoremap0
    _0_["nnoremap"] = v_0_0
    v_0_ = v_0_0
  end
  local t_0_ = (_0_)["aniseed/locals"]
  t_0_["nnoremap"] = v_0_
  nnoremap = v_0_
end
doom = {number = true, relative_number = true, syntax = "on"}
return nil