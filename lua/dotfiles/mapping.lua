local _2afile_2a = "mapping.fnl"
local _0_
do
  local name_0_ = "dotfiles.module.mapping"
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
    return {require("aniseed.core"), require("aniseed.nvim.util"), require("aniseed.nvim")}
  end
  ok_3f_0_, val_0_ = pcall(_2_)
  if ok_3f_0_ then
    _0_["aniseed/local-fns"] = {require = {core = "aniseed.core", nu = "aniseed.nvim.util", nvim = "aniseed.nvim"}}
    return val_0_
  else
    return print(val_0_)
  end
end
local _local_0_ = _2_(...)
local core = _local_0_[1]
local nu = _local_0_[2]
local nvim = _local_0_[3]
local _2amodule_2a = _0_
local _2amodule_name_2a = "dotfiles.module.mapping"
do local _ = ({nil, _0_, nil, {{}, nil, nil, nil}})[2] end
local noremap
do
  local v_0_
  local function noremap0(mode, from, to)
    return nvim.set_keymap(mode, from, to, {noremap = true})
  end
  v_0_ = noremap0
  local t_0_ = (_0_)["aniseed/locals"]
  t_0_["noremap"] = v_0_
  noremap = v_0_
end
nvim.set_keymap("n", "<space>", "<nop>", {noremap = true})
nvim.g.mapleader = " "
nvim.g.maplocalleader = ","
noremap("i", "jk", "<esc>")
noremap("c", "jk", "<c-c>")
noremap("t", "jk", "<c-\\><c-n>")
noremap("n", "<leader>wm", ":tab sp<cr>")
noremap("n", "<leader>wc", ":only<cr>")
noremap("n", "<leader>bd", ":bdelete!<cr>")
noremap("n", "<leader>to", ":tabonly<cr>")
noremap("n", "<leader>sw", ":mksession! .quicksave.vim<cr>")
noremap("n", "<leader>sr", ":source .quicksave.vim<cr>")
noremap("n", "<leader>bo", ":call DeleteHiddenBuffers()<cr>")
noremap("n", "<leader>zz", ":normal! 1z=<cr>")
noremap("n", "<leader>bt", ":%s/\\s\\+$//e<cr>")
nu["fn-bridge"]("DeleteHiddenBuffers", "dotfiles.module.mapping", "delete-hidden-buffers")
local delete_hidden_buffers
do
  local v_0_
  do
    local v_0_0
    local function delete_hidden_buffers0()
      local visible_bufs = core.concat(unpack(core.map(nvim.fn.tabpagebuflist, nvim.fn.range(1, nvim.fn.tabpagenr("$")))))
      local function _3_(bufnr)
        return nvim.ex.bwipeout(bufnr)
      end
      local function _4_(bufnr)
        return (nvim.fn.bufexists(bufnr) and (-1 == nvim.fn.index(visible_bufs, bufnr)))
      end
      return core["run!"](_3_, core.filter(_4_, nvim.fn.range(1, nvim.fn.bufnr("$"))))
    end
    v_0_0 = delete_hidden_buffers0
    _0_["delete-hidden-buffers"] = v_0_0
    v_0_ = v_0_0
  end
  local t_0_ = (_0_)["aniseed/locals"]
  t_0_["delete-hidden-buffers"] = v_0_
  delete_hidden_buffers = v_0_
end
return nil