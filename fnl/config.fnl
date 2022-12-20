(require-macros :macros)

;; Place your private configuration here! Remember, you do not need to run 'nyoom
;; sync' after modifying this file!

;; You can use the `colorscheme` macro to load a custom theme, or load it manually
;; via require. This is the default:
(set! background :dark)
(colorscheme oxocarbon)

;; The set! macro sets vim.opt options. By default it sets the option to true 
;; Appending `no` in front sets it to false. This determines the style of line 
;; numbers in effect. If set to nonumber, line numbers are disabled. For 
;; relative line numbers, set 'relativenumber`
(set! nonumber)

;; The let option sets global, or `vim.g` options. 
;; Heres an example with localleader, setting it to <space>m
(let! maplocalleader " m")
(let! mapleader " ")

;; map! is used for mappings
;; Heres an example, preseing esc should also remove search highlights
(map! [n] :<esc> :<esc><cmd>noh<cr>)
(map! [nvx] ";" :l)
(map! [nvx] :l :h)
(map! [nv] :<C-s> :<cmd>up!<cr> {:desc "Save buffer."})
(map! [nv] :<leader>q :<cmd>q!<cr> {:desc :Quit})

;; Poke around the Nyoom code for more! The following macros are also available:
;; contains? check if a table contains a value
;; custom-set-face! use nvim_set_hl to set a highlight value
;; set! set a vim option
;; local-set! buffer-local set!
;; command! create a vim user command
;; local-command! buffer-local command!
;; autocmd! create an autocmd
;; augroup! create an augroup
;; clear! clear events
;; packadd! force load a plugin from /opt
;; colorscheme set a colorscheme
;; map! set a mapping
;; buf-map! bufer-local mappings
;; let! set a vim global
;; echo!/warn!/err! emit vim notifications
; ────────────────────────────────────────────────────────────
; ────────────────────────────────────────────────────────────
; ────────────────────────────────────────────────────────────

;; <leader>
;; (map! [n] :<leader><cr> "<cmd><cr>" {:desc "Jump to bookmark"})
(map! [n] :<leader><space> "<cmd>Telescope find_files<CR>"
      {:desc "Find file in project"})

;; (map! [n] :<leader>, "<cmd><cr>" {:desc "Switch workspace buffer"})
(map! [n] :<leader>. "<cmd>Telescope find_files<CR>" {:desc "Find file"})
;; (map! [n] :<leader>? "<cmd><cr>" {:desc "Search project"})
;; (map! [n] :<leader>: "<cmd>Telescope commands<cr>" {:desc "Commands"})
(map! [n] "<leader>:" "<cmd>Telescope commands<CR>" {:desc :Commands})
;; (map! [n] :<leader>; "<cmd>Alpha<cr>" {:desc "Dashboard"})
;; (map! [n] :<leader>; "<cmd><cr>" {:desc "Eval expression"})
(map! [n] :<leader>< "<cmd>Telescope buffers<CR>" {:desc "Switch Buffer"})
;; (map! [n] "<leader>`" "<cmd><CR>" {:desc "Switch to last buffer"})
(map! [n] "<leader>'" "<cmd>Telescope resume<CR>" {:desc "Resume last search"})
(map! [n] :<leader>/ "<cmd>Telescope live_grep<CR>" {:desc "Search project"})

; ────────────────────────────────────────────────────────────
; ────────────────────────────────────────────────────────────
; ────────────────────────────────────────────────────────────

;; +workspace
(map! [n] :<leader><tab><tab> "<cmd>set showtabline=2<CR>"
      {:desc "Display tab bar"})

(map! [n] :<leader><tab>. "<cmd>Telescope telescope-tabs list_tabs<CR>"
      {:desc "Switch tab"})

(map! [n] :<leader><tab>l
      "<cmd>:lua require'telescope'.extensions.project.project{}<CR>"
      {:desc "List projects"})

; ────────────────────────────────────────────────────────────
; ────────────────────────────────────────────────────────────
; ────────────────────────────────────────────────────────────

