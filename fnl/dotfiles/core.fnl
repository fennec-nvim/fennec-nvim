(module dotfiles.module.core
  {require {nvim aniseed.nvim}})

;; Generic Neovim configuration.
(set nvim.o.termguicolors true)
(set nvim.o.mouse "a")
(set nvim.o.updatetime 500)
(set nvim.o.timeoutlen 500)
(set nvim.o.sessionoptions "blank,curdir,folds,help,tabpages,winsize")
(set nvim.o.inccommand :split)

(nvim.ex.set :nospell)
(nvim.ex.set :list)

;; LunarVim settings.lua

; vim.cmd('set iskeyword+=-') -- treat dash separated words as a word text object"
(vim.cmd "set iskeyword+=-")

;vim.cmd('set shortmess+=c') -- Don't pass messages to |ins-completion-menu|.
(vim.cmd "set shortmess+=c")

;vim.cmd('set inccommand=split') -- Make substitution work in realtime
(vim.cmd "set inccommand=split")

; vim.o.hidden = O.hidden_files -- Required to keep multiple buffers open multiple buffers
(set vim.o.hidden true)

; vim.o.title = true
(set vim.o.title true)

;TERMINAL = vim.fn.expand('$TERMINAL')
;vim.cmd('let &titleold="'..TERMINAL..'"')

;vim.o.titlestring="%<%F%=%l/%L - nvim"
(set vim.o.titlestring "%<%F%=%l/%L - nvim")

;vim.wo.wrap = O.wrap_lines -- Display long lines as just one line
(set nvim.wo.wrap false)

;vim.cmd('set whichwrap+=<,>,[,],h,l') -- move to next line with theses keys
(vim.cmd "set whichwrap+=<,>,[,],h,l")

;vim.cmd('syntax on') -- syntax highlighting
(nvim.ex.syntax :on) ; syntax highlighting
; (nvim.ex.syntax (. fennec :syntax))

;vim.o.pumheight = 10 -- Makes popup menu smaller
(set vim.o.pumheight 10) ; Makes popup menu smaller

;vim.o.fileencoding = "utf-8" -- The encoding written to file
(set vim.o.fileencoding "utf-8") ; The encoding written to file

;vim.o.cmdheight = 2 -- More space for displaying messages
(set vim.o.cmdheight 2) ; More space for displaying messages

;vim.cmd('set colorcolumn=99999') -- fix indentline for now
(vim.cmd "set colorcolumn=99999")

;vim.o.mouse = "a" -- Enable your mouse
(set vim.o.mouse "a") ; Enable your mouse

;vim.o.splitbelow = true -- Horizontal splits will automatically be below
(set vim.o.splitbelow true)

;vim.o.termguicolors = true -- set term gui colors most terminals support this
(set vim.o.termguicolors true) ; set term gui colors most terminals support this

;vim.o.splitright = true -- Vertical splits will automatically be to the right
(set vim.o.splitright true)

;vim.o.conceallevel = 0 -- So that I can see `` in markdown files
(set vim.o.conceallevel 0)

;vim.cmd('set ts=4') -- Insert 2 spaces for a tab
(vim.cmd "set ts=4")

;vim.cmd('set sw=4') -- Change the number of space characters inserted for indentation
(vim.cmd "set sw=4")

;vim.cmd('set expandtab') -- Converts tabs to spaces
(vim.cmd "set expandtab")

;vim.bo.smartindent = true -- Makes indenting smart
(set vim.bo.smartindent true)

;vim.wo.number = O.number -- set numbered lines
;(set vim.wo.number true)

;vim.wo.relativenumber = O.relative_number -- set relative number
;(set vim.wo.relativenumber (. fennec :relative_number))

;vim.wo.cursorline = true -- Enable highlighting of the current line
(set vim.wo.cursorline true)

;vim.o.showtabline = 2 -- Always show tabs
(set vim.o.showtabline 2)

;vim.o.showmode = false -- We don't need to see things like -- INSERT -- anymore
(set vim.o.showmode false)

;vim.o.backup = false -- This is recommended by coc
(set vim.o.backup false)

;vim.o.writebackup = false -- This is recommended by coc
(set vim.o.writebackup false)

;vim.wo.signcolumn = "yes" -- Always show the signcolumn, otherwise it would shift the text each time
(set vim.wo.signcolumn "yes")

;vim.o.updatetime = 300 -- Faster completion
(set vim.o.updatetime 300)

;vim.o.timeoutlen = O.timeoutlen -- By default timeoutlen is 1000 ms
(set vim.o.timeoutlen 100)

;vim.o.clipboard = "unnamedplus" -- Copy paste between vim and everything else
(set vim.o.clipboard "unnamedplus")

;vim.g.nvim_tree_disable_netrw = O.nvim_tree_disable_netrw -- enable netrw for remote gx gf support (must be set before plugin's packadd)
(set vim.g.nvim_tree_disable_netrw 0)

;vim.cmd('filetype plugin on') -- filetype detection
(vim.cmd "filetype plugin on")

;-- vim.o.guifont = "JetBrainsMono\\ Nerd\\ Font\\ Mono:h18"
(set nvim.o.guifont "JetBrainsMono Nerd Font:h15")

(nvim.ex.colorscheme (. fennec :colorscheme))

(nvim.ex.set :number)
(nvim.ex.set :relativenumber)
