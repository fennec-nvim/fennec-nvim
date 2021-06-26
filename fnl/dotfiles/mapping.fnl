(module dotfiles.module.mapping
  {require {nvim aniseed.nvim
            nu aniseed.nvim.util
            core aniseed.core
            which-key which-key}})

(defn- noremap [mode from to]
  "Sets a mapping with {:noremap true}."
  (nvim.set_keymap mode from to {:noremap true}))

;; Generic mapping configuration.
(nvim.set_keymap :n :<space> :<nop> {:noremap true})
(set nvim.g.mapleader " ")
(set nvim.g.maplocalleader ",")

;; jk escape sequences.
(noremap :i :jk :<esc>)
(noremap :c :jk :<c-c>)
(noremap :t :jk :<c-\><c-n>)

;; Better movement keys
(noremap :n :l :h)
(noremap :v :l :h)
(noremap :n ";" :l)
(noremap :v ";" :l)

;; Spacemacs style leader mappings.
(noremap :n :<leader>wm ":tab sp<cr>")
(noremap :n :<leader>wc ":only<cr>")
(noremap :n :<leader>bd ":bdelete!<cr>")
(noremap :n :<leader>to ":tabonly<cr>")
(noremap :n :<leader>sw ":mksession! .quicksave.vim<cr>")
(noremap :n :<leader>sr ":source .quicksave.vim<cr>")

;; Delete hidden buffers.
(noremap :n :<leader>bo ":call DeleteHiddenBuffers()<cr>")

;; Correct to first spelling suggestion.
(noremap :n :<leader>zz ":normal! 1z=<cr>")

;; Trim trialing whitespace.
(noremap :n :<leader>bt ":%s/\\s\\+$//e<cr>")

;; no hl
(noremap :n :<esc> ":nohl <CR>")

;; explorer
(noremap :n :<leader>e ":NvimTreeToggle<CR>")

;; neogit
(noremap :n :<leader>gg ":Neogit kind=vsplit<CR>")

;; telescope
; (noremap :n :<leader>f ":Telescope find_files<CR>")

;; dashboard
; (noremap :n :<leader>; ":Dashboard<CR>")

;; Comments
(noremap :n :<leader>/ ":CommentToggle<CR>")
(noremap :v :<leader>/ ":CommentToggle<CR>")

;; Packer
(noremap :n :<leader>ps ":PackerSync<CR>")
(noremap :n :<leader>pi ":PackerInstall<CR>")

;; close buffer
; (noremap :n :<leader>c ":BufferClose<CR>")

;local opts = {
;    mode = "n", -- NORMAL mode
;    prefix = "<leader>",
;    buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
;    silent = true, -- use `silent` when creating keymaps
;    noremap = true, -- use `noremap` when creating keymaps
;    nowait = false -- use `nowait` when creating keymaps
;}

;-- Set leader
;vim.api.nvim_set_keymap('n', '<Space>', '<NOP>', {noremap = true, silent = true})
;vim.g.mapleader = ' '

;-- no hl
;-- vim.api.nvim_set_keymap('n', '<Leader>h', ':set hlsearch!<CR>', {noremap = true, silent = true})

;-- explorer
;vim.api.nvim_set_keymap('n', '<Leader>e', ':NvimTreeToggle<CR>', {noremap = true, silent = true})

;-- telescope
;vim.api.nvim_set_keymap('n', '<Leader>f', ':Telescope find_files<CR>', {noremap = true, silent = true})

;-- dashboard
;vim.api.nvim_set_keymap('n', '<Leader>;', ':Dashboard<CR>', {noremap = true, silent = true})

;-- Comments
;vim.api.nvim_set_keymap("n", "<leader>/", ":CommentToggle<CR>", {noremap = true, silent = true})
;vim.api.nvim_set_keymap("v", "<leader>/", ":CommentToggle<CR>", {noremap = true, silent = true})

;-- close buffer
;vim.api.nvim_set_keymap("n", "<leader>c", ":BufferClose<CR>", {noremap = true, silent = true})

;-- TODO create entire treesitter section