;; +buffers
(map! [n] :<leader>ba "<cmd>BDelete all<CR>" {:desc "Delete all buffers"})
(map! [n] :<leader>bb "<cmd>Telescope buffers<CR>" {:desc "Switch buffers"})
(map! [n] :<leader>bB "<cmd>Telescope telescope-tabs list_tabs<CR>"
      {:desc "Switch tab"})
(map! [n] :<leader>bc "<cmd>Clear<CR>" {:desc "Clear session"})
;; (map! [n] :<leader>bd :<cmd>BDelete this<CR> {:desc "Delete buffer"})
(map! [n] :<leader>bd :<cmd>bw<CR> {:desc "Delete buffer"})
(map! [n] :<leader>bh "<cmd>BDelete! hidden<CR>" {:desc "Delete hidden buffers"})
(map! [n] :<leader>bn :<cmd>bnext<CR> {:desc "Next buffer"})
(map! [n] :<leader>bN :<cmd>bprevious<CR> {:desc "Previous buffer"})
(map! [n] :<leader>bo "<cmd>BDelete! other<CR>" {:desc "Delete other buffers"})
(map! [n] :<leader>bs :<cmd>up!<CR> {:desc "Save buffer"})
;; (map! [n] :<leader>bw :<cmd><CR> {:desc "Save all buffers"})
(map! [n] :<leader>bx :<cmd>Scratch<CR> {:desc "Scratch buffer"})

; ────────────────────────────────────────────────────────────
; ────────────────────────────────────────────────────────────
; ────────────────────────────────────────────────────────────

;; +code

; ────────────────────────────────────────────────────────────
; ────────────────────────────────────────────────────────────
; ────────────────────────────────────────────────────────────

;; +files
;; TODO: make an extension for a custom dotfiles picker
(map! [n] :<leader>f. "<cmd>Telescope dotfiles<cr>"
      {:desc "Find file in dotfiles"})

;; (map! [n] :<leader>fc "<cmd>Telescope editorconfig<cr>"
;;       {:desc "Open project editorconfig"})
;; (map! [n] :<leader>fC "<cmd><cr>"
;;       {:desc "Copy this file"})
;; (map! [n] :<leader>fd "<cmd><cr>"
;;       {:desc "Find directory"}) ;; Search for directories, on <cr> open dirvish
;; (map! [n] :<leader>fD "<cmd><cr>"
;;       {:desc "Delete this file"})
;; TODO: make an extension for a custom nvim files picker
(map! [n] :<leader>fe "<cmd>Telescope nvim_files<cr>"
      {:desc "Find file in .config/nvim"})

;; (map! [n] :<leader>E "<cmd>Telescope browse_nvim_files<cr>"
;;       {:desc "Browse .config/nvim"})
(map! [n] :<leader>ff "<cmd>Telescope find_files<cr>" {:desc "Find file"})
(map! [n] :<leader>fl "<cmd>Lf %<cr>" {:desc "File manager"})
(map! [n] :<leader>fp "<cmd>Telescope fennec_config<cr>"
      {:desc "Find file in private config"})

;; (map! [n] :<leader>fP :<cmd><cr> {:desc "Browse private config"})
;; (map! [n] :<leader>fP :<cmd><cr> {:desc "Grep in private config"})
(map! [n] :<leader>fr "<cmd>Telescope oldfiles<cr>" {:desc "Recent files"})
;; (map! [n] :<leader>fR :<cmd><cr> {:desc "Rename/move file"})
;; (map! [n] :<leader>fs :<cmd><cr> {:desc "Save file"})
;; (map! [n] :<leader>fS :<cmd><cr> {:desc "Save file as..."})
;; (map! [n] :<leader>fu :<cmd><cr> {:desc "Sudo find file"})
;; (map! [n] :<leader>fU :<cmd><cr> {:desc "Sudo this file"})
;; (map! [n] :<leader>fy :<cmd><cr> {:desc "Yank file path"})
;; (map! [n] :<leader>fY :<cmd><cr> {:desc "Yank file path from project"})

; ────────────────────────────────────────────────────────────
; ────────────────────────────────────────────────────────────
; ────────────────────────────────────────────────────────────
