" Automatically generated packer.nvim plugin loader code

if !has('nvim-0.5')
  echohl WarningMsg
  echom "Invalid Neovim version for packer.nvim!"
  echohl None
  finish
endif

packadd packer.nvim

try

lua << END
  local time
  local profile_info
  local should_profile = false
  if should_profile then
    local hrtime = vim.loop.hrtime
    profile_info = {}
    time = function(chunk, start)
      if start then
        profile_info[chunk] = hrtime()
      else
        profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
      end
    end
  else
    time = function(chunk, start) end
  end
  
local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end

  _G._packer = _G._packer or {}
  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/Users/svitax/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/Users/svitax/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/Users/svitax/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/Users/svitax/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/Users/svitax/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s))
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  AnsiEsc = {
    loaded = true,
    path = "/Users/svitax/.local/share/nvim/site/pack/packer/start/AnsiEsc"
  },
  ale = {
    loaded = true,
    path = "/Users/svitax/.local/share/nvim/site/pack/packer/start/ale"
  },
  aniseed = {
    loaded = true,
    path = "/Users/svitax/.local/share/nvim/site/pack/packer/start/aniseed"
  },
  ["auto-pairs"] = {
    loaded = true,
    path = "/Users/svitax/.local/share/nvim/site/pack/packer/start/auto-pairs"
  },
  ["clojure.vim"] = {
    loaded = true,
    path = "/Users/svitax/.local/share/nvim/site/pack/packer/start/clojure.vim"
  },
  ["compe-conjure"] = {
    loaded = true,
    path = "/Users/svitax/.local/share/nvim/site/pack/packer/start/compe-conjure"
  },
  conjure = {
    loaded = true,
    path = "/Users/svitax/.local/share/nvim/site/pack/packer/start/conjure"
  },
  fzf = {
    loaded = true,
    path = "/Users/svitax/.local/share/nvim/site/pack/packer/start/fzf"
  },
  ["fzf.vim"] = {
    loaded = true,
    path = "/Users/svitax/.local/share/nvim/site/pack/packer/start/fzf.vim"
  },
  ["gruvbox.nvim"] = {
    loaded = true,
    path = "/Users/svitax/.local/share/nvim/site/pack/packer/start/gruvbox.nvim"
  },
  ["janet.vim"] = {
    loaded = true,
    path = "/Users/svitax/.local/share/nvim/site/pack/packer/start/janet.vim"
  },
  ["lightline.vim"] = {
    loaded = true,
    path = "/Users/svitax/.local/share/nvim/site/pack/packer/start/lightline.vim"
  },
  ["lush.nvim"] = {
    loaded = true,
    path = "/Users/svitax/.local/share/nvim/site/pack/packer/start/lush.nvim"
  },
  ["nvcode-color-schemes.vim"] = {
    loaded = true,
    path = "/Users/svitax/.local/share/nvim/site/pack/packer/start/nvcode-color-schemes.vim"
  },
  ["nvim-colorizer.lua"] = {
    loaded = true,
    path = "/Users/svitax/.local/share/nvim/site/pack/packer/start/nvim-colorizer.lua"
  },
  ["nvim-compe"] = {
    loaded = true,
    path = "/Users/svitax/.local/share/nvim/site/pack/packer/start/nvim-compe"
  },
  ["nvim-local-fennel"] = {
    loaded = true,
    path = "/Users/svitax/.local/share/nvim/site/pack/packer/start/nvim-local-fennel"
  },
  ["nvim-tree.lua"] = {
    loaded = true,
    path = "/Users/svitax/.local/share/nvim/site/pack/packer/start/nvim-tree.lua"
  },
  ["nvim-treesitter"] = {
    loaded = true,
    path = "/Users/svitax/.local/share/nvim/site/pack/packer/start/nvim-treesitter"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/Users/svitax/.local/share/nvim/site/pack/packer/start/nvim-web-devicons"
  },
  ["onedark.nvim"] = {
    loaded = true,
    path = "/Users/svitax/.local/share/nvim/site/pack/packer/start/onedark.nvim"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/Users/svitax/.local/share/nvim/site/pack/packer/start/packer.nvim"
  },
  ["srcery-vim"] = {
    loaded = true,
    path = "/Users/svitax/.local/share/nvim/site/pack/packer/start/srcery-vim"
  },
  ["startuptime.vim"] = {
    loaded = true,
    path = "/Users/svitax/.local/share/nvim/site/pack/packer/start/startuptime.vim"
  },
  ["suda.vim"] = {
    loaded = true,
    path = "/Users/svitax/.local/share/nvim/site/pack/packer/start/suda.vim"
  },
  undotree = {
    loaded = true,
    path = "/Users/svitax/.local/share/nvim/site/pack/packer/start/undotree"
  },
  ["vim-abolish"] = {
    loaded = true,
    path = "/Users/svitax/.local/share/nvim/site/pack/packer/start/vim-abolish"
  },
  ["vim-argumentative"] = {
    loaded = true,
    path = "/Users/svitax/.local/share/nvim/site/pack/packer/start/vim-argumentative"
  },
  ["vim-better-default"] = {
    loaded = true,
    path = "/Users/svitax/.local/share/nvim/site/pack/packer/start/vim-better-default"
  },
  ["vim-commentary"] = {
    loaded = true,
    path = "/Users/svitax/.local/share/nvim/site/pack/packer/start/vim-commentary"
  },
  ["vim-dadbod"] = {
    loaded = true,
    path = "/Users/svitax/.local/share/nvim/site/pack/packer/start/vim-dadbod"
  },
  ["vim-dispatch"] = {
    loaded = true,
    path = "/Users/svitax/.local/share/nvim/site/pack/packer/start/vim-dispatch"
  },
  ["vim-dispatch-neovim"] = {
    loaded = true,
    path = "/Users/svitax/.local/share/nvim/site/pack/packer/start/vim-dispatch-neovim"
  },
  ["vim-easymotion"] = {
    loaded = true,
    path = "/Users/svitax/.local/share/nvim/site/pack/packer/start/vim-easymotion"
  },
  ["vim-enmasse"] = {
    loaded = true,
    path = "/Users/svitax/.local/share/nvim/site/pack/packer/start/vim-enmasse"
  },
  ["vim-eunuch"] = {
    loaded = true,
    path = "/Users/svitax/.local/share/nvim/site/pack/packer/start/vim-eunuch"
  },
  ["vim-fish"] = {
    loaded = true,
    path = "/Users/svitax/.local/share/nvim/site/pack/packer/start/vim-fish"
  },
  ["vim-fugitive"] = {
    loaded = true,
    path = "/Users/svitax/.local/share/nvim/site/pack/packer/start/vim-fugitive"
  },
  ["vim-gitgutter"] = {
    loaded = true,
    path = "/Users/svitax/.local/share/nvim/site/pack/packer/start/vim-gitgutter"
  },
  ["vim-hy"] = {
    loaded = true,
    path = "/Users/svitax/.local/share/nvim/site/pack/packer/start/vim-hy"
  },
  ["vim-jack-in"] = {
    loaded = true,
    path = "/Users/svitax/.local/share/nvim/site/pack/packer/start/vim-jack-in"
  },
  ["vim-javascript"] = {
    loaded = true,
    path = "/Users/svitax/.local/share/nvim/site/pack/packer/start/vim-javascript"
  },
  ["vim-jsx-pretty"] = {
    loaded = true,
    path = "/Users/svitax/.local/share/nvim/site/pack/packer/start/vim-jsx-pretty"
  },
  ["vim-nix"] = {
    loaded = true,
    path = "/Users/svitax/.local/share/nvim/site/pack/packer/start/vim-nix"
  },
  ["vim-prettier"] = {
    loaded = false,
    needs_bufread = true,
    path = "/Users/svitax/.local/share/nvim/site/pack/packer/opt/vim-prettier"
  },
  ["vim-racket"] = {
    loaded = true,
    path = "/Users/svitax/.local/share/nvim/site/pack/packer/start/vim-racket"
  },
  ["vim-repeat"] = {
    loaded = true,
    path = "/Users/svitax/.local/share/nvim/site/pack/packer/start/vim-repeat"
  },
  ["vim-sexp"] = {
    loaded = true,
    path = "/Users/svitax/.local/share/nvim/site/pack/packer/start/vim-sexp"
  },
  ["vim-sexp-mappings-for-regular-people"] = {
    loaded = true,
    path = "/Users/svitax/.local/share/nvim/site/pack/packer/start/vim-sexp-mappings-for-regular-people"
  },
  ["vim-sleuth"] = {
    loaded = true,
    path = "/Users/svitax/.local/share/nvim/site/pack/packer/start/vim-sleuth"
  },
  ["vim-surround"] = {
    loaded = true,
    path = "/Users/svitax/.local/share/nvim/site/pack/packer/start/vim-surround"
  },
  ["vim-terraform"] = {
    loaded = true,
    path = "/Users/svitax/.local/share/nvim/site/pack/packer/start/vim-terraform"
  },
  ["vim-unimpaired"] = {
    loaded = true,
    path = "/Users/svitax/.local/share/nvim/site/pack/packer/start/vim-unimpaired"
  },
  ["vim-vinegar"] = {
    loaded = true,
    path = "/Users/svitax/.local/share/nvim/site/pack/packer/start/vim-vinegar"
  },
  ["yats.vim"] = {
    loaded = true,
    path = "/Users/svitax/.local/share/nvim/site/pack/packer/start/yats.vim"
  },
  ["zest.nvim"] = {
    loaded = true,
    path = "/Users/svitax/.local/share/nvim/site/pack/packer/start/zest.nvim"
  }
}

