---Prints a string.format string.
---It is a function that passes the output of string.format(string, ...)
---to the print function
---@param template string #See `string.format` for more information
---@param ... any #Other arguments to feed to `string.format`
local function fprint(template, ...)
    print(template.format(template, ...))
end

---Bootstraps a plugin with folke/lazy.nvim.
---@param plugin string #Must follow the format `username/repository`
---@param ref? string #The branch to clone
local function bootstrap(plugin, ref)
	local _, _, name = string.find(plugin, [[%S+/(%S+)]])
	local path = vim.fn.stdpath("data") .. "/lazy/" .. name

	if not vim.loop.fs_stat(path) then
		fprint("Bootstraping '%s' to %s", name, path)

		vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/" .. plugin, path })
		if ref then
			vim.fn.system({ "git", "-C", path, "checkout", ref })
		end

		vim.cmd([[redraw]])
	end
	vim.opt.runtimepath:prepend(path)
end

bootstrap("folke/lazy.nvim")
bootstrap("rktjmp/hotpot.nvim")
-- bootstrap("fennec-nvim/kaftan.nvim")

if pcall(require, "hotpot") then
	-- Setup hotpot.nvim
	require("hotpot").setup({
		provide_require_fennel = true,
		enable_hotpot_diagnostics = true,
		compiler = {
			modules = {
				correlate = true,
			},
			macros = {
				env = "_COMPILER",
				compilerEnv = _G,
				allowGlobals = true,
			},
		},
	})
	-- AOT compile
	require("hotpot.api.make").build(
		vim.fn.stdpath("config"),
		{ verbosity = 0 },
		vim.fn.stdpath("config") .. "ftplugin/.+",
		function(path)
			return path
		end,
		vim.fn.stdpath("config") .. "/after/ftdetect/.+",
		function(path)
			return path
		end,
		vim.fn.stdpath("config") .. "/after/ftplugin/.+",
		function(path)
			return path
		end,
		vim.fn.stdpath("config") .. "/fnl/conf/health.fnl",
		function()
			return vim.fn.stdpath("config") .. "/lua/conf/health.lua"
		end
	)
	-- Import neovim configuration
	require("core")
else
	fprint("Unable to require hotpot.")
end