;local mappings = {
;    ["/"] = "Comment",
;    ["c"] = "Close Buffer",
;    ["e"] = "Explorer",
;    ["f"] = "Find File",
;    ["q"] = {"<cmd>:qa!<cr>", "Quit NVim"},
;    -- ["t"] = {"<cmd>lua require('FTerm').toggle()<cr>", "Terminal"},
;    -- ["t"] = {"<cmd>ToggleTerm<cr>", "Terminal"},
;    b = {
;        name = "+Buffer",
;        v = {":vnew<cr>", "New vertical buffer"},
;        h = {":new<cr>", "New horizontal buffer"},
;        s = {"<cmd>Telescope buffers<cr>", "List buffers"},
;        p = {"<cmd>BufferPick<cr>", "Pick buffers"}
;    },
;    d = {
;        name = "+Diagnostics",
;        -- TODO add a keymap to search actions in trouble
;        d = {"<cmd>TroubleToggle lsp_document_diagnostics<cr>", "Document"},
;        f = {"<cmd>TroubleToggle lsp_definitions<cr>", "Definitions"},
;        l = {"<cmd>TroubleToggle loclist<cr>", "Loclist"},
;        q = {"<cmd>TroubleToggle quickfix<cr>", "Quickfix"},
;        r = {"<cmd>TroubleToggle lsp_references<cr>", "References"},
;        t = {"<cmd>TodoTrouble<cr>", "Todos"},
;        T = {"<cmd>TroubleToggle<cr>", "Trouble"},
;        w = {"<cmd>TroubleToggle lsp_workspace_diagnostics<cr>", "Workspace"}
;    },
;    D = {
;        name = "+Debug",
;        b = {"<cmd>DebugToggleBreakpoint<cr>", "Toggle Breakpoint"},
;        c = {"<cmd>DebugContinue<cr>", "Continue"},
;        i = {"<cmd>DebugStepInto<cr>", "Step Into"},
;        o = {"<cmd>DebugStepOver<cr>", "Step Over"},
;        r = {"<cmd>DebugToggleRepl<cr>", "Toggle Repl"},
;        s = {"<cmd>DebugStart<cr>", "Start"}
;    },
;    g = {
;        name = "+Git",
;        b = {"<cmd>Telescope git_branches<cr>", "Checkout branch"},
;        c = {"<cmd>Telescope git_commits<cr>", "Checkout commit"},
;        C = {"<cmd>Telescope git_bcommits<cr>", "Checkout commit(for current file)"},
;        d = {"<cmd>Gitsigns diffthis<cr>", "Open diff view"},
;        -- g = {"<cmd>:Neogit<cr>", "Neogit"},
;        -- i = {"<cmd>Octo issue list<cr>", "GitHub issues"},
;        j = {"<cmd>NextHunk<cr>", "Next Hunk"},
;        k = {"<cmd>PrevHunk<cr>", "Prev Hunk"},
;        l = {"<cmd>Gitsigns toggle_current_line_blame<cr>", "Toggle git blame"},
;        o = {"<cmd>Telescope git_status<cr>", "Open changed file"},
;        p = {"<cmd>PreviewHunk<cr>", "Preview Hunk"},
;        -- P = {"<cmd>Octo pr list<cr>", "GitHub pull requests"},
;        r = {"<cmd>ResetHunk<cr>", "Reset Hunk"},
;        R = {"<cmd>ResetBuffer<cr>", "Reset Buffer"},
;        s = {"<cmd>StageHunk<cr>", "Stage Hunk"},
;        u = {"<cmd>UndoStageHunk<cr>", "Undo Stage Hunk"}
;    },
;    l = {
;        name = "+LSP",
;        -- TODO replace Telescope lsp with Trouble
;        a = {"<cmd>Lspsaga code_action<cr>", "Code Action"},
;        A = {"<cmd>Lspsaga range_code_action<cr>", "Selected Action"},
;        d = {"<cmd>Telescope lsp_document_diagnostics<cr>", "Document Diagnostics"},
;        D = {"<cmd>Telescope lsp_workspace_diagnostics<cr>", "Workspace Diagnostics"},
;        f = {"<cmd>Telescope lsp_definitions<cr>", "Definitions"},
;        F = {"<cmd>LspFormatting<cr>", "Format"},
;        i = {"<cmd>LspInfo<cr>", "Info"},
;        I = {"<cmd>Telescope lsp_implementations<cr>", "Implementation"},
;        k = {"<cmd>Lspsaga hover_doc<cr>", "Hover"},
;        l = {"<cmd>Lspsaga lsp_finder<cr>", "LSP Finder"},
;        L = {"<cmd>Lspsaga show_line_diagnostics<cr>", "Line Diagnostics"},
;        p = {"<cmd>Lspsaga preview_definition<cr>", "Preview Definition"},
;        q = {"<cmd>Telescope quickfix<cr>", "Quickfix"},
;        r = {"<cmd>Lspsaga rename<cr>", "Rename"},
;        R = {"<cmd>Telescope lsp_references<CR>", "references"},
;        s = {"<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols"},
;        S = {"<cmd>Telescope lsp_workspace_symbols<cr>", "Workspace Symbols"},
;        t = {"<cmd>LspTypeDefinition<cr>", "Type Definition"},
;        x = {"<cmd>cclose<cr>", "Close Quickfix"}
;    },
;    -- n = {
;    -- name = "+Notes"
;    -- m = {"<cmd>lua require('zk.command').create_note_link({title = vim.fn.expand('<cword>')})<cr>"},
;    -- j = {
;    -- "<cmd>lua require('zk.command').create_note_link({title = vim.fn.expand('<cword>'), notebook='jupyter'})<cr>"
;    -- }
;    -- },
;    p = {
;        name = "+Plugins",
;        c = {':PackerClean<CR>', 'Clean disabled or unused plugins'},
;        i = {':PackerInstall<CR>', 'Install missing plugins'},
;        p = {':PackerProfile<CR>', 'Profile the time taken loading your plugins'},
;        s = {':PackerSync<CR>', 'Performs PackerClean and then PackerUpdate'},
;        u = {':PackerUpdate<CR>', 'Update your plugins'}
;        -- l = {"<cmd>require('telescope').extensions.packer.plugins(opts)<cr>", "List installed plugins"}
;    },
;    r = {
;        name = "+REPL",
;        o = {"<cmd>IronReplHere<cr>", "Open REPL"},
;        v = {"<cmd>IronRepl<cr>", "Open REPL in split"},
;        r = {"<cmd>IronReplRestart<cr>", "Restart REPL"},
;        s = {"<cmd>IronSend<cr>", "Send to REPL"},
;        f = {"<cmd>IronFocus<cr>", "Focus on REPL"}
;    },
;    s = {
;        name = "+Search",
;        b = {"<cmd>Telescope git_branches<cr>", "Checkout branch"},
;        c = {"<cmd>Telescope colorscheme<cr>", "Colorscheme"},
;        d = {"<cmd>Telescope lsp_document_diagnostics<cr>", "Document Diagnostics"},
;        D = {"<cmd>Telescope lsp_workspace_diagnostics<cr>", "Workspace Diagnostics"},
;        f = {"<cmd>Telescope find_files<cr>", "Find File"},
;        m = {"<cmd>Telescope marks<cr>", "Marks"},
;        M = {"<cmd>Telescope man_pages<cr>", "Man Pages"},
;        n = {":lua require'lv-telescope'.search_vimwiki()<CR>", "Notes"},
;        N = {":lua require'lv-telescope'.search_vimwiki_text()<CR>", "Text inside notes"},
;        p = {":lua require'telescope'.extensions.project.project{}<CR>", "Projects"},
;        r = {"<cmd>Telescope oldfiles<cr>", "Open Recent File"},
;        R = {"<cmd>Telescope registers<cr>", "Registers"},
;        -- s = {"<cmd>Telescope session-lens search_session<CR>", "Session switcher"},
;        t = {"<cmd>Telescope live_grep<cr>", "Text"}
;    },
;    S = {name = "+Session", s = {"<cmd>SessionSave<cr>", "Save Session"}, l = {"<cmd>SessionLoad<cr>", "Load Session"}},
;    t = {
;        -- need a session that will open up 3 terminals
;        name = "+Terminal",
;        ["t"] = {":ToggleTerm<cr>", "Toggle term"},
;        ["o"] = {":ToggleTermOpenAll<cr>", "Open all terminal"},
;        ["c"] = {":ToggleTermCloseAll<cr>", "Close all terminals"}
;    },
;    w = {
;        name = "+Window",
;        c = {"<C-w>q<CR>", "Close current window"},
;        C = {"<cmd>only<CR>", "Close all other windows"},
;        h = {"<cmd>split<CR>", "Split window horizontally"},
;        j = {"<C-w>j<cr>", "Move to window below"},
;        k = {"<C-w>k<cr>", "Move to window above"},
;        l = {"<C-w>h<cr>", "Move to left window"},
;        v = {"<cmd>vsplit<CR>", "Split window vertically"},
;        [';'] = {"<C-w>l<cr>", "Move to right window"},
;        u = {"<cmd>!workspace up -e <cr>", "Open workspace"},
;        d = {"<cmd>!workspace down <cr>", "Close workspace"}
;    },
;    -- extras
;    z = {
;        name = "+Zen",
;        s = {"<cmd>TZBottom<cr>", "Toggle status line"},
;        t = {"<cmd>TZTop<cr>", "Toggle tab bar"},
;        z = {"<cmd>TZAtaraxis<cr>", "Toggle zen"}
;    }
;}

;local wk = require("which-key")
;wk.register(mappings, opts)

(nu.fn-bridge
  :DeleteHiddenBuffers
  :dotfiles.module.mapping :delete-hidden-buffers)

(defn delete-hidden-buffers []
  (let [visible-bufs (->> (nvim.fn.range 1 (nvim.fn.tabpagenr :$))
                          (core.map nvim.fn.tabpagebuflist)
                          (unpack)
                          (core.concat))]
    (->> (nvim.fn.range 1 (nvim.fn.bufnr :$))
         (core.filter
           (fn [bufnr]
             (and (nvim.fn.bufexists bufnr)
                  (= -1 (nvim.fn.index visible-bufs bufnr)))))
         (core.run!
           (fn [bufnr]
             (nvim.ex.bwipeout bufnr))))))
