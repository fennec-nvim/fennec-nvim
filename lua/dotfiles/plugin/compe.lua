local _2afile_2a = "plugin/compe.fnl"
local _0_
do
  local name_0_ = "dotfiles.plugin.compe"
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
    return {autoload("compe"), autoload("aniseed.nvim")}
  end
  ok_3f_0_, val_0_ = pcall(_2_)
  if ok_3f_0_ then
    _0_["aniseed/local-fns"] = {autoload = {compe = "compe", nvim = "aniseed.nvim"}}
    return val_0_
  else
    return print(val_0_)
  end
end
local _local_0_ = _2_(...)
local compe = _local_0_[1]
local nvim = _local_0_[2]
local _2amodule_2a = _0_
local _2amodule_name_2a = "dotfiles.plugin.compe"
do local _ = ({nil, _0_, nil, {{}, nil, nil, nil}})[2] end
nvim.o.completeopt = "menuone,noselect"
compe.setup({autocomplete = true, debug = false, documentation = true, enabled = true, incomplete_delay = 400, max_abbr_width = 100, max_kind_width = 100, max_menu_width = 100, min_length = 1, preselect = "enable", source = {buffer = true, calc = true, conjure = true, nvim_lsp = true, nvim_lua = true, path = true, vsnip = true}, source_timeout = 200, throttle_time = 80})
nvim.ex.inoremap("<silent><expr> <C-Space> compe#complete()")
nvim.ex.inoremap("<silent><expr> <CR> compe#confirm('<CR>')")
nvim.ex.inoremap("<silent><expr> <C-e> compe#close('<C-e>')")
nvim.ex.inoremap("<silent><expr> <C-f> compe#scroll({ 'delta': +4 })")
return nvim.ex.inoremap("<silent><expr> <C-d> compe#scroll({ 'delta': -4 })")