(local {: autoload} (require :core.lib.autoload))
(local {: setup} (require :core.lib.setup))

;; Init mason

(local mason-tools [])
(setup :mason {:ui {:border :solid} :PATH :skip})

;; language servers

;; fnlfmt: skip
(table.insert mason-tools :clojure-lsp)

(table.insert mason-tools :lua-language-server)

(table.insert mason-tools :marksman)

(table.insert mason-tools :pyright)

(table.insert mason-tools :bash-language-server)

;; formatters

(table.insert mason-tools :stylua)

(table.insert mason-tools :markdownlint)

(table.insert mason-tools :black)
(table.insert mason-tools :isort)

(table.insert mason-tools :shfmt)

;; linters

;; fnlfmt: skip
(table.insert mason-tools :selene)

;; TODO: find a way to only do MasonInstall when they aren't installed
;; (vim.cmd (.. "MasonInstall " (table.concat mason-tools " ")))
