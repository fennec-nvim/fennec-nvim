(module dotfiles.globals
  {autoload {a aniseed.core}})

(global fennec {:modules [:lsp :treesitter :git :lisps :explorer]
                :colorscheme "fennec-gruvbox"
                :mouse true
                :relative-num true

                :python {:linter ""
                         :formatter "" ; yapf or black
                         :autoformat false
                         :isort false
                         :diagnostics {:virtual_text {:spacing 0
                                                      :prefix ""}
                                       :signs true
                                       :underline true}
                         :analysis {:type_checking "basic"
                                    :auto_search_paths true
                                    :use_library_code_types true}}
                :dart {:sdk_path "/usr/lib/dart/bin/snapshots/analysis_server.dart.snapshot"}
                :lua {:formatter "" ;lua-format
                      :autoformat false
                      :diagnostics {:virtual_text {:spacing 0
                                                   :prefix ""}
                                    :signs true
                                    :underline true}}
                :sh {:linter ""
                     :formatter ""
                     :autoformat false
                     :diagnostics {:virtual_text {:spacing 0
                                                  :prefix ""}
                                   :signs true
                                   :underline true}}
                :tsserver {:linter "" ; eslint
                           :formatter "" ;prettier
                           :autoformat false
                           :diagnostics {:virtual_text {:spacing 0
                                                        :prefix ""}
                                         :signs true
                                         :underline true}}
                :json {:formatter "" ; prettier
                       :autoformat ""
                       :diagnostics {:virtual_text {:spacing 0
                                                    :prefix ""}
                                     :signs true
                                     :underline true}}
                :tailwindls {:filetypes [:html :css :scss :javascript :javascriptreact :typescript :typescriptreact]}
                :clang {:diagnostics {:virtual_text {:spacing 0
                                                     :prefix ""}
                                      :signs true
                                      :underline true}}
                :ruby {:diagnostics {:virtual_text {:spacing 0
                                                     :prefix ""}
                                      :signs true
                                      :underline true}
                       :filetype [:rb :erb :rakefile]}
                :go {}
                :css {}
                :html {} 
                :dashboard {:custom_header ["⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣠⡤⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
                                            "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣀⣤⠤⠴⠂⠒⠐⠤⠄⡀⡠⠤⠤⠤⠔⠂⣂⡽⠋⠁⣰⡁⠀⠀⢀⣀⣀⣀⣀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
                                            "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⠔⠘⠁⠁⠀⠀⠀⠀⠀⠀⠀⠠⠀⠀⠀⠀⣀⡤⠚⠃⠁⠀⢸⡄⠀⠀⠀⠈⠉⠁⠀⠐⠚⠉⠕⢲⣄⠀⠀⠀⠀⠀"
                                            "⢠⠤⠤⠤⠤⠤⠤⠤⠤⠤⠴⠶⠤⠞⠂⠂⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⡠⠐⠞⠁⠀⠀⠀⠀⢰⠞⠀⣀⡤⠤⢤⣤⣀⡀⠀⠀⠀⠀⠀⠈⠳⣄⠀⠀⠀"
                                            "⠀⠉⠑⠶⡒⠤⢄⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢄⡄⢄⡴⠚⢁⠖⠋⠁⠀⠀⠀⠀⠀⠉⠂⠀⠀⠀⠀⠀⠀⠘⣷⡄⠀"
                                            "⠀⠀⠀⠀⠈⠢⣄⠀⠉⠉⠒⠒⠲⠂⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⠄⠀⠀⠠⣖⠓⠊⢁⠀⡰⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠂⠀⠀⠀⠀⠀⡸⣿⡀"
                                            "⠀⠀⠀⠀⠀⠀⠀⠑⠢⠄⠀⡀⠄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣜⠁⠀⠀⢠⠮⠂⠀⠀⠀⢹⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⡏⡇"
                                            "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠑⠀⠠⠀⢨⠂⠀⠀⠐⠀⠐⢢⠀⠀⠀⢁⠀⢀⡔⢉⠟⠀⠀⠀⣴⠿⠀⠀⠀⠀⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣇⡇"
                                            "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠤⣤⣒⣀⠀⠒⠀⡀⠀⢨⠀⢀⣤⡄⠉⣬⢹⠃⠀⠀⡰⠋⠀⠀⠀⠀⣠⠆⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣾⡾⠁"
                                            "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠐⠜⢿⣟⣿⣥⡇⢀⠀⠀⠀⠁⡚⣻⡶⡿⢮⣞⣂⣠⣼⣀⡀⢀⣀⣴⣊⡏⠀⠀⠠⣀⣀⢀⡀⣀⣀⣀⣠⠔⠀⠀⠀⢼⠟⠁⠀"
                                            "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠘⠛⠉⠉⠁⢉⣱⠴⠒⠊⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠈⠉⠁⠀⠀⠚⠛⠻⠛⠛⠋⠉⠀⠀⢀⡴⠓⠁⠀⠀⠀"
                                            "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⠜⠈⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⢀⠴⠚⠁⠀⠀⠀⠀⠀⠀"
                                            "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⠜⠁⠀⠀⠀⠀⠀⠀⠀⠀⢀⡀⠀⢀⣀⣀⣀⣀⣀⡀⠀⠀⠀⠀⠀⠀⣀⣀⣤⣠⠶⠓⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
                                            "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢰⠋⠀⠀⢀⣀⣄⠤⠶⠒⠛⠛⠁⠙⠙⠛⠉⠉⠋⠉⠩⠽⠛⠛⠟⠛⠛⠻⠋⠉⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
                                            "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡇⠀⣠⠊⠊⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
                                            "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡇⠞⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
                                            "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"]
                            :footer "fennec-nvim"}})

(global fennec! (fn [...]
  (let [settings [...]]
    (for [i 1 (a.count settings) 2]
      (let [key (. settings i)
            val (. settings (+ i 1))]
        (tset fennec key val))))))

; CONFIG_PATH = vim.fn.stdpath('config')
; DATA_PATH = vim.fn.stdpath('data')
; CACHE_PATH = vim.fn.stdpath('cache')
