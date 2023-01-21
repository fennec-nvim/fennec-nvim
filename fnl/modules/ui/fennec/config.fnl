(local {: autoload} (require :core.lib.autoload))
(local {: setup} (require :core.lib.setup))

(local material-icons (autoload :nvim-material-icon))

;; (setup :nvim-web-devicons {:override (material-icons.get_icons)})

(setup :nvim-web-devicons
       {:default true
        :override {:fnl {:icon "" :color "#7bc45c" :name :fennel}}})

(setup :modes {:colors {:insert "#be95ff"
                        :delete "#ff7eb6"
                        :visual "#82cfff"
                        :copy "#42be65"}})