time([[Defining packer_plugins]], false)
vim.cmd [[augroup packer_load_aucmds]]
vim.cmd [[au!]]
  -- Filetype lazy-loads
time([[Defining lazy-load filetype autocommands]], true)
vim.cmd [[au FileType javascript ++once lua require("packer.load")({'vim-prettier'}, { ft = "javascript" }, _G.packer_plugins)]]
time([[Defining lazy-load filetype autocommands]], false)
vim.cmd("augroup END")
vim.cmd [[augroup filetypedetect]]
time([[Sourcing ftdetect script at: /Users/svitax/.local/share/nvim/site/pack/packer/opt/vim-prettier/ftdetect/css.vim]], true)
vim.cmd [[source /Users/svitax/.local/share/nvim/site/pack/packer/opt/vim-prettier/ftdetect/css.vim]]
time([[Sourcing ftdetect script at: /Users/svitax/.local/share/nvim/site/pack/packer/opt/vim-prettier/ftdetect/css.vim]], false)
time([[Sourcing ftdetect script at: /Users/svitax/.local/share/nvim/site/pack/packer/opt/vim-prettier/ftdetect/graphql.vim]], true)
vim.cmd [[source /Users/svitax/.local/share/nvim/site/pack/packer/opt/vim-prettier/ftdetect/graphql.vim]]
time([[Sourcing ftdetect script at: /Users/svitax/.local/share/nvim/site/pack/packer/opt/vim-prettier/ftdetect/graphql.vim]], false)
time([[Sourcing ftdetect script at: /Users/svitax/.local/share/nvim/site/pack/packer/opt/vim-prettier/ftdetect/html.vim]], true)
vim.cmd [[source /Users/svitax/.local/share/nvim/site/pack/packer/opt/vim-prettier/ftdetect/html.vim]]
time([[Sourcing ftdetect script at: /Users/svitax/.local/share/nvim/site/pack/packer/opt/vim-prettier/ftdetect/html.vim]], false)
time([[Sourcing ftdetect script at: /Users/svitax/.local/share/nvim/site/pack/packer/opt/vim-prettier/ftdetect/javascript.vim]], true)
vim.cmd [[source /Users/svitax/.local/share/nvim/site/pack/packer/opt/vim-prettier/ftdetect/javascript.vim]]
time([[Sourcing ftdetect script at: /Users/svitax/.local/share/nvim/site/pack/packer/opt/vim-prettier/ftdetect/javascript.vim]], false)
time([[Sourcing ftdetect script at: /Users/svitax/.local/share/nvim/site/pack/packer/opt/vim-prettier/ftdetect/json.vim]], true)
vim.cmd [[source /Users/svitax/.local/share/nvim/site/pack/packer/opt/vim-prettier/ftdetect/json.vim]]
time([[Sourcing ftdetect script at: /Users/svitax/.local/share/nvim/site/pack/packer/opt/vim-prettier/ftdetect/json.vim]], false)
time([[Sourcing ftdetect script at: /Users/svitax/.local/share/nvim/site/pack/packer/opt/vim-prettier/ftdetect/less.vim]], true)
vim.cmd [[source /Users/svitax/.local/share/nvim/site/pack/packer/opt/vim-prettier/ftdetect/less.vim]]
time([[Sourcing ftdetect script at: /Users/svitax/.local/share/nvim/site/pack/packer/opt/vim-prettier/ftdetect/less.vim]], false)
time([[Sourcing ftdetect script at: /Users/svitax/.local/share/nvim/site/pack/packer/opt/vim-prettier/ftdetect/lua.vim]], true)
vim.cmd [[source /Users/svitax/.local/share/nvim/site/pack/packer/opt/vim-prettier/ftdetect/lua.vim]]
time([[Sourcing ftdetect script at: /Users/svitax/.local/share/nvim/site/pack/packer/opt/vim-prettier/ftdetect/lua.vim]], false)
time([[Sourcing ftdetect script at: /Users/svitax/.local/share/nvim/site/pack/packer/opt/vim-prettier/ftdetect/markdown.vim]], true)
vim.cmd [[source /Users/svitax/.local/share/nvim/site/pack/packer/opt/vim-prettier/ftdetect/markdown.vim]]
time([[Sourcing ftdetect script at: /Users/svitax/.local/share/nvim/site/pack/packer/opt/vim-prettier/ftdetect/markdown.vim]], false)
time([[Sourcing ftdetect script at: /Users/svitax/.local/share/nvim/site/pack/packer/opt/vim-prettier/ftdetect/php.vim]], true)
vim.cmd [[source /Users/svitax/.local/share/nvim/site/pack/packer/opt/vim-prettier/ftdetect/php.vim]]
time([[Sourcing ftdetect script at: /Users/svitax/.local/share/nvim/site/pack/packer/opt/vim-prettier/ftdetect/php.vim]], false)
time([[Sourcing ftdetect script at: /Users/svitax/.local/share/nvim/site/pack/packer/opt/vim-prettier/ftdetect/ruby.vim]], true)
vim.cmd [[source /Users/svitax/.local/share/nvim/site/pack/packer/opt/vim-prettier/ftdetect/ruby.vim]]
time([[Sourcing ftdetect script at: /Users/svitax/.local/share/nvim/site/pack/packer/opt/vim-prettier/ftdetect/ruby.vim]], false)
time([[Sourcing ftdetect script at: /Users/svitax/.local/share/nvim/site/pack/packer/opt/vim-prettier/ftdetect/scss.vim]], true)
vim.cmd [[source /Users/svitax/.local/share/nvim/site/pack/packer/opt/vim-prettier/ftdetect/scss.vim]]
time([[Sourcing ftdetect script at: /Users/svitax/.local/share/nvim/site/pack/packer/opt/vim-prettier/ftdetect/scss.vim]], false)
time([[Sourcing ftdetect script at: /Users/svitax/.local/share/nvim/site/pack/packer/opt/vim-prettier/ftdetect/typescript.vim]], true)
vim.cmd [[source /Users/svitax/.local/share/nvim/site/pack/packer/opt/vim-prettier/ftdetect/typescript.vim]]
time([[Sourcing ftdetect script at: /Users/svitax/.local/share/nvim/site/pack/packer/opt/vim-prettier/ftdetect/typescript.vim]], false)
time([[Sourcing ftdetect script at: /Users/svitax/.local/share/nvim/site/pack/packer/opt/vim-prettier/ftdetect/vue.vim]], true)
vim.cmd [[source /Users/svitax/.local/share/nvim/site/pack/packer/opt/vim-prettier/ftdetect/vue.vim]]
time([[Sourcing ftdetect script at: /Users/svitax/.local/share/nvim/site/pack/packer/opt/vim-prettier/ftdetect/vue.vim]], false)
time([[Sourcing ftdetect script at: /Users/svitax/.local/share/nvim/site/pack/packer/opt/vim-prettier/ftdetect/xml.vim]], true)
vim.cmd [[source /Users/svitax/.local/share/nvim/site/pack/packer/opt/vim-prettier/ftdetect/xml.vim]]
time([[Sourcing ftdetect script at: /Users/svitax/.local/share/nvim/site/pack/packer/opt/vim-prettier/ftdetect/xml.vim]], false)
time([[Sourcing ftdetect script at: /Users/svitax/.local/share/nvim/site/pack/packer/opt/vim-prettier/ftdetect/yaml.vim]], true)
vim.cmd [[source /Users/svitax/.local/share/nvim/site/pack/packer/opt/vim-prettier/ftdetect/yaml.vim]]
time([[Sourcing ftdetect script at: /Users/svitax/.local/share/nvim/site/pack/packer/opt/vim-prettier/ftdetect/yaml.vim]], false)
vim.cmd("augroup END")
if should_profile then save_profiles() end

END

catch
  echohl ErrorMsg
  echom "Error in packer_compiled: " .. v:exception
  echom "Please check your config for correctness"
  echohl None
endtry
