(import-macros {: packadd! : pack : rock : use-package! : rock! : unpack!}
               :macros)

(local {: echo!} (require :core.lib.io))

;; Load packer
(echo! "Loading Packer")
(packadd! packer.nvim)

;; Include modules
(echo! "Compiling Modules")
(include :fnl.modules)

;; Setup packer
(echo! "Initiating Packer")
(let [packer (require :packer)]
  (packer.init {:git {:clone_timeout 300}
                :compile_path (.. (vim.fn.stdpath :config)
                                  :/lua/packer_compiled.lua)
                :auto_reload_compiled false
                :display {:non_interactive true}}))

;; Core packages
(use-package! :wbthomason/packer.nvim {:opt true})
(use-package! :nvim-lua/plenary.nvim {:module :plenary})
(use-package! :rktjmp/hotpot.nvim {:branch :nightly})

(use-package! :luisiacc/gruvbox-baby {:branch :main})
(use-package! :shaunsingh/oxocarbon.nvim {:run :./install.sh})

(echo! "Installing Packages")
(unpack!)
